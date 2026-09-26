# Controller and four-pixel display bench setup

Current pairing recovery, independent red power indication, and brightness
settings are documented in the [pairing/power update](PAIRING_POWER_UPDATE.md).
The results below preserve the earlier firmware's test history.

A separate [375 ns timing comparison](PIXEL_TIMING_375NS_BUILD.md) was prepared
on 2026-09-24 and flashed on 2026-09-25 after wiring completion. The firmware
copy completed and BLE sync confirmed the retained bond and Off transaction
`78b4dae0`. The user then confirmed pixel 1 Off/Red/Green/Blue/White, all four
normal On Air/Warn/Okay/Off states, and red restoration after a power cycle.
The unwanted green did not recur in those checks. The session ended in Off,
transaction `fa49507c`. See the linked build page for logs and test limits.

A [padded-transmission receiver test build](PIXEL_TIMING_BUILD.md) was prepared
on 2026-09-24 after rewiring and replacement of pixels 1 and 3. The user reports
all four illuminating but pixel 1 still green at that time. The padding-only
candidate was not physically tested; the later 375 ns candidate above was.

Hardware: XIAO ESP32-S3 desk controller and XIAO nRF52840 receiver with four
front NeoPixels configured for GRB on D2/P0.28. The intended data path runs
through the existing MODE switch and a 330 ohm resistor. During the individual
test, the user reported that the resistor may have been omitted; see below.

## Connections

Leave the controller connected to computer USB. Before connecting display USB,
set POWER OFF, then MODE PROGRAM. Use the XIAO USB port, with charger USB
unplugged. The front pixels are electrically isolated in this mode.

For the visible-light test, unplug display USB first, select RUN while POWER is
OFF, then switch POWER ON. Both display USB ports stay unplugged in RUN.
Keep the controller on USB.

## Receiver builds

The optional `pixels.conf` and `xiao_ble_nrf52840_pixels.overlay` add four front
pixels while retaining the onboard RGB indicator. The default legacy build
continues to use only the onboard LED. Front output uses GRB order and 12.5%
maximum brightness (31/255 per channel). D8 is an unused SPI clock output;
do not attach other hardware to it in this profile.

The driver uses Nordic SPIM on SPI2 with 4 MHz clock and five SPI bits per pixel
bit. Zero is `10000`, one is `11100`, and latch delay is 300 microseconds.
References: [Zephyr SPI pixel binding](https://docs.zephyrproject.org/latest/build/dts/api/bindings/led_strip/worldsemi%2Cws2812-spi.html)
and [RGB timing reference](https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf).

Build from the configured west workspace, substituting the repository path:

```sh
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -d build/receiver-pixels -- \
  -DEXTRA_CONF_FILE=pixels.conf \
  -DEXTRA_DTC_OVERLAY_FILE=/path/to/little-on-air/boards/xiao_ble_nrf52840_pixels.overlay
```

For USB diagnostics, use `-DEXTRA_CONF_FILE="debug.conf;pixels.conf"` and both
debug and pixel overlays in `EXTRA_DTC_OVERLAY_FILE`, separated by a semicolon.
Flash the resulting `zephyr/zephyr.uf2` after double-pressing display reset.
The rectangular reset button is on the front above AIR, left of the round
indicator. Ordinary application updates preserve pairing and saved state.

## Diagnostic receiver USB commands

These commands exist only in a build with `debug.conf`; use 115200 baud:

- `status`: report saved transaction/state and whether a bond exists.
- `pair-reset`: explicitly erase the existing bond and saved state, reboot,
  and open a fresh 60-second pairing window. A persistent one-time request
  performs the reset during boot before advertising starts.
- `reboot`: reboot with pairing/state preserved.
- `bootloader`: restart into the factory UF2 firmware drive.

The USB receive endpoint must be enabled for polling commands. The setup
command avoids relying on the five-reset gesture, which did not clear the old
bond on the tested factory 0.6.1 bootloader. Runtime logs showed retained reset
count zero after the attempted sequence; its underlying cause is not established.

After `pair-reset`, send `pair` to the ESP32-S3 controller. Verify `bonded=1`,
`known=1`, and `verified=1` before testing states.

## Automated commands

Close other serial monitors first. With controller firmware `esp32s3-0.2.1` or later:

```sh
python tools/paired_bench.py --controller COM4 --receiver COM6 \
  --cycles 2 --output tmp/paired-bench/usb-results.json
```

The script sends Warn, On Air, Okay, Off through the controller's BLE link,
requiring an exact transaction ID and status in each successful result. It saves
JSON results and a timestamped serial log. Omit `--receiver` when the display is
running on battery. Use `--dwell 5` for observing colors. A successful ACK proves
the protocol transaction; it does not independently measure physical LED output.

Use a non-debug pixel build for ordinary battery operation. Battery runtime,
current consumption, and thermal acceptance need separate measurements.

## Assembled pair results — 2026-09-19

Controller USB COM4; receiver diagnostic USB COM6. Receiver factory bootloader
0.6.1, board ID `Seeed_XIAO_nRF52840_Sense`. User confirmed four front pixels
and the documented D2/MODE/resistor wiring.

- Cleared the receiver's old bond using diagnostic `pair-reset`; receiver log
  confirmed unpair and state-clear result 0 and a new pairing window.
- Secure Connections pairing and authoritative Off read succeeded. Controller
  reported `bonded=1 known=1 verified=1`; receiver reported pairing complete.
- An initial `esp32s3-0.2.1` connection attempt failed before a command reached
  the receiver. Read-only reconciliation recovered. The next eight commands
  (Warn / On Air / Okay / Off twice) all received exact ACKs in 1.312–2.859 s.
  Both devices' logs recorded matching transactions, receiver persistence and
  successful indications.
- Updated controller to `esp32s3-0.2.2`, enabling one connection-establishment
  retry under the existing deadline. Upload verified flash hashes. Its reboot
  retained the bond and automatically read back the receiver's Off state.
- Five subsequent commands (Warn / On Air / Okay / Off / On Air) passed on
  `esp32s3-0.2.2`.
- Flashed the non-debug four-pixel receiver image through the USB bootloader
  command. Reconnection preserved the bond and exact saved On Air transaction
  `d4a0d7f3`.
- Controller portable protocol/input tests passed (GCC 11.4, CTest 1/1).
- With display USB unplugged and POWER OFF (user-confirmed), a Green command
  failed with connection error 13 after 4.5 seconds. The controller retained
  its last known On Air value but set `verified=0`; it did not falsely confirm
  Green. Read-only reconciliation followed.

Image SHA-256 values from the earlier controller 0.2.2 bench run (superseded by
the individual-pixel diagnostic builds below):

- Controller `esp32s3-0.2.2` application:
  `c24b6da2563834e0e84098ccf8a823a604ae7a2efd8f5eefd8237617e725fccc`
- Non-debug four-pixel receiver UF2:
  `e6af2556510b66fd41f1a1a9bba867affcab47251834b5e940bd245437466893`

Detailed captures and JSON records are in `tmp/paired-bench/` in the local
workspace. Initial SPI and USB command setup failures were corrected before
these successful runs: use SPIM with its clock on unused D8, and arm CDC ACM's
receive endpoint before polling it.

On battery, the bonded receiver read back the saved On Air transaction after
power loss. The user reported inconsistent front output: pixel 1 looked correct,
pixel 2 differed, pixel 3 appeared off, and pixel 4 looked correct. The exact pixel
SKU and RGB/RGBW format remain unknown. **Front-light acceptance is not passed.**

### Individual-pixel diagnostic (controller 0.2.3)

`pixel 1 red` (also indices 2–4 and off/green/blue/white/yellow) sends a separate
encrypted five-byte test command and checks exact read-back. It requests one
logical pixel with the others zeroed; visual observation is still required to
verify how the physical chain interprets those bytes. `pixel end` resumes normal
display output. The test expires after 120 seconds or on the next regular state
command, never saves a status, and keeps connection animations from overwriting
the front test pattern. The original onboard indicator continues operating.

The optional characteristic UUID is `7f6c0003-6b7e-4c80-9f2a-f9b9d7e2a601`.
Payload: version 1, zero-based pixel index (255=end), red, green, blue. Brightness
is still capped at 12.5%. The existing six-byte status protocol is unchanged.

Installed individual-test image SHA-256 values:

- Controller `esp32s3-0.2.3` application:
  `1d7c2e207085dcc46c22d2a328c05d4d96a8a0efc1af76fd771247653156eee8`
- Non-debug four-pixel receiver UF2:
  `a16bb6e2d27a27406f7b4217680f1cea51fbb18cf5831abe971fc81f9928c78e`

Observed before the resistor check, with exact BLE diagnostic read-back passing:

| Command | User's physical observation |
| --- | --- |
| Pixel 1 red | Pixel 1 green; pixels 2–4 off. Repeated with the same result. |
| Pixel 1 green | Pixel 1 green; pixels 2–4 off. |
| Pixel 1 blue | Pixel 1 blue; pixels 2–4 off. |
| Pixel 2 red | User saw pixel 2 red briefly, then off when the regular Off command was sent. Other pixel states were not explicitly confirmed. |

These observations do not identify a simple color-order permutation. No color
mapping change was made. The user then reported a potentially missing input
resistor. Sent regular Off and received exact transaction `b01648c3`; individual
testing is suspended for the resistor check. Fit the documented 330 ohm resistor
in series immediately before LED1 DIN with display power removed, then repeat
the individual tests. Missing resistance is a possible contributor, not a
confirmed diagnosis. Pixel 2's remaining channels, pixels 3–4, and overall
front-light acceptance remain open.
