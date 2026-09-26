# Little ON AIR v2 — fabrication and assembly

Use this v2 folder as a complete set. The earlier v1 carrier, separate board keepers and rear plate do not belong in this assembly.

The case body is **120 × 60 × 34 mm**. The reset button projects about 0.6 mm from the right side; the power grip projects 1.4 mm from the top. The wall face is flat and closed for removable adhesive strips.

## What to make

Print one of each of the **seven files in `stl/`**. The numbered gap is intentional: part 02 is the laser-cut acrylic.

| Part | Purpose | Supplied bed orientation |
|---|---|---|
| 01 Front optical bezel | Window, four LED seats, common panel datums and front screw recesses | Front face down |
| 03 Registered graphic backing | Black substrate, white lettering and hidden acrylic spacing pads | Flat back down, lettering up |
| 04 Optical retainer | Holds the optical stack and the four LED modules | Flat rear face down, LED pads up |
| 05 Rear electronics housing | Flat wall back, battery cradle, board and switch nests, recessed nuts | Wall face down |
| 06 Electronics retaining yoke | Restrains the boards and switch; closes assembly notches at ports and reset button | Broad front face down, feet and port caps up |
| 07 Captive reset plunger | Flat-sided tee with captive flange | Broad flat side down |
| 08 Captive power slider | Captive grip with a fork for the DPDT actuator | Small fork end down, expanding shoulder up |

All STL files use millimeters and rest on Z=0. Import at 100% scale. Keep these orientations.

## Bambu Studio

Open `bambu-studio/on-air-v2-X1C-PETG-AMS.3mf` for an AMS black-to-white change, or the `manual-swap` version for a pause and hand-loaded white filament. Use one version, not both.

The projects target the existing **X1 Carbon, 0.4 mm nozzle, textured PEI and Generic PETG** setup. They contain three named plates: (1) bezel and rear housing, (2) retainers and controls, (3) graphic. Hardware fit samples have their own `fit-checks` project.

Structural settings are 0.20 mm layers, four walls, five top/bottom layers, 25% gyroid infill, 60 mm/s outer walls and 25 mm/s bridges. Small parts and the graphic are solid. Brims are included; supports are off. Mounts grow from the rear floor, and port roofs grow from the yoke's flat print face. Short internal bridges remain over nut-loading pockets.

The graphic uses **0.10 mm layers after its 0.20 mm first layer**. The first 1.6 mm is black; white starts with the layer ending at **Z=1.7 mm**. Letters end at 2.0 mm; hidden white spacing pads continue to 2.5 mm. The AMS version contains one color change. The manual version pauses before that first white layer. An STL alone carries neither colors nor a pause.

The settings are an FDM starting profile, not a substitute for your filament calibration. Remove brim and first-layer bulges from mating edges before assessing fit.

## LightBurn and acrylic

Use `laser/02-acrylic-REAR-engrave-and-cut.svg` at **104 × 38 mm**. Nominal stock is **3.175 mm / 1/8 inch** clear acrylic. The Amazon description does not establish the actual thickness.

Place the eventual rear face upward. The file already mirrors both the lettering and the keyed corner. **Do not mirror again.** In LightBurn, set blue to **Fill** and engrave first; set red to **Line** and cut the single outside contour last. All text is closed vector paths; no font installation is needed. The file contains no kerf compensation. Apply compensation once, based on a cut test on the actual sheet.

After cutting, flip the panel left-to-right. The text reads normally through the front, and its clipped corner is at the upper left. Keep the four LED entry regions along the long edges clean and smooth. Put the LEDs' emitting faces toward those edges. Leave the broad clear faces separated from the backing.

LightBurn's Fill and Line modes are defined in its [Cuts / Layers documentation](https://docs.lightburnsoftware.com/latest/Reference/CutsLayersWindow/). The SVG separates operations; laser power, speed, passes and focus must come from a test for the actual laser and sheet. No machine-specific laser job is included.

## Optical registration

Both optical parts are 104 × 38 mm and use exactly the same text outlines. Seat both against the bezel's **left and bottom datums**, viewed from the front. Use thin compliant edge pads in the 0.5 mm spaces at the opposite edges to keep them seated without forcing the acrylic.

The black substrate is 1.6 mm thick; lettering relief is 0.4 mm. Integral hidden edge pads project 0.9 mm from the black face, establishing **0.5 mm between the white letter tips and the acrylic rear face**. The optical retainer has a nominal 0.2 mm allowance behind the backing for thin compliant strips. Clamp gently against the hard screw seats. The pads must not press on engraved letters or bow the panel.

Measure the sheet before clamping. A thinner sheet needs a correspondingly thicker compliant strip behind the backing; a thicker sheet consumes the 0.2 mm allowance. A sheet that prevents the retainer from reaching its seats requires an adjusted CAD stack, not extra screw force. LED emitter height is modeled at the nominal acrylic midplane and remains a physical fit check.

An optional finish uses **laser-safe, 1.6 mm black-over-white engraving laminate**. Use the unmirrored `03-optional-laminate-FRONT-engrave-and-cut.svg`, plus both rings in `optional-laminate/`: 81 goes between acrylic and laminate; 82 goes behind the laminate. Print those rings at 0.10 mm layers. Omit the printed graphic when using this option. Do not laser engrave ordinary FDM plastic as a substitute for laser-rated laminate.

The one-change print also makes the spacing pads white. They are hidden head-on but can appear at the window edge from an oblique angle. Blacken their visible side faces with an opaque black paint marker before assembly if needed; keep paint and adhesive off the acrylic's clear faces and LED entry edges.

## Fasteners and other assembly materials

| Item | Quantity | Where it goes |
|---|---:|---|
| M3 × 25 socket-head screws | 4 | From the front bezel into rear-housing nuts |
| M3 × 6 button-head screws | 2 | Optical retainer, inserted from its rear |
| M3 × 8 button-head screws | 2 | Electronics yoke, inserted from its front |
| Standard M3 nuts, about 5.5 mm across flats × 2.4 mm thick | 8 | Side-loaded hex pockets |
| Thin compliant strips / insulating pads | As needed | Optical preload and battery bed |
| Narrow nonconductive battery strap | 1 | Through the raised strap lugs; leave the pouch uncompressed |
| Removable wall adhesive strips | As needed | Flat external rear face |

The closure screws **do engage the rear housing**. Each rear boss contains a side-loaded nut. A screw bears at depth 3.2 mm from the front, passes through the bezel, then threads through that nut. Its tip ends at depth 28.2 mm, inside a blind bore ending at 29.2 mm. The rear surface is at 34 mm. Heads, nuts and tips remain inside the case.

## Assembly order

1. Fit the eight nuts before installing hardware. The four closure nuts and two yoke nuts enter the rear housing sideways; two optical nuts enter the front bezel. Check each screw threads freely.
2. In the front bezel, place four LEDs in their seats, two above and two below the display, with emitters aimed inward. Route soldered leads sideways along the edge. Nominal module size is 8 × 8 × 2 mm and nominal edge clearance is 0.2 mm.
3. Insert the keyed acrylic, then the graphic with its white letters facing the acrylic. Seat both against the common datums. Add the edge pads and thin rear compliant strips. Install the optical retainer with two M3 × 6 button-head screws. Its four fingers hold the LEDs with room for a thin cushion.
4. Lay the rear housing wall face down. Drop the charger and XIAO into their fixed nests from the open front. Their USB receptacles pass through the open assembly notches. The XIAO is mounted on edge, with USB at the top and reset facing right.
5. Drop the reset plunger into the side guide from the front after the XIAO is seated. Place the power slider through its top assembly notch, and lower the DPDT into its nest with its actuator in the slider fork. The six terminals point into the solder bay below the switch body.
6. Place and wire the battery, modules and LEDs. The battery envelope is 52 × 21 × 10 mm inside a 54 × 23 mm cradle. Use an insulating pad and a loose nonconductive strap. Keep solder joints and wires clear of the yoke feet, switch movement, screw bosses and case seam.
7. Fit the retaining yoke using two M3 × 8 button-head screws. Its feet prevent board and switch lift-out; its caps close the USB and control assembly notches. Check full USB cable seating, reset return and both DPDT detents before closing the front.
8. Mate the front optical assembly to the rear housing using the locating tongues. Install the four M3 × 25 front screws, tightening evenly until the case seats. Apply the wall strips to the flat back after the assembled sign has been tested.

## What still needs a physical fit check

The DPDT actuator is confirmed as **1.42 × 1.42 × 1.83 mm**, with a 4 mm full slot and approximately **2.58 mm travel**. Its case is 8.6 × 3.1 × 2.7 mm. The slider provides clearance across both positions.

The charger footprint remains **16.5 × 25 mm, 1 mm PCB**, with a provisional USB/component envelope. The [Seeed XIAO nRF52840](https://wiki.seeedstudio.com/XIAO_BLE/) footprint is 21 × 17.8 mm; its actual populated height, reset location and cable overmold still need checking against your board. The reset design allows 0.2 mm initial free play and 0.3 mm actuation before the stop; tune it to the physical switch if necessary.

The fit project uses clipped production sections, not simplified substitute holes. Pair 90 and 91 to check the real front-to-rear screw path. Use 92 for the charger, 93 with the actual reset plunger for XIAO access, and 94 with the power slider for the DPDT. Sections 95, 96 and 97 reproduce the lower optical edge around an LED and an optical screw: use a 31 × 6 mm scrap strip from the actual acrylic sheet at the section's panel position. They test the nominal optical stack and its clamping allowance. Small samples do not establish full-panel flatness or brightness uniformity.

Digital checks establish mesh integrity, modeled clearances, matching artwork and sliced toolpaths. Actual soldering, hardware tolerances, reset force, fit, light uniformity and finished appearance have not been physically tested.
