/* SPDX-License-Identifier: MIT */
#include <zephyr/kernel.h>

#include "mood_indicator.h"
#include "status_output.h"

static struct k_work_delayable mood_work;
static struct k_mutex mood_lock;
static enum loa_status mood;
static uint32_t started_at;

static void update_mood(struct k_work *work)
{
	ARG_UNUSED(work);
	k_mutex_lock(&mood_lock, K_FOREVER);
	(void)loa_status_output_set_status(mood, k_uptime_get_32() - started_at);
	uint16_t interval_ms = loa_status_animation_interval_ms(mood);
	if (interval_ms != 0U) {
		/* Anchor cadence to the mood change, not SPI transfer time. */
		uint16_t delay_ms = interval_ms - (k_uptime_get_32() - started_at) % interval_ms;
		(void)k_work_reschedule(&mood_work, K_MSEC(delay_ms));
	}
	k_mutex_unlock(&mood_lock);
}

int loa_mood_indicator_init(void)
{
	int err = loa_status_output_init();
	if (err != 0) {
		return err;
	}
	k_mutex_init(&mood_lock);
	k_work_init_delayable(&mood_work, update_mood);
	mood = LOA_STATUS_OFF;
	started_at = 0U;
	return 0;
}

void loa_mood_indicator_set(enum loa_status status)
{
	k_mutex_lock(&mood_lock, K_FOREVER);
	/* Same-state reconciliation must neither flash nor restart animation. */
	if (mood != status) {
		mood = status;
		started_at = k_uptime_get_32();
		(void)k_work_reschedule(&mood_work, K_NO_WAIT);
	}
	k_mutex_unlock(&mood_lock);
}
