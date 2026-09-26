/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdint.h>
extern uint32_t simulated_reset_reason;
#define NRF_POWER                         ((void *)0)
#define NRF_POWER_RESETREAS_RESETPIN_MASK 1U
static inline uint32_t nrf_power_resetreas_get(void *device)
{
	(void)device;
	return simulated_reset_reason;
}
static inline void nrf_power_resetreas_clear(void *device, uint32_t reasons)
{
	(void)device;
	simulated_reset_reason &= ~reasons;
}
