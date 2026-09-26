# ON AIR v2.12 — complete frame perimeter cleanup

Replace **front frame 01 only**. This revision fills the fourth legacy notch, on the upper part of the right side. It was clearance for the old side-mounted reset button. The three top notches closed in v2.11 remain closed.

The outer 1.4 mm and display-opening 0.8 mm bevels remain unchanged, both 45 degrees. The rear housing, yoke, optics, light guides and controls remain compatible. No laser artwork or hardware changes are needed.

## Files and printing

`stl/01-front-optical-bezel.stl` is in millimetres and oriented front face down. The Bambu Studio projects contain the replacement frame alone, using the existing eSUN PLA+ or structural PETG settings. Select the actual spool and its calibrated profile before printing.

Both projects use the X1C 0.4 mm nozzle, 0.20 mm layers, four walls, 25% gyroid infill, a 3 mm outer brim and no automatic supports. Retain the supplied orientation. Carefully remove the brim to preserve the front edge. Allow about 1 hour 10 minutes and 18 g. First-layer inspection remains disabled after the earlier printer stall; bed leveling and normal heater shutdown remain enabled. No print job was sent.

`cad/` contains the complete updated Fusion and STEP assembly. Previous revisions remain available separately.

## Full perimeter check

The inspection covers all four straight sides and all four rounded corners of the rear mating rim. An exact native solid comparison uses a continuous 1 mm-wide perimeter band from 8.5 to 9.5 mm front depth. Before correction, only the right side had missing material in this band. After correction, all eight perimeter regions are complete and no exterior recessed floor remains in the band.

The actual notch floor was restored by 0.35 mm, from 9.15 to 9.50 mm depth. Exact old/new solid subtraction confirms that only part 01 changed: 2.709 mm³ was added at X118.2–120.0, Y52.55–56.85 mm, with no material removed. The previous three top closures are untouched. The normal 0.15 mm gap to the yoke's front plane is preserved.

The added material clears the other modeled components, the front's continuous 20 mm closing path and rear insertion of the optical parts, reset button and front light guide. All 45 existing wire-route, component-bay and LED-pigtail reservations clear a conservative box around the fill. This validates the change in CAD; ordinary printed fit and button click/release checks still apply.

The STL is one watertight solid. Both source and sliced 3MF meshes match it, sit on the bed and slice without warnings. No manual pauses or first-layer inspection commands are present; bed leveling and heater shutdown commands remain.

`views/` shows the frame and the assembly from opposite directions so all four sides are visible. `validation/` includes the before/after perimeter audit, native geometry, assembly-motion, wiring, mesh and slicing results.
