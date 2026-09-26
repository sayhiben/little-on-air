# ON AIR v2.6 — build and assembly

Replace **01 bezel, 05 rear housing, 06 yoke and 07 reset button** together. Retain the acrylic, graphic backing and optical retainer. Use the new common M3×8 screw specification with this revision.

## Print the combined fit plate first

Open `bambu-studio/on-air-v26-X1C-eSUN-PLA-plus-fit-checks.3mf` as a complete project. Its four parts are upper housing 99, yoke 06, button 07 and upper front-frame section 91. Use four M3×8 button-head screws and four M3 nuts to check the two upper closure joints and the yoke.

Generic PLA and PETG variants are also included. Select your actual spool. The eSUN PLA+ project retains the user's successful standard-nozzle settings. All projects target the X1 Carbon with a 0.4 mm nozzle at 100% scale. Structural layers are 0.20 mm with four walls and five top/bottom layers; the button and lettering use 0.10 mm layers.

The housing prints flat back down, the yoke broad front face down, and the front bezel front face down. Automatic supports are disabled for these parts; small holes and nut pockets retain short bridges. Only the button uses local supports, exterior face down with a brim. Remove its supports and strings from holes before fitting.

First-layer inspection remains disabled to preserve the workaround that allowed the previous print to finish. Bed leveling remains present. Watch the first two layers. No print has been sent by this release process.

## Common fasteners and display

Use **eight M3×8 button-head screws**, head no larger than Ø5.7×1.65 mm, and eight ordinary M3 nuts, 5.5 mm across flats and 2.4 mm thick. Four close the case from the front; two retain the optics; two retain the electronics yoke. No washers. Closure head bearing is 6.6 mm below the face. The rear nut roof is 2 mm thick and the front compression seat is 2.9 mm thick. The full closure nut thickness is engaged, with 0.6 mm of tip beyond the nut inside the blind boss.

Optical screw tips stop 1.075 mm behind the front face, about 0.425 mm before their blind bore ends. Yoke screws have about 0.55 mm tip clearance. Nut pockets are 6.0 mm across flats and 3.0 mm deep; screw bores are 3.6 mm. Load nuts before components and tighten gently by hand.

The keyed acrylic and engraving SVGs are unchanged. The printed graphic remains black through Z=1.6 mm, with white starting at the layer ending at 1.7 mm. Choose the AMS or manual-swap project. Only the manual graphic plate contains a planned filament-change pause. STLs contain no color instructions.

<!-- RETAINED LASER AND ELECTRICAL GUIDE -->

## Revised routing and assembly

1. Load all eight nuts into the empty parts. The upper-left rear nut enters from below in the front view; the lower-left enters from the right, and the right-hand closure nuts from the left. Optical nuts enter from the right. The left yoke nut enters from the right and the right yoke nut from the left. Align the flats with the pockets.
2. Fit the reset button first, with the yoke removed. Hold its external end 9 mm inward from its final position, lower it through the open front, then slide it outward through the closed guide. Its flange stays inside and its rounded tip projects 3 mm.
3. With the battery disconnected, solder and insulate the XIAO wires outside the enclosure. The existing circuit uses BAT+, ground and D2. The underside BAT/GND wires pass through the central opening in the rear spine. Keep their solder within 1.25 mm of the PCB back; the dedicated loading channel carries these joints during the upward slide. Edge-pad solder joints face the open outer aisle. Keep insulation within the specified 0.8–0.9 mm wire envelopes and retain service slack.
4. Lower the XIAO from the front **8 mm below its final position**, then slide it upward 8 mm into the USB opening. Keep the free flexible power leads forward of the nearby yoke screw boss while loading, then dress them into the final notch. They must not pull the board or cross the reset, RGB sight line or nut entries. The yoke carries the lower side clamp so it can be fitted after the wired board is seated.
5. Insert the charger with its component side facing the back. Its LED centers should be visible through the two rear holes. The USB opening follows the flipped socket. Keep the clear areas 5 mm from the bottom edge at the lower PCB supports; neither OUT solder joint should rest on a support.
6. Insert POWER and MODE from the open front. All six DPDT legs enter the uninterrupted terminal-row spaces. Its 9.5 mm-wide pocket leaves 0.20 mm per side, while its keeper and rear seat leave 0.15 mm total depth clearance for the measured body. No printed MODE slider is used.
7. Fit the yoke with two M3×8 screws. Check both USB plugs fully engage without shifting the boards, both switches reach their detents, MODE stays seated and reset returns after twenty presses. Nominal reset free play is 0.10 mm and total travel 0.40 mm. Do not use screw force to overcome an obstruction.
8. Check the two upper closure joints with front sample 91. The M3×8 screws should clamp the seam before bottoming. After this sample passes, print complete revised parts 01, 05, 06 and 07.
9. Assemble the optical stack using the laser instructions above. Route the LED pigtails through their side exits and secure the optical retainer with two M3×8 screws. Complete and insulate the selected two-switch wiring, inline 330-ohm resistor, 680-uF capacitor and pigtails. No new electronic parts are required by this revision.
10. Place the battery on its insulated bed with a loose nonconductive strap. Secure the capacitor and insulated junctions in the existing right-hand space. Follow `routing-map.svg` and the wire cut list. Keep service slack clear of controls, indicators, USB openings and screws.
11. Set POWER off and MODE to PROGRAM, connect the internal pigtail and close the case by hand. Install the four remaining M3×8 screws at the front. Complete the retained commissioning checks before mounting. Leave the charger holes uncovered by adhesive strips; a flush wall obscures these rear service indicators.

## Fit limits

The records check native geometry, sampled assembly motion, nut access, reset travel, fourteen XIAO edge-pad exits, underside power-pad exits, LED sight lines, wire corridors, mesh integrity and slicing. The next fit print checks actual strength, tolerances and solder shapes. Charger PCB thickness remains a 1 mm assumption. Acrylic thickness and laser kerf still require material checks. The retained electrical operating procedure remains necessary for the two-switch circuit.
