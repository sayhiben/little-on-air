# Little On Air enclosure

## Current complete release

Use [enclosure v2.16](../../release/little-on-air-enclosure-v2.16/README.md) for a new build. It contains the current CAD, all production STLs, acrylic artwork, the three-plate Bambu Studio project, a two-part upgrade project, the BOM and consolidated assembly/wiring/laser guides.

- [Complete release ZIP](../../release/little-on-air-enclosure-v2.16.zip)
- [Bambu Studio: replacement housing and yoke](../../release/little-on-air-enclosure-v2.16/bambu-studio/on-air-v216-X1C-upgrade-parts.3mf)
- [Bambu Studio: all plates](../../release/little-on-air-enclosure-v2.16/bambu-studio/on-air-v216-X1C-all-plates.3mf)
- [Rearward LED wiring and mounting](../../release/little-on-air-enclosure-v2.16/guides/FRONT-WIRING.md)
- [Build and assembly](../../release/little-on-air-enclosure-v2.16/guides/BUILD-AND-ASSEMBLY.md)
- [Parts and hardware](../../release/little-on-air-enclosure-v2.16/BOM.csv)

The current set uses black PLA+ structure, black/white PLA+ backing and three clear PETG indicator guides. v2.16 changes only rear housing 05 and yoke 06: shallow reliefs and reinforced open grooves let the LED leads turn back behind the optical screw heads. One charger contact moves under the USB end. The v2.15 front, optics, board positions, USB/reset/guide interfaces and all nine M3x8 joints remain. The approved three-plate layout is preserved. New wire runs have 3 mm centerline bends and clearance for separate flexible wires up to 1.8 mm insulation OD; actual pad fanout and print fit still need checking.

The package preserves the earlier firmware 0.1.2 snapshot, which uses onboard RGB only. This hardware revision does not publish or assess newer firmware work in the development repository.

## Development files

[REVISION-HISTORY.md](REVISION-HISTORY.md) preserves the prior revision notes and links. Versioned source folders and `output/` are retained as development history and regeneration inputs; several scripts depend on those exact paths. Use the curated release instead of selecting similarly named files from multiple historical packages.

`v216/` contains the current CAD, wire-route, print, validation and release tooling. Its package script starts from the preserved v2.15 release, then replaces 05/06 and updates the guides/projects. `build_rear_access.py` is the complete CAD builder; export meshes from a fresh import of the resulting archive using `roundtrip_mesh.py` before preparing print projects. The `finish_*.py` scripts record one-time iterative fixes already incorporated in the builder. `v215/`, `v214/`, `release-docs/`, `package_current_release.py`, `audit_current_release.py` and `v213/` preserve preceding workflows. `archive/` holds older reports. No historical CAD or print iteration was deleted.
