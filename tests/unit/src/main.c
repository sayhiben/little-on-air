/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>

#include <zephyr/ztest.h>

#include <little_on_air/protocol.h>
#include <little_on_air/receiver_processor.h>
#include <little_on_air/record.h>
#include <little_on_air/reset_gesture.h>
#include <little_on_air/status.h>

ZTEST_SUITE(status_suite, NULL, NULL, NULL, NULL, NULL);
ZTEST_SUITE(protocol_suite, NULL, NULL, NULL, NULL, NULL);
ZTEST_SUITE(record_suite, NULL, NULL, NULL, NULL, NULL);
ZTEST_SUITE(reset_suite, NULL, NULL, NULL, NULL, NULL);
ZTEST_SUITE(receiver_suite, NULL, NULL, NULL, NULL, NULL);

ZTEST(status_suite, test_color_cycle)
{
	zassert_equal(loa_status_next(LOA_STATUS_OFF), LOA_STATUS_WARN);
	zassert_equal(loa_status_next(LOA_STATUS_WARN), LOA_STATUS_ON_AIR);
	zassert_equal(loa_status_next(LOA_STATUS_ON_AIR), LOA_STATUS_OKAY);
	zassert_equal(loa_status_next(LOA_STATUS_OKAY), LOA_STATUS_REQUEST);
	zassert_equal(loa_status_next(LOA_STATUS_REQUEST), LOA_STATUS_SPECIAL);
	zassert_equal(loa_status_next(LOA_STATUS_SPECIAL), LOA_STATUS_OFF);
}

ZTEST(status_suite, test_color_mapping)
{
	struct loa_rgb color = loa_status_rgb(LOA_STATUS_WARN);

	zassert_equal(color.red, 255U);
	zassert_equal(color.green, 112U);
	zassert_equal(color.blue, 0U);
	color = loa_status_rgb(LOA_STATUS_ON_AIR);
	zassert_equal(color.red, 255U);
	zassert_equal(color.green, 0U);
	color = loa_status_rgb(LOA_STATUS_OKAY);
	zassert_equal(color.green, 255U);
	color = loa_status_rgb(LOA_STATUS_OFF);
	zassert_equal(color.red | color.green | color.blue, 0U);
}

ZTEST(protocol_suite, test_round_trip)
{
	const struct loa_message source = {
		.transaction_id = 0x78563412U,
		.status = LOA_STATUS_ON_AIR,
	};
	struct loa_message decoded;
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	zassert_ok(loa_protocol_encode(payload, &source));
	zassert_equal(payload[0], LOA_PROTOCOL_VERSION);
	zassert_equal(payload[1], 0x12U);
	zassert_equal(payload[4], 0x78U);
	zassert_ok(loa_protocol_decode(&decoded, payload, sizeof(payload)));
	zassert_equal(decoded.transaction_id, source.transaction_id);
	zassert_equal(decoded.status, source.status);
}

ZTEST(record_suite, test_all_six_states_survive_wire_and_storage)
{
	for (enum loa_status status = LOA_STATUS_OFF; status < LOA_STATUS_COUNT; ++status) {
		struct loa_message source = {.transaction_id = 0x76543210U, .status = status};
		struct loa_message decoded;
		uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN], record[LOA_RECORD_LEN];
		zassert_ok(loa_protocol_encode(payload, &source));
		zassert_ok(loa_protocol_decode(&decoded, payload, sizeof(payload)));
		zassert_equal(decoded.status, status);
		loa_record_encode(record, &source);
		zassert_ok(loa_record_decode(&decoded, record, sizeof(record)));
		zassert_equal(decoded.status, status);
		zassert_equal(decoded.transaction_id, source.transaction_id);
	}
}

ZTEST(protocol_suite, test_rejects_malformed_payloads)
{
	struct loa_message decoded;
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN] = {
		LOA_PROTOCOL_VERSION, 1U, 0U, 0U, 0U, LOA_STATUS_OFF,
	};

	zassert_equal(loa_protocol_decode(&decoded, payload, sizeof(payload) - 1U), -EINVAL);
	payload[0]++;
	zassert_equal(loa_protocol_decode(&decoded, payload, sizeof(payload)), -EINVAL);
	payload[0] = LOA_PROTOCOL_VERSION;
	payload[5] = 99U;
	zassert_equal(loa_protocol_decode(&decoded, payload, sizeof(payload)), -EINVAL);
}

ZTEST(record_suite, test_round_trip_and_corruption_detection)
{
	const struct loa_message source = {
		.transaction_id = 0xdeadbeefU,
		.status = LOA_STATUS_WARN,
	};
	struct loa_message decoded;
	uint8_t record[LOA_RECORD_LEN];

	loa_record_encode(record, &source);
	zassert_ok(loa_record_decode(&decoded, record, sizeof(record)));
	zassert_equal(decoded.transaction_id, source.transaction_id);
	zassert_equal(decoded.status, source.status);

	record[7] ^= 0x80U;
	zassert_equal(loa_record_decode(&decoded, record, sizeof(record)), -EBADMSG);
}

ZTEST(record_suite, test_corrupt_or_missing_settings_fall_back_to_off)
{
	struct loa_message state = {
		.transaction_id = 55U,
		.status = LOA_STATUS_ON_AIR,
	};
	uint8_t record[LOA_RECORD_LEN] = {0};

	zassert_false(loa_record_decode_or_default(&state, record, sizeof(record)));
	zassert_equal(state.transaction_id, 0U);
	zassert_equal(state.status, LOA_STATUS_OFF);

	state.transaction_id = 77U;
	state.status = LOA_STATUS_OKAY;
	zassert_false(loa_record_decode_or_default(&state, NULL, 0U));
	zassert_equal(state.transaction_id, 0U);
	zassert_equal(state.status, LOA_STATUS_OFF);
}

ZTEST(reset_suite, test_five_pin_resets_trigger_factory_reset)
{
	uint8_t retained = 0U;

	for (uint8_t press = 1U; press <= LOA_FACTORY_RESET_PRESS_COUNT; ++press) {
		const struct loa_reset_decision decision = loa_reset_gesture_update(retained, true);

		zassert_true(decision.button_press);
		zassert_equal(decision.factory_reset, press == LOA_FACTORY_RESET_PRESS_COUNT);
		retained = decision.retained_value;
	}
	zassert_equal(retained, 0U);
}

ZTEST(reset_suite, test_power_boot_clears_partial_gesture)
{
	struct loa_reset_decision decision =
		loa_reset_gesture_update(LOA_RESET_GESTURE_MAGIC | 3U, false);

	zassert_false(decision.button_press);
	zassert_false(decision.factory_reset);
	zassert_equal(decision.retained_value, 0U);
}

ZTEST(reset_suite, test_only_reset_pin_reason_is_a_button_press)
{
	const uint32_t pin_mask = 0x00000001U;

	zassert_true(loa_reset_reason_has_pin(pin_mask, pin_mask));
	zassert_true(loa_reset_reason_has_pin(pin_mask | 0x10U, pin_mask));
	zassert_false(loa_reset_reason_has_pin(0x10U, pin_mask));
	zassert_equal(LOA_RESET_GESTURE_CLEAR_MS, 6000U);
}

struct receiver_mock {
	char calls[8];
	size_t call_count;
	char fail_step;
};

static int record_receiver_step(struct receiver_mock *mock, char step)
{
	mock->calls[mock->call_count++] = step;
	return mock->fail_step == step ? -EIO : 0;
}

static int mock_persist(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(state);
	return record_receiver_step(user_data, 'P');
}

static int mock_apply(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(state);
	return record_receiver_step(user_data, 'L');
}

static int mock_ack(const struct loa_message *state, void *user_data)
{
	ARG_UNUSED(state);
	return record_receiver_step(user_data, 'A');
}

ZTEST(receiver_suite, test_persists_then_applies_then_acknowledges)
{
	const struct loa_message initial = {
		.transaction_id = 1U,
		.status = LOA_STATUS_OFF,
	};
	const struct loa_message command = {
		.transaction_id = 2U,
		.status = LOA_STATUS_ON_AIR,
	};
	struct loa_receiver_processor processor;
	struct receiver_mock mock = {0};
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	loa_receiver_processor_init(&processor, &initial, mock_persist, mock_apply, mock_ack,
				    &mock);
	zassert_ok(loa_protocol_encode(payload, &command));
	zassert_ok(loa_receiver_process_payload(&processor, payload, sizeof(payload)));
	zassert_equal(mock.call_count, 3U);
	zassert_mem_equal(mock.calls, "PLA", 3U);
	zassert_equal(processor.current.status, LOA_STATUS_ON_AIR);
}

ZTEST(receiver_suite, test_never_acks_failed_persistence_or_output)
{
	const struct loa_message initial = {
		.transaction_id = 1U,
		.status = LOA_STATUS_OFF,
	};
	const struct loa_message command = {
		.transaction_id = 2U,
		.status = LOA_STATUS_WARN,
	};
	struct loa_receiver_processor processor;
	struct receiver_mock mock = {.fail_step = 'P'};
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	loa_receiver_processor_init(&processor, &initial, mock_persist, mock_apply, mock_ack,
				    &mock);
	zassert_ok(loa_protocol_encode(payload, &command));
	zassert_equal(loa_receiver_process_payload(&processor, payload, sizeof(payload)), -EIO);
	zassert_mem_equal(mock.calls, "P", 1U);

	mock = (struct receiver_mock){.fail_step = 'L'};
	zassert_equal(loa_receiver_process_payload(&processor, payload, sizeof(payload)), -EIO);
	zassert_mem_equal(mock.calls, "PL", 2U);
}

ZTEST(receiver_suite, test_duplicate_is_idempotent_and_reacknowledged)
{
	const struct loa_message current = {
		.transaction_id = 7U,
		.status = LOA_STATUS_OKAY,
	};
	struct loa_receiver_processor processor;
	struct receiver_mock mock = {0};
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	loa_receiver_processor_init(&processor, &current, mock_persist, mock_apply, mock_ack,
				    &mock);
	zassert_ok(loa_protocol_encode(payload, &current));
	zassert_ok(loa_receiver_process_payload(&processor, payload, sizeof(payload)));
	zassert_equal(mock.call_count, 1U);
	zassert_equal(mock.calls[0], 'A');
}

ZTEST(receiver_suite, test_transaction_id_collision_is_rejected)
{
	const struct loa_message current = {
		.transaction_id = 7U,
		.status = LOA_STATUS_WARN,
	};
	const struct loa_message collision = {
		.transaction_id = 7U,
		.status = LOA_STATUS_ON_AIR,
	};
	struct loa_receiver_processor processor;
	struct receiver_mock mock = {0};
	uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];

	loa_receiver_processor_init(&processor, &current, mock_persist, mock_apply, mock_ack,
				    &mock);
	zassert_ok(loa_protocol_encode(payload, &collision));
	zassert_equal(loa_receiver_process_payload(&processor, payload, sizeof(payload)), -EINVAL);
	zassert_equal(mock.call_count, 0U);
	zassert_equal(processor.current.status, LOA_STATUS_WARN);
}
