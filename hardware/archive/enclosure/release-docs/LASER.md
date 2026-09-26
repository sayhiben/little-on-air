# Acrylic and LightBurn — Nova Plus 24, 60 W RF

Use `laser/02-acrylic-REAR-engrave-and-cut.svg` for the production panel. It is **104 × 38 mm**, with outlined text and a keyed outline. It contains no machine power or speed preset and no kerf compensation. Its rear engraving and key are already mirrored.

The machine for this project is the Thunder Nova Plus 24 with the 60 W RF source. Use its verified installed device profile, lens, focus and air-assist procedure. Do not substitute a glass-tube Nova's power/speed table or change controller frequency settings for this job. [Thunder Nova Plus RF manual](https://support.thunderlaserusa.com/portal/en/kb/articles/thunder-laser-nova-plus-rf-machine-user-manual).

## Stock and fit

Use confirmed clear PMMA acrylic; cast material generally produces a frosted engraved target. Verify the sheet and masking are suitable for the laser. Measure the nominal 1/8-inch stock at its corners and middle; nominal thickness is 3.175 mm, not exactly 3.0 mm.

The existing stack accommodates approximately **3.00–3.45 mm** using measured rear shims and cushioning. Calculate the remaining gap behind the printed backing as:

`rear cushion gap = 0.45 − (measured acrylic thickness − 3.175) mm`

| Measured acrylic | Available rear gap |
| --- | --- |
| 3.00 mm | 0.625 mm |
| 3.175 mm | 0.450 mm |
| 3.45 mm | 0.175 mm |

Use thin nonconductive shims and a compliant layer at the intended retainer contacts to fill this gap without bowing the panel. Outside that thickness range, revise the stack instead of forcing it. Register the acrylic and backing against the common left/bottom datums. Leave the opposite-edge clearance for fit and expansion; do not glue all four edges rigidly.

The white printed letters face the engraved rear acrylic surface across approximately **0.5 mm of air**. They are a separate contrast/illumination backing, not an inlay into engraved pockets. Keep the clear face and the air gap free of adhesive. The hidden printed registration pads extend farther than the white letters; their exposed sides may be blackened if visible at an angle.

## Calibrate on scrap from the same sheet

1. Import [91 kerf coupon](../laser/calibration/91-kerf-plug-and-frame-CUT.svg) at **40 × 30 mm**, without compensation. Cut its nominal 20 × 20 inner square before the outer outline. Measure the loose plug P and opening H in both axes and at both faces. Estimate full kerf as `(H − P) / 2`. Compare `20 − P` and `H − 20` to identify taper or measurement error.
2. For the production **outside** outline, move the cutting path outward by **half that full kerf**. Verify the resulting geometry in Preview; LightBurn's kerf controls and a manual path offset are alternatives, not adjustments to stack together. Keep text at 100% scale with no offset. [LightBurn kerf guide](https://docs.lightburnsoftware.com/latest/Guides/Test-KerfOffset/).
3. Use the [90 fit strip](../laser/calibration/90-fit-strip-CUT-ONLY.svg), **31 × 6 mm**, to check the sheet edge in the actual frame/retainer stack. It does not replace the full panel's registration check.
4. Use [92 engraving samples](../laser/calibration/92-engraving-quality-nine-samples-FILL.svg) with the rear face up. Start from a proven RF acrylic engraving setting. Compare line intervals **0.10, 0.125 and 0.15 mm** across columns and modestly lower/base/higher energy down rows. Record which colored sample receives each setting. These are calibration choices, not an established machine recipe.
5. Aim for a shallow, even frosted engraving, roughly **0.05–0.15 mm deep**, without ridges, cracks or a melted lip. This is a target to evaluate on scrap, not a depth guaranteed by a power percentage. Choose the least aggressive setting that gives useful scattering. Record speed, minimum/maximum power, interval, focus, lens, air and passes in [COMMISSIONING.csv](COMMISSIONING.csv).

## Make the panel

1. Import the [production SVG](../laser/02-acrylic-REAR-engrave-and-cut.svg) at exactly **104 × 38 mm**. Keep the intended rear face toward the laser. **Do not mirror again.**
2. Assign **blue to Fill** for the lettering and **red to Line** for the outside cut. Engrave first, cut last. Apply only the tested outline compensation; avoid duplicate outline passes.
3. Preview the job: letter counters should remain unengraved, the text should appear reversed before cutting, and the cut outline should run once. Use your confirmed RF device and successful scrap settings.
4. After cutting, flip the panel left-to-right. ON AIR should read normally from the front and the clipped corner should be upper left. Clean the panel according to the acrylic supplier's guidance. Keep all four LED entry edges smooth and free of frosting, glue or masking residue.
5. Dry-fit with backing 03 in the common datums, check lettering registration, then fit cushioning and retainer 04 according to the assembly guide.

`laser/02-acrylic-REVIEW-ONLY.lbrn2` is supplied for inspecting layer order and geometry. Its layer outputs are disabled and all powers are zero. Its saved device name and remaining speed/interval fields are historical placeholders, not a validated RF machine setup. Importing the SVG into your verified current device is the preferred route.

## Optional laminate alternative

The selected build uses the printed black-and-white backing. Only if substituting a measured **1.6 mm, laser-safe black-over-white laminate**, use the separate unmirrored artwork and **both** spacer rings under [alternatives/laminate](../alternatives/laminate/README.md). Do not install those rings with the printed backing or cut the laminate artwork as the acrylic panel.
