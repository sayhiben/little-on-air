/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <little_on_air/brightness.h>

uint8_t loa_brightness_default(enum loa_light light)
{
	return light == LOA_LIGHT_SCREEN ? 100U : light == LOA_LIGHT_SCREEN_DIM ? 0U : 50U;
}

uint16_t loa_brightness_native(enum loa_light light, uint8_t percent)
{
	static const uint16_t minimum[] = {50U, 50U, 41U, 0U, 13U};
	static const uint16_t normal[] = {160U, 125U, 207U, 0U, 24U};
	static const uint16_t maximum[] = {500U, 250U, 207U, 40U, 76U};
	if (light < 0 || light >= LOA_LIGHT_COUNT) {
		return 0U;
	}
	if (percent > 100U) {
		percent = 100U;
	}
	uint8_t pivot = loa_brightness_default(light);
	/* Anchor the exact old drive value at the default, with monotonic ramps. */
	if (percent <= pivot && pivot != 0U) {
		return minimum[light] + (normal[light] - minimum[light]) * percent / pivot;
	}
	return normal[light] +
	       (maximum[light] - normal[light]) * (percent - pivot) / (100U - pivot);
}

struct loa_brightness loa_brightness_defaults(void)
{
	return (struct loa_brightness){0U, 50U, 50U};
}

bool loa_brightness_equal(const struct loa_brightness *a, const struct loa_brightness *b)
{
	return a->transaction_id == b->transaction_id && a->frame == b->frame &&
	       a->indicator == b->indicator;
}

int loa_brightness_encode(uint8_t *payload, const struct loa_brightness *value)
{
	if (payload == NULL || value == NULL || value->frame > 100U || value->indicator > 100U) {
		return -EINVAL;
	}
	payload[0] = 1U;
	for (size_t i = 0; i < 4U; ++i) {
		payload[i + 1U] = value->transaction_id >> (8U * i);
	}
	payload[5] = value->frame;
	payload[6] = value->indicator;
	return 0;
}

int loa_brightness_decode(struct loa_brightness *value, const void *payload, size_t len)
{
	const uint8_t *p = payload;
	if (value == NULL || p == NULL || len != LOA_BRIGHTNESS_PAYLOAD_LEN || p[0] != 1U ||
	    p[5] > 100U || p[6] > 100U) {
		return -EINVAL;
	}
	struct loa_brightness decoded = {0U, p[5], p[6]};
	for (size_t i = 0; i < 4U; ++i) {
		decoded.transaction_id |= (uint32_t)p[i + 1U] << (8U * i);
	}
	*value = decoded;
	return 0;
}

uint8_t loa_brightness_checksum(const void *data, size_t len)
{
	const uint8_t *bytes = data;
	uint8_t crc = 0U;
	for (size_t i = 0; i < len; ++i) {
		crc ^= bytes[i];
		for (unsigned int bit = 0; bit < 8U; ++bit) {
			crc = (crc << 1U) ^ ((crc & 0x80U) ? 0x07U : 0U);
		}
	}
	return crc;
}

void loa_brightness_record_encode(uint8_t *record, const struct loa_brightness *value)
{
	(void)loa_brightness_encode(record, value);
	record[7] = loa_brightness_checksum(record, 7U);
}

bool loa_brightness_record_decode(struct loa_brightness *value, const void *record, size_t len)
{
	const uint8_t *bytes = record;
	if (value == NULL) {
		return false;
	}
	*value = loa_brightness_defaults();
	return bytes != NULL && len == LOA_BRIGHTNESS_RECORD_LEN &&
	       bytes[7] == loa_brightness_checksum(bytes, 7U) &&
	       loa_brightness_decode(value, record, 7U) == 0;
}

int loa_brightness_process(struct loa_brightness *current, const void *payload, size_t len,
			   loa_brightness_step_fn persist, loa_brightness_step_fn apply,
			   void *context)
{
	struct loa_brightness candidate;
	if (current == NULL || persist == NULL || apply == NULL ||
	    loa_brightness_decode(&candidate, payload, len) != 0 ||
	    candidate.transaction_id == 0U) {
		return -EINVAL;
	}
	if (candidate.transaction_id == current->transaction_id) {
		return loa_brightness_equal(&candidate, current) ? 0 : -EINVAL;
	}
	int err = persist(&candidate, context);
	if (err == 0) {
		err = apply(&candidate, context);
	}
	if (err == 0) {
		*current = candidate;
	}
	return err;
}
