/* SPDX-License-Identifier: MIT */
#include <little_on_air/controller_fsm.h>

void loa_controller_fsm_init(struct loa_controller_fsm *fsm, enum loa_status confirmed_status)
{
	fsm->phase = LOA_CONTROLLER_DESYNCED;
	fsm->confirmed_status =
		loa_status_is_valid(confirmed_status) ? confirmed_status : LOA_STATUS_OFF;
	fsm->pending = (struct loa_message){
		.transaction_id = 0U,
		.status = fsm->confirmed_status,
	};
}

enum loa_controller_action loa_controller_on_boot(struct loa_controller_fsm *fsm, bool has_bond,
						  bool button_press, bool factory_reset)
{
	if (factory_reset || (!has_bond && button_press)) {
		fsm->phase = LOA_CONTROLLER_PAIRING;
		return LOA_ACTION_PAIR;
	}

	if (!has_bond) {
		fsm->phase = LOA_CONTROLLER_DESYNCED;
		return LOA_ACTION_SHOW_DESYNCED;
	}

	if (button_press) {
		fsm->pending.status = loa_status_next(fsm->confirmed_status);
		fsm->phase = LOA_CONTROLLER_SENDING;
		return LOA_ACTION_SEND;
	}

	fsm->phase = LOA_CONTROLLER_RECONCILING;
	return LOA_ACTION_RECONCILE;
}

void loa_controller_set_transaction(struct loa_controller_fsm *fsm, uint32_t transaction_id)
{
	fsm->pending.transaction_id = transaction_id;
}

enum loa_controller_action loa_controller_on_write_result(struct loa_controller_fsm *fsm,
							  bool accepted)
{
	if (fsm->phase != LOA_CONTROLLER_SENDING) {
		return LOA_ACTION_NONE;
	}

	if (!accepted) {
		fsm->phase = LOA_CONTROLLER_ERROR;
		return LOA_ACTION_ERROR_THEN_RECONCILE;
	}

	fsm->phase = LOA_CONTROLLER_WAITING_ACK;
	return LOA_ACTION_NONE;
}

enum loa_controller_action loa_controller_on_ack(struct loa_controller_fsm *fsm,
						 const struct loa_message *ack)
{
	if (fsm->phase != LOA_CONTROLLER_WAITING_ACK || ack == NULL ||
	    ack->transaction_id != fsm->pending.transaction_id ||
	    ack->status != fsm->pending.status) {
		return LOA_ACTION_NONE;
	}

	fsm->confirmed_status = ack->status;
	fsm->phase = LOA_CONTROLLER_SYNCED;
	return LOA_ACTION_CONFIRM;
}

enum loa_controller_action loa_controller_on_timeout(struct loa_controller_fsm *fsm)
{
	fsm->phase = LOA_CONTROLLER_ERROR;
	return LOA_ACTION_ERROR_THEN_RECONCILE;
}

void loa_controller_begin_reconcile(struct loa_controller_fsm *fsm)
{
	fsm->phase = LOA_CONTROLLER_RECONCILING;
}

enum loa_controller_action loa_controller_on_snapshot(struct loa_controller_fsm *fsm,
						      const struct loa_message *snapshot)
{
	if (snapshot == NULL || !loa_status_is_valid(snapshot->status)) {
		return LOA_ACTION_NONE;
	}

	fsm->confirmed_status = snapshot->status;
	fsm->phase = LOA_CONTROLLER_SYNCED;
	return LOA_ACTION_CONFIRM;
}

enum loa_controller_action loa_controller_on_retries_exhausted(struct loa_controller_fsm *fsm)
{
	fsm->phase = LOA_CONTROLLER_DESYNCED;
	return LOA_ACTION_SHOW_DESYNCED;
}
