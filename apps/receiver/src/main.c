/* SPDX-License-Identifier: MIT */
#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/settings/settings.h>

#include <little_on_air/indicator.h>
#include <little_on_air/reset_input.h>
#include <little_on_air/store.h>

#include "ble_server.h"

LOG_MODULE_REGISTER(loa_receiver_main);

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
	LOG_INF("boot button_press=%u factory_reset=%u", input.button_press, input.factory_reset);

	err = bt_enable(NULL);
	if (err != 0) {
		LOG_ERR("Bluetooth enable failed err=%d", err);
		return err;
	}
	LOG_INF("Bluetooth enabled");
	err = settings_load();
	if (err != 0) {
		LOG_ERR("settings load failed err=%d", err);
		return err;
	}
	LOG_INF("settings loaded");

	if (input.factory_reset) {
		err = bt_unpair(BT_ID_DEFAULT, BT_ADDR_LE_ANY);
		LOG_INF("factory reset unpair result=%d", err);
		err = loa_store_clear_state();
		LOG_INF("factory reset state clear result=%d", err);
	} else if (loa_store_has_state()) {
		initial_state = loa_store_get_state();
	}
	LOG_INF("initial transaction=0x%08x status=%u", initial_state.transaction_id,
		initial_state.status);

	err = loa_ble_server_init(&initial_state);
	if (err != 0) {
		LOG_ERR("BLE server init failed err=%d", err);
		return err;
	}
	err = loa_ble_server_start(input.button_press || input.factory_reset);
	if (err != 0) {
		LOG_ERR("BLE server start failed err=%d", err);
		return err;
	}
	LOG_INF("receiver ready");

	while (true) {
		k_sleep(K_FOREVER);
	}
	return 0;
}
