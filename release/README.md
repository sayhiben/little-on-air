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

The complete manufacturing release is [Little ON AIR enclosure v2.16](little-on-air-enclosure-v2.16/README.md). This revision changes rear housing 05 and yoke 06 so LED leads can turn rearward behind the optical mounts. It adds shallow open reliefs and reinforced grooves, with one charger contact relocated under the USB end. The widened front and all other printed/laser-cut parts remain unchanged.

- [Download the complete ZIP](little-on-air-enclosure-v2.16.zip)
- [Print only the replacement housing and yoke](little-on-air-enclosure-v2.16/bambu-studio/on-air-v216-X1C-upgrade-parts.3mf)
- [Open the three-plate Bambu Studio project](little-on-air-enclosure-v2.16/bambu-studio/on-air-v216-X1C-all-plates.3mf)
- [Read the rearward wiring guide](little-on-air-enclosure-v2.16/guides/FRONT-WIRING.md)
- [Read the complete build guide](little-on-air-enclosure-v2.16/guides/BUILD-AND-ASSEMBLY.md)
- [Review all parts and materials](little-on-air-enclosure-v2.16/BOM.csv)

The release includes current production STLs, acrylic artwork, calibration SVGs, Fusion/STEP CAD, assembly and wiring guides, validation records and a firmware source snapshot. Optional laminate parts are kept separate from the selected printed backing. Older development iterations remain under `hardware/enclosure/`; see its [revision history](../hardware/enclosure/REVISION-HISTORY.md).

The previous [v2.15 release](little-on-air-enclosure-v2.15/README.md) is preserved as history; use v2.16 for rearward LED wiring. The enclosure is v2.16; the preserved firmware snapshot is independently versioned v0.1.2 and drives onboard RGB only. This hardware package does not publish or assess newer development firmware. Current CAD, mesh and slicing checks pass; physical fit with the actual LED pads, insulation and solder joints remains to be verified.
