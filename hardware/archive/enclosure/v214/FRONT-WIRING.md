# Wider front frame and LED wiring — v2.14

Replace **part 01 only**. Reuse the existing acrylic, display backing, optical retainer, rear housing, electronics yoke, reset button, light guides, keeper and all nine M3×8 screws/nuts. The front is now **129 × 69 mm**, extending 4.5 mm beyond the original 120 × 60 mm rear body on each side. Overall body depth remains 24 mm, excluding the existing projecting button and wall adhesive.

![Frame section and cable-channel cross-section](../reference/previews/front-wiring.png)

The new covered perimeter passage goes outside the four corner bosses and both central optical-retainer bosses. It is nominally **4.2 mm wide × 6.3 mm deep**, with a 1.8 mm front floor, 1.4 mm roof and at least 1.6 mm outer wall. Inward-facing windows let you feed and dress wires beside the LEDs and at the sides. The upper-right LED's right window is narrower to preserve the reset guide. The rim is closed at the exterior and rear edge; no separate cover is needed for the wires.

The interfering LED side lips are removed above the original seating floors. Those floors still position the modules at depth 2.1875 mm, keeping the emitting faces aligned with the same acrylic edges. Secure the LEDs with small hot-glue anchors after checking their alignment. The original optical retainer remains usable.

## Wire size and preparation

Use flexible stranded wire with **measured insulation outside diameter no greater than 1.8 mm** for these frame passages. The model was checked with six 2.0 mm diameter clearance envelopes around the perimeter and three such envelopes through each LED-side access opening. The difference provides allowance for insulation, printing and wire dressing; it is not a promise that any wire labelled 22 or 24 AWG fits. Of your two gauges, flexible 24 AWG is generally easier to thread. Measure the actual insulation before cutting.

This larger-wire allowance applies to the **front LED interconnects**. The unchanged rear electronics have their existing, narrower routing spaces; reuse the fitted rear harness or follow its smaller wire-OD limits. Solder joints, heat-shrink, pigtail connector bodies and the inline resistor stay in the open solder/service bays, outside the covered tunnel.

Keep 330 Ω R1 near LED1 DIN, as described in the [capacitor/resistor guide](CAPACITOR-AND-RESISTOR.md). The 680 µF C1 remains across power and ground in its rear bay. This revision changes no electrical connections and adds no components or fasteners.

## Install the front harness

1. Print the frame, remove the brim and inspect each inside access window. Feed a loose test wire through every required passage, especially the curved corners. Remove any accessible strings without enlarging the screw or optical seats. Inspect the roof for sagging before proceeding.
2. Keep the battery and both USB cables disconnected. Dry-fit all four LED modules on their floors, with emitters pointing inward. The numbering is **lower-left 1 → lower-right 2 → upper-right 3 → upper-left 4, viewed from the front**. Looking into the detached frame from the rear reverses left and right.
3. Plan each lead from the actual DIN/DOUT and power-pad markings. H2 uses the lower perimeter between LED1 and LED2; H3 uses the lower/right/upper perimeter between LED2 and LED3; H4 uses the upper perimeter between LED3 and LED4. Routes can overlap: keep the leads ordered in the tunnel and make bends/crossovers in the open access and solder bays. The electrical power and ground rails remain common; they need not follow every data detour. Do not reverse a module's emitting direction to shorten its wires.
4. Feed **loose, unsoldered ends**, one at a time, through the inside windows before attaching both ends. Use the side windows to help feed around corners. Do not try to pull a connector or a soldered three-wire splice through the passage. Start with generous individual lengths and trim after the dry fit; the old H2–H4 cut lengths and deep-cavity routes are superseded.
5. Dress each lead beside its LED without stacking a solder lump under the PCB or over the light-emitting edge. Leave enough service slack to lift the module for soldering. Avoid sharp folds against the bosses. If a six-wire overlap is crowded, separate the leads and stagger their bends in the adjacent open bay; do not force the bundle through.
6. Solder and insulate the connections. Check the full chain against the [wiring table](WIRING.md), then place each LED flat on its seating floor. Use small hot-glue anchors at suitable PCB corners/back surfaces. Keep glue off emitters, acrylic entry edges, pads, screw holes and the cable passage. Glue provides retention; do not let it prop up a module.
7. Fit the acrylic, backing and optical retainer. Confirm the retainer ears sit down freely and its pads do not press solder joints. Route the front pigtail into the unchanged service bay. Close the case by hand before inserting screws; screws must not be used to crush a wire into place.
8. Check reset travel, both switches and USB access, then perform the existing electrical commissioning checks. Actual wire stiffness, insulation OD, solder and printed bridging remain physical fit checks.

## Printing

Use the supplied [front-only Bambu project](../bambu-studio/on-air-v214-X1C-front-only.3mf) to replace just this part. It uses black PLA+, face down, the X1C 0.4 mm nozzle, textured PEI, four walls, 0.20 mm main layers and **no supports**. The first layer remains 0.10 mm. Estimate: about **2 h 03 min / 25.08 g**. Filament slots 2 and 3 remain listed for consistency with the complete project but are unused here.

**Keep the frame's 45° bridge-angle override.** Automatic direction generated approximately 124 mm roof paths in the first trial slice. The supplied project instead crosses the channel diagonally; the longest measured unsupported centerline span is about **14.48 mm** at the curved corners. Inspect [the roof toolpaths](../reference/roof-toolpaths.svg). If importing the STL into another project, set part 01's bridge angle to 45°, keep this face-down orientation, and inspect Preview before printing. Physical bridge quality depends on the actual PLA+ spool, flow and cooling.

The [complete three-plate project](../bambu-studio/on-air-v214-X1C-all-plates.3mf) contains the same new frame. Only the rear housing's plate position moves, by 9 mm, to make room. Every other mesh and its painting is identical to v2.13. The insert is black/white PLA+; the three light guides are clear PETG; there is still exactly one guide keeper.

## What was validated

- Exact native comparison: all 24 other CAD components unchanged, including references and optional laminate components. Original optical stack, screw seats, reset bearing and RGB aperture retained.
- No assembled solid interference; front closure checked at 81 positions. Reset collar relief removes added rim material only; reset travel checked at 17 positions through 0.80 mm. Two assumed 12 × 6.5 mm USB cable overmolds clear the widened front during external approach.
- Six 2.0 mm wire envelopes around the complete loop, plus three through each of eight LED-side entries: all 30 passage checks pass against the installed parts and hardware. These are passage reservations, not a model of your unknown solder joints or every hand-dressed crossover.
- STL is a single connected, watertight solid. Both projects slice without warnings; no frame support, no manual pauses, and first-layer inspection remains disabled for the earlier timeout workaround. The insert's black/white layers and all 332 long optical-guide fill runs remain correct.

The laser-cut/engraved acrylic SVGs are byte-for-byte unchanged. Use the existing [laser guide](LASER.md); no new acrylic or backing print is needed for this frame update.
