# Little On Air enclosure

## Current complete release

Use [enclosure v2.13](../../release/little-on-air-enclosure-v2.13/README.md) for a new build. It contains the current CAD, all production STLs, acrylic artwork, one three-plate Bambu Studio project, the BOM and consolidated assembly/wiring/laser guides.

- [Complete release ZIP](../../release/little-on-air-enclosure-v2.13.zip)
- [Bambu Studio: all plates](../../release/little-on-air-enclosure-v2.13/bambu-studio/on-air-v213-X1C-all-plates.3mf)
- [Build and assembly](../../release/little-on-air-enclosure-v2.13/guides/BUILD-AND-ASSEMBLY.md)
- [Parts and hardware](../../release/little-on-air-enclosure-v2.13/BOM.csv)

The current set uses black PLA+ structure, black/white PLA+ backing and three clear PETG indicator guides. The case has the wider front bevels, all four seam corrections, two switches, flat PCB mounts, corrected reset travel and captive guide retention. All nine screws use M3x8 button heads. The three-plate arrangement keeps the user layout, with the spare keeper removed and the requested materials restored.

Firmware 0.1.2 uses the onboard RGB LEDs only. The release documents the remaining external NeoPixel output work rather than implying the harness is already driven.

## Development files

[REVISION-HISTORY.md](REVISION-HISTORY.md) preserves the prior revision notes and links. Versioned source folders and `output/` are retained as development history and regeneration inputs; several scripts depend on those exact paths. Use the curated release instead of selecting similarly named files from multiple historical packages.

`release-docs/` contains the consolidated guide sources. `package_current_release.py` assembles the curated files; `audit_current_release.py` validates and archives them. `v213/` contains the current CAD revision and combined-print tooling. `archive/` holds loose generated reports removed from the repository root. No historical CAD or print iteration was deleted during cleanup.
