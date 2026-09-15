# ON AIR v2.2 — validation record

Digitally checked fabrication prototype; actual build results belong in `COMMISSIONING.csv`.

| Check | Result |
|---|---|
| Native Fusion solids | 21 assembly components at origin; no feature warnings/errors or positive-volume static interference |
| Insertion, closure and control travel | 15 paths, 1071 poses; no overlap above0.001 mm³ |
| Exported STL topology | 7 main parts,2 optional rings,9 fit sections;18 connected,closed,positive-volume solids with bed contact atZ=0 |
| Wire and component space | 40 routes,bays and individual LED exits clear modeled obstacles |
| Simultaneous wire packing | All78 route pairs checked; compact insulation radii plus0.2 placement allowance; fanning inside marked bays only |
| Optical registration | Letter STL vs shared laser master error 0.00000874 mm; file agreement only |
| Previous optical parts | Unchanged main meshes verified against v2.1 by canonical geometry; laser files match byte for byte |
| Bambu Studio2.8.2.61 | 9 projects,21 plates sliced without warnings; source and saved meshes match final STLs |
| Graphic color change | Black ends at1.6 mm; first white layer ends at1.7; all24 extrusion layers checked; one manual pause or AMS change |
| LightBurn artwork | 104 ×38 mm, mirrored rear text and key; Fill before Cut; review file power zero and outputs disabled |

The new POWER mount was checked for front insertion with the lever already attached, nominal3 mm lever travel, yoke installation and front closure. A roof/tongue collision discovered during review was corrected with a45-degree printed ramp; the final report passes. No front optical geometry was changed to make room for the switch.

## Print estimates

| Project | Slicer estimate |
|---|---|
| PETG-AMS | 5 h 28 min / 87.1 g |
| PETG-fit-checks | 1 h 51 min / 24.0 g |
| PETG-manual-swap | 5 h 22 min / 85.4 g |
| PLA-AMS | 5 h 25 min / 87.7 g |
| PLA-fit-checks | 1 h 50 min / 24.2 g |
| PLA-manual-swap | 5 h 19 min / 86.0 g |
| PLA-plus-starting-AMS | 5 h 25 min / 87.7 g |
| PLA-plus-starting-fit-checks | 1 h 50 min / 24.2 g |
| PLA-plus-starting-manual-swap | 5 h 19 min / 86.0 g |

These estimates include configured brims and color purge; cooling, manual handling and calibration take additional time.

## Practical limits

The SPDT drawing gives the flange, main body,5 mm lever and2.5 mm legs. Its actual other-axis knob width and travel remain unmeasured. CAD reserves a3.2 mm square lever and checks3.0 mm motion; its7.9 mm opening has additional lateral clearance. Qualify it with sample98 and the full yoke. FDM fits use calibrated surfaces within±0.10 mm as an acceptance target, not a published X1C accuracy guarantee.

Motion sampling is generally0.25 mm and validates the specified straight insertion paths. Reference electronics simplify populated boards and solder geometry. Optional laminate rings pass mesh tests; assembly and optics use the printed graphic. Laser power/speed, actual PMMA thickness, kerf, engraving appearance, shrinkage, switch force, USB overmolds and connector bodies require real samples.

The13 wire routes and6 reserved bays plus21 individual LED exits clear modeled obstacles. Wire pairs near one another are allowed to fan within named bays and a2 mm dressing margin; this is not a physical cable simulation. Some native reference sweeps are stored as separate tested primitives because the CAD kernel could not unite nearly coincident display geometry. This does not skip their collision tests or affect printable parts.

Electrical behavior is not certified by CAD. In particular, confirm S1 startup/capacitive inrush, S2 MCU current below100 mA, the cell's charge rating versus the actual TP4056 setting, protected-ground wiring and the manual USB mode procedure. Direct battery-powered pixels may dim or become unreliable as voltage falls. Test the intended operating range and brightness.

No printer, laser or firmware job was sent. The existing receiver firmware still drives its onboard RGB LED and needs a four-pixel external output to operate this display.
