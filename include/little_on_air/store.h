/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_STORE_H_
#define LITTLE_ON_AIR_STORE_H_

#include <stdbool.h>

#include <little_on_air/protocol.h>

bool loa_store_has_state(void);
struct loa_message loa_store_get_state(void);
int loa_store_save_state(const struct loa_message *state);
int loa_store_clear_state(void);

#endif /* LITTLE_ON_AIR_STORE_H_ */
