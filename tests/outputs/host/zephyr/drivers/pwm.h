/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdbool.h>
#include <stdint.h>
struct pwm_dt_spec {
	unsigned int channel;
	uint32_t period;
};
#define PWM_DT_SPEC_GET(alias) {.channel = alias, .period = 1000000U}
static inline bool pwm_is_ready_dt(const struct pwm_dt_spec *spec)
{
	(void)spec;
	return true;
}
int pwm_set_pulse_dt(const struct pwm_dt_spec *spec, uint32_t pulse);
