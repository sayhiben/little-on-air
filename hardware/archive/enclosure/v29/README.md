# ON AIR v2.9 — subtly beveled front frame

Replace **part 01 only**. All remaining v2.8 printed parts, acrylic, graphic insert, fasteners and indicator light guides remain compatible.

The front frame has a 0.8 mm, 45° bevel around its outer perimeter, following the existing rounded corners. A finer 0.4 mm, 45° bevel surrounds the display opening. This leaves a broad flat front face and gives both borders a restrained highlight.

## Print files

- `stl/01-front-optical-bezel.stl`: millimetres, already oriented with the front face down on the bed.
- `bambu-studio/on-air-v29-X1C-eSUN-PLA-plus-beveled-front.3mf`: the user's previously successful eSUN PLA+ material settings, with the frame shown black.
- `bambu-studio/on-air-v29-X1C-PETG-beveled-front.3mf`: the existing structural PETG profile. Select the actual spool and its calibrated flow/temperature before printing.
- `cad/`: updated full Fusion and STEP assemblies, including the optional indicator guides. The only revised physical part is 01.

Both projects use the X1C 0.4 mm nozzle, 0.20 mm layers, four walls, 25% gyroid infill, a 3 mm outer brim and no automatic supports. The front is flat on the plate; the chamfers rise at 45°. Preserve this orientation. Peel the brim away carefully to protect the cosmetic edge. First-layer inspection remains disabled following the prior printer stall fix; bed leveling and normal shutdown remain enabled. No print job has been sent.

## Fit and validation

Native solid subtraction verified that the revision removes 134.541 mm³ and adds no material. Changes are confined to the first 0.8 mm of front depth. All deeper geometry is identical, including the acrylic seating surface at 1.6 mm. The display opening retains 1.2 mm of straight wall below its bevel.

Separate checks confirm zero material change around the reset guide, RGB guide collar seat, and all four screw head recesses. All other component volumes remain identical. This preserves the established joints, wiring routes and light-guide alignment; no new hardware or laser artwork is required.

The STL is watertight, one connected solid, with 3,240 mm² of planar front contact before slicing compensation. Both source and sliced 3MF meshes match it, and both materials slice without warnings. The included validation reports record these checks. Prior hardware-fit and reset click/release limitations still apply; this cosmetic revision does not change those mechanisms.

The images are CAD views of the new edge treatment. The assembly image uses simplified optical/component rendering; evaluate final colour and surface finish on the actual print.
