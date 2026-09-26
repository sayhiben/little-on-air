# v2.7 — parallel PCBs and a thinner body

The body is **120 × 60 × 24 mm**, reduced from 34 mm. The front reset button projects 2.5 mm, giving **26.5 mm maximum front-to-back depth** before wall adhesive. Both USB-C ports remain on top. Both boards lie parallel to the display; the XIAO component face points forward and the charger component face points backward.

Replace **01 front frame, 05 rear housing, 06 keeper and 07 reset button together**. Keep the existing acrylic, graphic backing 03 and optical retainer 04. All laser SVGs are unchanged. The upper-right closure screw moves from its former inboard position to the actual corner, so the new housing must use the new front frame.

| Interface | New design |
|---|---|
| XIAO mount | Short supports at both PCB ends, a separate rear reaction pad under reset, and open long pad rows. The tall vertical cage is removed. |
| Charger mount | Same measured 28.1 × 17.5 mm board and 8.85 × 3.1 mm socket. Lower supports remain 5 mm above the OUT-pad edge. A 2.9 mm gap between the keeper rail and bare PCB face gives the wire trunk a crossing space. |
| Loading | Both pre-soldered boards drop straight into the open housing. Their USB roofs are retained by the removable keeper. No upward board slide is required. |
| Reset | Front-frame access above the acrylic; 2.5 mm projection. Keyed 2.4 × 2.8 mm stem, 2.8 × 3.2 mm guides, 5.2 mm captive flange. Front guide is 6 mm long and rear guide approximately 5.4 mm. Nominal free play 0.25 mm; stop travel 0.60 mm; nominal button depression 0.35 mm. |
| XIAO RGB | Front-frame aperture, located from the same official Seeed layout used in v2.6. The board moves 3 mm right to preserve the nearby pixel's solder exits. |
| Charger LEDs | Two rear service apertures at the measured LED centers; still hidden by a flush wall. |
| MODE DPDT | The 9.5 mm pocket retains 0.20 mm lateral clearance per side and 0.15 mm total retained depth clearance. Both complete terminal rows load through open channels. |
| POWER SPDT | The measured body and flange clearances are retained. Bracket ends remain open rather than leaving extremely thin plastic fins; the main body pocket provides lateral location. |
| Hardware | All eight screws remain M3×8 button heads with ordinary M3 nuts. Heads and nuts remain inset. |
| Battery and wiring | Battery lies flat with a 0.5 mm insulating cushion at its bed. Capacitor lies on its side in the lower-right space; internal disconnect is left of the battery. Wiring passes around the pouch, with a dedicated underside XIAO power route. |

No extra electrical components are introduced. Retain the selected two-switch circuit, inline 330-ohm resistor and 680-uF capacitor, user pigtails and manual USB operating procedure.

The new fit plate contains four actual production sections/parts: upper front 91, complete upper rear 99, full keeper 06 and button 07. Fit these before printing the full body. CAD and slicer checks do not establish the tolerances of a physical PLA, PLA+ or PETG print.

The unchanged measurements still needing confirmation are charger PCB thickness (1.0 mm assumed), acrylic stock thickness, actual solder envelopes and connector dimensions. Use bare XIAO pads without pin headers. Keep underside XIAO solder within 1.25 mm of the PCB back, with insulated leads no more than 0.9 mm OD individually and 0.8 mm OD for the paired power fanout.
