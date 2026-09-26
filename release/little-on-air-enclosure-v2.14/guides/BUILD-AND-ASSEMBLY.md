# Build and assembly — enclosure v2.14

Use the complete set in this release. The electronics mounts are integrated into the rear housing; they are independent of the black-and-white display backing. All dimensions below are millimetres.

## 1. Prepare the parts and hardware

Print the ten pieces listed in [PARTS.csv](../PARTS.csv), using the [printing guide](PRINTING.md). Cut and engrave one acrylic panel using the [laser guide](LASER.md). Let printed parts cool before removing brims, support and strings. The clear guides' flat sides are intentional printing surfaces.

Clean screw holes, nut entries, USB apertures and guide pockets. Remove support from reset button 07 and rear guide keeper 11 without shortening the reset tip or rounding retaining shoulders. Dry-fit the shell and retainers; they must seat by hand before screws are tightened. Do not scale the assembly to correct one tight hole.

Use nine M3×8 button-head screws, measured under the head, with heads no larger than 5.7 diameter × 1.65 high, and nine M3 nuts, 5.5 across flats × approximately 2.4 thick. No washers. Allocation: four case closures, two optical-retainer joints, two electronics-yoke joints and one rear-guide-keeper joint.

Load captive nuts while the parts are empty. Directions below are viewed from the front of the sign, top ports upward:

- Upper-left closure nut: enter from below. Lower-left: from the right. Both right closure nuts: from the left.
- Left electronics-yoke nut: from the right. Right yoke nut: from the left.
- Optical-retainer nuts: from the right through their open entries.
- Rear-guide-keeper nut: lower into the open bay below its boss, then slide approximately 7.8 toward the top under the 2 mm roof. It does not load straight through the screw hole.

## 2. Prepare the electrical harness

Disconnect the battery and both USB cables while soldering. Follow the [exact connection table](WIRING.md). Identify switch commons and throws with a meter before attaching wires; physical pin position does not establish electrical function.

Solder the boards outside the case without pin headers. The XIAO's component face will point toward the display; the charger's component face will point toward the rear wall. On the XIAO, leave both long pad rows accessible, route BAT/GND through the gap behind the board, and keep underside solder projection within the reserved 1.25 allowance. The charger OUT+/OUT− corner joints must clear the support seats 5 mm above its bottom edge.

The front LED passages now accept flexible insulated wire up to **1.8 mm outside diameter**, subject to the actual printed fit. Follow the [front routing and mounting guide](FRONT-WIRING.md) and [frame section diagram](../reference/front-wiring.svg). Reuse the fitted rear harness: its unchanged limits remain up to 0.9 mm OD for individual leads and compact three-wire bundles, and up to 0.8 mm for constrained paired routes. The [rear coordinate record](../reference/routing-coordinates.json) and [length allowances](../reference/harness-length-guide.csv) preserve rear routing only; the old H2–H4 paths are superseded. Leave service slack and trim after fitting actual connectors.

### Connect the capacitor and resistor

Use one of each for the whole four-pixel chain. Follow the [illustrated soldering guide](CAPACITOR-AND-RESISTOR.md) for identifying leads, making the splices, insulating them and checking them with a meter.

| Part | What it does | How to connect it |
| --- | --- | --- |
| **C1: 680 µF, ≥6.3 V capacitor** | Stores a little energy to smooth brief changes in LED power demand | **+** to the VBAT_SW splice after S1 POWER; **−** to charger OUT− / protected ground. These are two branch connections; the main LED power and ground wires continue past them. |
| **R1: 330 Ω resistor** | Reduces sharp transients at the first pixel's data input | Front pigtail **DATA → either resistor lead → other resistor lead → LED1 DIN**. Either orientation works. All data to LED1 must pass through it. |

C1 is polarized: its negative stripe faces the ground connection. Keep its power branch before S2 MODE, and use OUT− rather than the charger's B−. R1 goes in the data wire only; it has no connection to power or ground. Leave the modules' existing SMD components in place. See [Adafruit's NeoPixel guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/best-practices) for the recommended capacitor and resistor arrangement.

Keep R1 close to LED1 DIN. Its insulated assembly must fit within 12 length × 3.2 diameter, in the 12.5 × 5.7 × 5.6 space behind LED1. C1 stays on the rear housing side of the pigtail: its body must fit within 8 diameter × 11.5 length, on its side in the right lower bay. Use short insulated branch leads with service slack, sleeve every exposed joint separately, and secure the parts so they cannot pull on solder pads or touch the battery pouch. Check both connections before closing the case.

The mated pigtail pair belongs in the left lower service bay, within 13 × 10 × 7.5 including its body. Label and verify both halves **GND, VBAT_SW, DATA**. Junctions belong in the open center, with the dressed trunk following the checked passages. Keep all leads out of screw/nut entries and the new guide keeper's channel.

## 3. Assemble the display in the front frame

With frame 01 face down on a clean soft surface, place the four cut LED modules in their seats, keeping every onboard SMD component and solder pad intact. Point the emitting sides into the clear acrylic edges. Pixel order in the routing drawing is lower-left → lower-right → upper-right → upper-left, as viewed from the front. Follow each module's actual DIN/DOUT labels even when that changes wire dressing.

Feed loose LED leads through the widened frame passages before soldering both ends, following [FRONT-WIRING.md](FRONT-WIRING.md). Secure the modules with small hot-glue anchors, retaining the original floor height and keeping emitters/pads clear. The interfering side lips are removed. Check real wires and joints before installing the optical retainer. Seat the acrylic with its smooth viewing face outward and engraved face inward. Viewed from the front, ON AIR must read normally and the keyed clipped corner must be upper left. Keep the LED entry edges clear of frosting, adhesive and excess solder.

Place backing 03 behind the acrylic, **white lettering toward the engraved face**. Use the common left/bottom datums so the text aligns. The integral pads set about 0.5 air gap between the white letter tips and the unengraved rear acrylic surface. The letters do not press into the engraving. Keep glue out of this optical gap.

Fit nonconductive shims/cushion behind the backing as specified in the laser guide: `rear gap = 0.45 − (actual acrylic thickness − 3.175)`. At nominal 3.175 thickness this is 0.45. Add thin compliant pads only where the optical retainer supports the LED modules, filling any real seating gap without bending their small boards.

Install optical retainer 04 with two M3×8 screws. Its ears must meet their seats without bowing the acrylic or loading the LED solder joints. Gently shake the subassembly: the panel, backing and LEDs should remain seated. Check text registration before tightening further.

Insert reset button 07 from inside the frame, feeding its keyed rounded stem through the front guide. Its collar retains it inside and its external face projects approximately 2.5. Keep the front subassembly separate for now.

## 4. Install the rear indicator guides first

With charger CH1 still out and the ninth nut already loaded, insert the two short guides 09 from inside housing 05. Their short outlet ends enter the rear viewing holes and their collars seat in the keyed wells. Point the broad printing flats toward the bottom of the sign; the smaller collar flats face the charger fence.

Lower keeper 11 over the guide shafts. Its crossbar enters the short channel through the charger fence and its screw pad bears on the nut boss. Install one M3×8 screw and tighten until seated. Do not use the screw to force alignment. Both guides should be captive with only slight movement; the nominal axial allowance is 0.20. They must not rest against either charger LED.

See [keeper view](../reference/views/rear-guide-keeper.png) and [rear housing view](../reference/views/rear-housing-with-retention.png).

## 5. Install the electronics and battery

Lower the XIAO into its short end supports, **components facing the front, USB toward the top**. Its PCB back seats at depth 19.7 from the display face. The pad beneath reset supports button force. Dress underside leads before clamping; do not trap wires in corner stops or against the antenna end.

Lower the charger into its supports, **components facing the rear, USB toward the top**. The bare PCB face is at depth 15.3 and the component-side face at approximately 16.3, based on the remaining 1.0 PCB-thickness assumption. Both solid lower corners must engage the widened 17.5 stop; the indented center need not touch. Confirm the real board, solder and USB overhang seat without strain. The rear guide pickups must stay clear of the two indicator packages.

Lower the SPDT POWER and DPDT MODE switches into their nests. Use the DPDT's exposed slider directly; there is no printed extension. Its two terminal channels clear three 0.7-wide legs per row with 1.85 clear gaps. The body must sit on its supports, rather than on bent legs or solder sleeves. The SPDT flange ends intentionally remain open for its bracket.

Place the 52 × 21 × 10 battery on approximately 0.5 insulating cushioning in its cradle. Pass a 2.5-wide nonconductive strap through the integral lugs and retain the pouch without compression. Route bundles around the battery, not on top of it; avoid projecting solder joints and sharp edges.

Install electronics yoke 06 with two M3×8 screws. It should seat on both screw bosses by hand. Its pads retain the PCB ends and switch bodies; its roofs finish the USB and slider apertures. Check both USB plugs latch and unplug without shifting a board, and both switches reach both detents. Keep the guide-keeper bay and service disconnect accessible.

## 6. Fit the front guide and close the case

Insert front guide 08 **from inside the detached front frame**, passing its plain outlet end outward through the RGB viewing hole. Seat the internal collar in the frame pocket, with its printing flat toward the bottom of the sign. The narrow pickup end points toward the XIAO RGB LED. The old guide with an exterior collar does not fit this retention scheme.

Hold the guide seated while bringing the front straight onto the housing. Feed the reset stem through the yoke's second keyed guide and the indicator pickup through its existing bore. The yoke completes the front guide's capture, leaving 0.25 nominal axial play. Before closure, the guide can still back out inward.

With POWER off and MODE in PROGRAM, mate the internal pigtail. Dress the slack into the reserved bay. Seat the halves by hand, with no spring pressure, trapped leads or interference. Install the four M3×8 closure screws from the front and tighten gently until the seam is seated. Heads, nuts and tips must remain inset.

The [front section view](../reference/views/front-captive-guide.png) shows the gray frame bearing, amber yoke stop and blue guide. The production frame is whole; the image is a section through the actual solids.

## 7. Check operation and mount

Before power, press and release reset twenty times. It must click before its collar reaches the stop, return freely and not shift the PCB. The current collar allows 0.80 total movement, but actual button contact must be checked physically. Do not force it against the stop. Operate both switches repeatedly and gently push/pull all three guides; they should remain captive without pressing an LED or wire.

Complete the continuity, charge-current, temperature and operating checks in [COMMISSIONING.csv](COMMISSIONING.csv) using the [mode table](WIRING.md). The packaged firmware can exercise the XIAO RGB indicator; the four display NeoPixels require the external-output firmware described in [firmware status](FIRMWARE-STATUS.md).

Once the assembled unit passes its checks, apply removable adhesive strips to the flat rear, leaving the charger viewing holes uncovered. Rear indicators are viewed with the sign removed from the wall. The top USBs/switches and front reset remain accessible.
