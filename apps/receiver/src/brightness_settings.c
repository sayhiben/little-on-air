/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>
#include <zephyr/kernel.h>
#include <zephyr/settings/settings.h>
#include "brightness_settings.h"
#include "status_output.h"

#define SETTINGS_KEY "loa_light/levels"
static struct loa_brightness saved = {0U, 50U, 50U};
static struct loa_brightness applied = {0U, 50U, 50U};
K_MUTEX_DEFINE(settings_lock);

static int load(const char *name, size_t len, settings_read_cb read_cb, void *cb_arg)
{
	uint8_t record[LOA_BRIGHTNESS_RECORD_LEN];
	if (strcmp(name, "levels") != 0) {
		return -ENOENT;
	}
	saved = loa_brightness_defaults();
	if (len == sizeof(record) && read_cb(cb_arg, record, sizeof(record)) == sizeof(record)) {
		(void)loa_brightness_record_decode(&saved, record, sizeof(record));
	}
	return 0;
}
SETTINGS_STATIC_HANDLER_DEFINE(loa_light, "loa_light", NULL, load, NULL, NULL);

static int persist(const struct loa_brightness *value, void *context)
{
	ARG_UNUSED(context);
	uint8_t record[LOA_BRIGHTNESS_RECORD_LEN];
	loa_brightness_record_encode(record, value);
	int err = settings_save_one(SETTINGS_KEY, record, sizeof(record));
	if (err == 0) {
		saved = *value;
	}
	return err;
}

static int apply(const struct loa_brightness *value, void *context)
{
	ARG_UNUSED(context);
	return loa_status_output_set_brightness(value->frame, value->indicator);
}

int loa_brightness_settings_init(void)
{
	int err = apply(&saved, NULL);
	if (err == 0) {
		applied = saved;
	}
	return err;
}

struct loa_brightness loa_brightness_settings_get(void)
{
	k_mutex_lock(&settings_lock, K_FOREVER);
	struct loa_brightness value = applied;
	k_mutex_unlock(&settings_lock);
	return value;
}

int loa_brightness_settings_write(const void *payload, size_t len)
{
	k_mutex_lock(&settings_lock, K_FOREVER);
	int err = loa_brightness_process(&applied, payload, len, persist, apply, NULL);
	k_mutex_unlock(&settings_lock);
	return err;
}
