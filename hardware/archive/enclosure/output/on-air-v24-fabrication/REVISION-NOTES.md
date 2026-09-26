# v2.4 — second physical-fit revision

Replace **05 rear housing, 06 electronics yoke and 07 reset button** together. This revision responds to the second printed fit test. The optical parts, acrylic artwork, electronics and fasteners remain compatible.

| Feature | Change |
|---|---|
| Side vents | Three angled capsule vents on each side, nominally 8 × 2.4 mm at 45°. They sit below the upper electronics corner and away from the screw bosses. |
| XIAO corner | A continuous wall, approximately 4 mm thick around the guide, replaces the inward-projecting guide ledge and open corner notch. The XIAO moves 0.8 mm inward from v2.3. |
| XIAO USB space | The measured outer socket opening keeps its size and follows the board inward. An additional interior envelope reserves space for connector tabs and solder. Both the seated assembly and insertion sequence are checked. |
| XIAO supports | Solder-access windows have 45° roofs; the frame has broad ribs and rear buttresses. The housing and yoke print profiles have automatic supports disabled. Short bridges remain at small holes and nut pockets. |
| Reset | Closed 3.2 mm keyed guide around a 2.8 mm stem, with 4 mm bearing length. The flange stays inside; the rounded outside end fits through the guide during assembly. Nominal free play is 0.15 mm and total inward travel is 0.45 mm. The small button alone uses support in the supplied profile. |
| Retaining yoke | Main rails are 3 mm thick, with wider arms and 2.4 mm charger/switch keeper posts. Roots and port roofs are reinforced. Local screw seats retain their original 2 mm thickness and bearing planes so the original screw lengths still work. |
| MODE DPDT | Body measured 9.1 mm long × 3.72 mm deep × 3.36 mm tall; six edge terminals project 3.25 mm. Actuator is 1.5 mm square × 1.87 mm high. The 3.9 mm slot gives 2.4 mm travel. The nest allows approximately 0.30–0.35 mm around the body, and lower pads sit between terminal columns. Actuator exposure is 0.72 mm. No printed slider. |
| POWER SPDT | The successful body fit is retained. Material is added outside the side cheeks and behind the roof. Its individual sample is widened to include more surrounding material. |
| New fit plate | One continuous 120 × 34 mm upper housing section, the complete yoke and reset button. This checks all four mounts, the actual corner, screw seats and one vent on each side together. It avoids the misleading thin cut edges of isolated samples. |

## Assembly order matters

1. Install the reset button first. Lower it through the open front with its rounded end about 6 mm inward from the final position, then slide it outward through the side guide. Its flange remains inside.
2. Insert the XIAO through the open front **8 mm below its final position**, then slide it up 8 mm into the USB opening. The enlarged guide clearance addresses the seated interference; the lowered insertion still lets the USB socket pass the button tip.
3. Fit the other boards and switches, dress the wires, and install the yoke. The yoke supplies the XIAO lower stop and the reset inward stop.
4. Check that the boards do not move when plugging in USB, both switch detents are accessible, and reset releases after twenty presses. Do not force the board past the button.

The XIAO wire approaches and ground route are updated for the thicker frame. Keep the solder joints inside the marked access windows. The circuit and component list are unchanged apart from correcting the DPDT dimensions.

These are nominal CAD allowances, not proof of a physical fit or a strength rating. The new combined sample is the acceptance test. The charger PCB thickness remains provisionally 1 mm. Use the material you intend for the finished case, remove brim and strings, and check all interfaces before printing the full housing.

The choice of angled roofs, wider roots and print orientation follows [Prusa's FDM design guidance](https://help.prusa3d.com/article/modeling-with-3d-printing-in-mind_164135). Board reference information comes from [Seeed's XIAO documentation](https://wiki.seeedstudio.com/XIAO_BLE/); the user's measurements and printed fit results take precedence.
