/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_INDICATOR_H_
#define LITTLE_ON_AIR_INDICATOR_H_

#include <little_on_air/patterns.h>

int loa_indicator_init(void);
void loa_indicator_set(enum loa_pattern pattern, enum loa_status status);
void loa_indicator_play(enum loa_pattern pattern, enum loa_status status,
			enum loa_pattern fallback_pattern, enum loa_status fallback_status);

#endif /* LITTLE_ON_AIR_INDICATOR_H_ */
