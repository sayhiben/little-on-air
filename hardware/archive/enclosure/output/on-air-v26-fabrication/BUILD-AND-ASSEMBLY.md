# ON AIR v2.6 — build and assembly

Replace **01 bezel, 05 rear housing, 06 yoke and 07 reset button** together. Retain the acrylic, graphic backing and optical retainer. Use the new common M3×8 screw specification with this revision.

## Print the combined fit plate first

Open `bambu-studio/on-air-v26-X1C-eSUN-PLA-plus-fit-checks.3mf` as a complete project. Its four parts are upper housing 99, yoke 06, button 07 and upper front-frame section 91. Use four M3×8 button-head screws and four M3 nuts to check the two upper closure joints and the yoke.

Generic PLA and PETG variants are also included. Select your actual spool. The eSUN PLA+ project retains the user's successful standard-nozzle settings. All projects target the X1 Carbon with a 0.4 mm nozzle at 100% scale. Structural layers are 0.20 mm with four walls and five top/bottom layers; the button and lettering use 0.10 mm layers.

The housing prints flat back down, the yoke broad front face down, and the front bezel front face down. Automatic supports are disabled for these parts; small holes and nut pockets retain short bridges. Only the button uses local supports, exterior face down with a brim. Remove its supports and strings from holes before fitting.

First-layer inspection remains disabled to preserve the workaround that allowed the previous print to finish. Bed leveling remains present. Watch the first two layers. No print has been sent by this release process.

## Common fasteners and display

Use **eight M3×8 button-head screws**, head no larger than Ø5.7×1.65 mm, and eight ordinary M3 nuts, 5.5 mm across flats and 2.4 mm thick. Four close the case from the front; two retain the optics; two retain the electronics yoke. No washers. Closure head bearing is 6.6 mm below the face. The rear nut roof is 2 mm thick and the front compression seat is 2.9 mm thick. The full closure nut thickness is engaged, with 0.6 mm of tip beyond the nut inside the blind boss.

Optical screw tips stop 1.075 mm behind the front face, about 0.425 mm before their blind bore ends. Yoke screws have about 0.55 mm tip clearance. Nut pockets are 6.0 mm across flats and 3.0 mm deep; screw bores are 3.6 mm. Load nuts before components and tighten gently by hand.

The keyed acrylic and engraving SVGs are unchanged. The printed graphic remains black through Z=1.6 mm, with white starting at the layer ending at 1.7 mm. Choose the AMS or manual-swap project. Only the manual graphic plate contains a planned filament-change pause. STLs contain no color instructions.

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

1. Load all eight nuts into the empty parts. The upper-left rear nut enters from below in the front view; the lower-left enters from the right, and the right-hand closure nuts from the left. Optical nuts enter from the right. The left yoke nut enters from the right and the right yoke nut from the left. Align the flats with the pockets.
2. Fit the reset button first, with the yoke removed. Hold its external end 9 mm inward from its final position, lower it through the open front, then slide it outward through the closed guide. Its flange stays inside and its rounded tip projects 3 mm.
3. With the battery disconnected, solder and insulate the XIAO wires outside the enclosure. The existing circuit uses BAT+, ground and D2. The underside BAT/GND wires pass through the central opening in the rear spine. Keep their solder within 1.25 mm of the PCB back; the dedicated loading channel carries these joints during the upward slide. Edge-pad solder joints face the open outer aisle. Keep insulation within the specified 0.8–0.9 mm wire envelopes and retain service slack.
4. Lower the XIAO from the front **8 mm below its final position**, then slide it upward 8 mm into the USB opening. Keep the free flexible power leads forward of the nearby yoke screw boss while loading, then dress them into the final notch. They must not pull the board or cross the reset, RGB sight line or nut entries. The yoke carries the lower side clamp so it can be fitted after the wired board is seated.
5. Insert the charger with its component side facing the back. Its LED centers should be visible through the two rear holes. The USB opening follows the flipped socket. Keep the clear areas 5 mm from the bottom edge at the lower PCB supports; neither OUT solder joint should rest on a support.
6. Insert POWER and MODE from the open front. All six DPDT legs enter the uninterrupted terminal-row spaces. Its 9.5 mm-wide pocket leaves 0.20 mm per side, while its keeper and rear seat leave 0.15 mm total depth clearance for the measured body. No printed MODE slider is used.
7. Fit the yoke with two M3×8 screws. Check both USB plugs fully engage without shifting the boards, both switches reach their detents, MODE stays seated and reset returns after twenty presses. Nominal reset free play is 0.10 mm and total travel 0.40 mm. Do not use screw force to overcome an obstruction.
8. Check the two upper closure joints with front sample 91. The M3×8 screws should clamp the seam before bottoming. After this sample passes, print complete revised parts 01, 05, 06 and 07.
9. Assemble the optical stack using the laser instructions above. Route the LED pigtails through their side exits and secure the optical retainer with two M3×8 screws. Complete and insulate the selected two-switch wiring, inline 330-ohm resistor, 680-uF capacitor and pigtails. No new electronic parts are required by this revision.
10. Place the battery on its insulated bed with a loose nonconductive strap. Secure the capacitor and insulated junctions in the existing right-hand space. Follow `routing-map.svg` and the wire cut list. Keep service slack clear of controls, indicators, USB openings and screws.
11. Set POWER off and MODE to PROGRAM, connect the internal pigtail and close the case by hand. Install the four remaining M3×8 screws at the front. Complete the retained commissioning checks before mounting. Leave the charger holes uncovered by adhesive strips; a flush wall obscures these rear service indicators.

## Fit limits

The records check native geometry, sampled assembly motion, nut access, reset travel, fourteen XIAO edge-pad exits, underside power-pad exits, LED sight lines, wire corridors, mesh integrity and slicing. The next fit print checks actual strength, tolerances and solder shapes. Charger PCB thickness remains a 1 mm assumption. Acrylic thickness and laser kerf still require material checks. The retained electrical operating procedure remains necessary for the two-switch circuit.
