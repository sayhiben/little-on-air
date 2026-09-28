/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_STATUS_OUTPUT_H_
#define LITTLE_ON_AIR_STATUS_OUTPUT_H_

#include <little_on_air/status.h>
#include <little_on_air/brightness.h>

int loa_status_output_init(void);
int loa_status_output_set_brightness(uint8_t frame, uint8_t indicator);
int loa_status_output_set_status(enum loa_status status, uint32_t elapsed_ms);
/* Onboard LED only; never writes front pixels. */
int loa_status_output_set_device_rgb(struct loa_rgb color);
/* Volatile front-pixel test: index 0..3, or 255 to end. Never persists state. */
int loa_status_output_test_pixel(uint8_t index, struct loa_rgb color);
bool loa_status_output_test_active(void);

#endif /* LITTLE_ON_AIR_STATUS_OUTPUT_H_ */
