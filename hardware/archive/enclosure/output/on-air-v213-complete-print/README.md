# Little ON AIR — complete v2.13 print project

Open **on-air-v213-X1C-all-plates.3mf** as a project in Bambu Studio, retaining its settings. It contains all ten production pieces on four plates for the **Bambu X1 Carbon, 0.4 mm nozzle, textured PEI plate**. Geometry matches the latest released STLs. No fit coupons or alternate-size guide sets are included.

| Plate | Contents | Material | Slicer estimate |
| --- | --- | --- | --- |
| 1 | 01 front frame, 05 rear housing, 11 rear light-guide keeper | Black PLA+ | 4 h 02 min / 53.87 g |
| 2 | 04 optical retainer, 06 electronics yoke, 07 reset button | Black PLA+ | 53 min / 7.08 g |
| 3 | 03 registered display backing, black base and white raised lettering | Black + white PLA+ | 1 h 05 min / 10.15 g |
| 4 | 08 captive front guide and two identical 09 rear charger guides | Transparent PETG | 13 min / 0.55 g |

Approximately **6 h 14 min and 71.65 g** for all plates, excluding plate changes. The acrylic remains a separate laser-cut part; its artwork is unchanged.

## Filaments

Map the project filaments to the corresponding loaded spools when sending a plate:

1. **Black PLA+** — the previous eSUN PLA+ baseline, 220 °C nozzle / 55 °C textured bed.
2. **White PLA+** — the same PLA+ profile as black, with white color assigned.
3. **Transparent PETG** — the previous optical profile, 255 °C nozzle / 70 °C textured bed, low part cooling and auxiliary fan off.

These are project filament numbers, not a requirement to use those physical AMS bays. Match temperatures and flow calibration to your actual spools. If changing profiles, re-slice the affected plate; preserve the clear PETG profile's low cooling and the guide objects' optical settings.

Plate 3 includes **one automatic AMS change to white at Z = 1.70 mm**, immediately above the 1.60 mm black base. Its raised lettering and upper registration pads print white. The prime tower and 700 mm³ black-to-white flush are enabled. Prepare-mode geometry thumbnails may show the backing entirely black because the white is a height-based filament change; Preview displays the sliced colors. Plates 1–2 use only black and plate 4 uses only PETG.

## Printing settings already included

- Main structural parts: 0.20 mm layers, four walls; housings use 25% gyroid. Optical retainer and electronics yoke use solid infill.
- Insert and reset button: 0.10 mm layers.
- Clear guides: lying flat with their long axes along bed X, 0.10 mm layers, one wall, 100% aligned fill, up to 20 mm/s extrusion. No brim or support on the guides. Keep their orientation; rotating them requires changing the fill direction to match.
- Automatic support is confined to **11 rear guide keeper** on plate 1 and **07 reset button** on plate 2. Keepers and housings have their intended print orientations and brims.
- **First-layer inspection stays disabled** to preserve the timeout workaround. Bed leveling and end-of-print heater shutdown remain enabled; there are no manual pause commands.

Bambu stores the first-layer height/speeds and acceleration at project level. This combined project uses the optical profile's **0.10 mm first layer at 15 mm/s**, 1000 mm/s² default acceleration and 500 mm/s² outer-wall acceleration across all four plates. This increases structural print time while retaining the optical settings in one editable project. Main structural layers after the first remain 0.20 mm. This distinction follows Bambu Studio's [print configuration definitions](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PrintConfig.hpp).

## Checks and assembly

The delivered 3MF was re-sliced with Bambu Studio 2.8.2.61. All four plates completed without slicer warnings. Both the editable source and sliced project were checked against the nine unique source STLs; all ten instances are correct, closed, correctly oriented, and separated on their plates. Toolpath checks confirmed the material allocation, all 25 insert layers' colors, supported-part locations, and **332 long optical fill runs parallel to the guide axes**. Detailed results are in `validation.json`.

The guide keeper uses one additional **M3×8 button-head screw and M3 nut**, for nine of each across the completed enclosure. Follow the [v2.13 guide installation instructions](../on-air-v213-captive-light-guides/README.md): the front guide's inner collar is captured by the frame and electronics yoke, and keeper 11 captures both rear guides. Install the rear guides and keeper before the charger. The two short guides are identical.

This is a packaging and slicing update; CAD geometry is unchanged. Printed fit and optical clarity still depend on the actual spool and printer calibration. No print job was sent.
