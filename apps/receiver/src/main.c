/* SPDX-License-Identifier: MIT */
#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/kernel.h>
#include <zephyr/settings/settings.h>

#include <little_on_air/indicator.h>
#include <little_on_air/reset_input.h>
#include <little_on_air/store.h>

#include "ble_server.h"

int main(void)
{
	struct loa_boot_input input;
	struct loa_message initial_state = {
		.transaction_id = 0U,
		.status = LOA_STATUS_OFF,
	};
	int err;

	err = loa_indicator_init();
	if (err != 0) {
		return err;
	}
	input = loa_reset_input_capture();
	loa_indicator_set(LOA_PATTERN_DESYNCED, LOA_STATUS_OFF);

	err = bt_enable(NULL);
	if (err != 0) {
		return err;
	}
	err = settings_load();
	if (err != 0) {
		return err;
	}

	if (input.factory_reset) {
		(void)bt_unpair(BT_ID_DEFAULT, BT_ADDR_LE_ANY);
		(void)loa_store_clear_state();
	} else if (loa_store_has_state()) {
		initial_state = loa_store_get_state();
	}

	err = loa_ble_server_init(&initial_state);
	if (err != 0) {
		return err;
	}
	err = loa_ble_server_start(input.button_press || input.factory_reset);
	if (err != 0) {
		return err;
	}

	while (true) {
		k_sleep(K_FOREVER);
	}
	return 0;
}
