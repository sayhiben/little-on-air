/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <stdint.h>

#include <zephyr/device.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/pwm.h>
#include <zephyr/drivers/led_strip.h>
#include <zephyr/kernel.h>

#include "status_output.h"

#ifndef LOA_LED_BRIGHTNESS_PERMILLE
#define LOA_LED_BRIGHTNESS_PERMILLE 125U
#endif
#ifndef LOA_PIXEL_BRIGHTNESS_PERMILLE
#define LOA_PIXEL_BRIGHTNESS_PERMILLE 160U
#endif
#ifndef LOA_LED_RED_CALIBRATION_PERMILLE
#define LOA_LED_RED_CALIBRATION_PERMILLE 1000U
#endif
#ifndef LOA_LED_GREEN_CALIBRATION_PERMILLE
#define LOA_LED_GREEN_CALIBRATION_PERMILLE 650U
#endif
#ifndef LOA_LED_BLUE_CALIBRATION_PERMILLE
#define LOA_LED_BLUE_CALIBRATION_PERMILLE 500U
#endif

static const struct pwm_dt_spec red_pwm = PWM_DT_SPEC_GET(DT_ALIAS(pwm_red));
static const struct pwm_dt_spec green_pwm = PWM_DT_SPEC_GET(DT_ALIAS(pwm_green));
static const struct pwm_dt_spec blue_pwm = PWM_DT_SPEC_GET(DT_ALIAS(pwm_blue));

static const struct device *const pixels = DEVICE_DT_GET(DT_ALIAS(loa_pixels));
static struct led_rgb pixel_colors[DT_PROP(DT_ALIAS(loa_pixels), chain_length)];
K_MUTEX_DEFINE(pixel_lock);
static bool pixel_test_active;
static struct loa_rgb latest_colors[DT_PROP(DT_ALIAS(loa_pixels), chain_length)];
static struct k_work_delayable pixel_test_timeout;

static struct led_rgb scaled_pixel(struct loa_rgb color)
{
	return (struct led_rgb){
		.r = color.red * LOA_PIXEL_BRIGHTNESS_PERMILLE / 1000U,
		.g = color.green * LOA_PIXEL_BRIGHTNESS_PERMILLE / 1000U,
		.b = color.blue * LOA_PIXEL_BRIGHTNESS_PERMILLE / 1000U,
	};
}

static int restore_pixels(void)
{
	for (size_t i = 0; i < ARRAY_SIZE(pixel_colors); ++i) {
		pixel_colors[i] = scaled_pixel(latest_colors[i]);
	}
	return led_strip_update_rgb(pixels, pixel_colors, ARRAY_SIZE(pixel_colors));
}

static void pixel_test_expired(struct k_work *work)
{
	ARG_UNUSED(work);
	(void)loa_status_output_test_pixel(UINT8_MAX, (struct loa_rgb){0});
}
BUILD_ASSERT(LOA_PIXEL_BRIGHTNESS_PERMILLE > 0 && LOA_PIXEL_BRIGHTNESS_PERMILLE <= 250,
	     "Front pixel brightness must be within the configured 25 percent ceiling");

static int set_channel(const struct pwm_dt_spec *channel, uint8_t intensity, uint16_t calibration)
{
	uint64_t pulse = channel->period;

	pulse *= intensity;
	pulse *= LOA_LED_BRIGHTNESS_PERMILLE;
	pulse *= calibration;
	pulse /= 255U * 1000U * 1000U;

	return pwm_set_pulse_dt(channel, (uint32_t)pulse);
}

int loa_status_output_init(void)
{
	if (!device_is_ready(pixels)) {
		return -ENODEV;
	}
	k_work_init_delayable(&pixel_test_timeout, pixel_test_expired);
	if (!pwm_is_ready_dt(&red_pwm) || !pwm_is_ready_dt(&green_pwm) ||
	    !pwm_is_ready_dt(&blue_pwm)) {
		return -ENODEV;
	}

	int err = loa_status_output_set_device_rgb((struct loa_rgb){.red = 255U});
	if (err != 0) {
		return err;
	}
	return loa_status_output_set_status(LOA_STATUS_OFF, 0U);
}

int loa_status_output_set_device_rgb(struct loa_rgb color)
{
	int err;

	err = set_channel(&red_pwm, color.red, LOA_LED_RED_CALIBRATION_PERMILLE);
	if (err != 0) {
		return err;
	}

	err = set_channel(&green_pwm, color.green, LOA_LED_GREEN_CALIBRATION_PERMILLE);
	if (err != 0) {
		return err;
	}

	err = set_channel(&blue_pwm, color.blue, LOA_LED_BLUE_CALIBRATION_PERMILLE);
	return err;
}

int loa_status_output_set_status(enum loa_status status, uint32_t elapsed_ms)
{
	if (!loa_status_is_valid(status)) {
		return -EINVAL;
	}
	k_mutex_lock(&pixel_lock, K_FOREVER);
	for (size_t i = 0; i < ARRAY_SIZE(latest_colors); ++i) {
		latest_colors[i] = loa_status_color_at(status, elapsed_ms, i);
	}
	int err = pixel_test_active ? 0 : restore_pixels();
	k_mutex_unlock(&pixel_lock);
	return err;
}

int loa_status_output_test_pixel(uint8_t index, struct loa_rgb color)
{
	int err;
	if (index != UINT8_MAX && index >= ARRAY_SIZE(pixel_colors)) {
		return -EINVAL;
	}
	k_mutex_lock(&pixel_lock, K_FOREVER);
	if (index == UINT8_MAX) {
		pixel_test_active = false;
		(void)k_work_cancel_delayable(&pixel_test_timeout);
		err = restore_pixels();
	} else {
		for (size_t i = 0; i < ARRAY_SIZE(pixel_colors); ++i) {
			pixel_colors[i] = i == index ? scaled_pixel(color) : (struct led_rgb){0};
		}
		err = led_strip_update_rgb(pixels, pixel_colors, ARRAY_SIZE(pixel_colors));
		if (err == 0) {
			pixel_test_active = true;
			(void)k_work_reschedule(&pixel_test_timeout, K_SECONDS(120));
		}
	}
	k_mutex_unlock(&pixel_lock);
	return err;
}

bool loa_status_output_test_active(void)
{
	k_mutex_lock(&pixel_lock, K_FOREVER);
	bool active = pixel_test_active;
	k_mutex_unlock(&pixel_lock);
	return active;
}
