/* SPDX-License-Identifier: MIT */
#include <hal/nrf_power.h>
#include <errno.h>
#include <string.h>
#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/settings/settings.h>

#include <little_on_air/reset_gesture.h>
#include <little_on_air/reset_input.h>

LOG_MODULE_REGISTER(loa_reset_input);

static struct k_work_delayable clear_retained_work;
static uint8_t saved_count;

static int reset_settings_set(const char *name, size_t len, settings_read_cb read_cb, void *arg)
{
	uint8_t value;
	if (strcmp(name, "count") != 0 || len != sizeof(value)) {
		return -ENOENT;
	}
	if (read_cb(arg, &value, sizeof(value)) != sizeof(value)) {
		return -EIO;
	}
	saved_count = value;
	return 0;
}

SETTINGS_STATIC_HANDLER_DEFINE(loa_reset, "loa_reset", NULL, reset_settings_set, NULL, NULL);

static int save_count(uint8_t value)
{
	if (saved_count == value) {
		return 0;
	}
	int err = settings_save_one("loa_reset/count", &value, sizeof(value));
	if (err == 0) {
		saved_count = value;
	}
	return err;
}

static void clear_retained(struct k_work *work)
{
	ARG_UNUSED(work);
	int err = save_count(0U);
	if (err != 0) {
		LOG_ERR("reset gesture clear failed: %d", err);
		(void)k_work_reschedule(&clear_retained_work, K_MSEC(1000));
	}
}

struct loa_boot_input loa_reset_input_capture(void)
{
	const uint32_t reasons = nrf_power_resetreas_get(NRF_POWER);
	const bool pin_reset = loa_reset_reason_has_pin(reasons, NRF_POWER_RESETREAS_RESETPIN_MASK);
	nrf_power_resetreas_clear(NRF_POWER, reasons);
	LOG_INF("reset reasons=0x%08x pin=%u", reasons, pin_reset);
	return (struct loa_boot_input){.button_press = pin_reset};
}

int loa_reset_input_resolve(struct loa_boot_input *input)
{
	/* GPREGRET2 is cleared by pin resets. NVS survives the stock bootloader.
	 * Only actual pin-reset boots advance the sequence; every other reset and
	 * six seconds of uninterrupted application time clear it.
	 */
	const struct loa_reset_decision decision =
		loa_reset_gesture_update(saved_count, input->button_press);
	int err = save_count(decision.retained_value);
	if (err != 0) {
		input->factory_reset = false;
		return err;
	}
	input->factory_reset = decision.factory_reset;
	LOG_INF("reset gesture next=0x%02x factory=%u", saved_count, input->factory_reset);

	k_work_init_delayable(&clear_retained_work, clear_retained);
	if (decision.retained_value != 0U) {
		(void)k_work_reschedule(&clear_retained_work, K_MSEC(LOA_RESET_GESTURE_CLEAR_MS));
	}

	return 0;
}
