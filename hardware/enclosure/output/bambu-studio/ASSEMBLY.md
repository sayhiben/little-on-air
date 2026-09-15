# Little On Air assembly

This is a **first-fit prototype**, not a dimensionally verified production
enclosure. Physical board heights, soldering envelopes, reset position/travel,
switch throw, and LED emitter alignment still need confirmation. Named Fusion
parameters identify these measurements. The native timeline supports editing
individual sketches and features; changes to the overall layout should be made
in the builder and regenerated so all component positions stay coordinated.

## Parts and materials

| Component | Process | Notes |
| --- | --- | --- |
| 01 Body and front frame | Black PETG | Integrated bezel, LED pockets, four front M3 recesses, top USB openings |
| 02 Engraved acrylic | Clear acrylic, CO2 laser | Nominal 3.175 mm; cut and reverse-engrave the supplied artwork |
| 03 Black and white backing | Black then white PETG | Back down; change filament at 1.6 mm; white lettering is 0.4 mm tall |
| 04 Optical and electronics tray | PETG | Three side latches, LED retaining fingers, battery cradle, board and switch mounts |
| 05 Charger keeper | PETG | U clip with locating legs; back ribs prevent withdrawal |
| 06 XIAO keeper | PETG | Side-inserted fork; case stop prevents withdrawal |
| 07 Captive reset plunger | PETG | Insert from inside before fitting the board |
| 08 Captive power slider | PETG | Insert from inside and engage the DPDT actuator |
| 09 Switch keeper | PETG | Removable terminal-access cover, captured by the back |
| 10 Wall back plate | Black PETG | Flat adhesive surface; internal nut bosses and keeper ribs |

Use a 0.4 mm nozzle and 0.2 mm layers as the starting print setup. Use four
perimeters on structural parts and solid small clips. Inspect the slicer for
bridges, support beneath overhangs, and thin features. Remove support from mating
surfaces before checking fit. The mesh package places parts on Z=0 and includes
recommended print orientations; do not apply those transforms to laser artwork.
The individual-part 3MF exports contain geometry only. The Bambu Studio ready
projects in this bundle include the printer profile, supports, and the black-to-white
change or manual pause after the 1.6 mm backing. Use `PRINT-SETUP.md` for those projects.

The upper-right fastener is at X=96, Y=54 mm, moved inward to clear the XIAO.
The other fasteners are at (6,6), (114,6), and (6,54) mm, measured from the lower-left
front corner. Hardware heads are recessed by 0.2 mm, and screw tips have 0.5 mm
clearance above a 1.3 mm rear skin. Reference bolts have simplified unthreaded shafts.

Hardware: four M3 x 25 mm socket-head screws and four ordinary M3 hex nuts,
removable adhesive mounting strips, a thin nonconductive battery strap, and thin
perimeter/LED cushioning pads. Confirm the actual screw head and nut dimensions
against the fit coupon before printing the full body.

## Optical stack and artwork

The 100 x 34 mm window exposes a 104 x 38 mm keyed acrylic panel. A chamfered
upper-left corner, viewed from the front, identifies the correct orientation.
The backing uses the same outline. A nominal 0.5 mm air gap separates the rear
engraving from the raised white letters. Do not glue the clear viewing faces
together or coat the light-entry edges.

The two upper and two lower LED modules point into the long acrylic edges.
Their emitting-window centres must align to the middle of the measured acrylic
thickness. The supplied 2 mm module thickness does not determine emitter height;
the current model assumes a 1 mm optical offset from the module's front face.

Use the **rear-face** laser file as supplied: the text and the asymmetric cut
outline are mirrored together. The separate front-view artwork is for alignment
and inspection. Engrave only the text layer; cut only the outline layer. Run an
engraving/edge-coupling sample with the actual acrylic before the full panel.

## Assembly and servicing

1. Solder and insulate the LED leads, with the emitting faces kept clean. Lay the
   four modules into the body pockets; route wires beside the modules.
2. Insert the acrylic from the rear, engraving facing inward. Insert the backing
   with the white lettering toward the acrylic, matching the keyed corner.
3. Install the XIAO and its fork keeper on the loose tray. Insert the reset
   plunger into the body from inside before fitting this tray assembly.
4. Fit the tray assembly, positioning the fork behind the case's withdrawal
   stop. Confirm all three side latches engage and the LED fingers contact
   cushioning pads without bending the LED boards. Verify the reset has no
   preload and adjust its contact tip before repeated presses.
5. Fit the charger and its U keeper. Check both actual USB cables can seat fully
   without moving the boards.
6. Fit the top slider, engage the DPDT actuator, and fit the switch keeper.
   Check both detents and adequate clearance for the six soldered terminals.
7. Install the battery and loose nonconductive strap. Keep solder joints, wire
   ends, and screws clear of the pouch; leave room at the battery lead exit.
8. Load the M3 nuts into the back's internal pockets. Check the internal ribs
   align behind the charger and switch keepers, leaving their small running
   gaps. Fit the back and tighten the four front screws gently until the
   compression posts meet.
9. Apply removable adhesive strips to the flat back, keeping removal tabs
   accessible after the body is detached. Remove the front screws to service
   the sign while the back remains on the wall.

Release the tray before removing the XIAO fork. The charger and switch keepers
can be lifted out after removing the back; their legs locate them while the back
ribs provide positive retention during use. Keep wiring out of the rib paths.

## Measurements and physical acceptance

- Measure actual acrylic thickness (3 mm and 1/8 inch are different).
- Verify each separated LED module including solder fillets and emitter height.
- Verify the charger PCB thickness, underside, components, and USB overhang.
- Verify the XIAO reset centre, actuation direction, safe travel, and bare PCB
  support locations. The reference model is an envelope, not a manufacturer STEP.
- Measure DPDT throw separately from the 1.4 mm actuator height. Tune the slider
  slot and socket if necessary. The six legs have a nominal 3 mm trimmed envelope;
  allow additional space for the actual soldered/insulated assembly.
- Verify mating clearances with small samples before full printing. Start at
  0.25 mm per side; keeper legs and slots require printer-specific adjustment.
- Verify letters are aligned and the four LEDs illuminate red/yellow/green
  acceptably, without strong glare or isolated hotspots.
- Test repeated USB insertion, single and double reset presses, switch operation,
  cable bend clearance against the wall, closed-case charging temperature, and
  BLE operation using the intended electrical circuit.

Firmware and the power circuit are unchanged. The mechanical model does not
validate charger selection, charge current, or isolation between the two USB
power paths.



