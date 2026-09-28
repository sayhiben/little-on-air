/* SPDX-License-Identifier: MIT */
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <zephyr/settings/settings.h>
#include <zephyr/kernel.h>
#include <zephyr/drivers/pwm.h>
#include <zephyr/drivers/led_strip.h>
#include "status_output.h"
#include "brightness_settings.h"

struct device fake_pixels;
static uint32_t pwm[3];
static struct led_rgb front[4];
static unsigned int frames;
static uint8_t flash[LOA_BRIGHTNESS_RECORD_LEN];
static unsigned int saves;
static bool fail_save, fail_output;
extern test_settings_handler loa_light_handler;
int settings_save_one(const char *key, const void *data, size_t len)
{
	assert(strcmp(key, "loa_light/levels") == 0 && len == sizeof(flash));
	++saves;
	if (fail_save) {
		return -EIO;
	}
	memcpy(flash, data, len);
	return 0;
}
static ssize_t read_flash(void *arg, void *data, size_t len)
{
	(void)arg;
	memcpy(data, flash, len);
	return len;
}
static void restart(void)
{
	assert(loa_light_handler("levels", sizeof(flash), read_flash, NULL) == 0);
	assert(loa_brightness_settings_init() == 0);
}
static int write_levels(uint32_t id, uint8_t frame, uint8_t indicator)
{
	struct loa_brightness value = {id, frame, indicator};
	uint8_t packet[LOA_BRIGHTNESS_PAYLOAD_LEN];
	assert(loa_brightness_encode(packet, &value) == 0);
	return loa_brightness_settings_write(packet, sizeof(packet));
}
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
	if (fail_output) {
		return -EIO;
	}
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
	// Apply retained brightness to the current phase without restarting the mood.
	assert(loa_brightness_settings_init() == 0);
	assert(write_levels(1, 100, 100) == 0);
	assert(saves == 1 && pwm[0] == 250000);
	for (int i = 0; i < 4; ++i) {
		struct loa_rgb raw = loa_status_color_at(LOA_STATUS_SPECIAL, 3456, i);
		assert(front[i].r == raw.red / 2 && front[i].g == raw.green / 2 &&
		       front[i].b == raw.blue / 2);
	}
	before = frames;
	assert(write_levels(1, 100, 100) == 0 && saves == 1 && frames == before);
	assert(write_levels(1, 0, 100) == -EINVAL && saves == 1);
	assert(write_levels(0, 0, 0) == -EINVAL && saves == 1);
	// Reading does not write flash/output, and restores survive reconnect/reboot.
	struct loa_brightness readback = loa_brightness_settings_get();
	assert(readback.transaction_id == 1 && readback.frame == 100 && readback.indicator == 100);
	assert(frames == before && saves == 1);
	restart();
	assert(loa_brightness_settings_get().transaction_id == 1 && saves == 1);
	assert(write_levels(1, 100, 100) == 0 && saves == 1);
	fail_save = true;
	assert(write_levels(2, 0, 0) == -EIO);
	assert(frames == before && pwm[0] == 250000);
	assert(loa_brightness_settings_get().transaction_id == 1);
	fail_save = false;
	fail_output = true;
	assert(write_levels(2, 0, 0) == -EIO);
	assert(loa_brightness_settings_get().transaction_id == 1); // Never ACK unapplied output.
	fail_output = false;
	restart(); // A durable write interrupted before application is applied on boot.
	assert(loa_brightness_settings_get().transaction_id == 2 && pwm[0] == 50000);
	// Indicator-only changes do not transmit a frame, including while blinking off.
	assert(loa_status_output_set_device_rgb((struct loa_rgb){0}) == 0);
	before = frames;
	assert(write_levels(3, 0, 100) == 0 && frames == before && pwm[0] == 0);
	assert(loa_status_output_test_pixel(2, (struct loa_rgb){.red = 255}) == 0);
	assert(write_levels(4, 100, 100) == 0 && front[2].r == 127 && front[0].r == 0);
	assert(loa_status_output_test_pixel(UINT8_MAX, (struct loa_rgb){0}) == 0);
	// Corrupt/old schema/truncated storage falls back to current defaults.
	flash[3] ^= 1;
	restart();
	assert(loa_brightness_settings_get().transaction_id == 0);
	assert(loa_brightness_settings_get().frame == 50);
	assert(loa_light_handler("levels", 1, read_flash, NULL) == 0);
	assert(loa_brightness_settings_init() == 0);
	assert(write_levels(5, 50, 50) == 0);
	assert(loa_status_output_set_device_rgb((struct loa_rgb){.red = 255}) == 0);
	assert(pwm[0] == 125000);
	puts("PASS separate power LED, all animated strip frames at 16%, device blink isolation, "
	     "brightness persistence/failures/idempotency/phase/test restoration");
}
