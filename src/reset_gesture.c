/* SPDX-License-Identifier: MIT */
#include <little_on_air/reset_gesture.h>

bool loa_reset_reason_has_pin(uint32_t reset_reasons, uint32_t reset_pin_mask)
{
	return (reset_reasons & reset_pin_mask) != 0U;
}

struct loa_reset_decision loa_reset_gesture_update(uint8_t retained_value, bool pin_reset)
{
	struct loa_reset_decision decision = {0};
	uint8_t count = 0U;

	if (!pin_reset) {
		return decision;
	}

	decision.button_press = true;
	if ((retained_value & 0xf0U) == LOA_RESET_GESTURE_MAGIC) {
		count = retained_value & 0x0fU;
	}

	count++;
	if (count >= LOA_FACTORY_RESET_PRESS_COUNT) {
		decision.factory_reset = true;
		return decision;
	}

	decision.retained_value = LOA_RESET_GESTURE_MAGIC | count;
	return decision;
}
