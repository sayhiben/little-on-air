# v2.6 — common screws and service access

Replace **01 front bezel, 05 rear housing, 06 retaining yoke and 07 reset button** together. The acrylic, graphic backing and optical retainer remain compatible.

| Change | Result |
|---|---|
| One screw specification | Eight **M3×8 button-head screws**, maximum head envelope Ø5.7×1.65 mm, and eight ordinary M3 nuts. Closure nuts move toward the front. Closure head-bearing depth becomes 6.6 mm. All hardware remains inset. The optical bosses receive deeper blind tip clearance. |
| XIAO RGB indicator | A 3.4 mm wide side sight aperture, with a printable angled roof, lines up with RGB6. Its location comes from the official Seeed KiCad board: 2.794 mm from the USB PCB end and 3.175 mm from the far long edge. |
| Charger indicators | The charging board turns over in the same PCB footprint. Its USB opening moves 1 mm laterally and 4.1 mm toward the back. Two Ø3.2 mm rear holes line up with the user's LED measurements: 9 and 13.75 mm from the USB end, 1.75 mm from the right edge viewed from the component face. |
| Loose MODE switch | The pocket width reduces from 9.8 to 9.5 mm, leaving 0.20 mm per side. The rear seat moves forward 0.20 mm and the keeper tips extend 0.25 mm. The measured 3.72 mm body has 0.15 mm total depth clearance. |
| XIAO wiring | The board moves 2 mm inward. Broad supports at the short ends replace the obstructing outer long-edge cage. The inboard retainer backbone is 3.4 mm wide, and the rear spine is 2.7 mm thick and supports the PCB directly against reset force. Both seven-pad rows have dedicated solder exits. A separate opening serves the underside BAT+ and GND pads. |
| Reset following the board | The contact extends 2 mm inward; the exterior location, rounded finger end, 3 mm projection and nominal 0.10 mm free play remain. Its positive stop still allows 0.40 mm travel. |

The DPDT feedback was approximately 1 mm of movement. The former CAD pocket allowed 0.60 mm total depth movement; the new pocket allows 0.15 mm. The correction uses the measured body stack rather than adding a full millimetre that would intersect the nominal switch. Test this interface before the full housing print.

The four-object fit plate contains the continuous upper housing (99), complete yoke (06), button (07), and matching upper front-frame section (91). Use four M3×8 screws and four nuts to test the two upper case joints plus the yoke. The individual lower nut sample (90) remains available.

Solder and insulate XIAO wires outside the enclosure. The lower outer clamp is part of the removable yoke, so the soldered edge pads can slide into place. A separate loading channel clears the underside power joints during the 8 mm upward slide. Keep free flexible power leads forward of the nearby screw boss while loading, then dress them into the final notch. The channels provide wire clearance; they are not intended for soldering with the board installed.

The charger holes are rear service indicators and will be obscured by a flush wall. Leave them uncovered by adhesive strips. No electronic parts, firmware changes or new laser artwork are introduced.

Position source: [Seeed XIAO nRF52840 hardware resources](https://wiki.seeedstudio.com/XIAO_BLE/#resources), official KiCad project v1.2 downloaded 2026-09-12. Physical board revision and printed fit still require checking.
