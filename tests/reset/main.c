/* SPDX-License-Identifier: MIT */
/* Runs the actual settings/reset code. Hardware reset clears volatile jobs;
 * simulated flash survives. No GPREGRET retention is assumed.
 */
#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <zephyr/kernel.h>
#include <zephyr/settings/settings.h>
#include <little_on_air/reset_input.h>
#include <little_on_air/reset_gesture.h>
#include <little_on_air/pairing_control.h>
#include "pair_reset.h"

extern test_settings_handler loa_reset_handler, loa_pair_handler;
uint32_t simulated_reset_reason;
static uint8_t flash_count, flash_pending;
static bool fail_writes, rebooted;
static unsigned int writes;
static uint32_t now;
static struct {
	struct k_work_delayable *work;
	uint32_t due;
} jobs[4];
uint32_t k_uptime_get_32(void)
{
	return now;
}
int k_work_reschedule(struct k_work_delayable *work, uint32_t delay)
{
	for (size_t i = 0; i < 4; ++i) {
		if (jobs[i].work == work || jobs[i].work == NULL) {
			jobs[i].work = work;
			jobs[i].due = now + delay;
			return 0;
		}
	}
	assert(false);
	return -1;
}
static void advance(uint32_t ms)
{
	now += ms;
	for (size_t i = 0; i < 4; ++i) {
		if (jobs[i].work && jobs[i].due <= now) {
			struct k_work_delayable *work = jobs[i].work;
			jobs[i].work = NULL;
			work->work.handler(&work->work);
		}
	}
}
static bool any_job(void)
{
	for (size_t i = 0; i < 4; ++i) {
		if (jobs[i].work) {
			return true;
		}
	}
	return false;
}
int settings_save_one(const char *key, const void *data, size_t len)
{
	if (fail_writes) {
		return -EIO;
	}
	assert(len == 1);
	++writes;
	if (strcmp(key, "loa_reset/count") == 0) {
		flash_count = *(const uint8_t *)data;
	} else {
		assert(strcmp(key, "loa_pair/pending") == 0);
		flash_pending = *(const uint8_t *)data;
	}
	return 0;
}
int settings_delete(const char *key)
{
	if (fail_writes) {
		return -EIO;
	}
	assert(strcmp(key, "loa_pair/pending") == 0);
	flash_pending = 0;
	++writes;
	return 0;
}
void sys_reboot(int type)
{
	assert(type == 0);
	rebooted = true;
}
static ssize_t read_byte(void *arg, void *data, size_t len)
{
	assert(len == 1);
	memcpy(data, arg, 1);
	return 1;
}
static struct loa_boot_input boot(bool pin, int expected_error)
{
	memset(jobs, 0, sizeof(jobs));
	now = 0;
	rebooted = false;
	simulated_reset_reason = pin ? 1U : 4U;
	struct loa_boot_input input = loa_reset_input_capture();
	assert(simulated_reset_reason == 0);
	assert(loa_reset_handler("count", 1, read_byte, &flash_count) == 0);
	assert(loa_pair_handler("pending", 1, read_byte, &flash_pending) == 0);
	assert(loa_reset_input_resolve(&input) == expected_error);
	return input;
}
int main(void)
{
	for (unsigned int i = 1; i <= 5; ++i) {
		struct loa_boot_input input = boot(true, 0);
		assert(input.button_press && input.factory_reset == (i == 5));
		advance(2000);
	}
	assert(flash_count == 0);
	puts("PASS five physical-reset boots with persistent count and no retained-register "
	     "assumption");
	for (unsigned int i = 0; i < 4; ++i) {
		assert(!boot(true, 0).factory_reset);
	}
	advance(5999);
	assert(flash_count != 0);
	advance(1);
	assert(flash_count == 0);
	assert(!boot(true, 0).factory_reset);
	assert(!boot(false, 0).factory_reset && flash_count == 0);
	unsigned int before = writes;
	for (unsigned int i = 0; i < 50; ++i) {
		boot(false, 0);
	}
	assert(writes == before);
	puts("PASS timeout, power/software restart cancellation, no writes on clean power boots");
	for (unsigned int i = 0; i < 4; ++i) {
		boot(true, 0);
	}
	fail_writes = true;
	assert(!boot(true, -EIO).factory_reset);
	fail_writes = false;
	boot(false, 0);
	for (unsigned int value = 0; value < 256; ++value) {
		struct loa_reset_decision d = loa_reset_gesture_update(value, true);
		assert(d.factory_reset == (value == (LOA_RESET_GESTURE_MAGIC | 4U)));
	}
	puts("PASS failed storage never authorizes reset; corrupt count values cannot erase "
	     "pairing");
	uint8_t packet[] = {1, 1, 3, 0, 0, 0};
	assert(loa_pairing_control_valid(packet, sizeof(packet)));
	assert(!loa_pairing_control_valid(NULL, 6));
	for (size_t len = 0; len < 9; ++len) {
		if (len != 6) {
			assert(!loa_pairing_control_valid(packet, len));
		}
	}
	packet[0] = 2;
	assert(!loa_pairing_control_valid(packet, 6));
	packet[0] = 1;
	packet[1] = 2;
	assert(!loa_pairing_control_valid(packet, 6));
	packet[1] = 1;
	packet[2] = 0;
	assert(!loa_pairing_control_valid(packet, 6));
	fail_writes = true;
	assert(loa_pair_reset_request() == -EIO && !loa_pair_reset_pending() && !any_job());
	fail_writes = false;
	assert(loa_pair_reset_request() == 0 && flash_pending == 1);
	advance(1499);
	assert(!rebooted);
	advance(1);
	assert(rebooted);
	boot(false, 0);
	assert(loa_pair_reset_pending());
	fail_writes = true;
	assert(loa_pair_reset_complete() == -EIO && flash_pending == 1);
	fail_writes = false;
	assert(loa_pair_reset_complete() == 0);
	boot(false, 0);
	assert(!loa_pair_reset_pending());
	puts("PASS malformed administrative commands, durable reset intent, delayed reboot, and "
	     "cleanup retry");
}
