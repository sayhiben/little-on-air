/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_RESET_INPUT_H_
#define LITTLE_ON_AIR_RESET_INPUT_H_

#include <stdbool.h>

struct loa_boot_input {
	bool button_press;
	bool factory_reset;
};

struct loa_boot_input loa_reset_input_capture(void);
/* Call once after settings_load(), before acting on factory_reset. */
int loa_reset_input_resolve(struct loa_boot_input *input);

#endif /* LITTLE_ON_AIR_RESET_INPUT_H_ */
