/* SPDX-License-Identifier: MIT */
#include <errno.h>

#include <zephyr/device.h>
#include <zephyr/drivers/led_strip.h>
#include <zephyr/drivers/spi.h>
#include <zephyr/dt-bindings/led/led.h>
#include <zephyr/kernel.h>
#include <zephyr/sys/util.h>

#include <little_on_air/ws2812_frame.h>

#define PIXEL_NODE DT_ALIAS(loa_pixels)

/* Keep this bench variant tied to the existing wiring, timing and GRB mapping.
 * Fail a build rather than silently encode a different strip configuration.
 */
BUILD_ASSERT(DT_NODE_HAS_STATUS(PIXEL_NODE, okay), "The front pixel overlay is required");
BUILD_ASSERT(DT_PROP(PIXEL_NODE, chain_length) == LOA_WS2812_MAX_PIXELS);
BUILD_ASSERT(DT_PROP(PIXEL_NODE, spi_max_frequency) == LOA_WS2812_SPI_HZ);
BUILD_ASSERT(LOA_WS2812_SPI_HZ <= DT_PROP(DT_BUS(PIXEL_NODE), max_frequency),
	     "SPI bus must support the requested clock without clamping");
#if defined(CONFIG_LOA_PIXELS_TIMING_375NS)
BUILD_ASSERT(DT_NODE_HAS_COMPAT(PIXEL_NODE, loa_padded_ws2812_spi),
	     "Ten-bit symbols require the application-owned pixel binding");
#endif
BUILD_ASSERT(DT_PROP(PIXEL_NODE, reset_delay) == LOA_WS2812_RESET_US);
BUILD_ASSERT(DT_PROP(PIXEL_NODE, bits_per_symbol) == LOA_WS2812_SYMBOL_BITS);
BUILD_ASSERT(DT_PROP(PIXEL_NODE, spi_zero_frame) == LOA_WS2812_ZERO_SYMBOL);
BUILD_ASSERT(DT_PROP(PIXEL_NODE, spi_one_frame) == LOA_WS2812_ONE_SYMBOL);
BUILD_ASSERT(DT_PROP_LEN(PIXEL_NODE, color_mapping) == 3);
BUILD_ASSERT(DT_PROP_BY_IDX(PIXEL_NODE, color_mapping, 0) == LED_COLOR_ID_GREEN);
BUILD_ASSERT(DT_PROP_BY_IDX(PIXEL_NODE, color_mapping, 1) == LED_COLOR_ID_RED);
BUILD_ASSERT(DT_PROP_BY_IDX(PIXEL_NODE, color_mapping, 2) == LED_COLOR_ID_BLUE);
BUILD_ASSERT(LOA_WS2812_FRAME_BYTES <= BIT_MASK(DT_PROP(DT_BUS(PIXEL_NODE), easydma_maxcnt_bits)),
	     "The entire padded frame must fit in one DMA transfer");

static const struct spi_dt_spec bus =
	SPI_DT_SPEC_GET(PIXEL_NODE, SPI_OP_MODE_MASTER | SPI_TRANSFER_MSB | SPI_WORD_SET(8));
/* A single contiguous RAM buffer prevents a driver/software pause between
 * leading LOW and payload. This board's 16-bit DMA counter fits the full frame.
 */
static uint8_t frame[LOA_WS2812_FRAME_BYTES];
K_MUTEX_DEFINE(frame_lock);

static int update_pixels(const struct device *dev, struct led_rgb *pixels, size_t count)
{
	ARG_UNUSED(dev);
	if (pixels == NULL || count != LOA_WS2812_MAX_PIXELS) {
		return -EINVAL;
	}
	struct loa_rgb colors[LOA_WS2812_MAX_PIXELS];
	for (size_t i = 0; i < count; ++i) {
		colors[i] = (struct loa_rgb){pixels[i].r, pixels[i].g, pixels[i].b};
	}
	k_mutex_lock(&frame_lock, K_FOREVER);
	const int length = loa_ws2812_encode(colors, count, frame, sizeof(frame));
	int err = length;
	if (length > 0) {
		const struct spi_buf buffer = {.buf = frame, .len = (size_t)length};
		const struct spi_buf_set tx = {.buffers = &buffer, .count = 1};
		err = spi_write_dt(&bus, &tx);
	}
	/* Preserve the original post-transfer guard too. Unlike sleep alone, the
	 * padding clocks LOW onto MOSI before/after every pixel frame.
	 */
	k_usleep(LOA_WS2812_RESET_US);
	k_mutex_unlock(&frame_lock);
	return err;
}

static size_t pixel_count(const struct device *dev)
{
	ARG_UNUSED(dev);
	return LOA_WS2812_MAX_PIXELS;
}

static int init_pixels(const struct device *dev)
{
	ARG_UNUSED(dev);
	return spi_is_ready_dt(&bus) ? 0 : -ENODEV;
}

static DEVICE_API(led_strip, padded_pixels_api) = {
	.update_rgb = update_pixels,
	.length = pixel_count,
};

DEVICE_DT_DEFINE(PIXEL_NODE, init_pixels, NULL, NULL, NULL, POST_KERNEL,
		 CONFIG_LED_STRIP_INIT_PRIORITY, &padded_pixels_api);
