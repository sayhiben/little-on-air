/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_PATTERNS_H_
#define LITTLE_ON_AIR_PATTERNS_H_

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <little_on_air/status.h>

enum loa_pattern {
	LOA_PATTERN_DESYNCED,
	LOA_PATTERN_SYNCING,
	LOA_PATTERN_SENDING,
	LOA_PATTERN_SOLID,
	LOA_PATTERN_ERROR,
	LOA_PATTERN_PAIR_SUCCESS,
};

struct loa_pattern_frame {
	struct loa_rgb color;
	uint16_t duration_ms;
};

bool loa_pattern_is_finite(enum loa_pattern pattern);
size_t loa_pattern_frame_count(enum loa_pattern pattern);
bool loa_pattern_get_frame(enum loa_pattern pattern, enum loa_status status, size_t frame_index,
			   struct loa_pattern_frame *frame);

#endif /* LITTLE_ON_AIR_PATTERNS_H_ */
