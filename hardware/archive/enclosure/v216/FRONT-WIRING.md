# Rearward LED wiring — v2.16

Reprint **05 rear housing and 06 electronics yoke** using the [two-part upgrade project](../bambu-studio/on-air-v216-X1C-upgrade-parts.3mf). Reuse the v2.15 front frame and all other parts. The wire paths now turn back into the electronics cavity, behind the optical screw heads, instead of taking the outside perimeter around the filled corners. The upper leads need small clearances in 05 and open grooves in 06; changing the front alone would leave those obstructions.

The [complete three-plate project](../bambu-studio/on-air-v216-X1C-all-plates.3mf) includes the same changes. Both replacement parts print in black PLA+, in the supplied orientations, without support. The new passages have open backs, without tunnel roofs to bridge. The nine M3×8 screws, nut pockets, board positions, USB openings, reset mechanism and light-guide bearings are retained. No new hardware or electrical parts are required.

![Rearward wiring routes and depth section](../reference/previews/front-wiring.png)

[Open the scalable drawing](../reference/front-wiring.svg). This is a **front-view projection**: when looking inside the detached front from the rear, left and right are reversed. Depth D is measured back from the visible front surface; larger D is farther into the enclosure. Route colors distinguish harness sections, not electrical pin colors. The background footprints are schematic; the clearance checks use the complete CAD solids.

## Follow the pads, then dress the wires

Use three separate flexible conductors, each **no more than 1.8 mm insulated outside diameter**. Your 24 AWG is preferable if its insulation meets that limit; some 22 AWG insulation will be too large. A joined three-wire cable or a heat-shrink bundle will not fit the shallow upper grooves as drawn. Measure the insulation, not the copper diameter.

The planned pixel order is **1 lower-right → 2 lower-left → 3 upper-left → 4 upper-right**, viewed from the front. This follows the pad direction shown in [Adafruit's side-light strip reference](https://www.adafruit.com/product/3634) when the emitters face the acrylic: the lower row runs right to left and the upper row runs left to right. Your exact strip SKU is still unconfirmed, so verify DIN/DI, DOUT/DO, power and ground on the actual segments before soldering. Do not turn an emitter away from the acrylic to match a drawing. Upper-right DOUT remains unconnected; it needs no outgoing wire through the reset corner.

| Run | Where to lay it | Depth of main run |
| --- | --- | --- |
| H1: disconnect → pixel 1 | Down from the left lower connector bay, across the bottom interior, with a broad return bend below the right capacitor bay to the lower-right pixel's outer pads | Two lanes at D19.6 and one at D16.8; return legs at D13.6 / D10.8 |
| H2: pixel 1 → pixel 2 | Between the lower inner pads, turning rearward behind the lower central optical screw head | D12.8 |
| H3: pixel 2 → pixel 3 | Three parallel columns over the charger's **bare face toward the display**, then back toward the upper-left pixel's outer pads | D13.85; columns X21, 23.2 and 25.4 |
| H4: pixel 3 → pixel 4 | Between the upper inner pads, behind the upper optical screw head and through the open yoke groove in front of MODE's terminals | D12.85 |

The modeled turns use **3 mm wire-center bend radii**. Start bending after the wire has left the pad and its solder joint; do not use the pad as a bending tool. H3 reverses lane order at the opposite end so its wires nest without crossing. H1's three leads also use different depths to clear the battery cradle. The [coordinate record](../reference/routing-coordinates.json) and [nominal length guide](../reference/harness-length-guide.csv) document each lane; lane numbers are physical tracks, not connector pin numbers. Trace electrical connections using [WIRING.md](WIRING.md).

## What changed in the mounts

The rear housing has shallow reliefs beside POWER's supports and ahead of MODE's terminal guard. The fitted switch-body seats remain. The yoke has a wider shared POWER/MODE rail and a **1.95 mm floor beneath its open wire groove**, rather than thin unsupported fingers. Its charger-side rail is widened inward before its outer edge is relieved.

One of the charger's four front contact pads moves under the USB end, onto the bare PCB face. Its contact area, height and nominal **0.15 mm board-face clearance** remain the same; a 45° gusset supports its base for printing. The other three contacts and the proven full-width lower charger stop remain. Check that the moved pad meets bare board, not a solder joint or through-hole on your actual PCB revision.

![Revised yoke with open grooves](../reference/views/v216-yoke-rear.png)

![Shallow reliefs in the rear housing](../reference/views/v216-housing-inside.png)

## Install without threading through tunnels

1. Print 05 and 06 from the upgrade project, let them cool, and remove strings from the open grooves and nut entries. Dry-fit the empty assembly and both switches. Leave yoke 06 loose until the wires are dressed.
2. Disconnect the battery and both USB cables. Solder the boards outside the enclosure. Preserve the existing circuit, including the inline **330 Ω R1** and **680 µF C1**. See [the capacitor/resistor soldering guide](CAPACITOR-AND-RESISTOR.md).
3. Dry-place the four pixels on the original front-frame floors, emitters inward. Plan the actual pad fanout using loose wires before soldering both ends. Start with excess length, form the rearward curves by hand and trim to the real path. Do not simply add a large loop to every conductor; the remaining space is finite.
4. Solder and insulate the pixel harness outside the frame. Keep solder blobs and sleeves outside the shallow grooves. Attach the LEDs with small hot-glue anchors at their backs/corners, leaving the optical floors, emitters and pads clear. Install the acrylic, backing and optical retainer as in [the build guide](BUILD-AND-ASSEMBLY.md); keep leads behind its screw heads, not under its clamping ears.
5. Install the rear light guides and keeper, then the charger, XIAO, switches and battery. Lay H1 along the bottom interior. Its connector body goes in the **left lower bay, X4–17, Y14–24, D12–19.5**: maximum 13 × 10 × 7.5 mm. Leave the connector accessible rather than gluing its two halves together.
6. Lay H3's three wires side by side on the front/bare side of the charger. Lay H4 flat in the new rear-open yoke grooves, between the yoke and the switch terminals. **Dress these wires before seating and tightening yoke 06.** They must not pass between a contact pad and a PCB, or between a switch body and its seat. Keep the existing small rear harness and its junctions off these new corridors.
7. Keep R1 in the bottom interior at **X70–82, Y5.2–8.4, D18–21.2**, in H1's DATA lead approaching pixel 1. Its sleeved assembly must fit within 12 mm length × 3.2 mm diameter. C1 stays in the unchanged right lower bay, body no larger than 8 mm diameter × 11.5 mm long. C1 stays on the rear side of the disconnect; R1 stays with the front pixel harness. Each exposed joint needs its own insulation.
8. Fit yoke 06 by hand, then tighten its two M3×8 screws gently. Check the charger contact under the USB end, both switch seats and the open wire grooves. Use only small hot-glue anchors on insulation in accessible open areas, away from contact pads, emitters, solder pads, screw/nut entries and mating faces. Do not fill the grooves with glue.
9. With POWER off and MODE in PROGRAM, connect the pigtail. Dress limited service slack in **X18–30, Y15–27, D10.3–12.4**. Bring the front straight onto the rear while guiding the reset and RGB guide into their bearings. Seat the seam by hand; do not pull it closed with screws. Reopen if there is spring pressure or a pinched lead.
10. Before the four closure screws are tightened, inspect all four pixel-pad exits, both optical screw heads, the charger contact, the MODE terminal area and the lower-right return bend. Verify reset travel, both USB plugs and both switch detents. Complete [COMMISSIONING.csv](COMMISSIONING.csv).

## What has been checked

All **12 modeled wire runs** clear the assembled CAD at **2.0 mm envelope diameter**, and all 66 wire-pair checks pass. This leaves nominal allowance around 1.8 mm insulation; it is not a guarantee for thicker wire. The rear housing and yoke pass static clearance checks plus 31 sampled yoke-insertion and 31 front-closure positions. Both meshes are single connected, watertight solids. Both supplied Bambu projects were sliced without warnings or supports on 05/06; the new reliefs have no roof bridges.

The wire paths start 1.15 mm beyond the nominal LED side edges. Exact copper-pad coordinates, solder fillets, insulation stiffness, end splices and printed shrinkage remain **physical dry-fit checks**. Motion checks cover the rigid parts, not automatic movement of flexible wires during closure. This revision has not yet been physically printed. The laser artwork and all unchanged parts are byte-identical to v2.15; no new acrylic or backing is needed.
