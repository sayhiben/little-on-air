/* SPDX-License-Identifier: MIT */
#include <assert.h>
#include <stdio.h>
#include <zephyr/kernel.h>
#include "mood_indicator.h"
#include "status_output.h"

static uint32_t now, due, rendered_elapsed;
static unsigned int render_count;
static struct k_work_delayable *pending;
static struct loa_rgb rendered;

uint32_t k_uptime_get_32(void)
{
	return now;
}
int k_work_reschedule(struct k_work_delayable *work, uint32_t delay_ms)
{
	pending = work;
	due = now + delay_ms;
	return 0;
}
int loa_status_output_init(void)
{
	return 0;
}
static int render_color(struct loa_rgb color)
{
	rendered = color;
	++render_count;
	now += 2; /* Deliberate output latency: cadence must not accumulate it. */
	return 0;
}
int loa_status_output_set_status(enum loa_status status, uint32_t elapsed)
{
	rendered_elapsed = elapsed;
	return render_color(loa_status_color_at(status, elapsed, 0));
}
static void run_next(void)
{
	assert(pending);
	struct k_work_delayable *work = pending;
	now = due;
	pending = NULL;
	work->work.handler(&work->work);
}
int main(void)
{
	assert(loa_mood_indicator_init() == 0);
	loa_mood_indicator_set(LOA_STATUS_REQUEST);
	for (unsigned int frame = 0; frame < 2000; ++frame) {
		run_next();
		assert(rendered_elapsed == frame * 600U);
		assert(rendered.green == (frame % 2U ? 0 : 255));
		const unsigned int before = render_count;
		const uint32_t next_due = due;
		loa_mood_indicator_set(LOA_STATUS_REQUEST);
		assert(due == next_due && render_count == before);
	}
	puts("PASS 20 minutes of Request: no cadence drift or restart on same-state reconcile");

	loa_mood_indicator_set(LOA_STATUS_SPECIAL);
	for (unsigned int frame = 0; frame < 500; ++frame) {
		run_next();
		assert(rendered_elapsed == frame * 50U);
		const uint32_t next_due = due;
		loa_mood_indicator_set(LOA_STATUS_SPECIAL);
		assert(due == next_due);
	}
	loa_mood_indicator_set(LOA_STATUS_ON_AIR);
	run_next();
	assert(rendered.red == 255 && rendered.green == 0 && rendered.blue == 0);
	assert(!pending);
	loa_mood_indicator_set(LOA_STATUS_ON_AIR);
	assert(!pending);
	loa_mood_indicator_set(LOA_STATUS_OFF);
	run_next();
	assert(rendered.red == 0 && rendered.green == 0 && rendered.blue == 0);
	assert(!pending);
	puts("PASS Special cadence, animation cancellation, and quiet repeated solid state");
	now = UINT32_MAX - 100;
	loa_mood_indicator_set(LOA_STATUS_REQUEST);
	for (unsigned int frame = 0; frame < 4; ++frame) {
		run_next();
		assert(rendered_elapsed == frame * 600U);
		assert(rendered.green == (frame % 2U ? 0 : 255));
	}
	puts("PASS animation timer across uptime wrap");
}
