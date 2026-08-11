/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_RECORD_H_
#define LITTLE_ON_AIR_RECORD_H_

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <little_on_air/protocol.h>

#define LOA_RECORD_LEN 14U

void loa_record_encode(uint8_t record[LOA_RECORD_LEN], const struct loa_message *state);
int loa_record_decode(struct loa_message *state, const void *record, size_t record_len);
bool loa_record_decode_or_default(struct loa_message *state, const void *record, size_t record_len);

#endif /* LITTLE_ON_AIR_RECORD_H_ */
