/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_RESET_GESTURE_H_
#define LITTLE_ON_AIR_RESET_GESTURE_H_

#include <stdbool.h>
#include <stdint.h>

#define LOA_FACTORY_RESET_PRESS_COUNT 5U
#define LOA_RESET_GESTURE_MAGIC       0xA0U
#define LOA_RESET_GESTURE_CLEAR_MS    6000U

struct loa_reset_decision {
	uint8_t retained_value;
	bool button_press;
	bool factory_reset;
};

struct loa_reset_decision loa_reset_gesture_update(uint8_t retained_value, bool pin_reset);
bool loa_reset_reason_has_pin(uint32_t reset_reasons, uint32_t reset_pin_mask);

#endif /* LITTLE_ON_AIR_RESET_GESTURE_H_ */
