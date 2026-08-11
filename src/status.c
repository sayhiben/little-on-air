/* SPDX-License-Identifier: MIT */
#include <little_on_air/status.h>

bool loa_status_is_valid(enum loa_status status)
{
	return status >= LOA_STATUS_OFF && status <= LOA_STATUS_OKAY;
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
	default:
		return LOA_STATUS_OFF;
	}
}

struct loa_rgb loa_status_rgb(enum loa_status status)
{
	switch (status) {
	case LOA_STATUS_WARN:
		return (struct loa_rgb){.red = 255U, .green = 255U, .blue = 0U};
	case LOA_STATUS_ON_AIR:
		return (struct loa_rgb){.red = 255U, .green = 0U, .blue = 0U};
	case LOA_STATUS_OKAY:
		return (struct loa_rgb){.red = 0U, .green = 255U, .blue = 0U};
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
	default:
		return "invalid";
	}
}
