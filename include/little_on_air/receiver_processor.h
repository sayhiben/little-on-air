/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_RECEIVER_PROCESSOR_H_
#define LITTLE_ON_AIR_RECEIVER_PROCESSOR_H_

#include <stddef.h>

#include <little_on_air/protocol.h>

typedef int (*loa_receiver_step_fn)(const struct loa_message *state, void *user_data);

struct loa_receiver_processor {
	struct loa_message current;
	loa_receiver_step_fn persist;
	loa_receiver_step_fn apply;
	loa_receiver_step_fn acknowledge;
	void *user_data;
};

void loa_receiver_processor_init(struct loa_receiver_processor *processor,
				 const struct loa_message *initial, loa_receiver_step_fn persist,
				 loa_receiver_step_fn apply, loa_receiver_step_fn acknowledge,
				 void *user_data);
int loa_receiver_process_payload(struct loa_receiver_processor *processor, const void *payload,
				 size_t payload_len);

#endif /* LITTLE_ON_AIR_RECEIVER_PROCESSOR_H_ */
