# Hardware acceptance checklist

Run this checklist with two boards before publishing a production-intended
release. CI cannot validate radio conditions, bootloader behavior, LED color,
or current draw.

- [ ] Controller and receiver UF2 files enter their intended roles.
- [ ] Both unpaired boards show slow blue after power-up.
- [ ] One paced reset on each board pairs them within 15 seconds.
- [ ] Successful pairing produces three green pulses, then Off.
- [ ] Controller presses cycle Off, Yellow, Red, Green, Off.
- [ ] Both LEDs reach the same solid state within four seconds in normal RF
      conditions.
- [ ] Removing receiver power produces three red/white alternations on the
      controller followed by reconciliation attempts and slow blue.
- [ ] Restoring receiver power and pressing the controller restores agreement.
- [ ] Receiver power loss restores its last acknowledged status.
- [ ] Controller power loss reads the receiver without advancing the color.
- [ ] Five paced resets on both boards clear the bond and saved state.
- [ ] Rapid double reset still opens the factory UF2 drive.
- [ ] Reflashing an application UF2 preserves bond and status.
- [ ] Controller idle/off current is at or below 150 uA average.
- [ ] Receiver bonded-advertising/off current is at or below 300 uA average.

Record board revisions, bootloader versions, battery voltage, meter model,
measured averages, and approximate board separation with the test results.
