# Brightness hardware bench — 2026-09-27

Firmware pair 0.5.0, built from the uncommitted `codex/brightness-settings`
changes over `010b80975053505cb5baeb6debd2cff7274aea94`. See
[brightness settings](BRIGHTNESS.md) for the mappings and storage contract.
Physical observations below are user reports; serial/BLE confirmations establish
device state, not measured light output.

## Images and update

The ESP32-S3 controller used USB COM4. The receiver's factory 0.6.1 UF2
bootloader enumerated as COM5 / XIAO-SENSE; the diagnostic application used COM6.
Receiver servicing used POWER OFF / PROGRAM and XIAO USB only. Battery tests
used normal firmware, RUN and both receiver USB ports unplugged.

| Image | SHA-256 |
| --- | --- |
| Controller application | `7352ae2d3989228dca2516555703c08a5fa146ab5a2158b606e20c2f02fac5e9` |
| Normal receiver UF2 | `0ce5257669a51cc7a269b714792559739f96e3fe08de0be8e87eb858ac07ada3` |
| Diagnostic receiver UF2 | `d6410a44f132662195d212699d81b1f2ab191c67bf5e953b57f814b921010a25` |

Controller upload verified the individual written flash hashes. Receiver UF2
family and application-only address bounds were checked before copying. Every
diagnostic application block matched a later UF2 flash readback. The normal
receiver image was then installed and exercised on battery.

Retained images and the source-hash validation report are in the local-only
`.local/firmware/brightness-0.5.0-2026-09-27/`. Raw logs, JSON results and private
receiver flash backups are in `.local/bench/brightness-2026-09-27/`; do not
publish or restore a full-flash backup as an ordinary firmware update.

## Confirmed results

- Upgrade retained the existing bond and saved On Air transaction `8c021471`.
  Receiver defaults read frame 50% / indicator 50%; controller defaults read
  awake 100% / dim 0% / light 50%. No re-pairing or factory reset was performed.
- Through the physical knob, the user saved frame 25%, indicator 75%, awake
  60%, dim 50% and controller light 25%. The user confirmed the visible screen,
  controller light and receiver indicator changes looked right. Front pixels
  were isolated in PROGRAM for this step.
- Receiver USB status and fresh encrypted BLE reads agreed on 25% / 75%,
  brightness transaction `a7b044a7`; saving brightness preserved the mood.
  A diagnostic software reboot retained those levels, mood and bond.
- Before the physical power cycle, the user adjusted the controller light
  further to 10%. The controller restored awake 60% / dim 50% / light 10% on
  a cold USB restart. It automatically reconnected with the original bond and
  read the unchanged On Air transaction.
- After receiver USB removal and battery startup in RUN, the user reported
  On Air and frame 25% were correct. Opening Sign frame made a fresh BLE read
  confirming both receiver levels were still 25% / 75% on normal firmware.
- Battery mood commands covered Off, Warn, On Air, Okay, Request, Special and
  On Air. Each ultimately received an exact transaction/status acknowledgement;
  successful sends took 1.297–2.453 seconds. Final transaction was `6f280aca`.
  The user confirmed the moods looked correct.
- The user tested both receiver brightness endpoints and reported both ranges
  visibly worked without flicker, all four corners remained red, and each
  Reset default followed by Save returned to 50%. BLE logs independently
  confirmed frame 0%, 100% and default 50%, and indicator 100%. A final read
  will establish the saved values after further user adjustments.
- The user reported that the three controller ranges, their default resets and
  Cancel worked. The serial capture independently recorded awake 0% and 100%;
  subsequent saved levels read awake 100% / dim 50% / light 10% after further
  knob activity. The report and saved-state observations are kept separate.
- With the receiver powered off during a brightness save, the controller showed
  **Save not confirmed**. Restoring receiver power and pressing to reload issued
  a read, not another write. BLE readback before and after agreed on frame 80% /
  indicator 100%; these followed the user's earlier explicit frame 80% save.
  The user confirmed the failed-save/recovery behavior, reporting a 100% level.
  The serial record distinguishes frame 80% from indicator 100%.
- An unsaved controller-light draft timed out to Home after approximately
  30 seconds; serial status retained light 10%, and background reads kept the
  same Special transaction. The user confirmed the preview was discarded,
  the screen slept after two minutes, the first press only woke it, and
  reopening the control still showed 10%.

Final recorded state: bonded and verified **Special**, transaction `cee743e2`.
Receiver brightness was frame **80%** / indicator **100%** on its last fresh
read; no subsequent brightness write was recorded. Final controller USB status
reported awake **100%**, dim **50%**, light **10%**. The user's later adjustments
were preserved. Both devices have the 0.5.0 applications; the receiver is on
normal firmware in battery-powered RUN. Serial capture was stopped afterward.

Evidence: `controller-upload.log`, `receiver-initial.log`,
`controller-initial.log`, `menu-save-profile.log`, `receiver-profile-status.log`,
`receiver-reboot.log`, `controller-before-power-cycle.log`, `power-cycle.log`,
`normal-battery-moods.json`, `normal-battery-moods-resumed.json` and their serial
logs. `final-controller-status.log` records the concluding local state.
Local `session.json` summarizes the bench state.
Receiver range/reset and subsequent controller checks are captured in
`endpoints-and-reset.log`.

## Transient failures

The first diagnostic receiver startup after UF2 copying produced a Windows USB
descriptor error and did not answer BLE. One cold XIAO USB reconnect in
OFF/PROGRAM recovered enumeration and Bluetooth. The user confirmed its red
indicator was lit. The later diagnostic software reboot succeeded.

The first Okay send in the battery sequence failed to connect (`error=13`,
4.531 seconds). The controller reported failure rather than confirming it.
A subsequent read returned the previous On Air transaction; an explicit retry
and the remaining mood commands succeeded with the existing bond. The failed
attempt is retained in the first results file, not counted as a pass.

The first receiver-brightness endpoint save also failed during connection setup
(`error=574`). The controller showed **Save not confirmed**; the user's next
press made a fresh read returning the old frame 25% / indicator 75%. Subsequent
explicit saves succeeded. No failed write was automatically replayed.
One later background mood read also failed with error 574, then recovered on
its next read-only retry. The intentional powered-off save failed with error 13
and is recorded separately from these transient failures.

## Coverage limits

The brightness-specific functional checks above are complete. Visual range,
reset, Cancel, sleep and wake acceptance rely on the user's reports. Serial
evidence independently covers the recorded saves, retention, timeout and
failure/reload behavior; it is not an optical measurement. The standalone
controller Light test was not separately repeated at both brightness extremes,
and every mood was not systematically repeated at every brightness endpoint.

Current consumption, battery runtime and thermal behavior have not been
measured. Digital range checks and visual observations do not establish those
measurements or electrical acceptance at the new 50% frame ceiling.
