// SPDX-License-Identifier: MIT
#pragma once
struct HostSerial {
	template <typename... Args> void printf(const char *, Args...)
	{
	}
};
extern HostSerial Serial;
