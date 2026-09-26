# First-layer inspection recovery — your edited PLA fit plate

Open **on-air-v22-X1C-eSUN-PLA-plus-fit-NO-FIRST-LAYER-SCAN.3mf** in Bambu Studio as a project. It is a freshly sliced copy of your `PLA-fit-checks2.3mf`, preserving your eSUN PLA+ material, temperatures, geometry, placement and other settings. The only functional setting changed is `scan_first_layer`: on → off. The original file is untouched.

Your original uses the installed factory X1C printer command templates. Its freshly generated code contains the normal `M976 S1 P1` inspection request before layer two, and no user-pause command. This points to the inspection step as the next diagnostic target; it does not prove a firmware or sensor fault, or guarantee the cause of the reported hang.

Both copies sliced without warnings and all twelve object meshes/placements match your edited file. The recovery file contains no executable M976/M977 scan commands or user pauses. Bed leveling, nozzle wiping, normal heating and end-of-job heater shutdown remain. Automated first-layer inspection is disabled, so watch the first two layers yourself.

1. Cancel the stalled job from the printer screen. Let the machine cool and remove the previous first layer before restarting.
2. Open the new file as a complete project. Retain its embedded settings; replacing the printer preset may restore scanning. Keep **Bed leveling** enabled in the send dialog.
3. If **First Layer Inspection** is also enabled in the printer's Print Options, turn that one option off for this diagnostic retry. Flow calibration and bed leveling are separate settings.
4. Send this new project rather than resuming or reprinting the previous cached job. Watch it pass into layer two; inspect adhesion yourself.
5. If it still stalls, cancel it and record the exact HMS code, printer firmware version and where the head parks. If the same inspection timeout appears, first verify the newly sent job is this recovery file. A continued hang then needs printer-side diagnosis and logs; repeated hot-idle retries are not useful.

This is an inspection-off workaround, not a physically verified repair. The earlier geometry/slicing checks did not exercise the printer's inspection firmware. No printer setting was changed remotely and no job was started by the assistant.

The local `validation/validation.json` records the original and changed settings, factory-template comparison, both slices, and command/geometry checks.

Primary source: [Bambu Studio first-to-second-layer inspection logic](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/GCode.cpp) inserts the scan only when `scan_first_layer` is enabled. The installed factory templates were also compared directly with your project.

The recovery project was also opened and re-sliced in the Bambu Studio desktop app. Its exported G-code again contains no inspection requests or user pauses, confirming the setting survives loading and re-slicing. It is left open in Preview; no print was started.
