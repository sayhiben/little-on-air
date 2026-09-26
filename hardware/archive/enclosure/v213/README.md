# ON AIR v2.13 — mechanically retained light guides

The front RGB guide now has an **internal collar captured between the front frame and the existing electronics yoke**. The two rear charger guides have **keyed collar seats and one rigid screw-fastened keeper**. Retention no longer depends on friction or adhesive.

## What to print

| Part | Quantity | Material / action |
| --- | --- | --- |
| 01 Front optical bezel | 1 | Replace with this revision; includes a deep guide bearing and collar pocket |
| 05 Rear electronics housing | 1 | Replace; adds collar seats, keeper mount and nut-loading bay |
| 08 Captive front RGB guide | 1 | Clear PETG; replaces the old exterior-collared front guide |
| 09 Charger light guide | 2 | Clear PETG; existing rear guides can be reused if they fit freely |
| 11 Rear light-guide keeper | 1 | PLA, PLA+ or PETG; rigid, removable plate |
| M3×8 button-head screw | 1 additional | Same screw size as the existing assembly |
| Standard M3 hex nut | 1 additional | 5.5 mm across flats, approximately 2.4 mm thick |

Keep the existing yoke 06, reset button 07, optical parts and electronics. The broader front bevels and all four seam-notch corrections remain included. No electrical parts or laser artwork change.

The **clear-PETG project contains exactly three parts: one front and two rear guides**. Install all three. There are no alternate-size sets or spare copies on the plate. The nominal shafts are 3.05 mm for the existing 3.2 mm bores; do not scale the parts to change fit.

The structural PLA+ and PETG projects each contain 01, 05 and 11. Choose one material project. The exported STLs already have their intended print orientation.

Slicer estimates: **20 minutes / 0.55 g** for the three clear guides; **3 h 9 min / 55.08 g** for the PLA+ structural plate or **3 h 10 min / 54.25 g** for PETG, including the keeper support.

## How each guide is retained

**Front:** the collar's forward face seats at 8.20 mm depth in the new frame pocket. Its rear face is at 9.40 mm; the existing yoke stops it at 9.65 mm. This limits nominal axial movement to **0.25 mm**. The long frame bearing supports the shaft, and the collar's flat keys into the pocket. The guide is fully captive only after the front is installed against the yoke. It can still back out into the open enclosure during assembly.

**Rear:** each existing collar seats against the inner rear wall at 21.70 mm. Keeper 11 stops its opposite face with **0.20 mm nominal axial clearance**. The shaped pocket limits lateral and rotational movement. The shaft cannot escape sideways through the keeper's open slot while it is in the rear-wall bore and collar pocket. One screw secures both guides.

The rear keeper's nut is retained under a **2 mm housing roof**, and the keeper's screw pad bears on that housing boss. The screw therefore clamps the keeper to the housing. The nut, screw head and screw tip remain inside the case envelope.

At their permitted axial extremes, the modeled LED gaps are at least **0.45 mm at the front** and **0.30 mm at the rear**. These are nominal CAD clearances; check the actual LED packages before applying power. Neither PCB nor LED is used as a retaining stop.

## Printing

Structural parts use the X1C 0.4 mm nozzle, 0.20 mm layers, four walls, 25% gyroid infill and a 3 mm outer brim. Frame 01 prints front down and housing 05 prints back down, both without automatic support. **Keeper 11 prints screw-bearing face down with support beneath its open arm.** The supported faces are away from the collar-contact and housing-bearing faces. Remove support before fitting; do not pry against a retaining shoulder.

Clear guides lie on their continuous flat faces, with their long axes along bed X. The project retains 0.10 mm layers, one wall, 100% aligned rectilinear fill, 0° fill direction and 20 mm/s printing. Do not rotate the guides independently of the fill direction. No supports are used for the clear pieces. The clear-PETG thermal profile is the existing Generic PETG starting point (255 °C nozzle, 70 °C textured PEI, low cooling); use the actual spool's calibrated flow and suitable temperatures.

First-layer inspection remains disabled following the earlier printer stall. Bed leveling and normal heater shutdown remain enabled. No print or laser job was sent.

## Assembly

1. Disconnect USB and battery power. Remove the front and electronics yoke, and transfer components to the revised rear housing as needed. Clear print residue from the light-guide bores, collar pockets, keeper and nut channel.
2. **Load the extra M3 nut before installing keeper 11.** Lower it into the open bay below the new boss, then slide it approximately 7.8 mm toward the top of the case, under the roof, until centered on the screw hole. The nut cannot be pushed straight through the roof at the screw position.
3. With the charger board out, insert both short guides from inside the rear housing. Their short outlet ends enter the rear-wall holes. Point the broad printing flats toward the bottom of the sign; the smaller collar flats face the nearby charger fence. Seat the collars in their keyed pockets.
4. Lower keeper 11 over the guide shafts. Its crossbar enters the short channel through the charger fence, and its screw pad sits on the nut boss. Install the additional M3×8 button-head screw. Tighten only until the keeper is seated; do not use the screw to force misaligned parts together. Verify that both guides are captured with only slight movement.
5. Refit the charger, other electronics and existing yoke. The measured PCB seats at both ends of the charger are retained. Keep the established wire routes clear of the new keeper and nut-loading bay.
6. With the front frame detached, install the new front guide **from the inside**: pass its plain front end outward through the indicator hole and seat its internal collar in the rear pocket of the guide bearing. Its narrow LED pickup points into the case; its printing flat points toward the bottom of the sign. The old exterior-collared front guide is not suitable here.
7. Hold the front guide seated while closing the frame. Guide its inner end through the existing yoke's indicator bore. The yoke completes the capture. Seat the case by hand before tightening the existing screws.
8. Gently push and pull each guide. Verify limited movement and no contact with LEDs, the USB socket or wires. Check the reset button still clicks and releases. Then reconnect power and check the three indicators independently. Rear indicators are viewed with the sign off the wall.

## Validation and files

Native checks cover component interference, assembly motions, guide travel and both retaining stops, screw access, nut insertion and the screw's structural clamping path. The full established harness reservations and the complete frame seam perimeter are checked again. The meshes and Bambu projects are audited for geometry, bed placement and print settings, and the clear-guide G-code is checked for lengthwise fill. CAD checks do not replace the first physical fit and optical test.

`cad/` contains the complete Fusion and STEP assembly; `stl/` contains five unique manufacturing meshes; `bambu-studio/` contains the three clearly separated projects. `views/` and `validation/` document the assembly and checks. Earlier releases remain available separately.

In `views/front-captive-guide.png`, the gray section is the frame bearing, amber is the yoke stop, and blue is the guide. The section is an illustration cut through the actual CAD solids; the production frame remains whole.
