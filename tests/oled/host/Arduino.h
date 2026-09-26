// SPDX-License-Identifier: MIT
// Minimal desktop compatibility for the pinned Adafruit GFX rasterizer.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <string>
#define PROGMEM
using String = std::string;
using std::max;
using std::min;
class __FlashStringHelper;
inline void yield()
{
}
inline float radians(float degrees)
{
	return degrees * 0.017453292519943295f;
}
