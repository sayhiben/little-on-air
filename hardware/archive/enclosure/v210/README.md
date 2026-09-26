# ON AIR v2.10 — broader front bevels

Replace **front frame 01 only**. This revision broadens the v2.9 bevels:

| Edge | Previous | New |
| --- | --- | --- |
| Outer perimeter | 0.8 mm | **1.4 mm** |
| Display opening | 0.4 mm | **0.8 mm** |

Both bevels remain 45°. The outer bevel follows the existing rounded corners. All other v2.8 components, acrylic, backing, hardware and optional indicator light guides remain compatible.

## Files and printing

`stl/01-front-optical-bezel.stl` is in millimetres and already oriented front face down. The two Bambu Studio projects contain only this replacement part, using either the previously successful eSUN PLA+ settings or the existing structural PETG profile. Select the actual spool and its calibrated settings before printing.

Both use the X1C 0.4 mm nozzle, 0.20 mm layers, four walls, 25% gyroid infill, a 3 mm outer brim and no automatic supports. Retain the supplied orientation. Carefully remove the brim to preserve the front edge. Estimates are approximately **1 h 10 min / 17.95 g PLA+** or **1 h 10 min / 17.69 g PETG**. First-layer inspection stays disabled following the earlier printer stall fix; bed leveling and normal heater shutdown remain present. No print job was sent.

The `cad/` files contain the updated full Fusion and STEP assembly. The earlier v2.9 release is preserved separately.

## Validation

Native old/new solid comparison confirms that only part 01 changed. The broader bevels remove 431.322 mm³ relative to the original unbeveled v2.8 frame, with no added material. Changes stop at 1.4 mm front depth. The acrylic seat remains at 1.6 mm; the display aperture retains 0.8 mm of straight wall beneath its bevel.

Separate probes confirm no material removal around the reset guide/front stop, RGB light-guide collar seat or four screw-head recesses. All deeper mounting geometry and other components remain identical. The STL is one watertight solid with approximately 2,922 mm² of planar bed contact. Both source and sliced 3MF meshes match the STL and slice without warnings. Existing physical fit and reset click/release checks still apply.

`views/` contains native CAD previews. `validation/` contains the detailed geometry, mesh and slicing results. No revised laser artwork or additional hardware is needed.
