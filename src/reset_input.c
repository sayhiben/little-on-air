/* SPDX-License-Identifier: MIT */
#include <hal/nrf_power.h>
#include <zephyr/kernel.h>

#include <little_on_air/reset_gesture.h>
#include <little_on_air/reset_input.h>

static struct k_work_delayable clear_retained_work;

static void clear_retained(struct k_work *work)
{
	ARG_UNUSED(work);
	nrf_power_gpregret_set(NRF_POWER, 1U, 0U);
}

struct loa_boot_input loa_reset_input_capture(void)
{
	const uint32_t reasons = nrf_power_resetreas_get(NRF_POWER);
	const bool pin_reset = loa_reset_reason_has_pin(reasons, NRF_POWER_RESETREAS_RESETPIN_MASK);
	const uint8_t retained = (uint8_t)nrf_power_gpregret_get(NRF_POWER, 1U);
	const struct loa_reset_decision decision = loa_reset_gesture_update(retained, pin_reset);

	nrf_power_resetreas_clear(NRF_POWER, reasons);
	nrf_power_gpregret_set(NRF_POWER, 1U, decision.retained_value);

	k_work_init_delayable(&clear_retained_work, clear_retained);
	if (decision.retained_value != 0U) {
		(void)k_work_reschedule(&clear_retained_work, K_MSEC(LOA_RESET_GESTURE_CLEAR_MS));
	}

	return (struct loa_boot_input){
		.button_press = decision.button_press,
		.factory_reset = decision.factory_reset,
	};
}
