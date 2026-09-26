# Validation records

`release-audit.json` checks this package after copying: inventory, source identity, STL topology, 3MF contents, SVG registration, disabled LightBurn review output, local guide links and ZIP checksums.

`printing.json` is the completed three-plate slicer/mesh/toolpath audit. `cad-v213/` retains the completed native interference, motion, guide-retention, nut-access, harness and seam checks. `unchanged-v28/` retains the applicable earlier solder/USB/reset and wire-packing checks for unchanged interfaces. These are existing validation results; packaging did not rerun Fusion or change geometry. Paths in historical JSON records identify the original workspace provenance.

Physical fit, actual charge current, optical clarity and external-pixel firmware remain commissioning tasks described in the guides.
