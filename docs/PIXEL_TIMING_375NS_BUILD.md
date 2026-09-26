# Receiver 375 ns timing comparison

This is a historical bench record. The old build trees were removed during
workspace cleanup; retained firmware snapshots, logs and simulation evidence
are listed in the [workspace guide](WORKSPACE.md#preserved-local-work).
Build commands below use the consolidated `build/` directory.

Prepared 2026-09-24 for the XIAO nRF52840 receiver's four front pixels.
This separate candidate changes the zero pulse width. It was flashed on
2026-09-25 after the user's wiring work. The scoped physical checks below passed;
the first pixel no longer showed the reported unwanted green in those checks.
The ESP32-S3 controller needs no update.

## Timing change

| Nominal timing | Earlier padded build | This comparison build |
| --- | --- | --- |
| SPI clock | 4 MHz | 8 MHz |
| SPI clocks per pixel bit | 5 | 10 |
| Zero HIGH / LOW | 250 / 1,000 ns | 375 / 875 ns |
| One HIGH / LOW | 750 / 500 ns | 750 / 500 ns |
| Pixel bit period | 1,250 ns | 1,250 ns |
| Leading / trailing continuous LOW | 300 / 300 us | 300 / 300 us |
| Clocked frame length | 360 bytes | 720 bytes |
| Clocked frame duration | 720 us | 720 us |

At 8 MHz, zero is `1110000000` and one is `1111110000`. The shared encoder
stores each symbol in a 16-bit integer so the leading bits are retained.
The original five-bit profile is still selectable. No runtime detection or
automatic timing changes are introduced.

The same SPIM2 peripheral clocks a single contiguous RAM buffer: 300 zero
bytes, 120 payload bytes, 300 zero bytes. The additional original 300 us
post-transfer wait remains. Compile-time checks enforce the selected SPI
bus's clock limit and DMA capacity, and match the encoder to the devicetree.
The actual bus supports 8 MHz and has a 16-bit DMA counter; 720 bytes fit in
one transfer. GRB order, four pixels, D2/P0.28, brightness, onboard indicator,
pairing, saved state and BLE commands are unchanged.

The upstream `worldsemi,ws2812-spi` driver only supports 3–8 bits per symbol.
This variant uses the application-owned `loa,padded-ws2812-spi` binding and
driver. It does not pass ten-bit symbols to the upstream driver or patch
Zephyr's source.

The nominal zero timing moves inside the older [WS2812B timing reference](https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf).
It does not establish compatibility with every WS2812-compatible part.
The exact installed pixel model and its electrical behavior remain unknown.

## Reproduce the build

From a configured Zephyr workspace, replace the paths as needed:

```sh
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -d build/receiver-pixels-timing375 -- \
  -DEXTRA_CONF_FILE="pixels.conf;pixels-padded.conf;pixels-timing375.conf" \
  -DEXTRA_DTC_OVERLAY_FILE="/path/to/little-on-air/boards/xiao_ble_nrf52840_pixels.overlay;/path/to/little-on-air/boards/xiao_ble_nrf52840_pixels_timing375.overlay"
```

Local image: `build/receiver-pixels-timing375/zephyr/zephyr.uf2`.
Checksums and the validation record are stored alongside it in
`SHA256SUMS.txt` and `build-record.json`.

Build and host verification passed. The image uses 163,664 bytes of flash and
29,988 bytes of RAM. UF2 starts at `0x27000`, preserving the factory bootloader.
Candidate SHA-256:
`715533d41269dd5ee470e7927f0443ce59f2c09c5f74eae442ca52b9d7ffdc8b`.

The earlier images are preserved:

- Installed baseline: `build/receiver-pixels/zephyr/zephyr.uf2`.
- Padding-only candidate: `build/receiver-pixels-padded/zephyr/zephyr.uf2`.

Their original hashes were verified, and copies are also saved in the new
build directory as `comparison-installed.uf2` and `comparison-padding-only.uf2`.

## Encoding and waveform verification

On Linux/WSL with a C compiler:

```sh
python3 tools/simulate_pixels.py --profile timing375
```

The default generated-header path is under `build/receiver-pixels-timing375`.
Use `--devicetree-header PATH` for another build directory. Results go to
`build/pixel-simulation-timing375/simulation.json` unless `--output` overrides it.

The tool compiles the firmware's actual C encoder. It verifies the generated
firmware's Kconfig, devicetree, SPI clock limit and DMA capacity. It checks:

- All channel values at all four positions, mixed colors, diagnostic colors
  and deterministic random frames: 3,359 complete frames.
- Every expected HIGH and LOW interval, in GRB/MSB-first order, including
  the final bit before reset: 322,464 nominal pulse pairs.
- Bounds, rejected inputs, guard bytes, padding and input preservation.
- The separately identified injected-startup fault model and hypothetical
  DMA pauses in padding, bringing total waveform cases to 10,055.

All checks passed for both profiles. The five-bit encoder output also matched
the preserved pre-change host executable byte for byte over all 3,359 frames.
A separate negative test deliberately restored eight-bit symbol storage in
a temporary host source; the nominal waveform checker rejected the corrupted
output. That mutation is not included in the firmware. Its result is recorded
in `.local/bench/build-pixel-simulation-timing375/truncation-regression.json`.

The 255-byte DMA split is an extra hypothetical stress case, not this board's
actual transfer. For this 720-byte profile its boundaries are at bytes 255
and 510, both in continuous LOW padding; the payload spans bytes 300–419.

The injected one-microsecond first-HIGH stretch deliberately tests a proposed
failure mode. It is not evidence that the hardware produces that fault.
The unpadded comparison removes padding from the selected profile's bytes;
it does not execute the old firmware. The nominal timing checks above do not
inject a fault or assume an unwanted green result.

Passing these checks verifies digital encoding under an assumed ideal SPI
clock. It is not an MCU emulator, electrical simulation, oscilloscope capture,
or confirmation that the first pixel is fixed.

## Hardware results and further comparison

### Flash session — 2026-09-25

The user confirmed POWER OFF / MODE PROGRAM, XIAO USB only. Factory bootloader
0.6.1 identified the target as `Seeed_XIAO_nRF52840_Sense` on `E:`. The source
UF2 checksum matched the recorded candidate. A 1,908,736-byte `CURRENT.UF2`
backup was saved under `.local/archive/2026-09-26/tmp/receiver-flash-20260926T043752Z/` before copying.
The copy completed and the firmware drive disappeared. A subsequent BLE sync
through controller COM4 succeeded with the existing bond and saved Off
transaction `78b4dae0`. This confirms application operation, not optical output
or a byte-for-byte post-flash read-back.

### Battery-powered visual checks — passed

The user confirmed POWER ON / MODE RUN with both receiver USB ports unplugged.
Controller COM4 remained connected. All ten diagnostic/state/sync operations
received successful BLE confirmation, and the user reported:

| Check | Physical observation |
| --- | --- |
| All Off | All four front pixels dark |
| Pixel 1 Red | Pixel 1 red; other three dark |
| Pixel 1 Green, Blue, White | Each color correct; other three dark |
| Normal On Air | All four red |
| Power off 3 seconds, then on | All four returned to red |
| Normal Warn, Okay, Off | All four yellow, then green, then dark |

After the power cycle, read-only sync confirmed the same saved On Air transaction
`04cf0874`. The final state was restored to Off, transaction `fa49507c`.
Command logs, the prior firmware backup and the observation record are under
`.local/archive/2026-09-26/tmp/receiver-flash-20260926T043752Z/`. The pre-update backup's application bytes
matched the preserved installed baseline.

The reported green symptom did not recur in these tests. This session tested
the combined padding and 375 ns timing build on the rewired hardware; it did
not isolate which change resolved the symptom. Pixels 2–4 were not separately
tested in blue/white, and long-duration/battery-voltage-range tests remain open.

Follow the existing [PROGRAM/RUN power sequence](PAIRED_BENCH.md#connections).
Use an ordinary application UF2 update, preserving pairing and saved state.
If further cause isolation is needed, compare the earlier padded build with
this one to isolate the zero-pulse change.
For each pixel, observe Off, Red, Green, Blue and White with the other pixels
dark. Then test normal states and a power cycle. Record the actual observed
colors before deciding which firmware to keep.
