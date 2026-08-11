/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>

#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/bluetooth/gatt.h>
#include <zephyr/bluetooth/hci.h>
#include <zephyr/bluetooth/uuid.h>
#include <zephyr/kernel.h>
#include <zephyr/sys/atomic.h>

#include <little_on_air/indicator.h>
#include <little_on_air/protocol.h>
#include <little_on_air/receiver_processor.h>
#include <little_on_air/store.h>

#include "ble_server.h"

#define PAIRING_WINDOW           K_SECONDS(60)
#define PAIR_SUCCESS_DURATION_MS 900U
#define ADV_FAST_INTERVAL        0x00a0U
#define ADV_SLOW_INTERVAL        0x0640U

static struct bt_uuid_128 service_uuid = BT_UUID_INIT_128(LOA_BT_UUID_SERVICE_VAL);
static struct bt_uuid_128 command_uuid = BT_UUID_INIT_128(LOA_BT_UUID_COMMAND_VAL);
static struct bt_uuid_128 state_uuid = BT_UUID_INIT_128(LOA_BT_UUID_STATE_VAL);

static struct loa_receiver_processor processor;
static struct bt_conn *current_conn;
static struct k_work indication_work;
static struct k_work_delayable pairing_timeout_work;
static struct k_work_delayable pair_success_done_work;
static struct bt_gatt_indicate_params indication_params;
static uint8_t state_payload[LOA_PROTOCOL_PAYLOAD_LEN];
static atomic_t indicating;
static atomic_t pair_success_active;
static bool indications_enabled;
static bool advertising;
static bool pairing_window_open;
static bool bonded;

static int persist_state(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(user_data);
	return loa_store_save_state(state);
}

static int apply_state(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(user_data);
	loa_indicator_set(LOA_PATTERN_SOLID, state->status);
	return 0;
}

static void indication_destroy(struct bt_gatt_indicate_params *params)
{
	ARG_UNUSED(params);
	atomic_clear(&indicating);
}

static void indication_complete(struct bt_conn *conn, struct bt_gatt_indicate_params *params,
				uint8_t err)
{
	ARG_UNUSED(conn);
	ARG_UNUSED(params);
	ARG_UNUSED(err);
}

static void send_indication(struct k_work *work);

static int acknowledge_state(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(user_data);
	int err = loa_protocol_encode(state_payload, state);

	if (err == 0) {
		k_work_submit(&indication_work);
	}
	return err;
}

static ssize_t read_state(struct bt_conn *conn, const struct bt_gatt_attr *attr, void *buf,
			  uint16_t len, uint16_t offset)
{
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	ARG_UNUSED(attr);
	if (loa_protocol_encode(payload, &processor.current) != 0) {
		return BT_GATT_ERR(BT_ATT_ERR_UNLIKELY);
	}

	return bt_gatt_attr_read(conn, attr, buf, len, offset, payload, sizeof(payload));
}

static ssize_t write_command(struct bt_conn *conn, const struct bt_gatt_attr *attr, const void *buf,
			     uint16_t len, uint16_t offset, uint8_t flags)
{
	int err;

	ARG_UNUSED(conn);
	ARG_UNUSED(attr);
	if (offset != 0U) {
		return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
	}
	if ((flags & BT_GATT_WRITE_FLAG_PREPARE) != 0U || len != LOA_PROTOCOL_PAYLOAD_LEN) {
		return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
	}

	err = loa_receiver_process_payload(&processor, buf, len);
	if (err == -EINVAL) {
		return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
	}
	if (err != 0) {
		return BT_GATT_ERR(BT_ATT_ERR_UNLIKELY);
	}

	return len;
}

static void state_ccc_changed(const struct bt_gatt_attr *attr, uint16_t value)
{
	ARG_UNUSED(attr);
	indications_enabled = value == BT_GATT_CCC_INDICATE;
}

BT_GATT_SERVICE_DEFINE(
	loa_service, BT_GATT_PRIMARY_SERVICE(&service_uuid),
	BT_GATT_CHARACTERISTIC(&command_uuid.uuid, BT_GATT_CHRC_WRITE, BT_GATT_PERM_WRITE_ENCRYPT,
			       NULL, write_command, NULL),
	BT_GATT_CHARACTERISTIC(&state_uuid.uuid, BT_GATT_CHRC_READ | BT_GATT_CHRC_INDICATE,
			       BT_GATT_PERM_READ_ENCRYPT, read_state, NULL, NULL),
	BT_GATT_CCC(state_ccc_changed, BT_GATT_PERM_READ | BT_GATT_PERM_WRITE_ENCRYPT));

static void send_indication(struct k_work *work)
{
	ARG_UNUSED(work);
	if (!indications_enabled || current_conn == NULL || !atomic_cas(&indicating, 0, 1)) {
		return;
	}

	indication_params.attr = &loa_service.attrs[4];
	indication_params.func = indication_complete;
	indication_params.destroy = indication_destroy;
	indication_params.data = state_payload;
	indication_params.len = sizeof(state_payload);
	if (bt_gatt_indicate(current_conn, &indication_params) != 0) {
		atomic_clear(&indicating);
	}
}

static const struct bt_data advertising_data[] = {
	BT_DATA_BYTES(BT_DATA_FLAGS, BT_LE_AD_GENERAL | BT_LE_AD_NO_BREDR),
	BT_DATA_BYTES(BT_DATA_UUID128_ALL, LOA_BT_UUID_SERVICE_VAL),
};

static const struct bt_data scan_response_data[] = {
	BT_DATA(BT_DATA_NAME_COMPLETE, CONFIG_BT_DEVICE_NAME, sizeof(CONFIG_BT_DEVICE_NAME) - 1U),
};

static void bond_to_filter_list(const struct bt_bond_info *info, void *user_data)
{
	int *result = user_data;
	int err = bt_le_filter_accept_list_add(&info->addr);

	if (*result == 0 && err != 0) {
		*result = err;
	}
}

static int configure_filter_list(void)
{
	int err = bt_le_filter_accept_list_clear();

	if (err != 0) {
		return err;
	}
	bt_foreach_bond(BT_ID_DEFAULT, bond_to_filter_list, &err);
	return err;
}

static int start_advertising(bool fast, bool filter_connections)
{
	struct bt_le_adv_param params = {
		.id = BT_ID_DEFAULT,
		.sid = 0U,
		.secondary_max_skip = 0U,
		.options = BT_LE_ADV_OPT_CONN,
		.interval_min = fast ? ADV_FAST_INTERVAL : ADV_SLOW_INTERVAL,
		.interval_max = fast ? ADV_FAST_INTERVAL : ADV_SLOW_INTERVAL,
		.peer = NULL,
	};
	int err;

	if (advertising) {
		(void)bt_le_adv_stop();
		advertising = false;
	}

	if (filter_connections) {
		err = configure_filter_list();
		if (err != 0) {
			return err;
		}
		params.options |= BT_LE_ADV_OPT_FILTER_CONN;
	}

	err = bt_le_adv_start(&params, advertising_data, ARRAY_SIZE(advertising_data),
			      scan_response_data, ARRAY_SIZE(scan_response_data));
	if (err == 0) {
		advertising = true;
	}
	return err;
}

static void pairing_window_expired(struct k_work *work)
{
	ARG_UNUSED(work);
	pairing_window_open = false;
	if (current_conn != NULL) {
		return;
	}

	if (advertising) {
		(void)bt_le_adv_stop();
		advertising = false;
	}
	if (bonded) {
		loa_indicator_set(LOA_PATTERN_SOLID, processor.current.status);
		(void)start_advertising(false, true);
	} else {
		loa_indicator_set(LOA_PATTERN_DESYNCED, LOA_STATUS_OFF);
	}
}

static void pair_success_finished(struct k_work *work)
{
	ARG_UNUSED(work);
	atomic_clear(&pair_success_active);
}

static void connected(struct bt_conn *conn, uint8_t err)
{
	if (err != 0U) {
		return;
	}

	advertising = false;
	current_conn = bt_conn_ref(conn);
	loa_indicator_set(LOA_PATTERN_SYNCING, processor.current.status);
}

static void disconnected(struct bt_conn *conn, uint8_t reason)
{
	ARG_UNUSED(reason);
	if (conn != current_conn) {
		return;
	}

	bt_conn_unref(current_conn);
	current_conn = NULL;
	indications_enabled = false;
	atomic_clear(&indicating);

	if (bonded) {
		if (atomic_get(&pair_success_active) == 0) {
			loa_indicator_set(LOA_PATTERN_SOLID, processor.current.status);
		}
		(void)start_advertising(false, true);
	} else if (pairing_window_open) {
		loa_indicator_set(LOA_PATTERN_SYNCING, LOA_STATUS_OFF);
		(void)start_advertising(true, false);
	} else {
		loa_indicator_set(LOA_PATTERN_DESYNCED, LOA_STATUS_OFF);
	}
}

BT_CONN_CB_DEFINE(connection_callbacks) = {
	.connected = connected,
	.disconnected = disconnected,
};

static void pairing_complete(struct bt_conn *conn, bool is_bonded)
{
	ARG_UNUSED(conn);
	if (!is_bonded) {
		return;
	}

	bonded = true;
	pairing_window_open = false;
	(void)k_work_cancel_delayable(&pairing_timeout_work);
	atomic_set(&pair_success_active, 1);
	(void)k_work_reschedule(&pair_success_done_work, K_MSEC(PAIR_SUCCESS_DURATION_MS));
	loa_indicator_play(LOA_PATTERN_PAIR_SUCCESS, processor.current.status, LOA_PATTERN_SOLID,
			   processor.current.status);
}

static void pairing_failed(struct bt_conn *conn, enum bt_security_err reason)
{
	ARG_UNUSED(conn);
	ARG_UNUSED(reason);
}

static struct bt_conn_auth_info_cb auth_info_callbacks = {
	.pairing_complete = pairing_complete,
	.pairing_failed = pairing_failed,
};

static void bond_found(const struct bt_bond_info *info, void *user_data)
{
	bool *found = user_data;

	ARG_UNUSED(info);
	*found = true;
}

bool loa_ble_server_has_bond(void)
{
	bool found = false;

	bt_foreach_bond(BT_ID_DEFAULT, bond_found, &found);
	return found;
}

int loa_ble_server_init(const struct loa_message *initial_state)
{
	k_work_init(&indication_work, send_indication);
	k_work_init_delayable(&pairing_timeout_work, pairing_window_expired);
	k_work_init_delayable(&pair_success_done_work, pair_success_finished);
	loa_receiver_processor_init(&processor, initial_state, persist_state, apply_state,
				    acknowledge_state, NULL);
	return bt_conn_auth_info_cb_register(&auth_info_callbacks);
}

int loa_ble_server_start(bool pairing_requested)
{
	bonded = loa_ble_server_has_bond();
	if (bonded) {
		loa_indicator_set(LOA_PATTERN_SOLID, processor.current.status);
		return start_advertising(false, true);
	}

	if (!pairing_requested) {
		loa_indicator_set(LOA_PATTERN_DESYNCED, LOA_STATUS_OFF);
		return 0;
	}

	pairing_window_open = true;
	loa_indicator_set(LOA_PATTERN_SYNCING, LOA_STATUS_OFF);
	(void)k_work_reschedule(&pairing_timeout_work, PAIRING_WINDOW);
	return start_advertising(true, false);
}
