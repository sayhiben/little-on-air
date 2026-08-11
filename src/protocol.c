/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <stdint.h>

#include <little_on_air/protocol.h>

static void put_le32(uint8_t *destination, uint32_t value)
{
	destination[0] = (uint8_t)value;
	destination[1] = (uint8_t)(value >> 8);
	destination[2] = (uint8_t)(value >> 16);
	destination[3] = (uint8_t)(value >> 24);
}

static uint32_t get_le32(const uint8_t *source)
{
	return (uint32_t)source[0] | ((uint32_t)source[1] << 8) | ((uint32_t)source[2] << 16) |
	       ((uint32_t)source[3] << 24);
}

int loa_protocol_encode(uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN],
			const struct loa_message *message)
{
	if (payload == NULL || message == NULL || !loa_status_is_valid(message->status)) {
		return -EINVAL;
	}

	payload[0] = LOA_PROTOCOL_VERSION;
	put_le32(&payload[1], message->transaction_id);
	payload[5] = (uint8_t)message->status;
	return 0;
}

int loa_protocol_decode(struct loa_message *message, const void *payload, size_t payload_len)
{
	const uint8_t *bytes = payload;
	enum loa_status status;

	if (message == NULL || bytes == NULL || payload_len != LOA_PROTOCOL_PAYLOAD_LEN ||
	    bytes[0] != LOA_PROTOCOL_VERSION) {
		return -EINVAL;
	}

	status = (enum loa_status)bytes[5];
	if (!loa_status_is_valid(status)) {
		return -EINVAL;
	}

	message->transaction_id = get_le32(&bytes[1]);
	message->status = status;
	return 0;
}
