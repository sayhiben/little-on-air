# ON AIR v2.3 — measured-fit build

Replace **05 rear housing, 06 retaining yoke and 07 reset button** together. Omit the old printed part 08. There are six printed assembly parts plus one laser-cut acrylic panel. The front optical bezel, graphic, retainer and all laser files remain compatible with v2.2. See REVISION-NOTES.md for measurements and allowances.

## Fit checks and print setup

Start with the eSUN PLA+ fit-check project. It carries the filament profile from the user's successful inspection-off print and contains only the four changed mount sections, full yoke and rounded reset button. First-layer inspection is disabled; keep bed leveling enabled and observe the first two layers yourself. Open as a complete project and retain embedded settings. No print has been started by the assistant.

Use the supplied orientation at 100% scale. The housing prints on its flat back; the yoke prints on its broad front rails; the reset button stands on its exterior face so its guide section is formed in XY. Remove its brim and any flange support before testing. The rear housing and XIAO sample permit local supports beneath the guide projection; remove those supports without altering the guide bore. Structural profiles use a 0.4 mm nozzle, 0.20 mm layers and four walls. The reset button uses 0.10 mm layers. The graphic retains its 0.10 mm layers and black-to-white change after 1.6 mm. AMS and manual-swap projects are labeled separately; only the manual graphic plate has an intentional filament-change pause.

Other material projects are supplied for PLA and PETG. Select the actual spool and validate the same coupons in the intended material. A generic PLA profile is not a certified profile for every PLA+ formulation. Do not scale the assembly to solve a single tight hole.

Before fitting the XIAO, assemble the button and yoke to the housing and check the stem slides freely without rocking excessively. Its keyed section is 2.8 mm across flats in a 3.2 mm guide, with 4.8 mm bearing length. After fitting the XIAO, verify no preload, reliable release, single presses and double presses. Nominal inward motion is 0.45 mm including 0.15 mm free play; test the real switch before powering.

Fit the charger and POWER switch without forcing the printed cheeks apart. The charger PCB thickness remains an assumption at 1 mm; measure that if the keeper height does not match. Verify both USB plugs fully engage while the boards remain stationary. The measured socket envelopes do not establish the dimensions of every possible cable overmold.

## Fasteners and optical joints

Retain four M3x25 socket-head closure screws, two M3x6 button-head optical screws, two M3x8 button-head yoke screws, and eight ordinary 5.5 mm-AF x2.4 mm M3 nuts. The rear nut traps remain 6 mm across flats and 3 mm high; closure bores are 3.6 mm and front head recesses 6.8 mm. Hardware remains recessed. Seat the seam by hand before tightening; do not use screws to pull a trapped wire or misaligned board into position.

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

The circuit above is unchanged. The routes and cut lengths in this release reflect the raised switch bodies and reinforced XIAO frame. Route coordinates are front-view X/Y with positive depth measured rearward. The marked corridors reserve room for insulated wires and bends; endpoints are dressing locations, not asserted pin numbers. Verify actual pin functions with continuity and labels.

1. Print and cool the fit plate. Clean brim and strings. Test the charger, XIAO/reset, DPDT and SPDT sections with the complete yoke. Check both detents on each switch, full cable seating, and twenty reset presses with reliable return.
2. Identify and label switch contacts. Solder and insulate the switch, board and LED harness with the battery disconnected. The DPDT needs no printed slider; preserve room around its actual actuator.
3. Prepare the acrylic and registered optical stack using the unchanged laser instructions. Fit LED wires into their side exits, and secure the optical retainer with the two M3x6 screws.
4. Side-load the rear and yoke nuts. Place the insulated battery in its cradle and retain it with a loose nonconductive strap. Secure the capacitor and insulated junctions on the right landing.
5. Insert the charger from the open front. Insert the XIAO with its board 8 mm below the final position, then slide it up 8 mm into the port; the yoke provides its removable lower stop. Keep XIAO solder joints inside the two access windows, clear of the crossbar and diagonal braces. Place the new reset button into its front-open guide after the XIAO; the internal flange remains inside the housing.
6. Insert both switches from the open front. The SPDT flange enters its internal rebate and its lever passes through the top slot. The DPDT actuator passes through the smaller top opening; use a fingernail to change MODE. Dress the soldered leads toward the interior before lowering the yoke.
7. Follow the updated wire corridors and leave service slack. Keep the reset guide, PCB support faces, port roofs and nut pockets clear. Use the same internal pigtails, 330-ohm resistor and 680-uF capacitor already selected; no additional electronic parts are introduced by this revision.
8. Install the complete revised yoke with two M3x8 screws. The yoke restrains both boards and both switches and completes the reset guide. Use measured thin nonconductive shims only where needed; never load an IC, USB shell, exposed solder joint or battery pouch as a clamp surface.
9. Repeat the button, switch and USB tests. With POWER off and MODE at PROGRAM, connect the internal pigtail and close the case by hand. Install the four front M3x25 screws gently into the captive rear nuts.
10. Complete the retained electrical and thermal commissioning checks before applying removable wall strips. Firmware support for the external four-pixel chain remains a separate operational requirement; this mechanical revision does not flash firmware.

## Validation limits

The accompanying record covers nominal solid intersections, insertion paths, control travel, wire clearance volumes, watertight STL exports and slicing. It cannot establish the actual dimensional error of the next printed part, switch actuation force, unidentified PCB thickness, solder shape or a particular USB cable's overmold. These require the new fit samples. The successful prior print established that bypassing inspection allowed that job to run; the printer-side inspection fault itself was not repaired.
