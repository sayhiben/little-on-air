// SPDX-License-Identifier: MIT
#include "bond_store.hpp"
#include <Arduino.h>
#include <NimBLEDevice.h>
#include <cassert>
#include <cstring>

HostSerial Serial;
static NimBLEDeviceCallbacks *callbacks;
static ble_store_value_rpa_rec cache;
static bool occupied = true;
static int deletions;
static int storageError;
static const ble_addr_t sign = {1, {1, 2, 3, 4, 5, 6}};

void NimBLEDevice::setDeviceCallbacks(NimBLEDeviceCallbacks *value) {
    callbacks = value;
}
int ble_store_delete_rpa_rec(const ble_store_key_rpa_rec *key) {
    assert(key->idx == 0);
    if (storageError)
        return storageError;
    if (!occupied || std::memcmp(&key->peer_rpa_addr, &cache.peer_addr, sizeof(sign)))
        return BLE_HS_ENOENT;
    occupied = false;
    ++deletions;
    return 0;
}

int main() {
    configureBondStore();
    assert(callbacks);
    cache.peer_addr = sign;
    ble_store_value candidate{};
    candidate.rpa_rec.peer_addr = sign;
    ble_store_status_event event{BLE_STORE_EVENT_OVERFLOW,
                                 {BLE_STORE_OBJ_TYPE_PEER_ADDR, &candidate}};
    // Repeated private-address changes must reclaim only the obsolete mapping.
    for (int rotation = 0; rotation < 1000; ++rotation) {
        candidate.rpa_rec.peer_rpa_addr.val[0] = uint8_t(rotation);
        candidate.rpa_rec.peer_rpa_addr.val[1] = uint8_t(rotation >> 8);
        assert(callbacks->onStoreStatus(&event, nullptr) == 0);
        assert(!occupied && deletions == rotation + 1);
        cache = candidate.rpa_rec;
        occupied = true;
    }
    // No key, identity, CCCD, or unknown storage overflow may erase a bond.
    for (int type = 0; type < 12; ++type) {
        if (type == BLE_STORE_OBJ_TYPE_PEER_ADDR)
            continue;
        event.overflow.obj_type = type;
        assert(callbacks->onStoreStatus(&event, nullptr) == BLE_HS_ESTORE_CAP);
        assert(occupied && deletions == 1000);
    }
    event.overflow.obj_type = BLE_STORE_OBJ_TYPE_PEER_ADDR;
    candidate.rpa_rec.peer_addr.val[0] ^= 0xff;
    assert(callbacks->onStoreStatus(&event, nullptr) == BLE_HS_ENOENT);
    assert(occupied && deletions == 1000);
    candidate.rpa_rec.peer_addr = sign;
    storageError = 99;
    assert(callbacks->onStoreStatus(&event, nullptr) == 99);
    assert(occupied && deletions == 1000);
    event.event_code = BLE_STORE_EVENT_FULL;
    assert(callbacks->onStoreStatus(&event, nullptr) == 0);
    event.event_code = 99;
    assert(callbacks->onStoreStatus(&event, nullptr) == BLE_HS_EUNKNOWN);
    assert(occupied && deletions == 1000);
}
