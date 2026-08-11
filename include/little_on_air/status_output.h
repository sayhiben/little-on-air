/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_STATUS_OUTPUT_H_
#define LITTLE_ON_AIR_STATUS_OUTPUT_H_

#include <little_on_air/status.h>

int loa_status_output_init(void);
int loa_status_output_set_rgb(struct loa_rgb color);

#endif /* LITTLE_ON_AIR_STATUS_OUTPUT_H_ */
