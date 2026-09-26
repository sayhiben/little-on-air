/* SPDX-License-Identifier: MIT */
#ifndef LITTLE_ON_AIR_PAIRING_CONTROL_H_
#define LITTLE_ON_AIR_PAIRING_CONTROL_H_
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define LOA_PAIRING_CONTROL_LEN  6U
#define LOA_PAIRING_CONTROL_UUID "7f6c0004-6b7e-4c80-9f2a-f9b9d7e2a601"

/* Version 1, Forget opcode 1, nonzero request ID (little endian).
 * This administrative command is accepted only over an encrypted bond.
 */
static inline bool loa_pairing_control_valid(const void *payload, size_t len)
{
	const uint8_t *p = (const uint8_t *)payload;
	return p != NULL && len == LOA_PAIRING_CONTROL_LEN && p[0] == 1U && p[1] == 1U &&
	       (p[2] | p[3] | p[4] | p[5]) != 0U;
}
#endif
