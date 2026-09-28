/* SPDX-License-Identifier: MIT */
#pragma once
#include <little_on_air/brightness.h>

int loa_brightness_settings_init(void);
struct loa_brightness loa_brightness_settings_get(void);
int loa_brightness_settings_write(const void *payload, size_t len);
