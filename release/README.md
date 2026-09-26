# Current project release

## Controller hardware prototype

The [measured Igor controller v4 ZIP](little-on-air-igor-controller-v4.zip)
uses Igor's actual desk orientation: broad flat base down, horizontal encoder,
upward-facing display and vertical back. A 9.5 mm base extension fits two
20 × 33.5 × 6.5 mm weights in one layer beneath a XIAO ESP32-S3 carrier.
The encoder and OLED mounts match supplied measurements; the front mini-strip
NeoPixel has a captured transparent PETG diffuser. The footprint is unchanged,
and the raised front nose contains no weights. Includes eight STLs, STEP CAD,
three Bambu projects, fit report, comparison views and assembly instructions.
Read the [controller guide](../hardware/controller/igor-measured-v4/README.md).

CAD and slicer checks pass; physical assembly and the ESP32-S3 firmware port
remain unvalidated/unimplemented. Controller v1–v3 are superseded.

## Receiver enclosure

The current manufacturing release is [Little ON AIR enclosure v2.15](little-on-air-enclosure-v2.15/README.md), the case retained by the user and restored as current on September 26, 2026. Frame 01 has open-backed perimeter wire channels; the channel roofs and access-window ceilings were removed after the v2.14 physical bridging failure. The original rear housing 05, electronics yoke 06 and other printed/laser-cut parts remain in this set.

- [Download the complete ZIP](little-on-air-enclosure-v2.15.zip)
- [Print only the replacement front frame](little-on-air-enclosure-v2.15/bambu-studio/on-air-v215-X1C-front-only.3mf)
- [Open the three-plate Bambu Studio project](little-on-air-enclosure-v2.15/bambu-studio/on-air-v215-X1C-all-plates.3mf)
- [Read the open-channel wiring guide](little-on-air-enclosure-v2.15/guides/FRONT-WIRING.md)
- [Read the complete build guide](little-on-air-enclosure-v2.15/guides/BUILD-AND-ASSEMBLY.md)
- [Review all parts and materials](little-on-air-enclosure-v2.15/BOM.csv)

The release includes production STLs, acrylic artwork, calibration SVGs, Fusion/STEP CAD, assembly and wiring guides, validation records and a firmware source snapshot. Optional laminate parts are kept separate from the selected printed backing. Older development iterations are in [the hardware archive](../hardware/archive/README.md); see the [revision history](../hardware/enclosure/REVISION-HISTORY.md).

The [v2.16 release](little-on-air-enclosure-v2.16/README.md) is preserved as an archived alternative. Both releases, their ZIPs and checksums retain their published bytes. The current case is v2.15; its bundled firmware snapshot is independently versioned v0.1.2 and drives onboard RGB only. Use the [developer guide](../CONTRIBUTING.md#four-pixel-nrf52840-receiver) for current receiver firmware. This case selection adds no new physical validation result; the original validation records and commissioning checks remain in the package.
