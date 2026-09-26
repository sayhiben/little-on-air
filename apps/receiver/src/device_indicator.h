/* SPDX-License-Identifier: MIT */
#pragma once
enum loa_device_state {
	LOA_DEVICE_READY,
	LOA_DEVICE_PAIRING,
	LOA_DEVICE_UNPAIRED
};
void loa_device_indicator_init(void);
void loa_device_indicator_set(enum loa_device_state state);
