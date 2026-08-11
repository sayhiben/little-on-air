/* SPDX-License-Identifier: MIT */
#ifndef LOA_BLE_CLIENT_H_
#define LOA_BLE_CLIENT_H_

#include <stdbool.h>

#include <zephyr/kernel.h>

#include <little_on_air/protocol.h>

int loa_ble_client_init(void);
bool loa_ble_client_has_bond(void);
int loa_ble_client_unpair_all(void);
int loa_ble_client_reconcile(struct loa_message *snapshot, k_timeout_t timeout, bool *new_pairing);
int loa_ble_client_send(const struct loa_message *command, struct loa_message *ack,
			k_timeout_t timeout, bool *new_pairing);

#endif /* LOA_BLE_CLIENT_H_ */
