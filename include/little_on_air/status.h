/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_STATUS_H_
#define LITTLE_ON_AIR_STATUS_H_

#include <stdbool.h>
#include <stdint.h>

enum loa_status {
	LOA_STATUS_OFF = 0,
	LOA_STATUS_WARN = 1,
	LOA_STATUS_ON_AIR = 2,
	LOA_STATUS_OKAY = 3,
	LOA_STATUS_COUNT,
};

struct loa_rgb {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
};

bool loa_status_is_valid(enum loa_status status);
enum loa_status loa_status_next(enum loa_status status);
struct loa_rgb loa_status_rgb(enum loa_status status);
const char *loa_status_name(enum loa_status status);

#endif /* LITTLE_ON_AIR_STATUS_H_ */
