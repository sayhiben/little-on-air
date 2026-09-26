/* SPDX-License-Identifier: MIT */
#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#include <little_on_air/ws2812_frame.h>

static void self_test(void)
{
	struct loa_rgb pixels[LOA_WS2812_MAX_PIXELS] = {
		{31, 0, 0}, {0, 31, 0}, {0, 0, 31}, {31, 31, 31}};
	const struct loa_rgb original[LOA_WS2812_MAX_PIXELS] = {
		{31, 0, 0}, {0, 31, 0}, {0, 0, 31}, {31, 31, 31}};
	uint8_t guarded[LOA_WS2812_FRAME_BYTES + 2];
	memset(guarded, 0xa5, sizeof(guarded));
	assert(loa_ws2812_encode(NULL, 4, &guarded[1], LOA_WS2812_FRAME_BYTES) == -EINVAL);
	assert(loa_ws2812_encode(pixels, 4, NULL, LOA_WS2812_FRAME_BYTES) == -EINVAL);
	assert(loa_ws2812_encode(pixels, 0, &guarded[1], LOA_WS2812_FRAME_BYTES) == -EINVAL);
	assert(loa_ws2812_encode(pixels, 5, &guarded[1], LOA_WS2812_FRAME_BYTES) == -EINVAL);
	assert(loa_ws2812_encode(pixels, 4, &guarded[1], LOA_WS2812_FRAME_BYTES - 1) == -ENOSPC);
	for (size_t i = 0; i < sizeof(guarded); ++i) {
		assert(guarded[i] == 0xa5);
	}
	for (size_t count = 1; count <= LOA_WS2812_MAX_PIXELS; ++count) {
		memset(guarded, 0xa5, sizeof(guarded));
		int length = loa_ws2812_encode(pixels, count, &guarded[1], LOA_WS2812_FRAME_BYTES);
		assert(length ==
		       (int)(2 * LOA_WS2812_RESET_BYTES + count * LOA_WS2812_PIXEL_BYTES));
		assert(guarded[0] == 0xa5 && guarded[length + 1] == 0xa5);
		for (size_t i = 0; i < LOA_WS2812_RESET_BYTES; ++i) {
			assert(guarded[i + 1] == 0);
			assert(guarded[length - i] == 0);
		}
	}
	assert(memcmp(pixels, original, sizeof(pixels)) == 0);
	memset(pixels, 0, sizeof(pixels));
	assert(loa_ws2812_encode(pixels, 4, &guarded[1], LOA_WS2812_FRAME_BYTES) ==
	       LOA_WS2812_FRAME_BYTES);
	fprintf(stderr,
		"PASS encoder bounds, invalid inputs, guard bytes, padding, input preservation\n");
}

int main(int argc, char **argv)
{
	if (argc == 2 && strcmp(argv[1], "--self-test") == 0) {
		self_test();
		return 0;
	}
	if (argc == 2 && strcmp(argv[1], "--info") == 0) {
		printf("{\"spi_hz\":%u,\"reset_us\":%u,\"reset_bytes\":%u,"
		       "\"symbol_bits\":%u,\"zero_symbol\":%u,\"one_symbol\":%u,"
		       "\"pixels\":%u,\"frame_bytes\":%u}\n",
		       LOA_WS2812_SPI_HZ, LOA_WS2812_RESET_US, LOA_WS2812_RESET_BYTES,
		       LOA_WS2812_SYMBOL_BITS, LOA_WS2812_ZERO_SYMBOL, LOA_WS2812_ONE_SYMBOL,
		       LOA_WS2812_MAX_PIXELS, LOA_WS2812_FRAME_BYTES);
		return 0;
	}
	uint8_t input[3 * LOA_WS2812_MAX_PIXELS];
	uint8_t frame[LOA_WS2812_FRAME_BYTES];
	size_t count;
	while ((count = fread(input, 1, sizeof(input), stdin)) != 0) {
		if (count != sizeof(input)) {
			return 2;
		}
		struct loa_rgb pixels[LOA_WS2812_MAX_PIXELS];
		for (size_t i = 0; i < LOA_WS2812_MAX_PIXELS; ++i) {
			pixels[i] =
				(struct loa_rgb){input[3 * i], input[3 * i + 1], input[3 * i + 2]};
		}
		int length = loa_ws2812_encode(pixels, LOA_WS2812_MAX_PIXELS, frame, sizeof(frame));
		if (length != sizeof(frame) ||
		    fwrite(frame, 1, sizeof(frame), stdout) != sizeof(frame)) {
			return 3;
		}
	}
	return ferror(stdin) ? 4 : 0;
}
