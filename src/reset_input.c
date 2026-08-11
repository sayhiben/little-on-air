/* SPDX-License-Identifier: MIT */
#include <hal/nrf_power.h>
#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>

#include <little_on_air/reset_gesture.h>
#include <little_on_air/reset_input.h>

LOG_MODULE_REGISTER(loa_reset_input);

static struct k_work_delayable clear_retained_work;

static void clear_retained(struct k_work *work)
{
	ARG_UNUSED(work);
	LOG_DBG("clearing retained reset gesture");
	nrf_power_gpregret_set(NRF_POWER, 1U, 0U);
}

struct loa_boot_input loa_reset_input_capture(void)
{
	const uint32_t reasons = nrf_power_resetreas_get(NRF_POWER);
	const bool pin_reset = loa_reset_reason_has_pin(reasons, NRF_POWER_RESETREAS_RESETPIN_MASK);
	const uint8_t retained = (uint8_t)nrf_power_gpregret_get(NRF_POWER, 1U);
	const struct loa_reset_decision decision = loa_reset_gesture_update(retained, pin_reset);

	LOG_INF("reset reasons=0x%08x pin=%u retained=0x%02x button=%u factory=%u next=0x%02x",
		reasons, pin_reset, retained, decision.button_press, decision.factory_reset,
		decision.retained_value);

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
