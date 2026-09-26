/* SPDX-License-Identifier: MIT */
#pragma once
#define DT_ALIAS(name)                   name
#define pwm_red                          0
#define pwm_green                        1
#define pwm_blue                         2
#define loa_pixels                       3
#define DT_NODE_HAS_STATUS(node, status) 1
#define DT_PROP(node, property)          4
#define DEVICE_DT_GET(node)              (&fake_pixels)
