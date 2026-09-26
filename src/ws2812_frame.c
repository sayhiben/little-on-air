/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>

#include <little_on_air/ws2812_frame.h>

_Static_assert(LOA_WS2812_SYMBOL_BITS <= 16, "Symbols must fit in uint16_t");
_Static_assert(LOA_WS2812_ZERO_SYMBOL < (1U << LOA_WS2812_SYMBOL_BITS),
	       "Zero symbol exceeds its encoded width");
_Static_assert(LOA_WS2812_ONE_SYMBOL < (1U << LOA_WS2812_SYMBOL_BITS),
	       "One symbol exceeds its encoded width");

int loa_ws2812_encode(const struct loa_rgb *pixels, size_t count, uint8_t *output, size_t capacity)
{
	if (pixels == NULL || output == NULL || count == 0 || count > LOA_WS2812_MAX_PIXELS) {
		return -EINVAL;
	}
	const size_t length = 2U * LOA_WS2812_RESET_BYTES + count * LOA_WS2812_PIXEL_BYTES;
	if (capacity < length) {
		return -ENOSPC;
	}
	memset(output, 0, length);
	size_t position = LOA_WS2812_RESET_BYTES * 8U;
	for (size_t i = 0; i < count; ++i) {
		const uint8_t channels[] = {pixels[i].green, pixels[i].red, pixels[i].blue};
		for (size_t channel = 0; channel < sizeof(channels); ++channel) {
			for (int bit = 7; bit >= 0; --bit) {
				const uint16_t symbol = (channels[channel] & (1U << bit))
								? LOA_WS2812_ONE_SYMBOL
								: LOA_WS2812_ZERO_SYMBOL;
				for (int clock = LOA_WS2812_SYMBOL_BITS - 1; clock >= 0; --clock) {
					if (symbol & (1U << clock)) {
						output[position / 8U] |= 1U << (7U - position % 8U);
					}
					++position;
				}
			}
		}
	}
	return (int)length;
}
