# Little On Air enclosure

## Current complete release

Use [enclosure v2.15](../../release/little-on-air-enclosure-v2.15/README.md), the receiver case retained by the user and restored as current on September 26, 2026. It has the open-backed wire channels in frame 01 and the original rear housing 05 and electronics yoke 06.

- [Complete release ZIP](../../release/little-on-air-enclosure-v2.15.zip)
- [Bambu Studio: replacement front frame](../../release/little-on-air-enclosure-v2.15/bambu-studio/on-air-v215-X1C-front-only.3mf)
- [Bambu Studio: all plates](../../release/little-on-air-enclosure-v2.15/bambu-studio/on-air-v215-X1C-all-plates.3mf)
- [Open-channel wiring and mounting](../../release/little-on-air-enclosure-v2.15/guides/FRONT-WIRING.md)
- [Build and assembly](../../release/little-on-air-enclosure-v2.15/guides/BUILD-AND-ASSEMBLY.md)
- [Parts and hardware](../../release/little-on-air-enclosure-v2.15/BOM.csv)

The current set uses black PLA+ structure, black/white PLA+ backing and three clear PETG indicator guides. v2.15 removes the failed wire-channel roofs from the widened 129 × 69 mm frame. Wires lay into the channels from the rear and use small hot-glue anchors for retention. The other parts, acrylic, optical floors and nine M3x8 joints retain their earlier geometry. The all-plates project preserves the approved three-plate layout; the front-only project is for upgrading a v2.14 frame.

The existing CAD, print projects, validation records and published checksums are unchanged. This selection records which case the user kept; it does not add a new physical fit or electrical validation result. The v2.16 rearward-wiring housing/yoke revision is preserved in [the archive](../archive/enclosure/v216/README.md).

The package preserves the earlier firmware 0.1.2 snapshot, which uses onboard RGB only. Follow the [developer guide](../../CONTRIBUTING.md#four-pixel-nrf52840-receiver) for the current four-pixel firmware; release-bundled firmware notes describe the historical snapshot.

## Development files

[v215/](v215/README.md) contains the current channel-opening builder, mesh and
print audits, wiring diagram and release tooling. `output/v215/` contains its
preserved CAD, frame mesh, print projects and validation evidence. Packaging
starts from the preserved v2.14 release and replaces frame 01 and its guides.

Earlier versions, one-time patch/probe scripts, old root-level builders,
references and superseded outputs now live in
[the hardware archive](../archive/README.md). Current tools explicitly import
several archived geometry and print-audit helpers; retain that dependency tree.
[REVISION-HISTORY.md](REVISION-HISTORY.md) links to the archived manufacturing
iterations. Published release bundles keep their existing paths and checksums.
