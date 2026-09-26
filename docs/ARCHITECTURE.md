# Architecture

This page describes the implemented nRF52840 v0 firmware. The new
[USB-powered ESP32-S3 Igor controller](../hardware/controller/igor-measured-v4/README.md)
uses a display and encoder; its [firmware migration contract](../hardware/controller/igor-measured-v4/FIRMWARE.md)
preserves this BLE protocol while replacing the reset-driven controller lifecycle.
The implementation is now in [apps/controller-esp32s3](../apps/controller-esp32s3/README.md):
an always-running OLED/encoder UI, independent BLE worker, native USB diagnostics,
and one external NeoPixel. See its [initial bench record](ESP32S3_BENCH.md) and
the [six-mood update](BUDDY_UPDATE.md) for current paired hardware checks.

## Roles and lifecycle

The receiver is a BLE peripheral and the authority for applied state. The
controller is a BLE central. A stored bond represents logical synchronization;
the radios do not remain connected between transactions.

On a controller reset-pin boot, the shared controller state machine advances
the last confirmed status, generates a random transaction ID, connects,
subscribes to state indications, and writes the command. On a battery boot it
performs a state read without advancing. The receiver continuously advertises
to its bonded peer at about a one-second interval.

## GATT service

| Item | UUID | Access |
| --- | --- | --- |
| Service | `7f6c0000-6b7e-4c80-9f2a-f9b9d7e2a601` | Primary service |
| Command | `7f6c0001-6b7e-4c80-9f2a-f9b9d7e2a601` | Encrypted write with response |
| State | `7f6c0002-6b7e-4c80-9f2a-f9b9d7e2a601` | Encrypted read and indicate |
| Pixel test (pixel builds) | `7f6c0003-6b7e-4c80-9f2a-f9b9d7e2a601` | Encrypted write and read |
| Pairing control (0.4 update) | `7f6c0004-6b7e-4c80-9f2a-f9b9d7e2a601` | Bonded, encrypted write with response |

Version 1 messages are six bytes:

| Offset | Size | Meaning |
| --- | --- | --- |
| 0 | 1 | Protocol version (`1`) |
| 1 | 4 | Transaction ID, little-endian |
| 5 | 1 | `0=off`, `1=warn`, `2=on-air`, `3=okay`, `4=request`, `5=special` |

Request and Special are appended in the six-mood update; the payload version,
size, and first four values are unchanged. Both peers must support the new values.

The receiver rejects unknown versions, lengths, or statuses. A command is
processed in this order:

1. Decode and validate.
2. Persist the candidate record.
3. Apply it through the status-output interface.
4. Update the readable state and send an indication.

An exact duplicate skips persistence and output but is indicated again. If an
indication is lost after the receiver applied a command, the controller reads
the state characteristic and accepts only an exact transaction/status match.

## Persistence

Zephyr stores BLE bonds and `loa/state` in the XIAO's stock 32 KiB internal
storage partition. The application record contains a magic value, schema,
status, transaction ID, and CRC-32. Invalid records fall back to Off.

The five-press factory gesture uses a one-byte NVS setting `loa_reset/count`.
Only `RESETREAS.RESETPIN` boots advance it, after settings have loaded. A power
or software reset clears it; six seconds of uninterrupted application runtime
also clears a partial sequence. Five presses about two seconds apart trigger
the reset. A failed counter write never authorizes an erase. Normal boots with
a zero count do not write flash. The previous GPREGRET2 counter failed because
pin resets clear that register. The stock bootloader still owns rapid double-reset
detection; RESET remains a hardware reset input.

The pairing-control packet is six bytes: version 1, opcode 1 (Forget), and a
nonzero 32-bit request ID in little-endian order. Only the currently bonded,
encrypted connection may request it. The receiver persists `loa_pair/pending`
before returning ATT success, then reboots after 1.5 seconds. Startup processes
that durable intent or a five-press gesture by removing bonds and saved mood,
then deleting the intent and entering a 60-second pairing window in Off. An
interrupted erase is retried on the next boot. The controller disconnects before
clearing its own keys. If the sign cannot acknowledge the request, explicit
Forget still clears the local keys and shows the physical reset instructions.
Ordinary sync/send never deletes a bond. The mood command/ACK protocol is unchanged.

The pinned NimBLE 2.5.1 host has two additional recovery hazards: an internal
status-518 handler starts pairing before notifying GAP listeners, and its default
storage-overflow callback can delete a bond when the private-address cache fills.
The controller build compiles a generated host copy with that automatic pairing
branch disabled; downloaded dependency sources are unchanged and source/version
mismatches fail the build. The application replaces only the same peer's stale
address-cache entry and refuses key eviction. Normal security operations require
a stored LTK, attempt encryption once, and preserve keys on a missing-key error.
See [the hardware regression record](PAIRING_POWER_UPDATE.md).

## Source organization

- `src/` and `include/little_on_air/` contain shared protocol, persistence,
  state-machine, reset, indicator, and output code.
- `apps/controller/` owns BLE central orchestration.
- `apps/receiver/` owns advertising and the GATT server.
- `tests/unit/` exercises the hardware-independent core using Ztest.
- `boards/` contains the shared XIAO overlay and three-channel PWM mapping.

`loa_status_output_set_rgb()` drives uniform indication/test colors;
`loa_status_output_set_status()` renders a mood at an elapsed time. The onboard
indicator uses P0.26, P0.30, and P0.06 on one nRF PWM peripheral. Receiver pixel
builds also drive the four external GRB pixels on D2/P0.28. The currently tested
hardware uses padded SPI with 375 ns zero-high timing. With
`CONFIG_LOA_RECEIVER_POWER_LED=y`, the onboard PWM channels are independent:
steady red when paired, 250 ms red on/off during pairing, and 1800 ms red on /
200 ms off when unpaired outside the pairing window. Sign Off leaves this power
indicator lit. Routine bonded radio connections leave it steady.

`LOA_PIXEL_BRIGHTNESS_PERMILLE=160` sets the front-pixel ceiling, separately from
the onboard `LOA_LED_BRIGHTNESS_PERMILLE=125`. The ESP32-S3 external indicator
uses 24/255. Color mapping, padded SPI frames, and 375 ns timing are unchanged.

Request flashes green every 600 ms. Special updates at 20 Hz, with a 20-second
color cycle and corner hue offsets for a diagonal wash. The receiver owns these
animations; radio traffic is not required to advance them. Setting an unchanged
status preserves its phase. Normal bonded BLE connection/disconnection leaves
the output alone, so the desk controller's 60-second read cannot flash blue or
restart an animation. Pairing and genuine error indications remain available.
