# ON AIR v2.5 — third physical-fit build

Replace **05 rear housing, 06 yoke and 07 reset button** together. Print the new combined fit plate first. The front optical bezel, graphic backing, optical retainer, acrylic and original fasteners remain compatible. Read REVISION-NOTES.md for the measured dimensions and revised interfaces.

## Print and fit check

Open `bambu-studio/on-air-v25-X1C-eSUN-PLA-plus-fit-checks.3mf` as a complete project and retain its settings. The plate contains three parts: the continuous upper housing sample 99, the yoke 06 and button 07. Use the existing M3 nuts and two M3x8 yoke screws to test the assembly. The combined sample includes the actual mounting seats and surrounding corner material; individual section STLs remain available for targeted checks.

First-layer inspection remains disabled. Keep bed leveling enabled and watch the first two layers. The material variants include the successful eSUN PLA+ standard-nozzle settings, Generic PLA and PETG; select the actual spool and calibrate its flow. Print at 100% scale with the supplied orientations and a 0.4 mm nozzle.

Structural layers are 0.20 mm, with four walls and five top/bottom layers. The housing and upper fit section print flat back down. The yoke prints broad front rails down. **Automatic support is disabled for the housing, fit housing and yoke.** Their small holes and nut pockets still contain short bridges. Remove strings from the guide and nut pockets without cutting the bearing surfaces. The button uses 0.10 mm layers, an exterior-face-down orientation, a brim and small local supports at its flange; remove those before fitting.

Test the reset button by itself before adding the XIAO. Install the components in the sequence below, then check the real USB plugs, switch detents and twenty reset presses. The charger PCB thickness remains an unmeasured 1 mm assumption. The enlarged XIAO connector envelope includes assembly allowance but cannot establish the shape of every solder joint or cable overmold.

## Fasteners and optical parts

Retain four M3x25 socket-head closure screws, two M3x6 button-head optical screws, two M3x8 button-head yoke screws, and eight ordinary M3 nuts (5.5 mm across flats, 2.4 mm thick). The closure bores remain 3.6 mm; head recesses are 6.8 mm; nut traps are 6.0 mm across flats and 3.0 mm high. The yoke has a common front print face 0.25 mm deeper than v2.4 so its POWER roof starts on the bed. Main rails are 2.75 mm thick and local screw seats 1.75 mm. Underside seats and keeper tips stay fixed; the same M3x8 screws seat 0.25 mm deeper and retain about 0.55 mm blind-bore tip clearance. Hardware remains recessed.

The printed graphic uses black through Z=1.6 mm and white from the layer ending at 1.7 mm. The graphic's layers are 0.10 mm after the 0.20 mm first layer. Select the labeled AMS or manual-swap project. Only the manual graphic plate contains an intentional filament-change pause. Separate STLs do not carry color instructions.

## Nova Plus 24, 60 W RF — acrylic

The user confirmed this machine. Thunder distinguishes its [Nova Plus RF source from the glass-tube Nova](https://www.thunderlaserusa.com/nova-plus-24/). Glass-tube 60 W cutting tables are not an RF preset. Use the machine's installed Thunder RF profile, focus and air-assist procedure from its [manual](https://support.thunderlaserusa.com/portal/en/kb/articles/thunder-laser-nova-plus-rf-machine-user-manual). Do not change controller PWM frequency or machine settings for this sign.

Use confirmed clear PMMA; cast stock usually gives a frosted engraved target. A generic Amazon “1/8 inch” listing does not establish actual thickness, casting process or masking material. Measure at all four corners and the middle. This stack accommodates approximately **3.00–3.45** with measured rear shims/cushions; material outside that range needs a stack revision. Do not force it into the case.

The retainer contact is at depth 7.725. Its available rear cushion is:

`cushion gap = 0.45 − (measured acrylic thickness − 3.175)`

For 3.00 stock that is 0.625; for 3.175 it is 0.450; for 3.45 it is 0.175. Use thin nonconductive shims plus a compliant layer to fill this gap without bowing the acrylic. The common left/bottom datums align the panel with the graphic; the opposite edges have 0.5 for compliant preload and expansion. A 30°C rise would expand a 104 mm acrylic edge about 0.225 using the acrylic coefficient cited in the earlier design review. Keep expansion clearance instead of gluing all four sides rigidly.

1. Import `91-kerf-plug-and-frame-CUT.svg`, 40 × 30, with zero kerf offset. Its inner square is nominally 20 × 20. Cut the inner contour first, using a verified RF acrylic setting and the same sheet/lens/focus as production. Measure the loose plug P and opening H in both axes. Estimated full kerf is `(H − P) / 2`; also compare `20 − P` and `H − 20`. Disagreement indicates taper, measurement error or an inaccurate cut. Measure both top and bottom surfaces and use the larger interference risk for fit.
2. For the production **outside** outline, apply an outward path offset of half the measured full kerf. Check its direction in LightBurn Preview. Do not offset or scale the text. The file itself contains zero compensation. This follows the method in [LightBurn's kerf guide](https://docs.lightburnsoftware.com/latest/Guides/Test-KerfOffset/).
3. Use `92-engraving-quality-nine-samples-FILL.svg` on scrap, rear face up. It has nine independently colored samples and fine bars. Start from a proven RF clear-acrylic engraving setting. Compare line intervals 0.10, 0.125 and 0.15 across the columns, and modestly lower/base/higher engraving energy down the rows. These intervals are a test range, not certified settings: Thunder quotes about 0.128 mm nominal spot size for a 2-inch Nova Plus lens under its test conditions. [Thunder spot-size reference](https://support.thunderlaserusa.com/portal/en/kb/articles/thunder-laser-beam-waist-matrix)
4. Choose a shallow, uniformly frosted fill with no ridges, cracks or melted lip. A target depth around 0.05–0.15 is a design aim to test, not a prediction from power percentage. Keep broad surfaces clear. Record speed, min/max power, interval, focus, passes, lens and air settings in `COMMISSIONING.csv`. Power/speed remain test-dependent; no unverified machine job is supplied.
5. Import `02-acrylic-REAR-engrave-and-cut.svg` at exactly **104 × 38**. Rear side faces the laser. Text **and key are already mirrored**. Blue = Fill, engrave first; red = Line, outline last. Do not mirror again. Use the tested compensation only on red. Preview to verify counters stay clear and the outline is cut once.
6. Flip the finished panel left-to-right. ON AIR reads normally and the clipped corner is upper left. Keep the four LED entry areas smooth and clean. Do not frost these edges or cover them with adhesive. Test the panel and matching graphic in their shared datums before fitting the retainer.

The optional `02-acrylic-REVIEW-ONLY.lbrn2` has the same geometry, blue Fill before red Line, both outputs disabled and all min/max powers set to zero. Its remaining speed/interval fields are placeholders. The existing LightBurn device profile was disconnected and was not confirmed to be the RF profile. Select your verified Nova Plus RF device and successful scrap settings before enabling output; the SVG remains the machine-independent master.

The graphic's integral spacing pads retain about 0.5 air between white letter tips and the unengraved acrylic rear plane. The engraving is recessed into that plane. Avoid adhesive across the clear face or filling the air gap. Blacken visible side faces of the white printed spacing pads if they show at oblique angles. Optional laser-safe black-over-white laminate still uses its separate unmirrored SVG and both optional spacer rings; measure its actual 1.6 thickness and adjust the rear cushion accordingly.

## Selected electrical circuit

S1, the larger SPDT, disconnects the sign's load from the protected battery output. S2, the tiny DPDT, separately isolates the XIAO battery input and data output for USB work. The battery remains connected to the charging board when POWER is off; this is a hard disconnect for the sign load, not a zero-leakage battery-storage disconnect.

The four NeoPixels run directly from the single-cell battery rail, labelled **VBAT_SW**, rather than a regulated 5 V supply. Adafruit describes a 3.7 V LiPo supply with 3.3 V logic as a usable configuration. This simplification gives battery-dependent brightness and less voltage margin as the cell discharges. Check the actual pixels over the intended operating range; do not assume every unidentified NeoPixel revision behaves identically. [Adafruit basic connections](https://learn.adafruit.com/adafruit-neopixel-uberguide/basic-connections)

Keep the selected **330 Ω data resistor** near the first pixel and **680 µF capacitor, rated at least 6.3 V**, across the switched pixel rail. The resistor is in series with DATA; the capacitor is in parallel across power, with its negative lead on protected ground. Keep the pixels' existing SMD components. No boost board, logic buffer, MOSFET or separate signal carrier is required by this selected circuit. [Adafruit resistor and capacitor guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/best-practices)

The SPDT listing rates its contacts at 0.5 A; the DPDT listing is 100 mA. An older-pixel conservative estimate is 4 × 60 mA = 240 mA at full white, plus the MCU branch. This is a paper budget, not a measurement at battery voltage. **Wire LED+ and C1+ directly to the S1 switched rail, before S2.** The tiny switch carries only the MCU branch and signal. Confirm MCU branch current, including startup, remains below 100 mA. Keep a 12.5% initial brightness ceiling and measure actual current. [Adafruit power estimates](https://learn.adafruit.com/adafruit-neopixel-uberguide/powering-neopixels)

The 0.5 A SPDT listing does not specify capacitive-load inrush. Charging 680 µF can briefly exceed steady LED current; a DC steady-current rating alone does not qualify this transient. Test the actual switch/startup behavior and inspect for contact sticking or bounce-related resets. This remains a bench qualification of the parts you own, rather than a reason to add a switching module to the enclosure. [TI explanation of capacitive inrush](https://www.ti.com/lit/an/slva670a/slva670a.pdf)

## Exact connections

Disconnect the battery while soldering. Find both switches' commons and throws with a continuity meter. Do not infer pin numbers from the drawing or assume slider direction matches the nearest terminal. A refers to one isolated DPDT pole; B refers to the other.

| From | To |
|---|---|
| Cell positive and negative | Charger B+ and B−, permanently |
| Charger OUT+ | S1 POWER common |
| S1 ON throw | VBAT_SW junction |
| S1 OFF throw | Unconnected and insulated |
| VBAT_SW junction | LED power pigtail, C1 positive, S2 pole A RUN throw |
| S2 pole A common | XIAO BAT+ |
| S2 pole A PROGRAM throw | Unconnected and insulated |
| XIAO D2 / P0.28 | S2 pole B RUN throw |
| S2 pole B common | Front DATA pigtail → 330 Ω near LED1 → LED1 DIN |
| S2 pole B PROGRAM throw | Unconnected and insulated |
| Charger OUT− | XIAO BAT−/GND, C1 negative and LED GND; permanent common protected ground |
| LED1 DOUT → LED2 DIN; LED2 DOUT → LED3 DIN; LED3 DOUT → LED4 DIN | Daisy-chain DATA in this order |
| All four pixel power pads | VBAT_SW, continuous corresponding power rail |
| All four pixel ground pads | Protected ground, continuous corresponding ground rail |
| LED4 DOUT | Unconnected and insulated |

Keep charger B− separate from OUT− outside the board so the protection is not bypassed. Mark the user-supplied pigtails **GND, VBAT_SW, DATA**, checking both halves with a meter. A pixel pad marked +5 V still connects to VBAT_SW in this battery-powered build; do not attach a separate 5 V source to that rail.

## Everyday modes

| Action | POWER | MODE | USB |
|---|---|---|---|
| Use the sign | ON | RUN | Both unplugged |
| Turn sign off | OFF | RUN is acceptable | Both unplugged |
| Charge the cell | OFF | PROGRAM | Charger USB only |
| Program the XIAO | OFF | PROGRAM | XIAO USB only |

**Before connecting either USB, switch POWER off and select PROGRAM. Use only that USB port.** Disconnect USB before returning to RUN and turning POWER on. Move MODE only with POWER off and USB removed. PROGRAM is an electrical isolation position; it does not automatically put the XIAO into its bootloader. Use the captive reset button and the firmware's normal upload procedure as needed.

POWER off alone is insufficient for USB programming: in RUN, the XIAO's onboard charging path could feed the shared battery/pixel rail from USB. PROGRAM disconnects both BAT+ and DATA, preventing that intended-route backfeed and data-line parasitic powering. The circuit provides no automatic USB interlock; arbitrary USB/switch combinations are outside this manual operating procedure. [Seeed XIAO battery and charging documentation](https://wiki.seeedstudio.com/XIAO_BLE/)

## Charging and commissioning

The existing HiLetgo TP4056 board is advertised as up to 1 A. A **1000 mAh capacity does not establish the cell's maximum charge current**. Verify the actual board's setting against the cell specification before charging. Retain the existing current-setting resistor only if that setting is appropriate. If the cell's permitted rate is unknown or lower than the measured setting, resolve that before charging; a replacement programming resistor may then be required on the existing board, with no extra enclosure footprint. It is not an unconditional extra BOM item. A confirmed TP4056 commonly uses about 12 kΩ for 100 mA, but verify the IC and actual current after any change. [TP4056 current-setting and termination table](https://www.umw-ic.com/static/pdf/1c10411cf0937f9f813d2f3f7dea7cda.pdf)

Charge only with the load disconnected using the mode table. A simple TP4056 does not manage system load sharing; a live load can interfere with termination. Keep the XIAO USB unplugged during cell charging and the charger USB unplugged during programming. Check the intended USB-C cable works with the particular board revision.

Before final closure, verify continuity and shorts without the cell, capacitor polarity, POWER isolation, both PROGRAM contact openings, correct protected-ground wiring and no connection to unused throws. On the bench, measure startup and steady currents, all four pixel colors/order, dimming and resets as supply voltage falls. Confirm charger termination with the load disconnected. Test the closed case at intended brightness and during charging; use 40°C cell/case at 20–25°C ambient as a conservative build target, or the cell maker's lower limit. This is an acceptance test, not a simulated or certified thermal result.





## Revised routing and assembly

1. Load all eight nuts before electronics and optics; turn the upper-left rear nut to match its rotated pocket and slide it upward from the open interior. Fit the reset button first, with the housing open and yoke removed. Hold the rounded outside end about 9 mm inward from its final position, lower the button from the open front into its clearance, then slide it outward through the side-wall guide. Its internal flange stops it falling out.
2. Insert the XIAO from the open front **8 mm below the seated position**, then slide it upward 8 mm into the top USB opening. This lets the USB socket pass the button tip. Keep the reset released and leave wire slack for this movement. The yoke's removable lower stop locks the board afterward.
3. Insert the charger and both switches from the open front. The POWER switch keeps its successful fit. Seat the larger MODE switch in its new body pocket, with the six legs in their clear spaces and the actual actuator through the top opening. No printed MODE slider is used.
4. Dry-install the yoke with its two M3x8 screws. Confirm the board and switch bodies sit squarely, both USB cables fully engage, the MODE and POWER actuators reach both detents, and reset moves and returns without loading the PCB. Do not use screw force to seat an obstructed part.
5. After the fit sample passes, print the production parts. Assemble the unchanged optical stack using the laser instructions above. Route each LED pigtail through its existing side exit and secure the optical retainer with the two M3x6 screws.
6. With the battery disconnected, solder and insulate the selected two-switch circuit. Use the existing inline 330-ohm resistor, 680-uF capacitor and internal pigtails. No new electronic components are introduced. Confirm actual pin functions with labels and continuity; routing coordinates are wire-dressing locations, not pin assignments.
7. Place the battery in its cradle with an insulated base and a loose nonconductive strap. Secure the capacitor and insulated junctions in the existing right-hand space. Follow `routing-map.svg` and the updated cut list. Keep wire clear of the vent openings, button, nut pockets, PCB supports and USB roofs. Route XIAO solder joints through the angled windows, with service slack for the upward slide.
8. Repeat the button-first/XIAO-second assembly and fit the remaining components. Install the yoke and repeat all mechanical tests. Use measured thin nonconductive shims only if needed; do not clamp ICs, exposed solder joints or the battery pouch.
9. With POWER off and MODE at PROGRAM, connect the internal pigtail and close the optical subassembly by hand. Install the four front M3x25 screws gently. Complete the retained electrical and thermal commissioning checks before wall mounting with removable adhesive strips.

## Validation limits

The record checks nominal solids, assembly paths, control motion, reserved wire space, the enlarged XIAO connector envelope, STL integrity and slicer output. It does not prove the next print's fit, removal force, strength, actual solder shape or thermal performance. The user's next combined fit sample is the acceptance test. The laser geometry is unchanged and retains the previous sheet-thickness and kerf calibration requirements. No printing, laser operation or firmware flashing is performed by this release process.
