# Validation scope

`cad-v214/` contains the current native component comparison, assembly and wire passage checks, reset collar correction/travel, final feature/USB checks, mesh topology and roof-span audit. `printing.json` validates both new Bambu projects and the unchanged insert colors/guide fill. `release-audit.json` verifies the delivered files and archive.

`cad-v213/` and `unchanged-v28/` are preserved historical evidence for unchanged parts. Their old front H2-H4 harness paths are superseded; use the v2.14 wire-passage checks and front wiring guide. Historical JSON paths identify original workspace sources.

The current correction removes added material only, so completed wire and front-closure collision checks remain valid. Reset movement is separately rechecked after the correction. Actual wire insulation, solder, bridges, optical performance, charging and firmware commissioning remain physical tasks.
