# v2.8 — charger corner contact and reset travel

Two production parts change: **05 rear housing and 07 reset button**. Reuse the v2.7 front frame, keeper 06, optical parts and hardware. Overall dimensions remain 120 × 60 × 24 mm, or 26.5 mm including the unpressed front button.

| Interface | Change |
|---|---|
| Charger lower stop | Widened from 10 mm to the full 17.5 mm PCB width. Both lower corner feet now meet the stop even when the middle of the board edge is indented. The existing 0.30 mm edge clearance remains. |
| Charger solder clearance | The seats 5 mm above the lower PCB edge and the OUT+/OUT− wire clearances are retained. The wider stop is below the board edge. |
| Reset collar | Thickness reduced from 3.05 to 2.85 mm by moving its rear face forward 0.20 mm. Available movement before the collar reaches the keeper increases from 0.60 to 0.80 mm. |
| Reset rest position | Contact tip length, front projection, captive shoulder and both running guides remain unchanged. The collar remains 5.2 × 5.2 mm in plan. |

The reset correction follows the physical report that the old stop is reached at, or almost at, switch contact. It adds 0.20 mm of movement beyond that observed position. The earlier simplified switch reference predicts earlier contact than the actual print, so its calculated overlap is **not** a validated switch depression or force limit. Verify a light click and full release with the new sample; do not force the button against its stop.

Use the new **two-part fit plate** containing upper rear sample 99 and replacement button 07. Assemble it with the already printed v2.7 upper front sample 91 and keeper 06. After it passes, print the full revised rear housing 05. Keep the tested new button.

All acrylic SVGs, display backing, electrical parts, wiring instructions and M3×8 fasteners remain unchanged. This revision adds no parts to the assembly.

Print the button at 0.10 mm layer height as configured. Remove its support and strings without rounding the collar's stop face or shortening its tip.

Reference: [Seeed's reset-switch drawing](https://forum.seeedstudio.com/t/xiao-nrf52840-reset-push-button-part-number/281655/2). This drawing identifies a separate small central actuator; the older model's rectangular reset target is a clearance approximation, not a detailed moving switch model.
