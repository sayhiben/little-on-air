# Bambu Studio — current three-plate project

Open [on-air-v216-X1C-all-plates.3mf](../bambu-studio/on-air-v216-X1C-all-plates.3mf) **as a project**, keeping its settings. It targets the **Bambu X1 Carbon, 0.4 mm nozzle and textured PEI plate**. This release changes 05 rear housing and 06 electronics yoke for rearward LED wiring. The v2.15 plate positions, all other meshes, insert painting and material settings are preserved. All ten required pieces are present.

| Plate | Contents | Material | Slicer estimate |
| --- | --- | --- | --- |
| 1 | 01 frame, 05 housing, 04 optical retainer, 06 electronics yoke, 07 reset button, 11 rear guide keeper | Black PLA+ | 5 h 08 min / 65.11 g |
| 2 | 03 registered backing | Black and white PLA+ | 1 h 16 min / 10.15 g |
| 3 | 08 front guide and two identical 09 rear guides | Transparent PETG | 13 min / 0.55 g |

Total: approximately **6 h 37 min / 75.81 g**, excluding plate changes. The acrylic is laser-cut separately. There is exactly one keeper 11; the second rear guide is the second copy of STL 09, not an extra keeper.

## Map the filaments

1. **Black PLA+** — previous eSUN PLA+ baseline: 220 °C nozzle, 55 °C textured bed.
2. **White PLA+** — the same PLA+ profile as black, with white color assigned. The PETG assignment from the edited working file has been corrected.
3. **Transparent PETG** — optical profile: 255 °C nozzle, 70 °C textured bed, low part cooling and auxiliary fan off. The generic PETG assignment from the working file has been replaced with the earlier optical profile.

These numbers identify project filaments, not mandatory physical AMS bays. Map them to the actual loaded spools when sending each plate. Match temperatures and calibrated flow to your actual material. If changing a filament profile, re-slice and keep the guide objects' optical settings and low cooling.

The black/white insert uses your mesh painting. Sliced paths remain black through the **1.60 mm base**, with the first white layer at **Z = 1.70 mm**. Letter tops finish at 2.0 mm; the upper registration pads finish at 2.5 mm and are also white. The plate makes one automatic filament change. Its prime tower and **700 mm³ black-to-white flush** are included. Do not add a second manual color change over the painting. The insert's object-level filament can display white while the painted base still slices black; use Preview to inspect the actual paths.

## Settings and handling

- Main structure: 0.20 mm layers, four walls. Housings use 25% gyroid; the optical retainer and yoke use solid infill.
- Reset button and insert: 0.10 mm layers. The insert retains your slower 12 mm/s top-surface setting.
- Guides: lying on their continuous flats, long axes along bed X; 0.10 mm layers, one wall, 100% aligned fill, up to 20 mm/s extrusion, no brim or support. Do not rotate their axes away from the fill direction.
- Automatic support is confined to **07 reset button and 11 rear guide keeper** on plate 1. Parts 05 and 06 need no support; their new wire reliefs are open and have no added roof spans. Existing small hardware overhangs remain.
- The compact arrangement has some approximately 2 mm part-to-part gaps. Brims can join; cut connecting brim material after cooling instead of pulling neighboring parts apart.

For keeper 11, support the rigid printed body on the bench while clipping the support away in small sections. Work along the supported underside and avoid levering against the open arm, retaining shoulders or thin edge. Stop and inspect if removal begins bending the keeper. The keeper geometry is unchanged by this packaging update; its fit depends on those retaining surfaces remaining intact.

The first-layer height/speeds and acceleration are shared project settings: **0.10 mm first layer at 15 mm/s**, 1000 mm/s² default acceleration and 500 mm/s² outer-wall acceleration. These retain the optical requirements; main structural layers after the first remain 0.20 mm. Bambu's configuration separates these project settings from [object settings](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PrintConfig.hpp).

**First-layer inspection remains disabled** for the prior timeout workaround. Bed leveling and end-of-print heater shutdown remain enabled. No manual pause commands were added.

## Verification

All three plates were sliced with the installed Bambu Studio without slicer warnings. The ten placed pieces match the latest nine unique STLs, allowing your rotations within the bed plane. The unchanged insert mesh painting is preserved byte-for-byte and still slices with one color change. Checks confirmed one keeper, correct filament assignments, support locations, heater shutdown, and **332 long guide fill runs parallel to their axes**. The two new parts match their exported STLs and have no roof bridges across the new wire reliefs. See [printing validation](../validation/printing.json).

The original edited project remains preserved in the development archive outside this release. The release file is the corrected, re-sliced copy. Follow the [assembly guide](BUILD-AND-ASSEMBLY.md) after printing; the finished enclosure uses nine M3×8 button-head screws and nine M3 nuts. No print job was sent.


## Existing-build upgrade: housing and yoke

Use [on-air-v216-X1C-upgrade-parts.3mf](../bambu-studio/on-air-v216-X1C-upgrade-parts.3mf): **05 rear housing + 06 electronics yoke**, approximately **3 h 06 min / 40.51 g**, black PLA+ only. Both are oriented on their original flat print planes and use no supports. Filament slots 2/3 are unused in this two-object file. Follow [the rearward wiring guide](FRONT-WIRING.md); reuse the existing frame, optics, reset and light guides. There is no need to re-cut the acrylic.
