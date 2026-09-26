// SPDX-License-Identifier: MIT
#include "bond_store.hpp"
#include <Arduino.h>
#include <NimBLEDevice.h>

namespace {
class BondStoreCallbacks : public NimBLEDeviceCallbacks {
    int onStoreStatus(ble_store_status_event *event, void *) override {
        if (event->event_code == BLE_STORE_EVENT_FULL)
            return 0;
        if (event->event_code != BLE_STORE_EVENT_OVERFLOW)
            return BLE_HS_EUNKNOWN;
        Serial.printf("SECURITY store_overflow type=%d\n", event->overflow.obj_type);
        if (event->overflow.obj_type == BLE_STORE_OBJ_TYPE_PEER_ADDR) {
            // Privacy-address rotation can fill the one-entry address cache.
            // Replace that peer's old address mapping, never its pairing keys.
            ble_store_key_rpa_rec key{};
            key.peer_rpa_addr = event->overflow.value->rpa_rec.peer_addr;
            return ble_store_delete_rpa_rec(&key);
        }
        // NimBLE's default round-robin handler erases the oldest bond. A
        // single-sign controller must require explicit Forget instead.
        return BLE_HS_ESTORE_CAP;
    }
} callbacks;
} // namespace

void configureBondStore() {
    NimBLEDevice::setDeviceCallbacks(&callbacks);
}
