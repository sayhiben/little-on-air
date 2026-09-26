# ON AIR v2.11 — clean top seam

Replace **front frame 01 only**. Three obsolete clearance notches at the top edge have been filled back to the normal rear mating plane. The wider v2.10 front bevels remain: 1.4 mm around the outside and 0.8 mm around the display opening, both 45 degrees.

The current rear housing, electronics yoke, optical layers, controls and optional indicator light guides remain compatible. No revised laser artwork or extra hardware is needed.

## Files and printing

`stl/01-front-optical-bezel.stl` is in millimetres and already oriented front face down. The two Bambu Studio projects contain this replacement part alone, using either the previously successful eSUN PLA+ settings or the existing structural PETG profile. Select the actual spool and its calibrated settings before printing.

Both projects use the X1C 0.4 mm nozzle, 0.20 mm layers, four walls, 25% gyroid infill, a 3 mm outer brim and no automatic supports. Retain the supplied orientation. Carefully remove the brim to preserve the front edge. Allow approximately 1 hour 10 minutes and 18 g. First-layer inspection remains disabled following the earlier printer stall; bed leveling and normal heater shutdown remain enabled. No print job was sent.

`cad/` contains the complete updated Fusion and STEP assembly. Earlier revisions are preserved separately.

## Validation

Exact native solid comparison confirms that only part 01 changed: 23.707 mm³ was added inside the three old top recesses, with no material removed. The exact floor contours preserve the rounded corner and internal cavity boundaries. The restored rim ends at 9.50 mm depth; the yoke begins at 9.65 mm, retaining the normal 0.15 mm seam clearance.

The added material has no static interference with the other modeled parts. Conservative continuous swept envelopes also clear the front's 20 mm closing path and the optical parts, reset button and front light guide during rear insertion. All 45 existing wire-route, component-bay and LED-pigtail reservations clear conservative enclosing boxes around the restored material. These are CAD checks; ordinary printed fit and button click/release checks still apply.

The exported STL is one watertight solid. Both source and sliced 3MF meshes match the STL, sit on the bed, and slice without warnings. No manual pauses or first-layer inspection commands are present; bed leveling and heater shutdown commands remain.

`views/` contains native CAD previews. `validation/` contains the detailed geometry, motion, wire clearance, mesh and slicing results. The unrelated historical side-edge recess was outside this three-notch cleanup and remains unchanged.
