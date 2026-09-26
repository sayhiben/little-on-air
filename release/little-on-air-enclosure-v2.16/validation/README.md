# Validation scope

Current evidence is in `cad-v216/` and `printing.json`:

- Native build: only 05/06 changed; critical retained interfaces checked against v2.15. One charger contact is intentionally relocated. The final support gusset and residual-lip cleanup are included.
- Wire paths: twelve 2 mm diameter envelopes with 3 mm centerline bends checked against all installed rigid solids; 66 wire-pair separation checks. Optional laminate solids and old harness references are excluded. Exact copper pads, solder fillets, terminations and compact rear wiring are not included in this new wire-to-wire check.
- Mechanical validation: static checks and 31 sampled positions each for yoke insertion and front closure; reserved connector, resistor and slack bays. Flexible-wire motion is not simulated.
- Mesh validation: single connected watertight solids, positive volume and original print planes. Meshes were exported from a fresh import of the final native archive to avoid Fusion's stale tessellation cache after in-place edits.
- Printing: both editable/sliced projects match STLs; approved three-plate positions, materials and unchanged painting retained; no supports on 05/06 or bridges across new reliefs. Guide fill remains parallel to guide axes. Inspection remains disabled, bed leveling and heater shutdown retained.
- Release audit: file integrity, exact unchanged fabrication files, project meshes, optical contour registration and local guide links.

Earlier `cad-v215/`, `cad-v214/`, `cad-v213/` and `unchanged-v28/` files are historical evidence for unchanged interfaces, not validation of the current wiring or a successful physical print. The v2.14 tunnel roof passed slicing but failed physical bridging; no such roofs are reintroduced. No structural FEA, actual print fit or brightness/thermal qualification is claimed. Follow the physical commissioning checklist.
