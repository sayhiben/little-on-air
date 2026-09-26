# Acceptance checks for the current device pair

Use the ESP32-S3 controller and four-pixel nRF52840 sign. Record the firmware
source revision and image hashes, case/board revisions, power arrangement and
what was actually observed. A build, protocol acknowledgement or simulation is
not evidence of physical light output, fit or current draw.

- [ ] Wiring, protection, polarity, charger configuration and case fit pass the
      current design's commissioning instructions.
- [ ] Controller runs on USB; sign runs on battery with POWER ON / RUN and both
      sign USB ports unplugged. OFF/PROGRAM isolation works for service/charging.
- [ ] Unpaired sign opens a 60-second window on RESET; controller knob Pair
      connects, and red power light changes from fast blink to steady.
- [ ] Turning previews without changing either mood light; pressing confirms
      Off, Warn, On Air, Okay, Request and Special on both devices.
- [ ] Request flashes at 600 ms on/off; Special flows across all four corners.
- [ ] Sign power light stays independent, including when mood is Off and during
      background reads. Repeated reads do not flash or restart mood animations.
- [ ] Receiver power loss/restoration retains the last accepted mood and bond.
- [ ] Controller USB power loss/restoration reads without advancing the mood.
- [ ] Offline screen shows Last/unverified state and dim white controller light;
      recovery reads the receiver without replaying a stale failed command.
- [ ] Hold opens settings; release after hold does not click. OLED dim/sleep,
      wake-only first gesture, menu timeout and local Light test work.
- [ ] Online Forget clears both devices, resets sign to Off and permits pairing.
- [ ] Offline Forget gives physical recovery; five paced receiver RESET presses
      clear pairing/state, while an interrupted sequence expires safely.
- [ ] Rapid receiver double-reset still opens the factory UF2 bootloader.
- [ ] Normal application updates preserve pairing/state; ESP32 writes do not
      erase NVS and receiver UF2 does not overwrite factory bootloader/settings.
- [ ] Measured battery/power behavior and charger indications are recorded for
      the actual parts and firmware, without reusing retired-board targets.

Use [FLASHING.md](FLASHING.md), [the developer guide](../CONTRIBUTING.md) and
[the current assembly guides](../hardware/README.md). Only check a box after the
physical action/observation. Store local raw captures under `.local/bench/` and
commit a concise dated record of the results and remaining limitations.
