// SPDX-License-Identifier: MIT
#pragma once
#include <cstdint>

enum {
	BLE_STORE_EVENT_OVERFLOW = 1,
	BLE_STORE_EVENT_FULL = 2,
	BLE_STORE_OBJ_TYPE_PEER_ADDR = 6,
	BLE_HS_ENOENT = 5,
	BLE_HS_EUNKNOWN = 17,
	BLE_HS_ESTORE_CAP = 27
};
struct ble_addr_t {
	uint8_t type;
	uint8_t val[6];
};
struct ble_store_key_rpa_rec {
	ble_addr_t peer_rpa_addr;
	uint8_t idx;
};
struct ble_store_value_rpa_rec {
	ble_addr_t peer_rpa_addr;
	ble_addr_t peer_addr;
};
union ble_store_value {
	ble_store_value_rpa_rec rpa_rec;
};
struct ble_store_status_event {
	int event_code;
	struct {
		int obj_type;
		const ble_store_value *value;
	} overflow;
};
class NimBLEDeviceCallbacks
{
      public:
	virtual ~NimBLEDeviceCallbacks() = default;
	virtual int onStoreStatus(ble_store_status_event *, void *) = 0;
};
class NimBLEDevice
{
      public:
	static void setDeviceCallbacks(NimBLEDeviceCallbacks *);
};
int ble_store_delete_rpa_rec(const ble_store_key_rpa_rec *);
