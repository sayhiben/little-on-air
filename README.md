# Little On Air

[![CI](https://github.com/sayhiben/little-on-air/actions/workflows/ci.yml/badge.svg)](https://github.com/sayhiben/little-on-air/actions/workflows/ci.yml)

Little On Air is a two-board, battery-powered status light built with Seeed
XIAO nRF52840 boards. Pressing the controller's reset button cycles the shared
state through:

```text
Off -> Yellow (warn) -> Red (on air) -> Green (okay) -> Off
```

Version 0 uses each board's onboard RGB LED. The receiver output is isolated
behind a small driver interface so a later version can add bright addressable
LEDs without changing the BLE protocol or state machines.

## What you need

- Two Seeed Studio XIAO nRF52840 boards with their factory UF2 bootloaders
- Two small protected 3.7 V LiPo batteries, if running untethered
- USB-C cables for flashing and charging
- Git, Python 3.10+, CMake, Ninja, and west 1.x for local development
- The Zephyr 4.3.0 host tools and Arm SDK toolchain installed below

The firmware targets `xiao_ble/nrf52840`; it does not use the Sense-only
sensors, so it also works on the Sense variant.

## First pairing

1. Flash `receiver.uf2` onto the display board and `controller.uf2` onto the
   remote board as described in [the flashing guide](docs/FLASHING.md).
2. Power both boards. An unpaired board slowly flashes blue.
3. Press reset once on the receiver and once on the controller within 60
   seconds. Both flash blue quickly while connecting.
4. Three green pulses confirm a bond. Both LEDs then turn off.

The controller disconnects after each transaction. The receiver advertises at
a low duty cycle only to its bonded controller, so a dark, idle system spends
most of its time asleep.

## Everyday use

Press reset once on the controller. The stock bootloader runs first, so a v0
button action has an expected 1-2 second delay. The controller flashes the
requested color while it connects and the two LEDs become solid only after the
receiver has persisted and applied the command.

If no acknowledgment arrives within eight seconds, the controller alternates
red and white three times, then reads the receiver's authoritative state. It
retries with bounded backoff before returning to a slow blue desynced pattern.

The receiver restores its last acknowledged status after a recharge. A
controller power-up reads that status instead of advancing the color.

### Repairing the pair

To deliberately erase a pairing, first press reset five times on the
controller, then do the same on the receiver while the controller is still
trying to pair. Wait for the LED to return between the first four presses;
pressing twice rapidly enters the UF2 bootloader instead. Each fifth paced
press clears that board's saved bond and status and enters a fresh pairing
window. If the windows do not overlap, press either unpaired board once to
reopen its window.

## LED language

| Condition | Pattern |
| --- | --- |
| Waiting/desynced | Blue, 250 ms on / 1750 ms off |
| Pairing, connecting, reconciling | Blue, 150 ms on/off |
| Sending a color | Requested color, 150 ms on/off |
| Sending Off | Blue, 150 ms on/off |
| Confirmed | Off or solid yellow/red/green |
| Failed command | Red/white three times at 200 ms per color |

The default PWM ceiling is 12.5%. It can be adjusted at configure time with
`LOA_LED_BRIGHTNESS_PERMILLE`; per-channel calibration variables are available
for balancing yellow and reducing battery drain.

## Build and test

Create a west workspace and install the pinned Zephyr dependencies:

```sh
mkdir little-on-air-workspace && cd little-on-air-workspace
git clone https://github.com/sayhiben/little-on-air.git little-on-air
west init -l little-on-air
west update
west zephyr-export
west packages pip --install
west sdk install -t arm-zephyr-eabi
```

Then build and test from the workspace root:

```sh
west build -b xiao_ble/nrf52840 little-on-air/apps/controller -d build/controller
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -d build/receiver
west twister -T little-on-air/tests -v --inline-logs
```

The user-facing images are `build/controller/zephyr/zephyr.uf2` and
`build/receiver/zephyr/zephyr.uf2`. GitHub Actions runs the same tests and
builds on every push and pull request. Semantic version tags publish named UF2
and ELF files with checksums as GitHub Releases.

## Design notes

- The BLE service is encrypted and bonded, supports exactly one pair, and uses
  an explicit 32-bit transaction ID for every command.
- The receiver stores state before applying it and indicates success only
  after both operations complete. Duplicate transactions are idempotent.
- P0.18 remains nRESET. Firmware reads and clears `RESETREAS.RESETPIN`; it does
  not erase UICR or replace the factory bootloader.
- Pairing/status records use the board's 32 KiB internal storage partition and
  survive application-only UF2 updates.
- Secure Connections “Just Works” is intentionally limited to a physical
  pairing window. It provides encryption but no passkey-based MITM protection.

See [architecture](docs/ARCHITECTURE.md), [USB diagnostics](docs/DEBUGGING.md),
[power notes](docs/POWER.md), and the
[hardware acceptance checklist](docs/HARDWARE_ACCEPTANCE.md) for more detail.

## License

[MIT](LICENSE)
