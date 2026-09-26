/* SPDX-License-Identifier: MIT */
#include <zephyr/kernel.h>
#include <little_on_air/status_output.h>
#include "device_indicator.h"

static enum loa_device_state mode;
static bool on;
K_MUTEX_DEFINE(device_lock);
static struct k_work_delayable device_work;

static void update(struct k_work *work)
{
	ARG_UNUSED(work);
	k_mutex_lock(&device_lock, K_FOREVER);
	(void)loa_status_output_set_device_rgb((struct loa_rgb){.red = on ? 255U : 0U});
	if (mode != LOA_DEVICE_READY) {
		uint32_t delay = mode == LOA_DEVICE_PAIRING ? 250U : on ? 1800U : 200U;
		on = !on;
		(void)k_work_reschedule(&device_work, K_MSEC(delay));
	}
	k_mutex_unlock(&device_lock);
}
void loa_device_indicator_init(void)
{
	k_work_init_delayable(&device_work, update);
	mode = LOA_DEVICE_READY;
	on = true;
}
void loa_device_indicator_set(enum loa_device_state state)
{
	if (!IS_ENABLED(CONFIG_LOA_RECEIVER_POWER_LED)) {
		return;
	}
	k_mutex_lock(&device_lock, K_FOREVER);
	if (mode != state) {
		mode = state;
		on = true;
		(void)k_work_reschedule(&device_work, K_NO_WAIT);
	}
	k_mutex_unlock(&device_lock);
}
