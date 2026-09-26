/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdbool.h>
bool loa_pair_reset_pending(void);
int loa_pair_reset_mark(void);
int loa_pair_reset_complete(void);
int loa_pair_reset_request(void);
