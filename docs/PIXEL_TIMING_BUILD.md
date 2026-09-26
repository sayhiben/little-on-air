# Receiver pixel timing test build

> Historical bench record: commands, paths and build variants below describe
> the recorded revision. Use the [current developer guide](../CONTRIBUTING.md)
> for today's build/flash commands. See [firmware history](HISTORY.md) for the
> retired source revision. Observations and image hashes below are retained.

This is a historical bench record. The old build trees were removed during
workspace cleanup; retained firmware snapshots, logs and simulation evidence
are listed in the [workspace guide](WORKSPACE.md#preserved-local-work).
Build commands below use the consolidated `build/` directory.

A separate [375 ns zero-pulse comparison build](PIXEL_TIMING_375NS_BUILD.md)
is now available. This page describes the earlier padding-only candidate,
whose image remains preserved for comparison.

Prepared 2026-09-24 for the XIAO nRF52840 receiver's four external GRB pixels.
This is a candidate fix for the first pixel showing unwanted green. It has not
yet been flashed or accepted on hardware. The ESP32-S3 controller needs no update.

## Change

The optional `pixels-padded.conf` replaces the default Zephyr WS2812 SPI driver
with a repository-owned driver. Every output uses one contiguous RAM buffer:

```text
300 microseconds LOW | 120 microseconds pixel data | 300 microseconds LOW
```

At 4 MHz this is 150 zero bytes, 60 encoded data bytes and 150 zero bytes.
The first and last transmitted bits are LOW. The original additional 300 us
post-transfer delay remains. Padding consists of raw zero bits, which hold the
wire LOW; an encoded black pixel would contain pulses and would not serve this
purpose. The existing GRB mapping, 250/750 ns high pulses, four-pixel count,
brightness limit, D2 data pin, onboard LED and BLE protocol are preserved.

The actual generated nRF52840 configuration has a 16-bit DMA counter. The full
360-byte frame fits in one transfer. A compile-time assertion checks that against
the selected SPI bus. Other assertions match the encoder constants to the
generated pixel configuration. No upstream Zephyr files are patched.

The motivation is a possible SPI first-bit preload: starting a transfer with
HIGH may lengthen the first WS2812 pulse. GRB puts the first pixel's green byte
first, so a zero becoming one there could introduce unwanted green. This is a
hypothesis, supported by similar [Nordic observations](https://devzone.nordicsemi.com/f/nordic-q-a/126078/ws2812-with-spi-on-nrf9160-disrupted-by-an-high-signal-before-data-on-the-spi-mosi/556785)
and a [Zephyr first-pixel report](https://github.com/zephyrproject-rtos/zephyr/issues/75965),
not a measurement of this receiver's waveform.

## Build

From a configured Zephyr workspace, substitute your repository path:

```sh
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -d build/receiver-pixels-padded -- \
  -DEXTRA_CONF_FILE="pixels.conf;pixels-padded.conf" \
  -DEXTRA_DTC_OVERLAY_FILE=/path/to/little-on-air/boards/xiao_ble_nrf52840_pixels.overlay
```

Local candidate image: `build/receiver-pixels-padded/zephyr/zephyr.uf2`.
Candidate SHA-256:
`494144f2415d9b36adc0d12e96015360f0f519aab6936112738dd224a9648840`.
The production receiver build passed: 163,664 bytes flash and 29,604 bytes RAM.
Inspection of the linked ELF confirmed the padded driver and shared encoder are
present and the default WS2812 SPI update function is absent.

The standard `pixels.conf` profile remains available as the comparison image.
The previously installed image is still `build/receiver-pixels/zephyr/zephyr.uf2`,
SHA-256 `a16bb6e2d27a27406f7b4217680f1cea51fbb18cf5831abe971fc81f9928c78e`.
Rebuilding that original profile produced the same checksum. A preserved copy is
also at `build/receiver-pixels-padded/comparison-receiver.uf2`.
Use the normal application-only UF2 update; no pairing/state erase is needed.

## Simulation

On Linux or WSL with a C compiler, from this repository:

```sh
python3 tools/simulate_pixels.py
```

By default this checks the generated header in `build/receiver-pixels-padded`.
Use `--devicetree-header PATH` for another build directory and `--output PATH`
for another report directory. The simulator compiles and runs the **same C frame
encoder linked into the firmware**, then independently interprets its emitted
pulses. It also verifies the actual generated SPI frequency, pixel count, color
order, symbols, reset time and DMA capacity.

Results: **3,359 frame vectors and 10,055 waveform checks passed**, plus C bounds,
null-input, output-canary and input-preservation checks. Cases include:

- Every channel value 0–255 at all four positions, 256 deterministic random
  frames, mixed colors, all-off, and each pixel/color diagnostic.
- First-bit preload of 0, 0.25, 0.5, 1, 5 and 20 microseconds.
- Reset thresholds of 50, 280 and 300 microseconds; preceding partial frames.
- The actual single-transfer layout, plus an extra hypothetical 255-byte split
  with 0, 10 and 500 microseconds of idle time. That split lands in trailing LOW.

In the specific model where a one-microsecond startup delay stretches the first
HIGH pulse into a one bit, a pixel-1 red request `(31, 0, 0)` decodes as
`(31, 128, 0)` without padding and correctly as `(31, 0, 0)` with padding.

Outputs are `build/pixel-simulation/simulation.json`, `pixel-1-red.spi.bin`, and
`all-off.spi.bin`. CI builds the receiver variant and runs the same simulation.

**Limits:** this is a digital pulse-width model, not a microcontroller emulator
or oscilloscope capture. It cannot verify voltage levels, signal integrity,
the unknown pixel IC's precise timing tolerance, or RGB versus RGBW hardware.
Passing it establishes the intended encoded signal, not a physical repair.

## Hardware acceptance when connected

Follow the existing [PROGRAM/RUN and power sequence](PAIRED_BENCH.md#connections).
Flash the candidate receiver UF2, preserving the bond. With receiver USB removed
and the sign in RUN, use the existing controller `pixel` commands to observe:

1. Pixel 1 Off, Red, Green, Blue, White; each must match, with pixels 2–4 dark.
2. The same sequence independently at positions 2, 3 and 4.
3. Normal Off / Warn / On Air / Okay, with all four matching.
4. A receiver power cycle and repeated updates to verify the first frame too.

Record actual observations before calling the green-pixel issue resolved.
