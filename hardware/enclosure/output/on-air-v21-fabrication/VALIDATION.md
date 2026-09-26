# ON AIR v2.1 — validation record

This is a digitally checked fabrication prototype. The commissioning form records the physical tests still required.

| Check | Result |
|---|---|
| Native Fusion | 19 components; no feature warnings/errors or positive-volume assembly interference |
| Insertion, closure and controls | 13 paths, 913 sampled positions; no overlap above 0.001 mm³ |
| FDM meshes | 7 main solids, 2 optional laminate rings, 8 fit sections; closed, connected, consistently wound, positive volume and Z=0 |
| Reserved harness | 38 routes, bays and individual LED exit checks passed against the native obstacles |
| Simultaneous wires | All 55 route pairs checked with compact insulation radii and 0.2 allowance; shared XIAO trunk and termination spaces documented |
| Optical registration | Exported letter outlines agree with the laser master within 0.00000874 mm; this is file agreement, not manufacturing accuracy |
| Bambu Studio 2.8.2.61 | 9 projects / 21 plates sliced without warnings; source and saved project meshes match final STL geometry |
| Graphic color | Black ends at 1.6 mm; white starts at 1.7 mm layer top; all 24 extrusion layers checked; one manual pause or AMS change |
| LightBurn 2.0.03 | Acrylic imported at 104 × 38 mm; mirrored text and key; blue Fill before red Line; review project power zero and both outputs off |

## What changed from v2

Fixed holders remain integral to the rear housing. Fastener pockets, moving controls and keeper gaps have more clearance. LED pigtails have side exits, the XIAO has open solder access, and the housing includes two auxiliary electrical landings and two strap anchors. Rounded harness reservations include depth-separated crossings and space above the battery for a detachable connector.

The first v2.1 Bambu export had an invalid triangle-field name. Bambu slicing caught it; the corrected schema and all nine rebuilt projects passed. No defective project is included here.

## Print estimates

| Project | Slicer estimate |
|---|---|
| PETG-AMS | 5 h 24 min / 86.8 g |
| PETG-fit-checks | 1 h 38 min / 20.9 g |
| PETG-manual-swap | 5 h 18 min / 85.1 g |
| PLA-AMS | 5 h 21 min / 87.3 g |
| PLA-fit-checks | 1 h 36 min / 21.0 g |
| PLA-manual-swap | 5 h 15 min / 85.7 g |
| PLA-plus-starting-AMS | 5 h 21 min / 87.3 g |
| PLA-plus-starting-fit-checks | 1 h 36 min / 21.0 g |
| PLA-plus-starting-manual-swap | 5 h 15 min / 85.7 g |

Estimates include the configured brims and, where applicable, color purge. Manual intervention and material calibration are additional. PLA+ uses a clearly labeled Generic PLA starting profile.

## Limits of this validation

Insertion paths are sampled, usually at 0.25 mm. They check the nominal solids, not arbitrary assembly angles. Optional laminate rings passed mesh checks; the full assembly study uses the printed graphic. Reference electronics and harness envelopes are excluded from printable exports.

Wire envelopes clear the modeled parts and auxiliary components. Close route pairs are permitted only in termination spaces with a 2 mm dressing margin, or the shared four-wire XIAO trunk. Actual pad locations, solder fillets, plug shells and wire packing still need a dry assembly. Wires are not physically simulated.

The actual acrylic sheet thickness, LED cut outline/emitter position, charger revision/populated height, XIAO reset location, cell specification and switch rating are unconfirmed dimensions/specifications. Use fit samples and the commissioning record. FDM distortion, screw strength, adhesive retention, battery protection, charging behavior, RF cut/engrave settings and illuminated appearance have not been physically tested.

The existing receiver firmware drives its onboard RGB LED. A four-pixel NeoPixel output remains necessary before the sign can operate. No firmware was changed or flashed, and no print or laser job was sent.

## Selected simplified wiring

The later direct-battery wiring choice is documented in `SIMPLIFIED-BATTERY-WIRING.md`. Printed parts and slicing are unchanged. The harness results above apply to the modeled original 5 V circuit; the simplified wiring and actual pigtail bodies have not received a new native routing study or physical fit test.
