# Validation scope

`cad-v215/` proves roof-only solid removal, preserved lower geometry and critical interfaces, unchanged native component geometry fingerprints, and one connected watertight frame mesh. `printing.json` checks both projects, no former wire-roof bridge paths, no frame support, and unchanged other meshes/painting/optical fill. `release-audit.json` verifies the delivered package.

Earlier `cad-v214/`, `cad-v213/` and `unchanged-v28/` records are historical. The v2.14 roof passed slicing but failed the user’s physical bridge print; that limitation is why the roofs were removed. Previous collision checks remain applicable under verified solid removal and unchanged other parts. Physical wall stiffness, wire retention and actual assembly remain to be checked.
