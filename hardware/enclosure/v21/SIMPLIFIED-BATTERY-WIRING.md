# Selected build — direct battery power, existing v2.1 case

**Switch update — 2026-09-09:** the supplied [WMYCONGCONG switch listing, B07F7PNDGM](https://www.amazon.com/dp/B07F7PNDGM), specifies **100 mA and 12 V DC**. A manufacturer datasheet or capacitive-load rating was not provided. **Do not use the direct-load switch wiring below with this switch as currently specified.** It remains an option with a suitably rated replacement; retaining this switch requires an electronic power-switch stage and revised wiring. No change to the STL geometry is required by this finding. The reduced BOM is provisional until that choice is resolved.

This note supersedes the regulated 5 V circuit, auxiliary-board assembly steps and electrical commissioning instructions in the original v2.1 guide for this build. Use the same STLs, acrylic SVGs, optical stack, fasteners and printed assembly sequence. No new printed part is required. The original 5 V circuit remains documented as an alternative.

The selected additions are one 330 ohm data resistor, one bulk capacitor (680 microfarads was the original choice; rated at least 6.3 V), and the user's pigtail disconnects. U2, U3, C2, R2 and PCB2 are omitted for the direct-battery architecture. Omitting Q1/R4 was conditional on adequate mechanical-switch ratings; the newly identified 100 mA switch does not establish that suitability. R3 is not an automatic purchase or modification: first establish the charger's actual current and the cell's allowed charge current. See `BOM-SIMPLIFIED.csv`.

## Construction

- Leave the unused auxiliary landings in place. The yoke retains the original charger, XIAO and switch independently of the omitted components; the extra boards are not structural spacers.
- The original capacitor body envelope is diameter 8 × length 11.5 mm, in the right auxiliary area. A larger capacitor is not covered by that fit check. Secure its insulated body to the unused landing; provide lead slack and strain relief. It must not hang from solder joints or bear against the battery pouch, optical insert or yoke.
- Install the resistor physically in the DATA lead, close to the first pixel. Keep its heat-shrink bulge in open interior space, outside the narrow LED seat exits. Keep all LED light-entry faces clear.
- Install the capacitor electrically **across switched pixel power and protected ground**, observing polarity. It is physically attached to the harness, but is **not in series** with either supply conductor. Insulate both leads separately.
- The original front disconnect reservation is 13 × 10 × 7.5 mm for the mated connector body. Check the actual pigtail bodies, latch movement and wire bends during a dry closure. Additional disconnects can use the vacant auxiliary space if they clear the yoke and optical assembly. Their exact positions and shapes have not been modeled.
- Keep connector housings and solder/heat-shrink bulges out of the case seam, screw pockets and moving controls. Keep service slack forward of the pouch rather than underneath it. Close the case by hand before tightening screws.

## Direct-load wiring — requires a suitably rated switch

Use the DPDT as a power disconnect on one pole and a data disconnect on the other. Identify commons and throws with a continuity meter; the leg order cannot be established from its dimensions. Label the same physical detent RUN on both poles. Leave the OFF throws unconnected and individually insulated.

| Connection | Destination |
|---|---|
| Battery + / − | Charger B+ / B−, permanently |
| Charger OUT− | XIAO BAT−/GND, all pixel GND pads and capacitor − |
| Charger OUT+ | Pole A RUN throw |
| Pole A common | XIAO BAT+, all pixel supply + pads, capacitor + |
| Pole A OFF throw | Unconnected and insulated |
| XIAO D2 / P0.28 | Pole B RUN throw |
| Pole B common | 330 ohm resistor → first pixel DIN; resistor physically near pixel |
| Pole B OFF throw | Unconnected and insulated |
| Each pixel DOUT | Next pixel DIN; fourth DOUT unconnected |

The pixel supply pad may be labeled +5V even though this alternative feeds it from the protected single-cell battery. Preserve the common protected ground. Do not externally bridge charger B− to OUT−. The pixel load is supplied from the switched protected battery rail; the XIAO's 3.3 V regulator is not the LED power source. Mark the pigtails GND, BATTERY + and DATA, using verified pin positions rather than assumed wire colors.

In OFF, pole A disconnects battery positive from both loads; pole B disconnects the MCU data output from the pixels. This prevents a USB-powered MCU from supplying unpowered pixels through DIN. Neither OFF terminal needs a ground connection. A charged capacitor may keep the pixels alive briefly after switching off.

| Use | Switch | USB |
|---|---|---|
| Operate sign | RUN | Both USB ports unplugged |
| Charge battery | OFF | Charger USB only |
| Program XIAO | OFF | XIAO USB only |

Switch OFF before connecting either USB cable. This design has no automatic load-sharing circuit or USB interlock. Disconnect internal pigtails with USB removed, switch OFF and the capacitor discharged.

## Checks before operation

The omitted MOSFET means **pole A carries the combined XIAO/pixel current and capacitor charging surge**. The now-identified switch is listed at 100 mA. Adafruit's conservative older-pixel estimate is up to 60 mA per RGB pixel at full white, or 240 mA for four, before the MCU. This is a design budget, not a measurement of the unidentified side-light variant on battery voltage. A firmware brightness limit reduces average LED demand but does not limit the initial bulk-capacitor charging current. Neither a capacitive-load rating nor a measured startup waveform is available for this switch. [Adafruit current estimate](https://learn.adafruit.com/adafruit-neopixel-uberguide/powering-neopixels), [TI capacitor inrush explanation](https://www.ti.com/lit/an/slva670a/slva670a.pdf)

Use a switch rated for the actual steady and startup load, or retain this DPDT only as a control for an electronic power-switch stage. Lowering the supply voltage does not automatically allow exceeding the listed 100 mA, and the two poles should not be paralleled to invent a higher rating. An electronic stage must also preserve the intended USB-programming isolation; simply replacing the mechanical power contact with an arbitrary single MOSFET is not a validated revision. The needed stage does not imply restoring the 5 V booster or level shifter.

Verify the charger resistor/current against the actual battery specification. The 1000 mAh capacity alone does not establish an allowed charge current. The earlier 100 mA proposal was a conservative design choice, not a mandatory value. Leaving the factory setting unchanged is acceptable only if it is appropriate for the actual cell and the closed-case temperature test.

Adafruit supports short NeoPixel chains powered from a nominal 3.7 V LiPo with 3.3 V data. The exact side-light pixel variant remains unidentified, so verify the intended colors and brightness across the usable battery-voltage range, including blue/white near the low end. This alternative has no regulated 5 V rail. [Adafruit battery/data guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/basic-connections)

Retain each pixel's original SMD capacitor. Adafruit recommends the first-pixel series resistor and a bulk capacitor for supply transients. [Adafruit wiring precautions](https://learn.adafruit.com/adafruit-neopixel-uberguide/best-practices)

Check OFF isolation with a meter before inserting the XIAO USB cable. Verify the capacitor polarity, connector pinout, current consumption and closed-case temperature on the bench. The existing firmware still needs four-pixel NeoPixel output; configure the data pin initially low and transmit an all-off frame on startup.

The v2.1 digital mechanical checks remain applicable to its unchanged geometry. The original harness map illustrates available corridors, but its auxiliary-board endpoints, wire counts and cut lengths describe the alternative 5 V circuit. Do not use it as this circuit's netlist. The simplified harness and the user's actual pigtails have not been rerouted or physically fit-tested.
