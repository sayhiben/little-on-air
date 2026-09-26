/* SPDX-License-Identifier: MIT */
#pragma once
#include <stddef.h>
#include <sys/types.h>
typedef ssize_t (*settings_read_cb)(void *, void *, size_t);
typedef int (*test_settings_handler)(const char *, size_t, settings_read_cb, void *);
#define SETTINGS_STATIC_HANDLER_DEFINE(name, prefix, get, set, commit, export)                     \
	test_settings_handler name##_handler = set
int settings_save_one(const char *key, const void *data, size_t len);
int settings_delete(const char *key);
