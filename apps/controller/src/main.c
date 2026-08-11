/* SPDX-License-Identifier: MIT */
#include <errno.h>

#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/kernel.h>
#include <zephyr/random/random.h>
#include <zephyr/settings/settings.h>

#include <little_on_air/controller_fsm.h>
#include <little_on_air/indicator.h>
#include <little_on_air/reset_input.h>
#include <little_on_air/store.h>

#include "ble_client.h"

#define COMMAND_TIMEOUT        K_SECONDS(8)
#define ERROR_PATTERN_DURATION K_MSEC(1200)

static void sleep_forever(void)
{
	while (true) {
		k_sleep(K_FOREVER);
	}
}

static void show_confirmed(struct loa_controller_fsm *fsm, const struct loa_message *snapshot,
			   bool pairing_happened)
{
	(void)loa_controller_on_snapshot(fsm, snapshot);
	(void)loa_store_save_state(snapshot);
	if (pairing_happened) {
		loa_indicator_play(LOA_PATTERN_PAIR_SUCCESS, snapshot->status, LOA_PATTERN_SOLID,
				   snapshot->status);
	} else {
		loa_indicator_set(LOA_PATTERN_SOLID, snapshot->status);
	}
}

static int reconcile_with_retries(struct loa_controller_fsm *fsm, bool pairing_mode)
{
	static const uint8_t retry_delays_seconds[] = {0U, 1U, 2U, 4U, 8U};
	struct loa_message snapshot;
	bool pairing_happened = false;

	loa_controller_begin_reconcile(fsm);
	for (size_t attempt = 0U; attempt < ARRAY_SIZE(retry_delays_seconds); ++attempt) {
		if (retry_delays_seconds[attempt] != 0U) {
			loa_indicator_set(LOA_PATTERN_DESYNCED, fsm->confirmed_status);
			k_sleep(K_SECONDS(retry_delays_seconds[attempt]));
		}

		loa_indicator_set(LOA_PATTERN_SYNCING, fsm->confirmed_status);
		const k_timeout_t timeout =
			pairing_mode && attempt == 0U ? K_SECONDS(60) : COMMAND_TIMEOUT;
		if (loa_ble_client_reconcile(&snapshot, timeout, &pairing_happened) == 0) {
			show_confirmed(fsm, &snapshot, pairing_happened);
			return 0;
		}
	}

	(void)loa_controller_on_retries_exhausted(fsm);
	loa_indicator_set(LOA_PATTERN_DESYNCED, fsm->confirmed_status);
	return -ETIMEDOUT;
}

int main(void)
{
	struct loa_controller_fsm fsm;
	struct loa_boot_input input;
	struct loa_message persisted = {
		.transaction_id = 0U,
		.status = LOA_STATUS_OFF,
	};
	enum loa_controller_action action;
	bool has_bond;
	int err;

	err = loa_indicator_init();
	if (err != 0) {
		return err;
	}
	loa_indicator_set(LOA_PATTERN_DESYNCED, LOA_STATUS_OFF);
	input = loa_reset_input_capture();

	err = loa_ble_client_init();
	if (err != 0) {
		return err;
	}
	err = bt_enable(NULL);
	if (err != 0) {
		return err;
	}
	err = settings_load();
	if (err != 0) {
		return err;
	}

	if (input.factory_reset) {
		(void)loa_ble_client_unpair_all();
		(void)loa_store_clear_state();
	}
	if (loa_store_has_state()) {
		persisted = loa_store_get_state();
	}

	has_bond = loa_ble_client_has_bond();
	loa_controller_fsm_init(&fsm, persisted.status);
	action = loa_controller_on_boot(&fsm, has_bond, input.button_press, input.factory_reset);

	switch (action) {
	case LOA_ACTION_PAIR:
		(void)reconcile_with_retries(&fsm, true);
		break;
	case LOA_ACTION_RECONCILE:
		(void)reconcile_with_retries(&fsm, false);
		break;
	case LOA_ACTION_SEND: {
		struct loa_message ack;
		bool new_pairing = false;
		uint32_t transaction_id = sys_rand32_get();

		if (transaction_id == 0U) {
			transaction_id = 1U;
		}
		loa_controller_set_transaction(&fsm, transaction_id);
		loa_indicator_set(LOA_PATTERN_SENDING, fsm.pending.status);

		err = loa_ble_client_send(&fsm.pending, &ack, COMMAND_TIMEOUT, &new_pairing);
		(void)loa_controller_on_write_result(&fsm, err == 0);
		if (err == 0 && loa_controller_on_ack(&fsm, &ack) == LOA_ACTION_CONFIRM) {
			(void)loa_store_save_state(&ack);
			loa_indicator_set(LOA_PATTERN_SOLID, ack.status);
			break;
		}

		(void)loa_controller_on_timeout(&fsm);
		loa_indicator_play(LOA_PATTERN_ERROR, fsm.confirmed_status, LOA_PATTERN_SYNCING,
				   fsm.confirmed_status);
		k_sleep(ERROR_PATTERN_DURATION);
		(void)reconcile_with_retries(&fsm, false);
		break;
	}
	case LOA_ACTION_SHOW_DESYNCED:
	default:
		loa_indicator_set(LOA_PATTERN_DESYNCED, fsm.confirmed_status);
		break;
	}

	sleep_forever();
	return 0;
}
