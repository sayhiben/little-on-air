# ON AIR v2.8 — transparent PETG indicator light guides

These are solid light pipes for the front XIAO RGB status LED and the two rear charger indicators. They retrofit the v2.8 enclosure. Use one long front guide and two identical short charger guides. The four acrylic edge-lighting pixels and the laser files are unchanged.

## Files and fit choices

Open `bambu-studio/on-air-v28-clear-PETG-light-pipes.3mf`. It contains nine parts: three complete sets, each with one long guide and two short guides. Keep each row together after removing it from the bed.

| Row / object name | Shaft diameter | Clearance in a nominal 3.2 mm bore |
| --- | --- | --- |
| Bed Y 112 / `2.95mm` | 2.95 mm | 0.25 mm diametral |
| Bed Y 126 / `3.05mm` | 3.05 mm | 0.15 mm diametral |
| Bed Y 140 / `3.15mm` | 3.15 mm | 0.05 mm diametral |

Start with 2.95 mm, then choose the largest size that slides in using light finger pressure. Different holes may need different sizes. These are nominal CAD clearances; printed bore size, extrusion calibration and elephant foot determine the actual fit. Do not scale an STL: that would change its length and LED clearance too.

Six individual STLs are supplied, flat face down and long axis along bed X. The charger STL prints twice. The F3D/STEP include the unchanged enclosure and component references to show placement. They are not a new enclosure release.

## Printing

The X1C 0.4 mm project uses 0.10 mm layers, one wall, 100% aligned rectilinear fill, aligned top/bottom/internal fill, and 0° infill direction. Narrow-area infill substitution is disabled. Speeds are 20 mm/s, with 15 mm/s on the first layer. No supports or brim are required by the supplied geometry. Keep the guides horizontal and along X; rotating a part in the plate requires changing its fill angle too.

The single clear-PETG material is a starting profile based on installed Generic PETG: 255 °C nozzle, 70 °C textured PEI, 10–30% part fan, auxiliary fan off. Confirm these temperatures suit your spool, dry it per its maker's instructions, and use its calibrated flow value. The project does not assume a particular clear-PETG brand. Print at normal speed, without Sport/Ludicrous overrides.

CLI estimate for all nine pieces: about 29 minutes including startup, approximately 1.00 g. First-layer inspection remains disabled, following the successful fix for this printer's earlier inspection stall. Bed leveling and normal heater shutdown remain present.

Bambu's [PETG Translucent product guidance](https://us.store.bambulab.com/products/petg-translucent?id=42479468281992) notes that transparency depends on geometry and print settings. The installed slicer's infill options and the [Bambu Studio source](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/Fill/Fill.cpp) were checked; the delivered G-code, rather than just its settings, was audited for line direction. There is no measured optical-efficiency guarantee for these FDM guides.

## Installation

1. Disconnect USB and battery power. Remove strings and any lip on the guide's flat printing face. Keep the end faces clean. Avoid shortening the locating collar or extending the tip.
2. Test fit sizes gently. For the front RGB guide, insert the narrow pickup end through the front indicator opening. Its collar stops against the outside front face; it projects 0.8 mm. The flat side faces toward the bottom of the sign.
3. Install the charger guides from inside the rear housing, before refitting the charger board. The shorter collar-to-end section enters the rear wall hole; the longer section points toward the LED. The extra small flat on each collar faces the nearby charger side fence. The broad printing flat faces toward the bottom of the sign.
4. Seat the charger collars against the inside rear wall. The outlets should finish about 0.1 mm inside the outside back surface. Refit the board and retainer; preserve the existing wire routes.
5. These are friction-located parts with insertion stops, not snap latches. With a snug fit they should have little lateral play. If a guide slides axially or rattles, secure its collar to the case with a tiny removable adhesive spot, keeping adhesive away from both optical ends and the electronics. Let any adhesive cure before installing electronics. Do not use the LED or PCB as a retaining stop. In particular, a loose rear guide must not slide forward against its LED.
6. Confirm the guides do not touch the LEDs, USB socket or wires. Nominal air gaps are 0.4 mm at RGB and 0.5 mm at the charger indicators. The front pickup narrows to 1.8 mm to give 0.32 mm nominal clearance from the USB metal shell.
7. Power up and check RGB and each charger indicator separately. Check brightness and unwanted light leakage before final assembly. The rear indications are viewed with the sign removed from its wall mounting. Light transmission and the final fit still need this physical test.

## Validation completed

- Original v2.8 component volumes unchanged; no housing, button or retainer reprint required.
- Largest 3.15 mm option checked against all native assembly/reference bodies, insertion paths and the case stop surfaces.
- All 45 established wire, termination and component-bay reservations remain clear.
- All six exported meshes are watertight, single connected solids, on Z=0, with a continuous bed face and no elevated horizontal undersides.
- Source and sliced 3MF meshes match the STLs. Slicer returned no warnings. All 968 straight infill runs longer than 1 mm are along X; short connections, curved turns and perimeters are excluded from that count.

The closeup images show simplified reference component envelopes, not detailed circuit-board models. Fit retention, optical brightness and the nominal LED gaps have not been physically tested with the user's printed parts.
