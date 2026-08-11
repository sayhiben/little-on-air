# Architecture

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

Version 1 messages are six bytes:

| Offset | Size | Meaning |
| --- | --- | --- |
| 0 | 1 | Protocol version (`1`) |
| 1 | 4 | Transaction ID, little-endian |
| 5 | 1 | `0=off`, `1=warn`, `2=on-air`, `3=okay` |

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

The five-press factory gesture uses `POWER.GPREGRET2`, which survives pin reset
but clears on power-on. Each firmware boot increments the retained count; six
seconds of uninterrupted application runtime clears a partial gesture. The
stock bootloader continues to own rapid double-reset detection.

## Source organization

- `src/` and `include/little_on_air/` contain shared protocol, persistence,
  state-machine, reset, indicator, and output code.
- `apps/controller/` owns BLE central orchestration.
- `apps/receiver/` owns advertising and the GATT server.
- `tests/unit/` exercises the hardware-independent core using Ztest.
- `boards/` contains the shared XIAO overlay and three-channel PWM mapping.

`loa_status_output_set_rgb()` is the future extension point for addressable
receiver LEDs. The v0 implementation drives P0.26, P0.30, and P0.06 using one
nRF PWM peripheral.
