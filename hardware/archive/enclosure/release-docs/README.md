# Little ON AIR enclosure v2.13

This is the complete manufacturing package for the **120 × 60 × 24 mm** enclosure with the broad front bevels, corrected frame seams, two switches, flat PCB mounts, front reset button and captive indicator light guides. The unpressed reset button projects approximately 2.5 mm beyond the front.

## Start here

1. Check the [parts and hardware list](BOM.csv).
2. Open the [single Bambu Studio project](bambu-studio/on-air-v213-X1C-all-plates.3mf) **as a project**, keeping its settings. It contains all ten production prints on three plates. [Printing guide](guides/PRINTING.md).
3. Cut and rear-engrave the acrylic using the [production SVG](laser/02-acrylic-REAR-engrave-and-cut.svg) and [laser guide](guides/LASER.md). The artwork is already mirrored; do not mirror again.
4. Follow the [complete build guide](guides/BUILD-AND-ASSEMBLY.md) and [two-switch wiring guide](guides/WIRING.md). The [capacitor and resistor walkthrough](guides/CAPACITOR-AND-RESISTOR.md) shows their purpose, exact lead connections and soldering steps. Record the physical checks in [COMMISSIONING.csv](guides/COMMISSIONING.csv).

**Firmware status:** the included firmware source snapshot is version 0.1.2 and drives the onboard RGB LEDs. It does not yet drive the four external NeoPixels. The mechanical files and wiring provisions are current; external-pixel firmware remains unfinished. See [firmware status](guides/FIRMWARE-STATUS.md).

## Print set

| Plate | Parts | Material |
| --- | --- | --- |
| 1 | 01 frame, 05 housing, 04 optical retainer, 06 electronics yoke, 07 reset button, 11 rear guide keeper | Black PLA+ |
| 2 | 03 display backing, black base and white raised letters | Black and white PLA+ |
| 3 | 08 front indicator guide and **two** identical 09 charger guides | Transparent PETG |

The project uses your three-plate layout with the spare keeper removed and the requested material profiles restored. Project filament numbers are **1 black PLA+, 2 white PLA+, 3 transparent PETG**; map them to your loaded spools. First-layer inspection remains disabled. Estimated total is about **6 h 15 min / 71.30 g**.

There are nine unique production STL files and ten printed pieces. Part 02 is laser-cut acrylic. Part 10 in the CAD is the second instance of STL 09; there is no missing STL. The printed display backing sits behind the acrylic with an air gap; its letters do not insert into engraved recesses.

## Folder guide

| Folder / file | Contents |
| --- | --- |
| `stl/` | Latest production meshes, millimetres, already oriented for printing |
| `bambu-studio/` | One editable and sliced project containing all three plates |
| `laser/` | Production acrylic SVG and clearly disabled LightBurn review project |
| `laser/calibration/` | Thickness-fit strip, kerf coupon and engraving samples |
| `cad/` | Complete current Fusion F3D and STEP assembly; hardware/reference bodies are not extra print parts |
| `guides/` | Consolidated printing, laser, wiring, assembly, firmware and commissioning instructions |
| `reference/` | Wire paths, length allowances, fastener layout and assembly images |
| `alternatives/laminate/` | Optional laminate artwork and its two spacer rings; omit with the selected printed backing |
| `firmware/` | Current committed firmware source snapshot; no unverified local build binaries |
| `validation/` | Current mesh/print/optics checks and the existing native CAD validation records |
| `PARTS.csv` | Exact quantities, file paths, materials and revision provenance |
| `MANIFEST.json`, `SHA256SUMS.txt` | File inventory, source provenance and integrity checks |

The main case, yoke, optical retainer and guide keeper use **nine M3×8 button-head screws and nine standard M3 nuts total**. No older long closure screws, printed DPDT plunger or alternate-size guide sets are required.

The manufacture package has been checked digitally; actual spool behavior, acrylic thickness/kerf, electrical operation and optical brightness still require the build checks. No printer, laser or firmware job was started while packaging this release.
