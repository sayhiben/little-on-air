# Assemble the corrected Igor controller

## Orientation and printing

For use, the **broad base is down, encoder is horizontal, display tilts upward,
and back is vertical**. Supplied STLs use a different orientation for printing:
shell and faceplate front-down, hat and inlays underside-down.

The Bambu projects use a 0.4 mm nozzle, PLA, 0.2 mm layers, four walls,
25% gyroid infill and a 3 mm brim. Supports are enabled for the shell and
removed through its existing front opening. The other parts slice without
supports. Select your printer and actual filament and re-slice.

Print the new shell and front LED faceplate. The hat and two decorative inlays
are unchanged original geometry and can be reused.

## Assembly

1. **Dry-fit the original interfaces.** Clean out support and test the front
   closure, OLED mount, encoder and hat. Use Igor-compatible modules; the
   screen opening and encoder mount have not moved.
2. **Fit the weights in the flat base.** Use three 5 g adhesive steel segments,
   each no larger than **19 × 11.5 × 4 mm including tape**. Place them side by
   side across the **36 × 20 mm** well, long sides front to back. Press onto
   clean, dry floors. Keep them in one layer below the surrounding floor.
   There are no weights in the raised display nose.
3. **Fit the XIAO.** Use the standard ESP32-S3 without headers or Sense
   expansion. Put **0.3 mm electrically insulating double-sided tape** on its
   central mounting pad, at most 13 × 17 mm. Insert USB end first through the
   front opening, with the board's front tipped up about 15°. Align the USB
   socket, advance along the horizontal pocket, then lower the front onto
   the tape. Dry-fit before exposing the adhesive. Test a real cable.
4. **Fit the front NeoPixel.** With the faceplate removed, insert a 5 mm
   through-hole addressable NeoPixel from behind into the hole beside the
   display. Its flange must be at most 6 mm across. Secure the flange with
   a small electronics-adhesive dot. Use the vendor's actual pin diagram.
   Trim and individually insulate leads, keeping joints and bends within
   the checked 3.6 mm diameter × 7 mm space behind the flange. Place a 100 nF
   bypass capacitor close to its power leads, clear of the closure. Check
   the real soldered module fit.
5. **Wire and close.** Follow [WIRING.md](WIRING.md). Secure the insulated buffer
   against the left inner wall. Fit the OLED, encoder and original hat using
   Igor's original arrangement. Route the antenna on upper plastic away from
   weights. Close the faceplate and power through computer USB.

## Physical prototype checks

Confirm print tolerances, retention, full USB seating, OLED clearance, free
encoder rotation and push, and closure over real wires. Verify red/green/blue
channel order; the specified through-hole NeoPixel uses RGB. Check desk
stability with the actual cable connected.

The base extension is 6 mm. The recess has at least 2.1 mm of verified material
beneath it. Continuing the original front underside into the added depth moves
the start of the flat contact patch about 10.4 mm rearward. The width and
vertical rear wall remain unchanged. The main flat contact patch is about
35 × 43.6 mm before its rounded edge regions. The raised nose has no ballast.

Digital checks do not establish a completed physical print, electronics test
or ESP32-S3 firmware implementation.
