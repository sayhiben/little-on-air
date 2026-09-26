# ON AIR v2.7 — slim parallel-PCB case

Open **bambu-studio/on-air-v27-X1C-eSUN-PLA-plus-fit-checks.3mf** as a complete project. Print the four-part fit plate before the full body. Generic PLA and PETG fit projects are supplied too.

Opened and sliced successfully in Bambu Studio: estimated **2 h 8 min / 34.25 g** for the eSUN PLA+ fit plate, including preparation. No print was sent.

Body: **120 × 60 × 24 mm**, down from 34 mm. Including the front reset button: **26.5 mm maximum depth**. Both USB ports remain on top. Both PCBs are parallel to the display; XIAO faces forward and charger faces backward.

Replace production parts **01, 05, 06 and 07 together**. Keep acrylic, graphic backing03 and optical retainer04. All eight screws remain M3×8 button heads with ordinary M3 nuts. The upper-right case screw moves to the corner.

- `REVISION-NOTES.md`: changed interfaces and nominal fits.
- `BUILD-AND-ASSEMBLY.md`: print, assembly, routing, retained electrical procedure and laser instructions.
- `BOM.csv`: retained circuit and materials; no additional electronics.
- `routing-map.svg` and `routing-coordinates.json`: placement and wire corridors.
- `stl/`: oriented production meshes, millimetres, 100% scale.
- `fit-samples/`: actual clipped production geometry.
- `bambu-studio/`: sliced X1C projects for eSUN PLA+, generic PLA and PETG; AMS and manual-color-swap variants.
- `laser/02-acrylic-REAR-engrave-and-cut.svg`: unchanged 104 × 38 acrylic master, already mirrored for rear engraving.
- `cad/`: native Fusion assembly, STEP assembly and native fit sections.
- `validation/`: exact geometry and slicing check records.

First-layer inspection is disabled, retaining the successful workaround; bed leveling remains enabled. Only the button uses automatic support. No print or laser job has been sent.

The fit print remains the check for real tolerances and solder shape. Charger PCB thickness remains a 1.0 mm assumption; measure acrylic thickness and laser kerf on the actual stock.
