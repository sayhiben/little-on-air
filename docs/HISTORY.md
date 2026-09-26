# Firmware history and current support

This is a bespoke pair, not a family of supported firmware products. Current
code builds only the ESP32-S3 OLED/encoder controller and the four-pixel
nRF52840 receiver. Its USB diagnostic configuration remains a service tool for
that same receiver.

The last complete tree before firmware retirement is
[`04879443b3f015cbfd0007984686a501a69c5e85`](https://github.com/sayhiben/little-on-air/tree/04879443b3f015cbfd0007984686a501a69c5e85).
Use a separate checkout of that revision to inspect old firmware; do not copy
retired build targets back into the active tree as a compatibility layer.

Removed from active development:

- nRF52840 reset-button controller application, BLE client and debug target.
- Its portable controller state machine, status/error/pairing blink patterns and
  tests specific to those retired implementations.
- Onboard-only and 4 MHz/5-bit receiver build alternatives, optional pixel
  fragments and the runtime/build switches that selected them.
- Legacy firmware CI/release targets and dual-nRF USB identity handling.

Receiver output/scheduling code now lives with the receiver application, and
host test configuration for both current devices is under `tests/host/`. The
current 8 MHz/10-bit, 375 ns padded pixel stream is the receiver default.
Protocol validation, durable state, explicit pairing recovery, bootloader
recovery and current-device failure-path tests remain in active code.

## Dated evidence

These records retain observations and image hashes from their original builds.
Their historical commands may refer to retired files; use the current
[developer guide](../CONTRIBUTING.md) for builds and [FLASHING.md](FLASHING.md)
for updates.

- [Initial ESP32-S3 bench work](ESP32S3_BENCH.md)
- [Paired-device bench work](PAIRED_BENCH.md)
- [Initial padded-pixel experiment](PIXEL_TIMING_BUILD.md)
- [375 ns timing selection](PIXEL_TIMING_375NS_BUILD.md)
- [Buddy UI and six moods](BUDDY_UPDATE.md)
- [Pairing and independent power light](PAIRING_POWER_UPDATE.md)

Hardware archives, historical manufacturing ZIPs/checksums and preserved local
firmware/bench records are retained. Old firmware embedded in a manufacturing
snapshot records its provenance; it is not the firmware to install today.
