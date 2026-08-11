/* SPDX-License-Identifier: MIT */
#include <zephyr/kernel.h>

#include <little_on_air/indicator.h>
#include <little_on_air/status_output.h>

struct indicator_state {
	struct k_work_delayable work;
	struct k_mutex lock;
	enum loa_pattern pattern;
	enum loa_status status;
	enum loa_pattern fallback_pattern;
	enum loa_status fallback_status;
	size_t frame_index;
};

static struct indicator_state indicator;

static void indicator_work_handler(struct k_work *work)
{
	struct indicator_state *state = CONTAINER_OF(work, struct indicator_state, work.work);
	struct loa_pattern_frame frame;
	uint16_t delay_ms;

	k_mutex_lock(&state->lock, K_FOREVER);
	if (!loa_pattern_get_frame(state->pattern, state->status, state->frame_index, &frame)) {
		state->pattern = state->fallback_pattern;
		state->status = state->fallback_status;
		state->frame_index = 0U;
		(void)loa_pattern_get_frame(state->pattern, state->status, 0U, &frame);
	}

	(void)loa_status_output_set_rgb(frame.color);
	state->frame_index++;
	delay_ms = frame.duration_ms;
	k_mutex_unlock(&state->lock);

	if (delay_ms != 0U) {
		(void)k_work_reschedule(&state->work, K_MSEC(delay_ms));
	}
}

int loa_indicator_init(void)
{
	int err = loa_status_output_init();

	if (err != 0) {
		return err;
	}

	k_mutex_init(&indicator.lock);
	k_work_init_delayable(&indicator.work, indicator_work_handler);
	indicator.pattern = LOA_PATTERN_SOLID;
	indicator.status = LOA_STATUS_OFF;
	indicator.fallback_pattern = LOA_PATTERN_SOLID;
	indicator.fallback_status = LOA_STATUS_OFF;
	indicator.frame_index = 0U;
	return 0;
}

void loa_indicator_set(enum loa_pattern pattern, enum loa_status status)
{
	k_mutex_lock(&indicator.lock, K_FOREVER);
	indicator.pattern = pattern;
	indicator.status = status;
	indicator.fallback_pattern = pattern;
	indicator.fallback_status = status;
	indicator.frame_index = 0U;
	k_mutex_unlock(&indicator.lock);
	(void)k_work_reschedule(&indicator.work, K_NO_WAIT);
}

void loa_indicator_play(enum loa_pattern pattern, enum loa_status status,
			enum loa_pattern fallback_pattern, enum loa_status fallback_status)
{
	k_mutex_lock(&indicator.lock, K_FOREVER);
	indicator.pattern = pattern;
	indicator.status = status;
	indicator.fallback_pattern = fallback_pattern;
	indicator.fallback_status = fallback_status;
	indicator.frame_index = 0U;
	k_mutex_unlock(&indicator.lock);
	(void)k_work_reschedule(&indicator.work, K_NO_WAIT);
}
