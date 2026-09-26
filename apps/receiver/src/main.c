/* SPDX-License-Identifier: MIT */
#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/bluetooth/conn.h>
#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/settings/settings.h>

#include <little_on_air/indicator.h>
#include <little_on_air/reset_input.h>
#include <little_on_air/store.h>

#include "ble_server.h"
#include "device_indicator.h"
#include "pair_reset.h"

#if defined(CONFIG_UART_CONSOLE)
#include <errno.h>
#include <string.h>
#include <hal/nrf_power.h>
#include <zephyr/drivers/uart.h>
#include <zephyr/sys/reboot.h>

static void bench_usb_poll(void)
{
	static char line[32];
	static size_t used;
	static bool overflow;
	const struct device *uart = DEVICE_DT_GET(DT_CHOSEN(zephyr_console));
	uint8_t c;
	while (uart_poll_in(uart, &c) == 0) {
		if (c == '\r') {
			continue;
		}
		if (c != '\n') {
			if (used < sizeof(line) - 1) {
				line[used++] = c;
			} else {
				overflow = true;
			}
			continue;
		}
		line[used] = 0;
		used = 0;
		if (overflow) {
			overflow = false;
			printk("BENCH ERROR command too long\n");
			continue;
		}
		if (strcmp(line, "pair-reset") == 0) {
			int err = loa_pair_reset_request();
			printk("BENCH pair-reset saved=%d\n", err);
		} else if (strcmp(line, "reboot") == 0 || strcmp(line, "bootloader") == 0) {
			printk("BENCH %s\n", line);
			k_sleep(K_MSEC(250));
			if (strcmp(line, "bootloader") == 0) {
				nrf_power_gpregret_set(NRF_POWER, 0U, 0x57U);
			}
			sys_reboot(SYS_REBOOT_COLD);
		} else if (strcmp(line, "status") == 0) {
			struct loa_message current = loa_store_get_state();
			printk("BENCH bonded=%u saved=%u tx=%08x status=%u\n",
			       loa_ble_server_has_bond(), loa_store_has_state(),
			       current.transaction_id, current.status);
		} else {
			printk("BENCH commands: status | pair-reset | reboot | bootloader\n");
		}
	}
}
#endif

LOG_MODULE_REGISTER(loa_receiver_main);

int main(void)
{
	struct loa_boot_input input;
	struct loa_message initial_state = {
		.transaction_id = 0U,
		.status = LOA_STATUS_OFF,
	};
	int err;

	err = loa_indicator_init();
	if (err != 0) {
		return err;
	}
	loa_device_indicator_init();
	input = loa_reset_input_capture();
	LOG_INF("boot button_press=%u factory_reset=%u", input.button_press, input.factory_reset);

	err = bt_enable(NULL);
	if (err != 0) {
		LOG_ERR("Bluetooth enable failed err=%d", err);
		return err;
	}
	LOG_INF("Bluetooth enabled");
	err = settings_load();
	if (err != 0) {
		LOG_ERR("settings load failed err=%d", err);
		return err;
	}
	LOG_INF("settings loaded");
	err = loa_reset_input_resolve(&input);
	if (err != 0) {
		LOG_ERR("reset gesture storage failed err=%d", err);
		return err;
	}
	input.factory_reset = input.factory_reset || loa_pair_reset_pending();

	if (input.factory_reset) {
		err = loa_pair_reset_mark();
		if (err != 0) {
			return err;
		}
		err = bt_unpair(BT_ID_DEFAULT, BT_ADDR_LE_ANY);
		LOG_INF("factory reset unpair result=%d", err);
		if (err != 0) {
			return err;
		}
		err = loa_store_clear_state();
		LOG_INF("factory reset state clear result=%d", err);
		if (err != 0) {
			return err;
		}
		err = loa_pair_reset_complete();
		if (err != 0) {
			return err;
		}
	} else if (loa_store_has_state()) {
		initial_state = loa_store_get_state();
	}
	LOG_INF("initial transaction=0x%08x status=%u", initial_state.transaction_id,
		initial_state.status);

	err = loa_ble_server_init(&initial_state);
	if (err != 0) {
		LOG_ERR("BLE server init failed err=%d", err);
		return err;
	}
	err = loa_ble_server_start(input.button_press || input.factory_reset);
	if (err != 0) {
		LOG_ERR("BLE server start failed err=%d", err);
		return err;
	}
	LOG_INF("receiver ready");

#if defined(CONFIG_UART_CONSOLE)
	/* CDC ACM needs its OUT endpoint armed even with polling reads. */
	uart_irq_rx_enable(DEVICE_DT_GET(DT_CHOSEN(zephyr_console)));
#endif
	while (true) {
#if defined(CONFIG_UART_CONSOLE)
		bench_usb_poll();
		k_sleep(K_MSEC(10));
#else
		k_sleep(K_FOREVER);
#endif
	}
	return 0;
}
