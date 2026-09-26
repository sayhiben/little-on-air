# Open-backed front wiring — v2.15

Print **only frame 01** to upgrade an existing build. The v2.14 channel roofs did not bridge reliably in the physical print, so v2.15 removes them and the ceilings over the LED/side access openings. The other printed parts, acrylic, screw positions, front bevels and 129 × 69 mm front footprint remain unchanged.

![Open-channel section and wire placement](../reference/previews/front-wiring.png)

## Why the roofs are removed

Covered tunnels are not required for the electrical circuit or case assembly. They concealed and retained the wires and added some stiffness, but made printing and installation harder. The open version retains the **1.8 mm front floor**, **at least 1.6 mm outer wall**, and the original screw, optical, reset and guide bearing areas. The nominal perimeter channel is **4.2 mm wide × 7.7 mm deep**, open at the rear. It still passes outside all four corner bosses and both central retainer bosses.

Because the front extends 4.5 mm beyond each side of the original rear housing, **the housing does not close the entire channel**. The openings face toward the wall. Keep insulated wires recessed and secure them with small hot-glue anchors; do not depend on the housing to trap them. No additional printed cover or fastener is needed.

![Rear access to the channels](../reference/views/v215-inside.png)

## Print and assemble

1. Open [the front-only Bambu project](../bambu-studio/on-air-v215-X1C-front-only.3mf) **as a project**. Print face down in black PLA+, X1C 0.4 mm nozzle, textured PEI, four walls, 0.20 mm main layers and a 0.10 mm first layer. **No supports and no special bridge-angle setting are needed for these open channels.** Existing small hardware features remain; this is not a claim that the whole part has no overhangs.
2. Remove the brim and inspect the channels. Check the actual wire insulation diameter. Retain the conservative **≤1.8 mm OD** allowance for the inter-LED wires; flexible 24 AWG is generally easier to dress than stiff 22 AWG. AWG alone does not specify insulation size. The unchanged rear electronics still have their previous smaller wire clearances.
3. Lay the wires into the open channels. Follow the actual DIN/DOUT labels: LED order is lower-left 1 → lower-right 2 → upper-right 3 → upper-left 4 **viewed from the front**. Looking into the frame from the rear reverses left and right. Use the lower perimeter for 1→2, the lower/right/upper perimeter for 2→3, and the upper perimeter for 3→4. Power and ground are common rails and can take shorter connections where appropriate.
4. Dress overlaps and bends in the open solder bays, leaving service slack. Keep connector bodies, heat-shrink splices and R1 in their existing service/solder bays. Dry-fit before trimming the leads. Do not place wires across screw seats, optical datums or the case mating faces.
5. Seat each LED on its original floor, emitter facing the acrylic edge. The floor still sets the module at depth 2.1875 mm. Use small hot-glue anchors at suitable PCB corners/back surfaces, clear of emitters, solder pads and acrylic entry edges. Add small anchors to hold the wire insulation down in the channels without filling the available space or lifting a module off its floor.
6. Fit the acrylic, backing and optical retainer. The retainer ears must seat freely. Close the case by hand before tightening the screws; screws must not compress a misplaced wire. Verify reset, switches and USB access.

The circuit is unchanged: R1 is **330 Ω in series with LED1 DATA**, and C1 is **680 µF across switched LED power and protected ground** in its rear bay. Follow the [capacitor/resistor guide](CAPACITOR-AND-RESISTOR.md) and [connection table](WIRING.md). Disconnect the battery and both USB cables while soldering.

The [complete three-plate project](../bambu-studio/on-air-v215-X1C-all-plates.3mf) contains this same new frame, with the v2.14 plate positions. All other meshes, insert painting and material assignments remain unchanged. The laser artwork is unchanged; no new acrylic or display backing is required.

## Validation and remaining fit checks

Native solid subtraction confirms that only frame material at depths 8.1–9.5 mm was removed. The front floor, optical seats and LED alignment floors are untouched. Protected screw/reset/light-guide areas are unchanged, and every other native component has the same geometry fingerprint. Previous collision-free wire, button and closure checks remain applicable because this revision only removes material.

The exported frame must remain one watertight connected solid. The slicer audit checks that **no bridge extrusion remains at the former wire-roof layer**, no frame supports are generated, and the other nine print instances retain their original meshes and painting. First-layer inspection remains disabled for the previous printer timeout workaround.

This revision has not yet been physically printed or assembled. Check actual wire dressing and wall stiffness during assembly, and keep the wire bundle recessed with glue anchors. The earlier v2.14 successful slice did not establish physical bridge reliability; this version removes that bridge requirement instead of relying on it.
