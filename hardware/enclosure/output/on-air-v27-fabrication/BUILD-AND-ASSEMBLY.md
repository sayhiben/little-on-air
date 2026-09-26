# v2.7 â€” revised mechanical assembly

Print the combined fit plate first. Open its 3MF as a complete Bambu Studio project. It contains front sample 91, rear sample 99, keeper 06 and front reset button 07. The eSUN PLA+ preset is carried forward from the user's successful profile; generic PLA and PETG projects are also included. X1 Carbon, standard 0.4 mm nozzle, textured PEI, four walls, five top/bottom layers, 0.20 mm structural layers. The button and graphic use 0.10 mm layers.

The front prints face down, the housing flat back down, the keeper broad front face down, and the button external face down. Only the button uses automatic supports and a 5 mm brim. Other parts retain short bridges over nut traps and the optical screw-head recess. Remove strings and support cleanly before testing sliding fits. First-layer inspection is disabled, retaining the prior timeout workaround; bed leveling remains enabled.

Use four M3Ã—8 button-head screws and four ordinary M3 nuts for this fit plate: two upper closure joints and two keeper joints. The full case uses eight of each. Heads must be no larger than Ã˜5.7 Ã— 1.65 mm; nuts 5.5 mm across flats Ã— 2.4 mm thick. No washers. Load the nuts into empty parts first and tighten gently by hand.

1. Load housing nuts. The upper-left closure nut enters from below in the front view, lower-left from the right, and both right-hand closure nuts from the left. The left keeper nut enters from the right and the right keeper nut from the left. Load optical nuts from the right when assembling the full front.
2. Insert the reset button into the front frame from its rear. Feed the rounded keyed stem through the front guide until the flange rests against the internal collar. Its face projects 2.5 mm. Keep this subassembly separate while installing the electronics.
3. Solder and insulate the XIAO outside the case. Its component face points toward the display. Keep both long-edge pad rows clear of end supports; use its underside BAT/GND pads for the selected circuit. Limit underside solder projection to 1.25 mm and route its two flexible wires through the reserved rear gap toward the left. Do not add pin headers.
4. Lower the XIAO straight into its four end supports, USB-C toward the top. Its PCB back seats at depth 19.7 mm. The additional rear pad beneath reset resists button force. Keep wires out of the short corner stops.
5. Lower the charger straight into its supports with components facing the back and USB toward the top. Its bare PCB face is at depth 15.3 mm and component-side PCB face at 16.3 mm. OUT solder joints near the bottom corners must stay clear of the supports 5 mm above the bottom edge. The two LED centers align with the rear holes.
6. Lower POWER and MODE into their nests. MODE has no printed actuator: use its exposed fingernail slider. All six feet pass through the two open terminal-row channels. The main body, not the solder legs, should sit on the supports. The POWER bracket's outer ends remain open intentionally.
7. Install the keeper with two M3Ã—8 screws. Its short end pads retain the PCBs, its tips retain the switches, and its removable roofs finish the USB and slider openings. It should seat on its screw bosses by hand before tightening.
8. Check full engagement of both USB plugs and both switch detents. The USB openings leave 0.30 mm nominal clearance around the measured metal sockets. Verify neither PCB rocks and MODE's 0.15 mm depth clearance is acceptable on the actual print.
9. Bring the front subassembly straight onto the housing, threading the reset stem through its second keyed guide. Do not force it past resistance. Fit the two upper closure screws for the sample. Press and release reset twenty times. It should have a small initial gap, actuate reliably and return fully without shifting the PCB. The positive stop permits 0.60 mm travel; adjust only after identifying the actual contact gap.
10. After the sample passes, print full parts 01 and 05 and retain the tested 06/07 if their fit is good. The new upper-right screw position requires both new case halves. Existing acrylic, graphic backing and optical retainer remain usable.

## Wiring and final closure

Use `routing-map.svg` to locate the components and major passages, and `routing-coordinates.json` for the checked paths and their depths. Lines that cross in the front-view map often occupy different depths. The route-length CSV is a cutting allowance by physical harness segment; use the electrical connection table to identify each actual wire. Leave service slack, then trim after fitting the real connectors.

- Use flexible stranded wire: up to 0.9 mm insulated OD for individual leads and three-wire bundles; up to 0.8 mm OD for paired power routes. Maintain the dressed bundle shape when passing the keeper/charger crossing. Reserve the clear area beneath the charger keeper for the trunk and the offset POWER lead.
- Route the LED harness around the battery rather than laying bundles on its pouch. Keep all four LED entry edges clear. Solder and assemble the optical harness while the front is accessible; retain the resistor near the first pixel's DIN.
- The inline data resistor sits behind LED1 in the reserved 12.5 Ã— 5.7 Ã— 5.6 mm space. Keep its insulated body within 12 mm length Ã— 3.2 mm diameter and dress the two bypass power wires in front of or behind it within that space.
- Put the mated disconnect in the left lower bay, maximum 13 Ã— 10 Ã— 7.5 mm. Put the capacitor on its side in the right lower bay, maximum Ã˜8 Ã— 11.5 mm body. Insulate its leads and polarity-mark the negative side. Secure these to the back with suitable insulating adhesive; do not leave them loose against the battery or PCBs.
- Make the switched supply, protected ground and isolated DATA junctions in the open central space. F0 represents the physical three-wire trunk from these junctions to the disconnect. Keep heat-shrink splices within the reserved junction bays. Place wires at different depths where indicated, especially the two bottom LED runs and the POWER lead crossing the service trunk.
- Seat the 52 Ã— 21 Ã— 10 mm battery on a 0.5 mm insulating cushion and retain it with a loose 2.5 mm nonconductive strap through the two integral lugs. Do not compress the pouch or stack solder joints on it. Strap opening fit should be tested with the actual strap.
- The underside XIAO wire route uses the gap behind the PCB; its solder allowance leaves approximately 0.75 mm to the back wall. Dress these leads before clamping the board. Other pad wires leave through the open long sides; the upper-right exit stays inside the corner screw boss.

Assemble the unchanged optical stack using the retained laser and spacing instructions. Set POWER off and MODE to PROGRAM, connect the internal pigtail, close the halves by hand and install all four closure screws. No screw should bottom before the seam clamps. Leave the charger LED holes uncovered by wall adhesive.

The body is 24 mm deep and the front button adds 2.5 mm. This revision preserves 2.3 mm of rear wall and the tested optical depth. Going thinner would consume battery cushioning and wire space, so 24 mm is the present practical target.


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







