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
#include <zephyr/sys/clock.h>

#include <little_on_air/protocol.h>

#include "ble_client.h"

static struct bt_uuid_128 service_uuid = BT_UUID_INIT_128(LOA_BT_UUID_SERVICE_VAL);
static struct bt_uuid_128 command_uuid = BT_UUID_INIT_128(LOA_BT_UUID_COMMAND_VAL);
static struct bt_uuid_128 state_uuid = BT_UUID_INIT_128(LOA_BT_UUID_STATE_VAL);
static struct bt_uuid_16 ccc_uuid = BT_UUID_INIT_16(BT_UUID_GATT_CCC_VAL);

static struct bt_conn *default_conn;
static struct bt_gatt_discover_params discover_params;
static struct bt_gatt_subscribe_params subscribe_params;
static struct bt_gatt_write_params write_params;
static struct bt_gatt_read_params read_params;

static struct k_sem connected_sem;
static struct k_sem disconnected_sem;
static struct k_sem security_sem;
static struct k_sem discovery_sem;
static struct k_sem write_sem;
static struct k_sem ack_sem;
static struct k_sem read_sem;

static atomic_t scan_active;
static atomic_t pairing_happened;
static int connection_result;
static int security_result;
static int discovery_result;
static int write_result;
static int read_result;
static uint16_t service_end_handle;
static uint16_t command_value_handle;
static uint16_t state_value_handle;
static struct loa_message indicated_state;
static struct loa_message read_state;

enum discovery_stage {
	DISCOVER_SERVICE,
	DISCOVER_COMMAND,
	DISCOVER_STATE,
	DISCOVER_CCC,
};

static enum discovery_stage discovery_stage;

static void reset_operation_state(void)
{
	k_sem_reset(&connected_sem);
	k_sem_reset(&disconnected_sem);
	k_sem_reset(&security_sem);
	k_sem_reset(&discovery_sem);
	k_sem_reset(&write_sem);
	k_sem_reset(&ack_sem);
	k_sem_reset(&read_sem);
	connection_result = -ETIMEDOUT;
	security_result = -ETIMEDOUT;
	discovery_result = -ETIMEDOUT;
	write_result = -ETIMEDOUT;
	read_result = -ETIMEDOUT;
	command_value_handle = 0U;
	state_value_handle = 0U;
	atomic_clear(&pairing_happened);
}

static bool advertisement_has_service(struct bt_data *data, void *user_data)
{
	static const uint8_t expected_uuid[] = {LOA_BT_UUID_SERVICE_VAL};
	bool *found = user_data;

	if (data->type != BT_DATA_UUID128_ALL && data->type != BT_DATA_UUID128_SOME) {
		return true;
	}

	for (size_t offset = 0U; offset + sizeof(expected_uuid) <= data->data_len;
	     offset += sizeof(expected_uuid)) {
		if (memcmp(&data->data[offset], expected_uuid, sizeof(expected_uuid)) == 0) {
			*found = true;
			return false;
		}
	}

	return true;
}

static void device_found(const bt_addr_le_t *address, int8_t rssi, uint8_t type,
			 struct net_buf_simple *advertising_data)
{
	bool found = false;
	int err;

	ARG_UNUSED(rssi);
	if (type != BT_GAP_ADV_TYPE_ADV_IND && type != BT_GAP_ADV_TYPE_ADV_DIRECT_IND &&
	    type != BT_GAP_ADV_TYPE_EXT_ADV) {
		return;
	}

	bt_data_parse(advertising_data, advertisement_has_service, &found);
	if (!found || !atomic_cas(&scan_active, 1, 0)) {
		return;
	}

	err = bt_le_scan_stop();
	if (err != 0 && err != -EALREADY) {
		connection_result = err;
		k_sem_give(&connected_sem);
		return;
	}

	err = bt_conn_le_create(address, BT_CONN_LE_CREATE_CONN, BT_LE_CONN_PARAM_DEFAULT,
				&default_conn);
	if (err != 0) {
		connection_result = err;
		k_sem_give(&connected_sem);
	}
}

static void connected(struct bt_conn *conn, uint8_t err)
{
	if (conn != default_conn) {
		return;
	}

	connection_result = err == 0U ? 0 : -ECONNREFUSED;
	k_sem_give(&connected_sem);
}

static void disconnected(struct bt_conn *conn, uint8_t reason)
{
	ARG_UNUSED(reason);
	if (conn == default_conn) {
		k_sem_give(&disconnected_sem);
	}
}

static void security_changed(struct bt_conn *conn, bt_security_t level, enum bt_security_err err)
{
	if (conn != default_conn) {
		return;
	}

	security_result = err == BT_SECURITY_ERR_SUCCESS && level >= BT_SECURITY_L2 ? 0 : -EACCES;
	k_sem_give(&security_sem);
}

BT_CONN_CB_DEFINE(connection_callbacks) = {
	.connected = connected,
	.disconnected = disconnected,
	.security_changed = security_changed,
};

static void pairing_complete(struct bt_conn *conn, bool bonded)
{
	if (conn == default_conn && bonded) {
		atomic_set(&pairing_happened, 1);
	}
}

static void pairing_failed(struct bt_conn *conn, enum bt_security_err reason)
{
	ARG_UNUSED(reason);
	if (conn == default_conn) {
		security_result = -EACCES;
		k_sem_give(&security_sem);
	}
}

static struct bt_conn_auth_info_cb auth_info_callbacks = {
	.pairing_complete = pairing_complete,
	.pairing_failed = pairing_failed,
};

static uint8_t indication_received(struct bt_conn *conn, struct bt_gatt_subscribe_params *params,
				   const void *data, uint16_t length)
{
	ARG_UNUSED(conn);
	if (data == NULL) {
		params->value_handle = 0U;
		return BT_GATT_ITER_STOP;
	}

	if (loa_protocol_decode(&indicated_state, data, length) == 0) {
		k_sem_give(&ack_sem);
	}

	return BT_GATT_ITER_CONTINUE;
}

static void subscription_complete(struct bt_conn *conn, uint8_t err,
				  struct bt_gatt_subscribe_params *params)
{
	ARG_UNUSED(conn);
	ARG_UNUSED(params);
	discovery_result = err == 0U ? 0 : -EIO;
	k_sem_give(&discovery_sem);
}

static uint8_t discovery_callback(struct bt_conn *conn, const struct bt_gatt_attr *attr,
				  struct bt_gatt_discover_params *params)
{
	int err;

	ARG_UNUSED(params);
	if (attr == NULL) {
		discovery_result = -ENOENT;
		k_sem_give(&discovery_sem);
		return BT_GATT_ITER_STOP;
	}

	switch (discovery_stage) {
	case DISCOVER_SERVICE: {
		const struct bt_gatt_service_val *service = attr->user_data;

		service_end_handle = service->end_handle;
		discovery_stage = DISCOVER_COMMAND;
		discover_params.uuid = &command_uuid.uuid;
		discover_params.start_handle = attr->handle + 1U;
		discover_params.end_handle = service_end_handle;
		discover_params.type = BT_GATT_DISCOVER_CHARACTERISTIC;
		break;
	}
	case DISCOVER_COMMAND:
		command_value_handle = bt_gatt_attr_value_handle(attr);
		discovery_stage = DISCOVER_STATE;
		discover_params.uuid = &state_uuid.uuid;
		discover_params.start_handle = command_value_handle + 1U;
		discover_params.end_handle = service_end_handle;
		discover_params.type = BT_GATT_DISCOVER_CHARACTERISTIC;
		break;
	case DISCOVER_STATE:
		state_value_handle = bt_gatt_attr_value_handle(attr);
		discovery_stage = DISCOVER_CCC;
		discover_params.uuid = &ccc_uuid.uuid;
		discover_params.start_handle = state_value_handle + 1U;
		discover_params.end_handle = service_end_handle;
		discover_params.type = BT_GATT_DISCOVER_DESCRIPTOR;
		break;
	case DISCOVER_CCC:
		memset(&subscribe_params, 0, sizeof(subscribe_params));
		subscribe_params.notify = indication_received;
		subscribe_params.subscribe = subscription_complete;
		subscribe_params.value_handle = state_value_handle;
		subscribe_params.ccc_handle = attr->handle;
		subscribe_params.value = BT_GATT_CCC_INDICATE;
		subscribe_params.min_security = BT_SECURITY_L2;
		atomic_set_bit(subscribe_params.flags, BT_GATT_SUBSCRIBE_FLAG_VOLATILE);
		err = bt_gatt_subscribe(conn, &subscribe_params);
		if (err != 0 && err != -EALREADY) {
			discovery_result = err;
			k_sem_give(&discovery_sem);
		} else if (err == -EALREADY) {
			discovery_result = 0;
			k_sem_give(&discovery_sem);
		}
		return BT_GATT_ITER_STOP;
	default:
		return BT_GATT_ITER_STOP;
	}

	err = bt_gatt_discover(conn, &discover_params);
	if (err != 0) {
		discovery_result = err;
		k_sem_give(&discovery_sem);
	}
	return BT_GATT_ITER_STOP;
}

static int discover_service(k_timepoint_t deadline)
{
	memset(&discover_params, 0, sizeof(discover_params));
	discovery_stage = DISCOVER_SERVICE;
	discover_params.uuid = &service_uuid.uuid;
	discover_params.func = discovery_callback;
	discover_params.start_handle = BT_ATT_FIRST_ATTRIBUTE_HANDLE;
	discover_params.end_handle = BT_ATT_LAST_ATTRIBUTE_HANDLE;
	discover_params.type = BT_GATT_DISCOVER_PRIMARY;

	discovery_result = bt_gatt_discover(default_conn, &discover_params);
	if (discovery_result != 0) {
		return discovery_result;
	}

	if (k_sem_take(&discovery_sem, sys_timepoint_timeout(deadline)) != 0) {
		return -ETIMEDOUT;
	}
	return discovery_result;
}

static int connect_and_prepare(k_timepoint_t deadline)
{
	static const struct bt_le_scan_param scan_params = {
		.type = BT_LE_SCAN_TYPE_PASSIVE,
		.options = BT_LE_SCAN_OPT_FILTER_DUPLICATE,
		.interval = BT_GAP_SCAN_FAST_INTERVAL,
		.window = BT_GAP_SCAN_FAST_WINDOW,
	};
	int err;

	reset_operation_state();
	atomic_set(&scan_active, 1);
	err = bt_le_scan_start(&scan_params, device_found);
	if (err != 0) {
		atomic_clear(&scan_active);
		return err;
	}

	if (k_sem_take(&connected_sem, sys_timepoint_timeout(deadline)) != 0) {
		if (atomic_cas(&scan_active, 1, 0)) {
			(void)bt_le_scan_stop();
		}
		return -ETIMEDOUT;
	}
	if (connection_result != 0) {
		return connection_result;
	}

	if (bt_conn_get_security(default_conn) >= BT_SECURITY_L2) {
		security_result = 0;
	} else {
		err = bt_conn_set_security(default_conn, BT_SECURITY_L2);
		if (err != 0 && err != -EALREADY) {
			return err;
		}
		if (k_sem_take(&security_sem, sys_timepoint_timeout(deadline)) != 0) {
			return -ETIMEDOUT;
		}
		if (security_result != 0) {
			return security_result;
		}
	}

	return discover_service(deadline);
}

static void disconnect_and_release(void)
{
	struct bt_conn_info info;

	if (atomic_cas(&scan_active, 1, 0)) {
		(void)bt_le_scan_stop();
	}

	if (default_conn == NULL) {
		return;
	}

	if (bt_conn_get_info(default_conn, &info) == 0 &&
	    info.state != BT_CONN_STATE_DISCONNECTED) {
		(void)bt_conn_disconnect(default_conn, BT_HCI_ERR_REMOTE_USER_TERM_CONN);
		if (info.state == BT_CONN_STATE_CONNECTED) {
			(void)k_sem_take(&disconnected_sem, K_MSEC(250));
		}
	}

	bt_conn_unref(default_conn);
	default_conn = NULL;
}

static void write_complete(struct bt_conn *conn, uint8_t err, struct bt_gatt_write_params *params)
{
	ARG_UNUSED(conn);
	ARG_UNUSED(params);
	write_result = err == 0U ? 0 : -EIO;
	k_sem_give(&write_sem);
}

static uint8_t read_complete(struct bt_conn *conn, uint8_t err, struct bt_gatt_read_params *params,
			     const void *data, uint16_t length)
{
	ARG_UNUSED(conn);
	ARG_UNUSED(params);
	if (err != 0U) {
		read_result = -EIO;
		k_sem_give(&read_sem);
		return BT_GATT_ITER_STOP;
	}

	if (data != NULL) {
		read_result = loa_protocol_decode(&read_state, data, length);
		k_sem_give(&read_sem);
	}
	return BT_GATT_ITER_STOP;
}

static int read_snapshot(struct loa_message *snapshot, k_timepoint_t deadline)
{
	memset(&read_params, 0, sizeof(read_params));
	read_params.func = read_complete;
	read_params.handle_count = 1U;
	read_params.single.handle = state_value_handle;
	read_params.single.offset = 0U;
	read_result = -ETIMEDOUT;
	k_sem_reset(&read_sem);

	int err = bt_gatt_read(default_conn, &read_params);

	if (err != 0) {
		return err;
	}
	if (k_sem_take(&read_sem, sys_timepoint_timeout(deadline)) != 0) {
		return -ETIMEDOUT;
	}
	if (read_result == 0) {
		*snapshot = read_state;
	}
	return read_result;
}

int loa_ble_client_init(void)
{
	k_sem_init(&connected_sem, 0, 1);
	k_sem_init(&disconnected_sem, 0, 1);
	k_sem_init(&security_sem, 0, 1);
	k_sem_init(&discovery_sem, 0, 1);
	k_sem_init(&write_sem, 0, 1);
	k_sem_init(&ack_sem, 0, 1);
	k_sem_init(&read_sem, 0, 1);
	return bt_conn_auth_info_cb_register(&auth_info_callbacks);
}

static void bond_found(const struct bt_bond_info *info, void *user_data)
{
	bool *found = user_data;

	ARG_UNUSED(info);
	*found = true;
}

bool loa_ble_client_has_bond(void)
{
	bool found = false;

	bt_foreach_bond(BT_ID_DEFAULT, bond_found, &found);
	return found;
}

int loa_ble_client_unpair_all(void)
{
	return bt_unpair(BT_ID_DEFAULT, BT_ADDR_LE_ANY);
}

int loa_ble_client_reconcile(struct loa_message *snapshot, k_timeout_t timeout, bool *new_pairing)
{
	k_timepoint_t deadline = sys_timepoint_calc(timeout);
	int err = connect_and_prepare(deadline);

	if (err == 0) {
		err = read_snapshot(snapshot, deadline);
	}
	if (new_pairing != NULL) {
		*new_pairing = atomic_get(&pairing_happened) != 0;
	}
	disconnect_and_release();
	return err;
}

int loa_ble_client_send(const struct loa_message *command, struct loa_message *ack,
			k_timeout_t timeout, bool *new_pairing)
{
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];
	k_timepoint_t deadline = sys_timepoint_calc(timeout);
	int err = connect_and_prepare(deadline);

	if (err != 0) {
		goto done;
	}

	err = loa_protocol_encode(payload, command);
	if (err != 0) {
		goto done;
	}

	k_sem_reset(&write_sem);
	k_sem_reset(&ack_sem);
	memset(&write_params, 0, sizeof(write_params));
	write_params.func = write_complete;
	write_params.handle = command_value_handle;
	write_params.offset = 0U;
	write_params.data = payload;
	write_params.length = sizeof(payload);
	write_result = -ETIMEDOUT;

	err = bt_gatt_write(default_conn, &write_params);
	if (err != 0) {
		goto done;
	}
	if (k_sem_take(&write_sem, sys_timepoint_timeout(deadline)) != 0 || write_result != 0) {
		err = write_result;
		goto done;
	}

	if (k_sem_take(&ack_sem, sys_timepoint_timeout(deadline)) == 0 &&
	    indicated_state.transaction_id == command->transaction_id &&
	    indicated_state.status == command->status) {
		*ack = indicated_state;
		err = 0;
		goto done;
	}

	/* A readback recovers the case where the indication was applied but lost. */
	err = read_snapshot(ack, deadline);
	if (err == 0 &&
	    (ack->transaction_id != command->transaction_id || ack->status != command->status)) {
		err = -EAGAIN;
	}

done:
	if (new_pairing != NULL) {
		*new_pairing = atomic_get(&pairing_happened) != 0;
	}
	disconnect_and_release();
	return err;
}
