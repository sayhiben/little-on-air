# Current firmware architecture

Little On Air maintains one ESP32-S3 controller and one nRF52840 sign. The full
implementation reference is the [developer guide](../CONTRIBUTING.md#software-architecture),
including the [wire/storage contract](../CONTRIBUTING.md#protocol-and-persistence).

## Roles and ownership

- `apps/controller-esp32s3/`: Arduino UI/input loop, Preferences cache and one
  asynchronous NimBLE worker. The OLED separates selected, confirmed and verified
  state. Startup and background reconciliation read without changing the sign.
- `apps/receiver/`: Zephyr peripheral, encrypted GATT server, durable reset intent,
  independent power light, mood scheduler, status output and padded SPI driver.
  Its normal build always includes four pixels with 375 ns zero pulses.
- `src/`, `include/little_on_air/`: portable status/protocol, receiver processing,
  record/storage/reset helpers and pixel-frame encoding. Status/protocol are
  compiled into both device applications.
- `tests/host/`: host build for both devices' tests under `tests/`. It includes
  ESP32 input/state, actual receiver output/scheduling/reset logic and bond guards.
- `tests/unit/`: Zephyr core tests for protocol, persistence, reset and receiver
  processing. `tests/oled/` and `tests/pixels/` exercise actual rendering/encoding.

## Transaction and persistence

A command is six bytes: version 1, 32-bit little-endian transaction ID and status
0–5. The receiver validates and deduplicates, persists, applies, then acknowledges.
The controller confirms only an exact transaction/status match through an
indication or fallback state read. An ATT write response is not confirmation.
Do not automatically replay a command after an ambiguous acknowledgement failure.

Normal operations preserve pairing keys. Explicit Forget writes a durable
receiver reset intent, reboots and clears pairing/saved mood, with physical
five-reset recovery if communication fails. Factory rapid double-reset recovery
and nRESET remain intact. The NimBLE build guard and address-cache handling stop
ordinary security errors or address churn from silently replacing keys.

## Current output model

`apps/receiver/src/mood_indicator.c` schedules steady/animated moods and preserves
phase on unchanged reads. `status_output.c` drives four GRB pixels separately
from the onboard power LED. `padded_pixels.c` sends the shared encoder's 720-byte
frame in a single SPI DMA transfer: 300 µs low, 120 µs data, 300 µs low. The
complete pin/timing configuration is in `boards/xiao_ble_nrf52840.overlay`.

The old reset-button controller, its state machine/blink patterns, and optional
receiver comparison profiles were retired. [Firmware history](HISTORY.md) points
to their last source revision. Hardware history and published bundle bytes are
preserved separately; they are not active firmware targets.
