/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>

#include <zephyr/settings/settings.h>

#include <little_on_air/record.h>
#include <little_on_air/store.h>

#define LOA_SETTINGS_KEY "loa/state"

static struct loa_message stored_state = {
	.transaction_id = 0U,
	.status = LOA_STATUS_OFF,
};
static bool stored_state_valid;

static int loa_settings_set(const char *name, size_t len, settings_read_cb read_cb, void *cb_arg)
{
	uint8_t record[LOA_RECORD_LEN];
	int read_len;

	if (strcmp(name, "state") != 0 || len != sizeof(record)) {
		return -ENOENT;
	}

	read_len = read_cb(cb_arg, record, sizeof(record));
	if (read_len != sizeof(record) ||
	    !loa_record_decode_or_default(&stored_state, record, sizeof(record))) {
		stored_state_valid = false;
		return 0;
	}

	stored_state_valid = true;
	return 0;
}

SETTINGS_STATIC_HANDLER_DEFINE(loa, "loa", NULL, loa_settings_set, NULL, NULL);

bool loa_store_has_state(void)
{
	return stored_state_valid;
}

struct loa_message loa_store_get_state(void)
{
	return stored_state;
}

int loa_store_save_state(const struct loa_message *state)
{
	uint8_t record[LOA_RECORD_LEN];
	int err;

	if (state == NULL || !loa_status_is_valid(state->status)) {
		return -EINVAL;
	}

	loa_record_encode(record, state);
	err = settings_save_one(LOA_SETTINGS_KEY, record, sizeof(record));
	if (err == 0) {
		stored_state = *state;
		stored_state_valid = true;
	}

	return err;
}

int loa_store_clear_state(void)
{
	int err = settings_delete(LOA_SETTINGS_KEY);

	if (err == 0 || err == -ENOENT) {
		stored_state = (struct loa_message){
			.transaction_id = 0U,
			.status = LOA_STATUS_OFF,
		};
		stored_state_valid = false;
		return 0;
	}

	return err;
}
