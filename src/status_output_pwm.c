/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <stdint.h>

#include <zephyr/device.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/pwm.h>

#include <little_on_air/status_output.h>

#ifndef LOA_LED_BRIGHTNESS_PERMILLE
#define LOA_LED_BRIGHTNESS_PERMILLE 125U
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
	if (!pwm_is_ready_dt(&red_pwm) || !pwm_is_ready_dt(&green_pwm) ||
	    !pwm_is_ready_dt(&blue_pwm)) {
		return -ENODEV;
	}

	return loa_status_output_set_rgb((struct loa_rgb){0});
}

int loa_status_output_set_rgb(struct loa_rgb color)
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

	return set_channel(&blue_pwm, color.blue, LOA_LED_BLUE_CALIBRATION_PERMILLE);
}
