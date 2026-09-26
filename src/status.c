/* SPDX-License-Identifier: MIT */
#include <little_on_air/status.h>

bool loa_status_is_valid(enum loa_status status)
{
	return status >= LOA_STATUS_OFF && status < LOA_STATUS_COUNT;
}

enum loa_status loa_status_next(enum loa_status status)
{
	switch (status) {
	case LOA_STATUS_OFF:
		return LOA_STATUS_WARN;
	case LOA_STATUS_WARN:
		return LOA_STATUS_ON_AIR;
	case LOA_STATUS_ON_AIR:
		return LOA_STATUS_OKAY;
	case LOA_STATUS_OKAY:
		return LOA_STATUS_REQUEST;
	case LOA_STATUS_REQUEST:
		return LOA_STATUS_SPECIAL;
	case LOA_STATUS_SPECIAL:
	default:
		return LOA_STATUS_OFF;
	}
}

struct loa_rgb loa_status_rgb(enum loa_status status)
{
	switch (status) {
	case LOA_STATUS_WARN:
		return (struct loa_rgb){.red = 255U, .green = 112U, .blue = 0U};
	case LOA_STATUS_ON_AIR:
		return (struct loa_rgb){.red = 255U, .green = 0U, .blue = 0U};
	case LOA_STATUS_OKAY:
	case LOA_STATUS_REQUEST:
		return (struct loa_rgb){.red = 0U, .green = 255U, .blue = 0U};
	case LOA_STATUS_SPECIAL:
		return (struct loa_rgb){.red = 255U, .green = 0U, .blue = 160U};
	case LOA_STATUS_OFF:
	default:
		return (struct loa_rgb){0};
	}
}

const char *loa_status_name(enum loa_status status)
{
	switch (status) {
	case LOA_STATUS_OFF:
		return "off";
	case LOA_STATUS_WARN:
		return "warn";
	case LOA_STATUS_ON_AIR:
		return "on-air";
	case LOA_STATUS_OKAY:
		return "okay";
	case LOA_STATUS_REQUEST:
		return "request";
	case LOA_STATUS_SPECIAL:
		return "special";
	default:
		return "invalid";
	}
}

static struct loa_rgb rainbow(uint8_t hue)
{
	if (hue < 85U) {
		return (struct loa_rgb){255U - hue * 3U, hue * 3U, 0U};
	}
	if (hue < 170U) {
		hue -= 85U;
		return (struct loa_rgb){0U, 255U - hue * 3U, hue * 3U};
	}
	hue -= 170U;
	return (struct loa_rgb){hue * 3U, 0U, 255U - hue * 3U};
}

struct loa_rgb loa_status_color_at(enum loa_status status, uint32_t elapsed_ms, uint8_t pixel)
{
	if (status == LOA_STATUS_REQUEST) {
		return elapsed_ms % 1200U < 600U ? loa_status_rgb(status) : (struct loa_rgb){0};
	}
	if (status == LOA_STATUS_SPECIAL) {
		/* A diagonal gradient across the physical four-corner layout,
		 * drifting one complete hue cycle in 20 seconds. Equal time offsets
		 * preserve the diagonal instead of chasing around the perimeter.
		 */
		static const uint8_t corner_hues[] = {0U, 140U, 224U, 84U};
		const uint8_t phase = (elapsed_ms % 20000U) * 256U / 20000U;
		return rainbow((uint8_t)(phase + corner_hues[pixel % 4U]));
	}
	return loa_status_rgb(status);
}

uint16_t loa_status_animation_interval_ms(enum loa_status status)
{
	return status == LOA_STATUS_REQUEST ? 600U : status == LOA_STATUS_SPECIAL ? 50U : 0U;
}
