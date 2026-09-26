# v2.5 — third physical-fit revision

Replace **05 rear housing, 06 electronics yoke and 07 reset button** together. The optical bezel, graphic, acrylic artwork and fasteners remain compatible. Begin with the three-piece combined upper-housing fit plate.

| Feedback | Revision |
|---|---|
| Upper-left nut inaccessible | Its M3 hex pocket and entry turn 90 degrees toward the open interior, away from the charger rail. All eight nuts receive separate loading and sliding-path checks. Load nuts before components or optical layers. |
| XIAO USB slot too low | The socket is centered across the 17.8 mm board width, moving its opening 1.785 mm toward the front. The previous measured 8.97 mm metal width is retained, giving 4.415 mm margins, close to the newly reported 4.5 mm. Socket height remains 3.17 mm and overhang 1.75 mm. The PCB is corrected to 1.2 mm thick. Both housing and yoke follow the corrected envelope. |
| Reset difficult to press | The measured PCB-back-to-button distance is 1.8 mm. The contact tip is 0.75 mm longer, leaving nominal 0.10 mm free play. Its face is 2.8 × 1.6 mm, the outer end projects 3 mm, and the stop permits 0.40 mm travel. An asymmetric internal flange stays clear of the USB edge. |
| DPDT support strikes legs | Legs are 0.7 mm wide with 1.85 mm clear gaps, giving 2.55 mm pitch and 1.65 mm end margins. Broad end shoulders sit outside the entire six-terminal span. This allows straight insertion from the front and leaves the spaces between pins open for solder. |
| POWER roof has unnecessary gap | A square exterior roof closes the gap. Internal relief remains for the existing front-bezel locating tongue; the successful switch body and flange fits are retained. |
| Charger OUT solder conflicts with feet | Both lower front keepers and rear supports move to a clear PCB area centered 5 mm from its bottom edge. Separate clearances reserve the two bottom through-hole solder areas on both faces. |

The six angled side vents and reinforced corner remain. Main layers are 0.20 mm with four walls; the button uses 0.10 mm layers. Automatic supports remain off for the housing and yoke. Only the button uses local support. Keep the supplied orientations, 100% scale and the profile's first-layer inspection workaround.

The yoke's front print face is leveled by 0.25 mm so the new POWER roof starts on the bed. Main rails are 2.75 mm thick and local screw seats are 1.75 mm thick. Keeper tips, underside seats and contact positions stay fixed. The same M3×8 screws seat 0.25 mm deeper, with approximately 0.55 mm clearance at the blind bore ends.

## Assembly changes

1. Load all M3 nuts into the empty parts. For the upper-left rear pocket, place the nut below the boss and slide it upward into place, with its flats aligned to the rotated pocket. The other entries retain their directions. Coordinates and checked approach directions are in the nut-access validation file; left/right refer to the front view.
2. Load the longer reset button before the XIAO and before the yoke. Hold it approximately **9 mm inward** from its final position, lower it through the open front, then slide it outward through the closed guide. Its flange stays inside.
3. Insert the XIAO **8 mm below** its final position, then slide it upward into the USB opening. Leave wire slack for this movement. Install the remaining boards and switches, then the yoke.
4. Verify reset is released at rest, actuates easily and returns after twenty presses. Check both USB plugs fully latch without shifting a board, both switch detents are reachable, and OUT solder joints clear the supports on both PCB faces.

These are nominal CAD clearances, not proof of printed fit or strength. The charger PCB thickness remains provisionally 1 mm. The next combined sample is the physical acceptance test. Electronics and laser artwork are unchanged.
