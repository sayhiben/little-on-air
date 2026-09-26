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

`v216/` contains the current CAD builder, wire-route checks, print preparation,
validation and release tooling. `output/v216/` contains its current outputs.
`build_rear_access.py` incorporates the completed iterative fixes; export meshes
from a fresh import of its native archive using `roundtrip_mesh.py` before
preparing print projects. Packaging starts from the preserved v2.15 release and
replaces the changed housing/yoke and supporting guides.

Earlier versions, one-time patch/probe scripts, old root-level builders,
references and superseded outputs now live in
[the hardware archive](../archive/README.md). Current tools explicitly import
several archived geometry and print-audit helpers; retain that dependency tree.
[REVISION-HISTORY.md](REVISION-HISTORY.md) links to the archived manufacturing
iterations. Published release bundles keep their existing paths and checksums.
