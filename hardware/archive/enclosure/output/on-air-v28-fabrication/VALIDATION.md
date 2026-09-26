# v2.8 validation

- Only production parts 05 and 07 change. The model restores contact patches at both charger bottom corners and a continuous 17.5 mm edge stop.
- Reset collar dimensions measured from the resulting solid: 2.85 mm thick. No keeper contact through 0.80 mm travel; keeper contact confirmed beyond that stop. Resting tip and projection are unchanged. An additional 81-pose control sweep passes against rigid PCB, USB, LED and case envelopes.
- 14 full native assembly/control checks pass; no feature errors or static overlaps. USB clearance, all eight nut-loading paths, solder exits and prewired board insertion checks pass.
- All 45 wire-route, component-bay and individual LED-exit reservations were rechecked against the final assembly. All 120 route-pair packing checks pass.
- All 18 STL meshes are watertight, connected solids, oriented with positive bed contact at Z=0.
- Nine Bambu projects slice without warnings. Project meshes match the exported STL meshes. First-layer inspection is disabled; normal bed leveling and heater shutdown remain. Only the full manual-color-swap graphic plate contains a deliberate filament-change pause.
- The packaged eSUN PLA+ fit project also opens and slices successfully in the Bambu Studio GUI: two objects, 1 h 22 min and 22.40 g. No print was sent.
- Native Fusion archive reopens with matching volumes. Laser files are unchanged from v2.7.

The physical print reaches reset contact later than the simplified CAD target predicts. Therefore overlap with that target is not a valid switch depression/force calculation. The new motion limit is 0.20 mm beyond the empirically reported old stop. Nominal clearance from the plunger to the bare PCB at the new stop is only 0.05 mm; this is an envelope check, not a tolerance guarantee. Confirm a light click and release before the stop with the fit parts; do not force a jammed button. Actual charger indentation shape, PCB thickness, solder shape and printer accuracy still require physical fitting.
