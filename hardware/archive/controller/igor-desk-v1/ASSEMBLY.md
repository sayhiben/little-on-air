# Print and assemble the Igor desk controller

## 1. Match the parts before the long print

Use the standard XIAO ESP32-S3, an Igor-compatible KY-040 and a **0.96 inch,
128 × 64 SSD1306 I2C module**. Igor's faceplate is preserved at its original size:
its window throat is 24 × 13 mm and its four mounting centers are spaced
21.2 × 23 mm. The compatible small OLED family has a roughly 27 × 27 mm PCB.
The controller IC name alone does not identify a mechanical fit.

First print the faceplate and try the actual OLED. Check that its glass clears
the posts, the active image is centered in the opening, and rear components
and wires do not bear on the glass. Use the original faceplate retention fit;
if necessary, small neutral-cure silicone dots at the PCB edges hold it in
place. Keep adhesive off the glass and connector pads. Check the hat on the
actual encoder shaft separately, without forcing the key.

Measure the chosen single-pixel carrier: **10 × 10 mm, 1.6 mm PCB thickness,
centered 5 × 5 mm emitter up to 1.6 mm tall**. Larger round NeoPixel boards need
a different carrier slot. Wires leave the back of this board; header pins or
a plug on the carrier will not fit.

For the example 80 g ballast, select sixteen steel 5 g adhesive segments, each
no larger than **19 × 11.5 × 4 mm including tape**. The pocket is a dimensional
specification, not a promise that every wheel-weight product fits. Shorter
segments work; clip-on weights are not the intended form.

## 2. Print

All STL coordinates are millimetres. Import at **100% scale** and preserve
their supplied orientation. Use a 0.4 mm nozzle and the actual filament's
temperature/flow settings. The included X1C profiles use the existing project
PLA+ and clear-PETG material presets.

| Project | Parts | Settings | Measured slicer estimate |
| --- | --- | --- | --- |
| PLA body | Shell, hat, bottom cover | 0.20 mm; 4 walls; 25% gyroid | 5 h 12 min / 97.25 g, including support |
| PLA faceplate | Faceplate | 0.20 mm; 4 walls; 25% gyroid | 19 min / 3.31 g |
| Clear PETG | Diffuser | 0.12 mm; 3 walls; 100% fill | 12 min / 0.42 g, including startup |

The **shell prints front down**, with normal snug supports enabled throughout
the part, including interior areas. Remove them through the open front and
the underside service opening. The ballast compartment and LED slot must be
fully cleared before assembly. Do not change to build-plate-only support:
the cavity can need support beginning on printed surfaces. Supports cannot
remain in the weight pocket or on the XIAO pedestal.

The faceplate prints front down, the hat with its shaft socket down, the cover
with its outside face down, and the diffuser with its small front end down.
These four parts use no automatic supports. The short overhang around the
diffuser's collar is intentional. Remove the brim without reducing the
collar. Try the clear lens before choosing a final brightness; printed clear
PETG will diffuse light and will not behave like polished optical plastic.

The plate layout and exact STL identities are recorded with the slicer
results. No job has been uploaded to a printer. Slicer success verifies toolpath
generation, not physical print quality or component fit.

## 3. Prepare the shell and cover

1. Remove all support and brim. Check the faceplate seam, encoder hole, USB
   opening, board pedestal, LED slot, wire passage and all four screw holes.
2. Test the bottom cover dry. It has **0.3 mm clearance per side**, seats on
   its outer ledge, and is flush with the base. Its small inner tongue belongs
   at the **front**, below the LED board. It is not a snap fit.
3. Install four **M3 × 4 mm heat-set inserts, nominal 4.2 mm outside diameter**,
   into the four 4.0 mm pilot holes from below. Test the insert/material
   combination on scrap first. Set the insert mouths flush with the internal
   cover-bearing surface, not the outer bottom face. Allow them to cool fully.
4. Use four **M3 × 8 mm countersunk screws**, length measured including the
   head. The 90° countersinks accept heads up to 6.2 mm. Do not use a longer
   screw to compensate for an incorrectly seated insert.

## 4. Bench-wire the electronics

Follow [WIRING.md](WIRING.md). Keep USB unplugged while soldering. Direct-solder
the XIAO and modules without headers, and insulate exposed joints. Include
the 5 V AHCT buffer, 330 Ω data resistor and decoupling capacitors.

The display and encoder use **3.3 V**, while the pixel and buffer use **USB 5 V**.
Preserve common ground. The pixel's `DIN` is the input; its `DOUT` is unused.
Do not load the old nRF52840 UF2 onto the ESP32-S3. Firmware status and the
required bench tests are in [FIRMWARE.md](FIRMWARE.md).

Keep service loops modest: approximately 60–80 mm of wire from the XIAO to
the front components is a starting allowance, then trim to the actual route.
These are assembly allowances, not prevalidated cut lengths. Before soldering
the final ends, check the path with the components in the case.

## 5. Fit the upper electronics

1. Attach the included **external antenna** to the XIAO's U.FL socket before
   burying the board. Place the flexible antenna along the upper right plastic
   wall, clear of the encoder and display metal. Keep it out of the weight
   compartment. Confirm radio range after assembly.
2. Put **0.3 mm insulating double-sided mounting tape** on the central XIAO
   pedestal, at most 13 × 17 mm. Solder the board pads from the upper side and
   keep the underside clear so it can sit on this pad.
3. With the faceplate and encoder still out, bring the board in through the
   front, **about 2 mm above its final position**, USB socket toward the rear.
   Slide it back and lower it onto the pedestal. The checked insertion motion
   clears the forward stop. The socket is about **1.6 mm recessed** from the
   rear outer plane. Use a USB plug whose overmould is at most **12 × 7 mm**.
4. Check the USB cable inserts fully without levering the PCB. The printed
   forward stop supports insertion; the tape resists lift and withdrawal.
   Add a relaxed cable loop on the desk rather than letting the cable pull
   sideways on the case.
5. Secure the insulated shifter assembly to the upper left inside wall with
   thin tape. Keep its completed size within **18 × 12 × 4 mm** and place it
   forward of the XIAO. Put the small bulk capacitor above the front floor,
   toward the right; sleeve both leads. Keep electronics out of the weight bay.
6. Fit the KY-040 through Igor's original encoder hole and use its supplied
   washer and nut. Orient its connector toward the open front as space allows.
   Keep wire loops clear of the moving shaft. Fit the hat with a visible gap
   above the shell (nominal 0.6 mm); increase the gap if required for the
   actual encoder's full push travel. It must rotate, click and release freely.
7. Route the display wires, then install the OLED faceplate. Route wires along
   the side walls so the faceplate rim seats without crushing a wire.

## 6. Install the front pixel

1. Feed the pixel's three wires from the underside LED bay up the **3.2 mm
   vertical passage** into the upper electronics bay. Keep the data resistor
   in the upper bay just above this passage; only insulated wires pass through.
2. Insert the diffuser from inside the front bay, small end toward the front
   hole. Its 6.8 mm collar remains inside and prevents it pulling outward.
3. Slide the wired **10 × 10 mm** pixel PCB upward from below into the narrow
   guide slot, LED facing the diffuser. Seat the top edge against the stop.
   The PCB has nominal 0.2 mm side clearance and 0.2 mm depth clearance. Keep
   solder bumps and wires in the wider rear wire bay.
4. The PCB stops the diffuser withdrawing inward, and the cover's tongue
   stops the PCB sliding downward. Retention becomes complete only when the
   cover is installed. No adhesive is required for the lens or pixel.

## 7. Add ballast and close

Lay out the segments on the **inside of the removable cover**, within its
40 × 48 mm recessed center. Use two 19 mm-wide columns and four rows of
segments no longer than 11.5 mm. Repeat as a second layer if using all 80 g.
Keep every piece inside the rectangular recess and clear of the LED tongue,
screw holes and cover-bearing ledge.

The two layers occupy up to 8 mm including their tape, leaving **2 mm** for
clearance and a lightly compressed anti-rattle pad. Adhesive retains each
segment; a thin foam pad prevents movement if the adhesive ages. The total
weights, tape and compressed pad must not exceed the **10 mm** pocket height.
The rigid printed roof separates the metal weights from the electronics.

Lift the cover into place and tighten the four screws just until seated. If
the cover bows or will not sit flush, reopen it and correct the packing.
Fit four Ø8 mm rubber feet approximately at **X=±16 mm, Y=13 and 54 mm**,
measured from the enclosure centerline and front. These positions clear the
screws, so the cover remains serviceable.

## First-prototype acceptance

- Cover flush, all four feet touch the desk, no rattle when lifted.
- Weight pocket, LED bay and upper electronics remain separated; no loose
  metal or exposed conductor can migrate between them.
- USB plug seats and releases without PCB movement; no solder joint rubs a wall.
- Display centered; hat turns, presses and releases without touching the shell.
- Turn and press one-handed on the intended desk; check sliding and tipping
  with the actual weights, feet, encoder force and cable arrangement.
- After the ESP32 firmware port, verify all four states, exact acknowledgments,
  receiver disconnect/recovery, USB restart, LED colors and BLE range with
  ballast installed. Record results before calling this a tested hardware build.
