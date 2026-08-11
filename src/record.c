/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <stdint.h>
#include <string.h>

#include <little_on_air/record.h>

#define LOA_RECORD_MAGIC_0         'L'
#define LOA_RECORD_MAGIC_1         'O'
#define LOA_RECORD_MAGIC_2         'A'
#define LOA_RECORD_MAGIC_3         '1'
#define LOA_RECORD_CHECKSUM_OFFSET 10U

static uint32_t crc32_ieee(const uint8_t *data, size_t length)
{
	uint32_t crc = 0xffffffffU;

	for (size_t i = 0; i < length; ++i) {
		crc ^= data[i];
		for (uint8_t bit = 0; bit < 8U; ++bit) {
			const uint32_t mask = (uint32_t)-(int32_t)(crc & 1U);

			crc = (crc >> 1) ^ (0xedb88320U & mask);
		}
	}

	return ~crc;
}

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

void loa_record_encode(uint8_t record[LOA_RECORD_LEN], const struct loa_message *state)
{
	record[0] = LOA_RECORD_MAGIC_0;
	record[1] = LOA_RECORD_MAGIC_1;
	record[2] = LOA_RECORD_MAGIC_2;
	record[3] = LOA_RECORD_MAGIC_3;
	record[4] = LOA_PROTOCOL_VERSION;
	record[5] = (uint8_t)state->status;
	put_le32(&record[6], state->transaction_id);
	put_le32(&record[LOA_RECORD_CHECKSUM_OFFSET],
		 crc32_ieee(record, LOA_RECORD_CHECKSUM_OFFSET));
}

int loa_record_decode(struct loa_message *state, const void *record, size_t record_len)
{
	const uint8_t *bytes = record;
	uint32_t expected_crc;
	enum loa_status status;

	if (state == NULL || bytes == NULL || record_len != LOA_RECORD_LEN ||
	    bytes[0] != LOA_RECORD_MAGIC_0 || bytes[1] != LOA_RECORD_MAGIC_1 ||
	    bytes[2] != LOA_RECORD_MAGIC_2 || bytes[3] != LOA_RECORD_MAGIC_3 ||
	    bytes[4] != LOA_PROTOCOL_VERSION) {
		return -EINVAL;
	}

	expected_crc = crc32_ieee(bytes, LOA_RECORD_CHECKSUM_OFFSET);
	if (get_le32(&bytes[LOA_RECORD_CHECKSUM_OFFSET]) != expected_crc) {
		return -EBADMSG;
	}

	status = (enum loa_status)bytes[5];
	if (!loa_status_is_valid(status)) {
		return -EINVAL;
	}

	state->status = status;
	state->transaction_id = get_le32(&bytes[6]);
	return 0;
}

bool loa_record_decode_or_default(struct loa_message *state, const void *record, size_t record_len)
{
	if (state != NULL && loa_record_decode(state, record, record_len) == 0) {
		return true;
	}

	if (state != NULL) {
		*state = (struct loa_message){
			.transaction_id = 0U,
			.status = LOA_STATUS_OFF,
		};
	}
	return false;
}
