/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_WS2812_FRAME_H_
#define LITTLE_ON_AIR_WS2812_FRAME_H_

#include <stddef.h>
#include <stdint.h>

#include <little_on_air/status.h>

/* Bench profile for four GRB pixels on nRF52840 SPIM2. The device-tree
 * configuration is checked against these constants by the hardware driver.
 * Padding is raw SPI zero bits (continuous LOW), not encoded black pixels.
 */
#define LOA_WS2812_RESET_US 300U
#if defined(CONFIG_LOA_PIXELS_TIMING_375NS) && CONFIG_LOA_PIXELS_TIMING_375NS
/* 125 ns SPI clocks: zero = 375/875 ns, one = 750/500 ns HIGH/LOW. */
#define LOA_WS2812_SPI_HZ      8000000U
#define LOA_WS2812_SYMBOL_BITS 10U
#define LOA_WS2812_ZERO_SYMBOL 0x380U
#define LOA_WS2812_ONE_SYMBOL  0x3f0U
#else
#define LOA_WS2812_SPI_HZ      4000000U
#define LOA_WS2812_SYMBOL_BITS 5U
#define LOA_WS2812_ZERO_SYMBOL 0x10U
#define LOA_WS2812_ONE_SYMBOL  0x1cU
#endif
#define LOA_WS2812_MAX_PIXELS  4U
#define LOA_WS2812_RESET_BYTES (LOA_WS2812_SPI_HZ / 1000000U * LOA_WS2812_RESET_US / 8U)
#define LOA_WS2812_PIXEL_BYTES (3U * LOA_WS2812_SYMBOL_BITS)
#define LOA_WS2812_FRAME_BYTES                                                                     \
	(2U * LOA_WS2812_RESET_BYTES + LOA_WS2812_MAX_PIXELS * LOA_WS2812_PIXEL_BYTES)

/* Inputs are already brightness-limited. Returns bytes written, or -errno.
 * The input colors are not modified. Output contains LOW / GRB data / LOW.
 */
int loa_ws2812_encode(const struct loa_rgb *pixels, size_t count, uint8_t *output, size_t capacity);

#endif /* LITTLE_ON_AIR_WS2812_FRAME_H_ */
