# USB diagnostics for the current pair

The ESP32-S3 controller always exposes native USB serial diagnostics at 115200
baud. The normal nRF52840 receiver disables USB/logging; its optional diagnostic
configuration enables CDC without changing the current pixel configuration.
There is no nRF52840 controller debug target.

## Controller

```sh
python -m platformio device list
python tools/controller_serial.py --port COM4 --command status
python tools/controller_serial.py --port COM4 --command sync
```

Replace the example port. `status` inspects local state; `sync` reads the sign.
`help` lists the full command set. `send`, `pair` and `pixel` commands act on
hardware; use them as deliberate bench actions. The script sets serial control
lines before opening the port to avoid resetting the controller while observing.

## Receiver

From the repository root in a configured west workspace:

```sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver-debug -- \
  -DEXTRA_CONF_FILE=debug.conf \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/boards/xiao_ble_nrf52840_debug.overlay"
```

Flash the diagnostic UF2 using [FLASHING.md](FLASHING.md). Receiver USB requires
POWER OFF / PROGRAM and charger USB unplugged. That isolates battery/pixel paths;
a USB log capture is not evidence of normal battery/RUN optical behavior.

Receiver commands are `status`, `pair-reset`, `reboot` and `bootloader`. The last
three change device state. `pair-reset` stores reset intent before rebooting;
`bootloader` deliberately enters factory update mode.

## Reconnecting log capture

```sh
python -m pip install pyserial
python tools/tail_serial.py --duration 60
```

The tailer follows the current identities: ESP32-S3 native USB `303A:1001` as
CTRL and Zephyr receiver debug `2FE3:0006` as RECV. Keep only the intended boards
connected. It reconnects after USB resets and preserves ANSI-free log text.

For physical paired runs, leave receiver USB unplugged and capture from the
controller using `tools/paired_bench.py`. See the [developer guide](../CONTRIBUTING.md#diagnostics-and-bench-work).
After servicing, restore the normal receiver image before power measurements.
Record image hashes, source revision, power arrangement and actual observations.
