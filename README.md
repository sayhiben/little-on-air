# Little On Air

[![CI](https://github.com/sayhiben/little-on-air/actions/workflows/ci.yml/badge.svg)](https://github.com/sayhiben/little-on-air/actions/workflows/ci.yml)

A wireless desk controller and status sign. Turn the knob to choose a mood,
press to send it, and see the confirmed state on the controller's OLED and the
sign's four corner lights.

[Workspace guide](docs/WORKSPACE.md) · [Hardware](hardware/README.md) · [Current bench results](docs/PAIRING_POWER_UPDATE.md) · [Design history](hardware/archive/README.md)

## Current system

| Part | Hardware and firmware | Design files |
| --- | --- | --- |
| Desk controller | USB-powered XIAO ESP32-S3, 128×64 SSD1306 OLED, rotary push encoder and one NeoPixel; Arduino/PlatformIO | [Measured Igor v4](hardware/controller/igor-measured-v4/README.md) · [Complete ZIP](release/little-on-air-igor-controller-v4.zip) |
| Status sign | XIAO nRF52840, four external NeoPixels and an independent onboard power/status LED; Zephyr | [Enclosure v2.16](release/little-on-air-enclosure-v2.16/README.md) · [Complete ZIP](release/little-on-air-enclosure-v2.16.zip) |

The current controller firmware is `esp32s3-0.4.0`. Its matching receiver profile
uses padded SPI transmission with 375 ns zero pulses. The paired hardware has
been tested through all six moods, battery operation, pairing recovery and
online Forget; details and image hashes are in the
[pairing and power-light record](docs/PAIRING_POWER_UPDATE.md).

The latest enclosure and controller CAD have digital fit and manufacturing
checks. Physical print fit remains a separate validation step documented in
their assembly guides.

**Choose firmware separately from the manufacturing ZIPs.** The enclosure ZIPs
retain a firmware 0.1.2 snapshot that drives the onboard RGB LED only. Use the
current four-pixel receiver build below for an assembled sign. Local validated
firmware snapshots, when present, are under `.local/firmware/current/`; they are
not included in a fresh clone.

## Using the sign

| Mood | Light |
| --- | --- |
| Off | Dark |
| Warn | Warm amber |
| On Air | Red |
| Okay | Steady green |
| Request | Flashing green |
| Special | Slowly flowing rainbow |

- **Turn** to preview a mood. The sign and controller pixel retain the confirmed
  mood until you send a change.
- **Press** to apply the selection, or to connect when the controller is unpaired.
- **Hold for 1.2 seconds** to open the menu for connection checks, pairing, light
  tests and **Forget this sign**.

The OLED distinguishes confirmed state from an unverified cached state. A BLE
write alone is not confirmation: the receiver must acknowledge the exact mood
and transaction. Background checks leave the lights and animations undisturbed.

For first pairing, power the sign and reset an unpaired receiver once to open
its 60-second pairing window. Press the unpaired controller's knob to connect.
The receiver's onboard LED blinks red during pairing and stays red when paired,
including when the front lights are Off.

To pair again, keep the sign on and choose **Forget this sign → Forget sign**.
After **Ready to connect**, press the knob. If the sign was unavailable, follow
the displayed recovery steps: five receiver reset presses about two seconds
apart clear its bond and saved mood. Rapid double-reset still enters the UF2
bootloader.

See the [controller wiring and controls](apps/controller-esp32s3/README.md) for
complete setup and [pairing recovery](apps/controller-esp32s3/README.md#reconnecting-after-forget-this-sign).

## Build the firmware

The commands below use a Linux/WSL shell. Host checks need a C/C++ compiler and
CMake. Receiver builds also need Git, Python, Ninja, west and the Zephyr host
dependencies. Reuse an existing configured workspace and toolchain when available;
the [workspace guide](docs/WORKSPACE.md) describes this checkout's local setup.

### ESP32-S3 controller

From the repository root:

```sh
python -m pip install platformio==6.1.18
python -m platformio run -d apps/controller-esp32s3
```

Dependencies are pinned in [platformio.ini](apps/controller-esp32s3/platformio.ini).
Outputs are in `apps/controller-esp32s3/.pio/build/xiao_esp32s3/`. Use the
[PlatformIO upload instructions](apps/controller-esp32s3/README.md#build-flash-and-inspect)
to flash the controller's bootloader, partition table and application.

### Four-pixel nRF52840 receiver

For a fresh Zephyr workspace, install the pinned dependencies from
[west.yml](west.yml):

```sh
mkdir little-on-air-workspace && cd little-on-air-workspace
git clone https://github.com/sayhiben/little-on-air.git little-on-air
west init -l little-on-air
west update
west zephyr-export
west packages pip --install
west sdk install -t arm-zephyr-eabi
cd little-on-air
```

Then, from the repository root within that workspace:

```sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver-pixels-timing375 -- \
  -DEXTRA_CONF_FILE="pixels.conf;pixels-padded.conf;pixels-timing375.conf" \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/boards/xiao_ble_nrf52840_pixels.overlay;$PWD/boards/xiao_ble_nrf52840_pixels_timing375.overlay"
```

Flash `build/receiver-pixels-timing375/zephyr/zephyr.uf2` using the
[UF2 instructions](docs/FLASHING.md) and the assembled sign's
[USB/battery connection sequence](docs/PAIRED_BENCH.md#connections).
The factory bootloader, reset pin, bond storage and saved state are preserved by
ordinary application-only updates.

### Legacy controller and default receiver

`apps/controller/` retains the reset-button nRF52840 controller. The default
receiver build uses the onboard power/status LED; external sign pixels require
the profile above. Both applications remain covered by CI:

```sh
west build -b xiao_ble/nrf52840 apps/controller -d build/controller
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver
```

The [tagged release workflow](.github/workflows/release.yml) publishes nRF52840
UF2/ELF images. Those controller UF2 files are not ESP32-S3 firmware.

## Test and inspect

From the repository root, with the corresponding toolchains configured:

```sh
cmake -S apps/controller-esp32s3/test -B build/desk-tests
cmake --build build/desk-tests
ctest --test-dir build/desk-tests --output-on-failure
west twister -T tests -v --inline-logs --integration --outdir build/twister
```

After building the controller and four-pixel receiver, check the actual OLED
renderer and simulated pixel waveform:

```sh
python -m pip install Pillow==10.4.0
python tools/render_buddy_ui.py
python tools/simulate_pixels.py --profile timing375
```

The OLED renderer uses g++ and the PlatformIO-installed GFX library. Previews,
test output and simulations stay under `build/`. [CI](.github/workflows/ci.yml)
checks formatting, host and core tests, both controllers, receiver profiles,
OLED bounds and pixel timing on pull requests.

CI and release builds share a [cached Zephyr setup](.github/actions/setup-zephyr/action.yml).
The official Zephyr action caches the SDK, pip downloads and compiled objects;
the local wrapper also caches west source dependencies by the pinned manifest
and setup configuration. Only the Nordic HAL is needed for the current Zephyr
targets. ESP32 builds cache PlatformIO packages and libraries by `platformio.ini`
and the PlatformIO version. Builds and tests still run on every CI invocation,
and a missing cache is populated automatically. Update the HAL filter when
adding a Zephyr target from another chip vendor.

## Project layout and further reading

Firmware lives in `apps/`, `src/`, `include/` and `boards/`. Current CAD and print
files are under `hardware/enclosure/` and `hardware/controller/`; older designs
are under `hardware/archive/`. Published manufacturing bundles retain their
versioned paths in `release/`. Disposable output belongs in `build/`, and local
firmware snapshots, bench evidence and scratch work belong in `.local/`.

- [Workspace guide](docs/WORKSPACE.md): directory map and preserved local records.
- [Architecture](docs/ARCHITECTURE.md): shared protocol, state machines and persistence.
- [Power](docs/POWER.md) and [debugging](docs/DEBUGGING.md): board-specific details.
- [Hardware acceptance](docs/HARDWARE_ACCEPTANCE.md): physical validation checklist.
- [Contributing](CONTRIBUTING.md) and [agent guidance](AGENTS.md): development conventions.

## License

[MIT](LICENSE)
