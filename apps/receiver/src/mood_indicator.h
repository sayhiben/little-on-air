/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_MOOD_INDICATOR_H_
#define LITTLE_ON_AIR_MOOD_INDICATOR_H_

#include <little_on_air/status.h>

int loa_mood_indicator_init(void);
void loa_mood_indicator_set(enum loa_status status);

#endif /* LITTLE_ON_AIR_MOOD_INDICATOR_H_ */
