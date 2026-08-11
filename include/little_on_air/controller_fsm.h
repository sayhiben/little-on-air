/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_CONTROLLER_FSM_H_
#define LITTLE_ON_AIR_CONTROLLER_FSM_H_

#include <stdbool.h>
#include <stdint.h>

#include <little_on_air/protocol.h>

enum loa_controller_phase {
	LOA_CONTROLLER_DESYNCED,
	LOA_CONTROLLER_PAIRING,
	LOA_CONTROLLER_RECONCILING,
	LOA_CONTROLLER_SENDING,
	LOA_CONTROLLER_WAITING_ACK,
	LOA_CONTROLLER_SYNCED,
	LOA_CONTROLLER_ERROR,
};

enum loa_controller_action {
	LOA_ACTION_NONE,
	LOA_ACTION_SHOW_DESYNCED,
	LOA_ACTION_PAIR,
	LOA_ACTION_RECONCILE,
	LOA_ACTION_SEND,
	LOA_ACTION_CONFIRM,
	LOA_ACTION_ERROR_THEN_RECONCILE,
};

struct loa_controller_fsm {
	enum loa_controller_phase phase;
	enum loa_status confirmed_status;
	struct loa_message pending;
};

void loa_controller_fsm_init(struct loa_controller_fsm *fsm, enum loa_status confirmed_status);
enum loa_controller_action loa_controller_on_boot(struct loa_controller_fsm *fsm, bool has_bond,
						  bool button_press, bool factory_reset);
void loa_controller_set_transaction(struct loa_controller_fsm *fsm, uint32_t transaction_id);
enum loa_controller_action loa_controller_on_write_result(struct loa_controller_fsm *fsm,
							  bool accepted);
enum loa_controller_action loa_controller_on_ack(struct loa_controller_fsm *fsm,
						 const struct loa_message *ack);
enum loa_controller_action loa_controller_on_timeout(struct loa_controller_fsm *fsm);
void loa_controller_begin_reconcile(struct loa_controller_fsm *fsm);
enum loa_controller_action loa_controller_on_snapshot(struct loa_controller_fsm *fsm,
						      const struct loa_message *snapshot);
enum loa_controller_action loa_controller_on_retries_exhausted(struct loa_controller_fsm *fsm);

#endif /* LITTLE_ON_AIR_CONTROLLER_FSM_H_ */
