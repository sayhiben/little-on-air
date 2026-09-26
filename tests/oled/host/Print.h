// SPDX-License-Identifier: MIT
#pragma once
#include <cstddef>
#include <cstdint>
class Print
{
      public:
	virtual ~Print() = default;
	virtual size_t write(uint8_t value) = 0;
	size_t write(const uint8_t *data, size_t size)
	{
		for (size_t i = 0; i < size; ++i) {
			write(data[i]);
		}
		return size;
	}
	size_t print(const char *text)
	{
		size_t count = 0;
		while (*text) {
			write(static_cast<uint8_t>(*text++));
			++count;
		}
		return count;
	}
};
