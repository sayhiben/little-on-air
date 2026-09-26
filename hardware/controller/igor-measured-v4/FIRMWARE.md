# Controller firmware migration

This revision defines the **new controller hardware**. The existing
`apps/controller` application, overlays, UF2 images, reset gesture and build
instructions still describe the nRF52840 controller. They are not ESP32-S3
firmware. Igor's upstream D1-mini timer sketch is also not a Little On Air
controller and must not be treated as the new firmware.

The implementation is now available in
[apps/controller-esp32s3](../../../apps/controller-esp32s3/README.md). The assembled
controller has passed local USB, display and input checks; receiver integration
remains to be tested. See the [bench record](../../../docs/ESP32S3_BENCH.md).

## Intended local interaction

- Boot from computer USB, show **Connecting**, then read the receiver's
  authoritative state. Boot never advances or sends a state.
- Turn the encoder to choose **Off → Warn → On Air → Okay**. Rotation previews
  a selection; it does not change the receiver.
- Press once to send the selected state. Show **Sending** until the exact
  transaction/status acknowledgment arrives.
- Show **Confirmed** and a solid matching pixel only after the receiver's
  persisted/applied acknowledgment. The OLED labels also convey the status.
- On timeout, show the failure and reconcile with a read. Keep the last
  confirmed state visibly distinct from the pending selection.
- Pair through a deliberate on-screen action and the receiver's existing
  physical pairing window. Require an additional confirmation before erasing
  a bond; pressing or holding the encoder during boot must not erase it.
- Dim or blank the OLED after inactivity to reduce static-image wear. Wake on
  interaction while keeping the receiver's status unchanged.

## Implementation boundary

Retain the existing encrypted, bonded BLE central/peripheral relationship and
six-byte version-1 protocol. **ESP-NOW is not compatible with the existing
nRF52840 receiver.** Keep its service/characteristic UUIDs, little-endian
transaction IDs, indication subscription, exact-ack matching and recovery
semantics from `docs/ARCHITECTURE.md`.

The ESP32-S3 implementation and its acceptance testing must provide:

1. Its own supported board configuration and flash format, USB diagnostics,
   GPIO encoder debounce, an I2C driver matched to the actual display controller
   and resolution, and a NeoPixel output driver.
2. Event-driven input during runtime instead of the nRF reset-pin boot action
   and terminal `sleep_forever()` lifecycle. Retain responsive input/rendering
   while BLE operations run.
3. Bond/state storage on ESP32 flash. Remove nRF-only `RESETREAS`, UICR,
   GPREGRET2, nRF PWM and battery-current assumptions from that application.
4. A reviewed pairing and factory-reset UI, display error states, brightness
   limit, encoder direction check, and a bounded reconnect policy.
5. A real ESP32-S3 build plus bench tests against the existing receiver for
   first pairing, command acknowledgment, lost indications, reboot, USB power
   loss, peer replacement and input bounce.

The reusable protocol and state-machine code can remain shared. Add a
controller-specific board/output layer rather than switching the receiver's
board or changing the established wire protocol.

Revision 4 uses the measured Adafruit mini-strip segment. Its exact SKU and
color order are not established; verify red, green and blue individually.
