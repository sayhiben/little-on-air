# ESP32-S3 controller bench record

> Historical bench record: commands, paths and build variants below describe
> the recorded revision. Use the [current developer guide](../CONTRIBUTING.md)
> for today's build/flash commands. See [firmware history](HISTORY.md) for the
> retired source revision. Observations and image hashes below are retained.

This is the initial controller-only record. The subsequent assembled-pair
session is recorded in [the paired bench guide](PAIRED_BENCH.md).

Date: 2026-09-18 (America/Los_Angeles). Firmware: `esp32s3-0.2.0`.

Final flashed application SHA-256:
`3ad316a40b54186ec2d90a377e3ff1392d22528d4697c1fd9025654510668b14`.
The final image also passed USB command/status checks after reboot, including
rejection of Sync while unpaired. USB diagnostics use a 2 KiB transmit buffer
and a short write timeout to keep complete status lines without lengthy UI stalls.

Hardware: Seeed XIAO ESP32-S3, ESP32-S3 revision v0.2, 8 MB embedded PSRAM;
native USB Serial/JTAG detected as COM4. SSD1306 128×64 OLED; one RGB NeoPixel;
push encoder. Wiring matches [the controller guide](../apps/controller-esp32s3/README.md).

## Observed on the assembled controller

| Check | Evidence / result |
| --- | --- |
| Build | Pinned PlatformIO ESP32-S3 release build passed |
| USB flash | Bootloader, partitions, and application written; uploader verified hashes |
| Runtime | USB `status` responds; unpaired boot reports `known=0 verified=0`, so no false receiver confirmation |
| OLED I2C | Controller reports `oled=ok address=0x3c size=128x64` |
| OLED / pixel visual check | User reported the RED hardware-test screen and pixel looked good |
| Clockwise direction | Exactly three requested clockwise detents produced three `steps=1` events and selected Warn → On Air → Okay |
| Short press | One deliberate press produced `clicks=1`, with no extra rotation |
| Long press | One two-second hold produced `holds=1`; release did not create another click |
| Idle inputs | No events before the deliberate input sequence |
| Input responsiveness | Encoder and display responded through repeated hardware-test color selections |
| Pairing with receiver absent | Scan returned `Receiver unavailable` after 45.0 seconds; `busy=0 bonded=0 known=0 verified=0` afterward; USB status still responsive |

Controlled input trace (milliseconds since boot):

```text
69009  steps=1  turns=1 clicks=0 holds=0  selected=warn
69677  steps=1  turns=2 clicks=0 holds=0  selected=on-air
70353  steps=1  turns=3 clicks=0 holds=0  selected=okay
71713  click    turns=3 clicks=1 holds=0
75223  hold     turns=3 clicks=1 holds=1
165159 status  turns=3 clicks=1 holds=1  bonded=0 verified=0
```

## Automated host checks

Passed with GCC/G++ 11.4, `-Wall -Wextra -Werror`, compiling the actual shared C
protocol and status sources with the controller's portable C++ input/state code.

- Quadrature forward/backward, contact bounce, partial reversals, illegal edges,
  multiple detents and selection wraparound.
- Button debounce, held-at-boot suppression, one hold event, no click after hold,
  and millisecond counter wraparound.
- Version-1 byte layout, malformed length/version/status, wrong transaction or
  status rejection, and exact acknowledgment acceptance.
- Cached state remains unverified; authoritative snapshots update state; preview
  selection survives reconciliation; an unmatched ACK cannot change confirmed state.

## Still requires the receiver or further physical checks

The receiver was not available for this session. These are **not yet verified**:

- First Secure Connections bond and receiver read-back.
- All four commands, exact indications, and lost-indication read recovery.
- Reconnect to the receiver's private address after both boards reboot.
- Receiver persisted state after USB/power loss; stale/missing peer keys.
- Failure during a send, bounded reconciliation, and restore after receiver loss.
- Deliberate pair replacement on both boards.
- Visual confirmation of every pixel color separately, OLED dim/sleep and wake,
  and a physical held-button power-up.

The implementation preserves the existing receiver protocol, but a successful
controller build and local hardware test do not establish BLE interoperability.
