/* SPDX-License-Identifier: MIT */
#ifndef LOA_BLE_SERVER_H_
#define LOA_BLE_SERVER_H_

#include <stdbool.h>

#include <little_on_air/protocol.h>

int loa_ble_server_init(const struct loa_message *initial_state);
bool loa_ble_server_has_bond(void);
int loa_ble_server_start(bool pairing_requested);

#endif /* LOA_BLE_SERVER_H_ */
