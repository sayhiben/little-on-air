/* SPDX-License-Identifier: MIT */
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <zephyr/kernel.h>
#include <zephyr/drivers/pwm.h>
#include <zephyr/drivers/led_strip.h>
#include <little_on_air/status_output.h>

struct device fake_pixels;
static uint32_t pwm[3];
static struct led_rgb front[4];
static unsigned int frames;
int pwm_set_pulse_dt(const struct pwm_dt_spec *spec, uint32_t pulse)
{
	assert(spec->channel < 3);
	pwm[spec->channel] = pulse;
	return 0;
}
int led_strip_update_rgb(const struct device *device, struct led_rgb *pixels, size_t count)
{
	(void)device;
	assert(count == 4);
	memcpy(front, pixels, sizeof(front));
	++frames;
	memset(pixels, 0xcd, sizeof(front)); /* Model a driver that changes its scratch input. */
	return 0;
}
int k_work_reschedule(struct k_work_delayable *work, uint32_t delay)
{
	(void)work;
	(void)delay;
	return 0;
}
int k_work_cancel_delayable(struct k_work_delayable *work)
{
	(void)work;
	return 0;
}
uint32_t k_uptime_get_32(void)
{
	return 0;
}
int main(void)
{
	assert(loa_status_output_init() == 0);
	assert(pwm[0] == 125000 && pwm[1] == 0 && pwm[2] == 0);
	for (int i = 0; i < 4; ++i) {
		assert(front[i].r == 0 && front[i].g == 0 && front[i].b == 0);
	}
	for (int state = 0; state < LOA_STATUS_COUNT; ++state) {
		for (uint32_t t = 0; t < 20000; t += 50) {
			assert(loa_status_output_set_status(state, t) == 0);
			assert(pwm[0] == 125000 && pwm[1] == 0 && pwm[2] == 0);
			for (int i = 0; i < 4; ++i) {
				struct loa_rgb expected = loa_status_color_at(state, t, i);
				assert(front[i].r == expected.red * 160U / 1000U);
				assert(front[i].g == expected.green * 160U / 1000U);
				assert(front[i].b == expected.blue * 160U / 1000U);
			}
		}
	}
	unsigned int before = frames;
	assert(loa_status_output_set_device_rgb((struct loa_rgb){.red = 0}) == 0);
	assert(frames == before && pwm[0] == 0); // Device blink never writes the strip.
	assert(loa_status_output_set_device_rgb((struct loa_rgb){.red = 255}) == 0);
	assert(frames == before);
	assert(loa_status_output_set_status(LOA_STATUS_SPECIAL, 3456) == 0);
	struct led_rgb saved[4];
	memcpy(saved, front, sizeof(saved));
	assert(loa_status_output_test_pixel(0, (struct loa_rgb){.green = 255}) == 0);
	assert(front[0].g == 40 && pwm[0] == 125000);
	assert(loa_status_output_test_pixel(UINT8_MAX, (struct loa_rgb){0}) == 0);
	assert(memcmp(saved, front, sizeof(saved)) == 0);
	puts("PASS separate power LED, all animated strip frames at 16%, device blink isolation, "
	     "test restoration");
}
