/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_PROTOCOL_H_
#define LITTLE_ON_AIR_PROTOCOL_H_

#include <stddef.h>
#include <stdint.h>

#include <little_on_air/status.h>

#define LOA_PROTOCOL_VERSION     1U
#define LOA_PROTOCOL_PAYLOAD_LEN 6U

#define LOA_BT_UUID_SERVICE_VAL                                                                    \
	BT_UUID_128_ENCODE(0x7f6c0000, 0x6b7e, 0x4c80, 0x9f2a, 0xf9b9d7e2a601)
#define LOA_BT_UUID_COMMAND_VAL                                                                    \
	BT_UUID_128_ENCODE(0x7f6c0001, 0x6b7e, 0x4c80, 0x9f2a, 0xf9b9d7e2a601)
#define LOA_BT_UUID_STATE_VAL BT_UUID_128_ENCODE(0x7f6c0002, 0x6b7e, 0x4c80, 0x9f2a, 0xf9b9d7e2a601)

struct loa_message {
	uint32_t transaction_id;
	enum loa_status status;
};

int loa_protocol_encode(uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN],
			const struct loa_message *message);
int loa_protocol_decode(struct loa_message *message, const void *payload, size_t payload_len);

#endif /* LITTLE_ON_AIR_PROTOCOL_H_ */
