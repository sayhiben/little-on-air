/* SPDX-License-Identifier: MIT */
#include <errno.h>

#include <little_on_air/receiver_processor.h>

void loa_receiver_processor_init(struct loa_receiver_processor *processor,
				 const struct loa_message *initial, loa_receiver_step_fn persist,
				 loa_receiver_step_fn apply, loa_receiver_step_fn acknowledge,
				 void *user_data)
{
	processor->current = *initial;
	processor->persist = persist;
	processor->apply = apply;
	processor->acknowledge = acknowledge;
	processor->user_data = user_data;
}

int loa_receiver_process_payload(struct loa_receiver_processor *processor, const void *payload,
				 size_t payload_len)
{
	struct loa_message candidate;
	int err;

	if (processor == NULL || processor->persist == NULL || processor->apply == NULL ||
	    processor->acknowledge == NULL) {
		return -EINVAL;
	}

	err = loa_protocol_decode(&candidate, payload, payload_len);
	if (err != 0) {
		return err;
	}

	if (candidate.transaction_id == processor->current.transaction_id) {
		if (candidate.status == processor->current.status) {
			return processor->acknowledge(&processor->current, processor->user_data);
		}
		return -EINVAL;
	}

	err = processor->persist(&candidate, processor->user_data);
	if (err != 0) {
		return err;
	}

	err = processor->apply(&candidate, processor->user_data);
	if (err != 0) {
		return err;
	}

	processor->current = candidate;
	return processor->acknowledge(&processor->current, processor->user_data);
}
