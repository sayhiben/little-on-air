/* SPDX-License-Identifier: MIT */
#include <little_on_air/patterns.h>

static const struct loa_rgb off = {0};
static const struct loa_rgb blue = {.blue = 255U};
static const struct loa_rgb red = {.red = 255U};
static const struct loa_rgb green = {.green = 255U};
static const struct loa_rgb white = {
	.red = 255U,
	.green = 255U,
	.blue = 255U,
};

bool loa_pattern_is_finite(enum loa_pattern pattern)
{
	return pattern == LOA_PATTERN_ERROR || pattern == LOA_PATTERN_PAIR_SUCCESS;
}

size_t loa_pattern_frame_count(enum loa_pattern pattern)
{
	switch (pattern) {
	case LOA_PATTERN_DESYNCED:
	case LOA_PATTERN_SYNCING:
	case LOA_PATTERN_SENDING:
		return 2U;
	case LOA_PATTERN_SOLID:
		return 1U;
	case LOA_PATTERN_ERROR:
	case LOA_PATTERN_PAIR_SUCCESS:
		return 6U;
	default:
		return 0U;
	}
}

bool loa_pattern_get_frame(enum loa_pattern pattern, enum loa_status status, size_t frame_index,
			   struct loa_pattern_frame *frame)
{
	const size_t count = loa_pattern_frame_count(pattern);

	if (frame == NULL || count == 0U) {
		return false;
	}

	if (loa_pattern_is_finite(pattern)) {
		if (frame_index >= count) {
			return false;
		}
	} else {
		frame_index %= count;
	}

	switch (pattern) {
	case LOA_PATTERN_DESYNCED:
		*frame = frame_index == 0U ? (struct loa_pattern_frame){blue, 250U}
					   : (struct loa_pattern_frame){off, 1750U};
		break;
	case LOA_PATTERN_SYNCING:
		*frame = frame_index == 0U ? (struct loa_pattern_frame){blue, 150U}
					   : (struct loa_pattern_frame){off, 150U};
		break;
	case LOA_PATTERN_SENDING:
		*frame = frame_index == 0U
				 ? (struct loa_pattern_frame){status == LOA_STATUS_OFF
								      ? blue
								      : loa_status_rgb(status),
							      150U}
				 : (struct loa_pattern_frame){off, 150U};
		break;
	case LOA_PATTERN_SOLID:
		*frame = (struct loa_pattern_frame){loa_status_rgb(status), 0U};
		break;
	case LOA_PATTERN_ERROR:
		*frame = (struct loa_pattern_frame){frame_index % 2U == 0U ? red : white, 200U};
		break;
	case LOA_PATTERN_PAIR_SUCCESS:
		*frame = (struct loa_pattern_frame){frame_index % 2U == 0U ? green : off, 150U};
		break;
	default:
		return false;
	}

	return true;
}
