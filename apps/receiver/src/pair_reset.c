/* SPDX-License-Identifier: MIT */
#include <errno.h>
#include <string.h>
#include <zephyr/kernel.h>
#include <zephyr/settings/settings.h>
#include <zephyr/sys/reboot.h>
#include "pair_reset.h"

static bool pending;
static int reset_settings(const char *name, size_t len, settings_read_cb read_cb, void *arg)
{
	uint8_t value;
	if (strcmp(name, "pending") != 0 || len != sizeof(value)) {
		return -ENOENT;
	}
	if (read_cb(arg, &value, sizeof(value)) != sizeof(value)) {
		return -EIO;
	}
	pending = value == 1U;
	return 0;
}
SETTINGS_STATIC_HANDLER_DEFINE(loa_pair, "loa_pair", NULL, reset_settings, NULL, NULL);

static void reboot_to_pair(struct k_work *work)
{
	ARG_UNUSED(work);
	sys_reboot(SYS_REBOOT_COLD);
}
K_WORK_DELAYABLE_DEFINE(reboot_work, reboot_to_pair);

bool loa_pair_reset_pending(void)
{
	return pending;
}
int loa_pair_reset_mark(void)
{
	const uint8_t value = 1U;
	int err = pending ? 0 : settings_save_one("loa_pair/pending", &value, sizeof(value));
	if (err == 0) {
		pending = true;
	}
	return err;
}
int loa_pair_reset_complete(void)
{
	int err = settings_delete("loa_pair/pending");
	if (err == 0 || err == -ENOENT) {
		pending = false;
		return 0;
	}
	return err;
}
int loa_pair_reset_request(void)
{
	int err = loa_pair_reset_mark();
	if (err == 0) {
		/* Give the encrypted write response time to reach the controller.
		 * The durable intent also completes if power is lost before reboot.
		 */
		(void)k_work_reschedule(&reboot_work, K_MSEC(1500));
	}
	return err;
}
