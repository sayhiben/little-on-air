# Print and assemble the minimal Igor shell

## Print

Use the supplied shell STL **front opening down**. The prepared Bambu project
uses PLA, a 0.4 mm nozzle, 0.2 mm layers, four walls, 25% gyroid infill and a
3 mm brim. Supports are enabled for the shell, including its internal ledges.
Remove them through the existing front opening before fitting electronics.
Print the original hat with its underside down and the faceplate front down;
they and the optional inlays use no supports in the supplied projects.

If reusing an existing Igor, print **only `01-igor-shell-minimal.stl`**. The
faceplate, hat and inlays in this package are unchanged original geometry.
No new screws, heat-set inserts, bottom lid or lens are required.

## Fit the parts

1. **Clean the shell.** Remove support and check the original front closure,
   encoder mount, LED opening and rear USB opening. Dry-fit the purchased OLED
   and encoder against the original mounting geometry. Use Igor-compatible
   modules and the encoder’s original panel nut/washer.
2. **Fit five adhesive weight segments.** Maximum individual size is
   **19 × 11.5 × 4 mm including adhesive**. Put two side by side in the flat front
   well (long edges across the case), and three side by side in the sloping well
   (long edges front to back). Both are accessible through the front opening.
   Press firmly onto clean, dry recess floors. These recesses are sized for one
   layer totaling 25 g with 5 g segments. Insulate any exposed conductive weight
   surfaces near wiring. Keep all weights below the surrounding floor.
3. **Mount the XIAO.** Use the standard ESP32-S3 without headers or Sense
   expansion board. Add **0.3 mm electrically insulating double-sided tape**
   on the central pad, at most 13 × 17 mm. Insert from the front, USB end first,
   with the board’s front tipped up about 15°. As the USB end approaches
   the rear wall, lower it about 2 mm to align the socket with the opening,
   advance along the sloping pocket, then lower the front onto the tape. Dry-fit before
   removing the release liner. The PCB pocket locates the board and the tape
   retains it. Check a real USB cable seats fully without stressing the board.
4. **Mount the pixel under the top opening.** Use a 10 × 10 × 1.6 mm carrier
   with a centered 5 × 5 × 1.6 mm emitter. Insert through the front, emitter up,
   between the small internal locating lands. The board sits just behind the
   faceplate, under the opening ahead of the hat. Secure its edges to the lands
   with small dots of suitable electronics adhesive. Leave the emitter and
   solder pads clear; use directly soldered wires without headers.
5. **Wire and close Igor.** Follow [WIRING.md](WIRING.md). Fit the original OLED,
   encoder, faceplate and hat using the original assembly arrangement. Secure
   the insulated shifter assembly against the left inner wall and dress the
   wires clear of the controls. Fit the XIAO antenna on upper plastic, away
   from the weights. The computer supplies power through USB-C; no battery.

## First physical prototype

The CAD checks use Seeed’s board model, nominal weights and a specified LED
carrier. Check actual solder joints, wire bends, adhesive thickness and module
variation during dry assembly. Verify unobstructed encoder rotation and push,
full USB seating, firm board/weight retention and faceplate closure. A slicer
pass does not establish real printer tolerances or a completed electronics test.

## Size and access

- Overall shell width and front-to-back length remain **49 × 67.27 mm**.
- The bottom moves down 6 mm; the rest of Igor’s original position is retained.
- Flat weight well: **39 × 13 mm**, floor 3.5 mm below the old bottom datum.
- Sloping weight well: **36 × 20 mm** along the original 30° base plane.
- Minimum modeled material beneath the weight wells: approximately **2.2 mm**.
- No removable weight cover: service through Igor’s original front opening.
