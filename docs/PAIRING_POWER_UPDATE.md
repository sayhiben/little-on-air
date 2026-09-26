# Pairing recovery, power indicator, and brightness

Controller `esp32s3-0.4.0` and the matching four-pixel receiver, built and tested
2026-09-25/26 (local session / UTC logs). The successful padded 375 ns pixel
transport and all six moods are retained.

## Using it

Keep the sign on, then select **Forget this sign → Forget sign** on the
controller. The receiver erases its pairing and saved mood, restarts in Off,
and opens pairing for 60 seconds. After **Ready to connect**, press the knob.

If the sign was unavailable when forgotten, the controller shows recovery
instructions. Leave the sign powered and tap its rectangular RESET **five
times, about two seconds apart**. Let the application light return between
presses; rapid double-reset still enters the factory UF2 bootloader. Then press
the controller knob to connect. If the controller still holds an old bond,
use Forget there first. One receiver reset reopens an expired pairing window.

Holding RESET holds the processor in reset, so it cannot measure a long hold.
The five-press gesture clears a partial count after six seconds of uninterrupted
application time or on a power/software reset.

| Indicator | Behavior / brightness |
| --- | --- |
| Receiver onboard RGB | Steady red when paired, including when the sign is Off |
| Receiver pairing | Red 250 ms on / 250 ms off |
| Receiver unpaired, window closed | Red 1800 ms on / 200 ms off |
| Receiver front pixels | Mood only; ceiling raised from 12.5% to 16% (31 → 40/255) |
| Controller external pixel | Mood indicator; ceiling reduced from 32 to 24/255 |

Bonded connection checks leave both the front mood and onboard red light alone.
The onboard PWM ceiling remains 12.5%. Brightness values are drive settings,
not measured optical output or battery-runtime estimates.

## Causes and fixes

The earlier Forget action removed only the controller's keys. A new encrypted
pairing-control characteristic asks the bonded receiver to erase its keys too.
It persists reset intent before acknowledging, delays reboot 1.5 seconds, and
finishes or retries cleanup at startup. The controller disconnects before
erasing local keys and any residual security records. An unreachable receiver
leads to the physical recovery screen.

The old five-reset counter used GPREGRET2. Physical pin resets clear that
register, so repeated presses never accumulated on this board. The new counter
uses a one-byte NVS setting and the actual pin-reset reason. Counter storage
failure cannot authorize an erase; normal boots with a zero count do not write
flash. [Nordic's explanation of reset retention](https://devzone.nordicsemi.com/f/nordic-q-a/74659/dfu-over-usb---nrf52840-running-zephyr)
matches the earlier observed zero counter. RESET/UICR and the factory bootloader
are unchanged.

Physical testing then exposed two NimBLE 2.5.1 behaviors that could defeat
recovery. Its internal status-518 handler started fresh pairing before the GAP
error listener ran. Its default storage-overflow handler could erase a bond
when the one-entry private-address cache filled. This produced mismatched keys
in intermediate tests, even though the receiver's five-reset erase succeeded.

The controller now compiles a generated copy of the pinned host with only that
automatic-pairing branch disabled. The build checks version and source shape;
it does not modify downloaded dependencies. Ordinary operations require a saved
LTK and attempt encryption once. The GAP listener prevents the wrapper's
missing-key deletion/retry. The storage callback replaces only the same peer's
obsolete address mapping and refuses bond eviction. Explicit Pair remains the
only way to create a new pairing. See `nimble_guard.py`, `bond_store.cpp`, and
`receiver_link.cpp` in the controller application.

## Builds

```sh
python -m platformio run -d apps/controller-esp32s3
west build -b xiao_ble/nrf52840 apps/receiver -d build-receiver-pairing-power -- \
  -DEXTRA_CONF_FILE="pixels.conf;pixels-padded.conf;pixels-timing375.conf" \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/boards/xiao_ble_nrf52840_pixels.overlay;$PWD/boards/xiao_ble_nrf52840_pixels_timing375.overlay"
```

For diagnostics only, also include `debug.conf` and the receiver debug overlay.
The final receiver image omits USB logging. Follow the
[power/USB flashing sequence](FLASHING.md). Application-only updates preserve
the current pairing unless a reset gesture or Forget explicitly clears it.

Local artifacts are in `build-pairing-power-release/`:

| Image | SHA-256 |
| --- | --- |
| `controller-esp32s3-0.4.0.bin` | `723706eb752325a9a8c8d7ce0f45b9f168b3a15bbb5334a5e7b185a9e6bc0443` |
| `receiver.uf2` | `0f5b3f70cd4781e7fcb28f40287f541355fc45a67707d5de3b3afd3a808d5494` |
| `receiver-diagnostic.uf2` | `273ca496dc5e9901fccfec3aa3e9f4d9c7fb194c3137e09540c1512442aa4a26` |

Receiver UF2 headers, family, sequential addresses, and application-only bounds
were checked before copying; previous flash contents were backed up in
`tmp/pairing-power-*/`. Controller upload verified written flash hashes.
The earlier 0.3.0 artifacts in `build-buddy-release/` are preserved for rollback.
Do not restore an old full-flash controller backup: its pairing keys are stale.

## Validation

- Normal and diagnostic receiver, ESP32-S3 controller, and legacy nRF controller
  compile successfully.
- All 24 Zephyr core tests pass.
- Six host suites pass: controls/protocol, animation timing, persistent reset and
  reset-intent failures, independent outputs, 1000 private-address cache rotations
  with failure cases, and rejection of unrecognized pinned-library patch targets.
- Thirteen screens from the actual OLED renderer pass text-bound checks;
  `build-pairing-ui/oled-preview.png` includes the recovery instructions.
- Online Forget was accepted by the receiver; both sides cleared and the user
  reconnected with the knob. User observed red blinking then steady red.
- The user performed five paced physical presses twice. The first full USB
  capture records `pin=1`, `factory=1`, successful unpair/state-clear, then
  `bonded=0 saved=0`. The second also confirmed an unpaired receiver.
- After the final Bluetooth fix, a diagnostic reset exercised that same cleanup
  path. Four ordinary sync attempts returned missing-key error 518 while the
  controller retained its keys; receiver status still showed `bonded=0`.
- The user then used Forget, one receiver reset, and the knob to pair successfully
  through the recovery screen. User confirmed steady red afterward.
- The final non-debug receiver was restored. A controller hardware restart
  retained the new keys and successfully read the receiver's Off state.
- Final normal firmware on battery in RUN: all seven commands (Off, Warn,
  On Air, Okay, Request, Special, On Air) received exact transaction/status
  acknowledgments in 1.28–2.28 seconds. The user approved the brightness balance
  and confirmed the onboard light stayed red throughout. A subsequent automatic
  read preserved On Air transaction `e7c4d8a3`.
- Final normal-firmware online Forget on battery: receiver accepted request
  `4203c122`, controller reported `bonded=0`, and pressing the knob paired again
  successfully. No receiver reset was needed. The user confirmed Off, dark front
  pixels, and steady red onboard. Final state: paired, verified Off, transaction 0.

The physical reset test and the later missing-key regression test are separate
observations; the final missing-key test used the diagnostic reset command.
Detailed serial captures and flash records use `tmp/pairing-power-*` prefixes.
