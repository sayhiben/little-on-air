# Six moods and a quieter connection

This is a historical bench record. The old build trees were removed during
workspace cleanup; retained firmware snapshots, logs and simulation evidence
are listed in the [workspace guide](WORKSPACE.md#preserved-local-work).
Build commands below use the consolidated `build/` directory.

This is the historical 0.3.0 bench record. The later
[pairing and power-light update](PAIRING_POWER_UPDATE.md) supersedes its pairing
recovery workaround and brightness settings while retaining the six moods.

This update pairs the ESP32-S3 controller `esp32s3-0.3.0` with the nRF52840
receiver. Keep the existing successful padded/375 ns pixel transport: changes
here concern status rendering, BLE connection indications, and the OLED UI.

## Moods

| Mood | Wire value | Front light |
| --- | --- | --- |
| Off | 0 | Dark |
| Warn | 1 | Warm amber, raw RGB 255/112/0 |
| On Air | 2 | Red |
| Okay | 3 | Steady green |
| Request | 4 | Green: 600 ms on, 600 ms off |
| Special | 5 | Slowly flowing diagonal rainbow, 20-second cycle |

Viewed from the front, pixel order is lower-left, lower-right, upper-right,
upper-left. Hue offsets 0/140/224/84 give a diagonal
across the four corners. The diffuser blends these four sources; it cannot draw
a sharp diagonal stripe like a pixel matrix. The receiver renders at 20 Hz.
Rainbow RGB channels sum to 255 before the existing 12.5% brightness limit,
so it does not introduce a higher all-white load. The controller's single pixel
samples the first corner. Animations run locally and are not phase synchronized.

## Periodic blue blink

The ESP32 intentionally reads the receiver state every 60 seconds and disconnects
after each transaction. Previously the receiver's `connected()` callback selected
the blue SYNCING indication on every connection; `disconnected()` restored the
status. This produced a periodic blue interruption during a healthy state read.

The receiver now leaves its output alone during ordinary bonded connection and
disconnection. Its indicator also treats setting the same state as a no-op, so
reconciliation does not restart an animation. Unpaired connections still indicate
pairing/sync. The ESP32 suppresses routine read notices and OLED wake-ups while
retaining real failure reporting and read-only retry behavior.

## Controls and OLED

Turn to preview a mood, press to set it, hold 1.2 seconds for settings. A small
buddy has sleepy eyes for Off, sunglasses for On Air, and starry eyes for Special.
The sign's confirmed status is shown separately during preview; offline values
are explicitly labeled as last known. A press during a background check queues
the selected mood only until that read succeeds. Screens dim after 30 seconds
and sleep after two minutes; background traffic leaves that timer alone.

The preview at `build/buddy-ui/oled-preview.png` renders the actual firmware
home-screen template using the pinned Adafruit GFX library and font. It checks
12 home-screen variants for text bounds; it is not a photograph of the hardware.

## Build and rollback

Build the controller using the instructions in
[its README](../apps/controller-esp32s3/README.md). For the receiver use:

```sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver-buddy -- \
  -DEXTRA_CONF_FILE="pixels.conf;pixels-padded.conf;pixels-timing375.conf" \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/boards/xiao_ble_nrf52840_pixels.overlay;$PWD/boards/xiao_ble_nrf52840_pixels_timing375.overlay"
```

Preserve the previously bench-tested image at
`build/receiver-pixels-timing375/zephyr/zephyr.uf2`, SHA-256
`715533d41269dd5ee470e7927f0443ce59f2c09c5f74eae442ca52b9d7ffdc8b`.
Update the receiver before using the new moods. Old firmware rejects states 4
and 5; set Off before rolling back. Flashing retains bonds and saved state.
Follow [the receiver power/USB sequence](FLASHING.md) for each physical update.

## Validation

- Receiver and ESP32 builds completed locally.
- Zephyr core tests: 24 passed, including all six states through wire/storage.
- ESP32 native tests: encoder/button behavior, exact acknowledgments, cache trust,
  preview preservation, six moods, animation timing, and quiet background checks.
- Actual OLED renderer: 12 screen variants pass text bounds.
- The real indicator state machine passes a deterministic host scheduler test:
  20 minutes of Request at the intended cadence despite simulated 2 ms output
  latency, uninterrupted same-state reconciliation, Special timing, cancellation
  when switching to a solid state, and uptime counter wrap. This is a software
  timing test, not a measurement of the LEDs.
- Existing pixel waveform tests pass 3,359 vectors / 322,464 pulse pairs with the
  unchanged 375/875 ns zero and 750/500 ns one timings and 300 us low padding.
- Physical observations for this update are recorded below separately from the
  preceding timing build's checks.

## Bench update, 2026-09-25 (local)

Both devices were updated without erasing pairing. The receiver UF2 copy
completed and the bootloader drive disappeared; the ESP32 uploader verified
the written image and USB reports `esp32s3-0.3.0`, OLED 0x3C, bonded and verified.
The receiver remained OFF/PROGRAM with only XIAO USB connected during flashing,
then returned to battery-only ON/RUN for optical tests.

- The receiver backup matches the previously tested 375 ns application's bytes.
  A full 8 MiB controller flash backup was also captured before its update.
- Request was acknowledged with exact transaction/status `85ad6f25` / Request.
  The user confirmed all four pixels flashing green and the new OLED UI.
- Special was acknowledged with exact transaction/status `60152f54` / Special.
  The user confirmed the flowing diagonal rainbow and OLED UI.
- Warn was acknowledged as `0cb70a15`; the user confirmed the warmer color.
- On Air was acknowledged as `2b5e89e6`. A 135-second idle log captured two
  successful automatic reads (at 66.094 and 127.594 seconds after the test began),
  both retaining that exact transaction/status. Neither background read emitted
  a connection notice. The user reported no blue blink or unexpected OLED wake.
- Final Okay (`931b683d`) and Off (`8e75205d`) commands were acknowledged exactly.
  The session ended bonded, verified, and Off. All six moods passed real BLE
  command/acknowledgment checks; the new moods and warmer color were also visually
  confirmed by the user.

The local build bundle is `.local/firmware/previous/buddy-0.3.0/`, with SHA-256 hashes
and validation records in `manifest.json`. Receiver SHA-256:
`b7ab5fe5fe1b0a392d365a163f87f4d5a774559ed3f9ba87b59fb2cb359d2001`.
Controller application SHA-256:
`d4b020bba4dce74f7b9615e63f225f0fff4be919cf7ad98e093088b1277d48e7`.
Flash/backup record: `.local/archive/2026-09-26/tmp/buddy-flash-20260926T051530Z/flash-record.json`;
controller backup: `.local/archive/2026-09-26/tmp/controller-before-buddy-fullflash.bin`.
Command and idle logs are `.local/archive/2026-09-26/tmp/buddy-request.log`, `.local/archive/2026-09-26/tmp/buddy-special.log`,
`.local/archive/2026-09-26/tmp/buddy-warn.log`, `.local/archive/2026-09-26/tmp/buddy-idle-on-air.log`, and `.local/archive/2026-09-26/tmp/buddy-final-states.log`.

## Pairing recovery after Forget this sign

Later in the same session, the user selected **Forget this sign**. USB confirmed
the controller was unbonded while the receiver still had a bond and saved Special
state (`47184337`). The controller menu currently erases only its own keys.
Power cycling does not clear the remaining receiver bond. The five-reset gesture
had failed on this factory bootloader in the earlier bench session, so the
receiver was recovered using its diagnostic USB command.

- Built a temporary diagnostic image from the same source and padded/375 ns
  profile, adding `debug.conf` and the debug USB overlay. SHA-256:
  `964de901ff4dfd26bfe6dea382f59589b269f01d6adf47ef2a769bd48ee47fbe`.
- With receiver OFF/PROGRAM and XIAO USB only, backed up the current application,
  flashed diagnostics, and verified receiver `bonded=1` versus controller
  `bonded=0`. Sent diagnostic `pair-reset` once; it clears the receiver bond and
  saved mood and opens a fresh pairing window.
- Controller Pair succeeded with verified Off state. Receiver diagnostics then
  confirmed `bonded=1 saved=0 status=0`.
- Restored the exact normal receiver image from `.local/firmware/previous/buddy-0.3.0/`.
  A new Off command was acknowledged as `65139a58`, proving the fresh pairing
  survived the firmware restore. After the user unplugged receiver USB and
  returned it to battery-only ON/RUN, Sync read back the same `65139a58` / Off
  state with `bonded=1 verified=1`.

Logs: `.local/archive/2026-09-26/tmp/re-pair-controller-before.log`, `.local/archive/2026-09-26/tmp/re-pair-receiver-before.log`,
`.local/archive/2026-09-26/tmp/re-pair-controller-pair.log`, `.local/archive/2026-09-26/tmp/re-pair-receiver-after.log`, and
`.local/archive/2026-09-26/tmp/re-pair-normal-check.log`, and `.local/archive/2026-09-26/tmp/re-pair-battery-sync.log`.
Flash records/backups are under
`.local/archive/2026-09-26/tmp/re-pair-20260926T060821Z-diagnostic/` and
`.local/archive/2026-09-26/tmp/re-pair-20260926T061037Z-normal/`.

The older full controller backup predates this fresh bond; restoring that entire
flash would restore its old keys. Ordinary application-only rollback preserves
the new pairing. The [controller README](../apps/controller-esp32s3/README.md#reconnecting-after-forget-this-sign)
now documents the current two-sided pairing reset requirement and USB recovery.
