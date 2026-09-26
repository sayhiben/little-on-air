/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdbool.h>
struct device {
	int unused;
};
extern struct device fake_pixels;
static inline bool device_is_ready(const struct device *device)
{
	(void)device;
	return true;
}
