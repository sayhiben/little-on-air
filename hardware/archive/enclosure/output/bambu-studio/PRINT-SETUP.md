# Little ON AIR — Bambu Studio print setup

Open `little-on-air-X1C-PETG-AMS-ready.3mf` as a project. It contains all nine case parts and three fit samples, already oriented and separated across four plates. Bambu Studio was left open with the project sliced. When reopening the editable project, use **Slice all** to regenerate its previews.

The setup uses the printer selected in Bambu Studio: **Bambu Lab X1 Carbon, 0.4 mm standard nozzle, Textured PEI Plate**. Material is **Generic PETG**: filament 1 black and filament 2 white. Select the matching physical spools when sending a print. Nothing has been sent to the printer.

| Plate | Contents | Final Bambu Studio estimate |
|---|---|---:|
| 1 — Fit samples first | M3 head/nut, LED/acrylic, reset guide coupons | 33 min |
| 2 — Body and back | Integrated front frame/body and backplate | 3 h 10 min |
| 3 — Carrier and controls | Electronics tray, three keepers, reset plunger, power slider | 1 h 20 min |
| 4 — Black and white backing | Black backing with raised white ON AIR lettering | 35 min |

Total: approximately **5 h 38 min and 94.6 g PETG**, including coupons, supports, brim, purge and tower. These are estimates from Bambu Studio 2.8.2.61.

## Saved slicing settings

- 0.20 mm layers and first layer; four walls; five top and bottom layers.
- Arachne wall generation; 25% gyroid infill for the body, back and carrier; 100% infill for the backing, controls, keepers and coupons.
- Outer walls 60 mm/s, inner walls 100 mm/s, top surfaces 45 mm/s, bridges 25 mm/s, first layer 25 mm/s.
- Native Generic PETG temperatures: 255 °C nozzle and 70 °C textured bed.
- Normal snug supports on the body, carrier, reset plunger and power slider. Supports can start on model surfaces; 0.20 mm contact gap, three interface layers and 0.35 mm XY gap.
- Supports disabled on the backplate so the short nut-slot roofs bridge without filling the captive pockets. Keepers and coupons also have supports disabled.
- 3 mm outer brims on the body, back, carrier, plunger and slider; 2 mm on the keepers.

## Backing color change

The AMS project prints layers 1–8 in black, through 1.60 mm, then changes once to white for layers 9–10 at 1.80 and 2.00 mm. A prime tower is placed clear of the backing. Black-to-white purge is 700 mm³; flushing into the model is disabled. Toolpaths were checked to confirm only the raised lettering prints in white.

`little-on-air-X1C-PETG-manual-swap-ready.3mf` is the alternate project for manual filament loading. Plate 4 pauses before layer 9, after completing the black 1.60 mm backing. Load white PETG, purge until clean white, and resume. Its preview uses one assigned filament; the physical color changes at the pause. The other plates use black throughout. The manual pause was verified in the generated toolpath at layer 9 of 10.

## Printing and assembly

Print plate 1 first and check the actual M3 hardware, LED/acrylic fit and reset guide. The case and small controls have not yet been physically test-printed. The three fit samples are optional checks and are not assembly parts.

Remove the carrier's supports beneath the partition and latches, and carefully clear support and brim from the plunger and slider before checking movement. Leave the supplied orientations in place: case front against the bed, backplate wall face against the bed, backing flat black face against the bed, and the controls in their prepared orientations.

The laser acrylic SVG is included separately at `acrylic/02-acrylic-rear-engrave-and-cut.svg`. Its engraving is already mirrored for the rear face; do not mirror it again. Full assembly instructions are in `ASSEMBLY.md`.

## Double-check results

Both ready projects were checked against all twelve original print meshes: each mesh is a single closed solid, at the original millimetre scale and bed orientation. Parts and their brim allowances fit the plates without overlap. A fresh Fusion check found no unhealthy features or modeled interference, including the battery, board, switch and fastener reference envelopes.

The acrylic cut outline matches the backing exactly. The rear-mirrored engraving follows the same letter placement; sampled contour differences between the laser curve approximation and STL are below 0.09 mm. The model uses 3.175 mm acrylic; measure the actual sheet before cutting.

Fresh slices contain no reported slicing warnings. The AMS toolpath uses black at every model layer through 1.60 mm and white only at 1.80 and 2.00 mm. The manual toolpath has exactly one pause before layer 9. See `audit/independent-audit.json` for the detailed checks. Physical hardware fits, button travel and switch throw remain prototype acceptance checks.
