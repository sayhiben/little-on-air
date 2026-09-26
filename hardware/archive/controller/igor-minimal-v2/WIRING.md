# Wiring — USB-powered ESP32-S3 controller

Use the **standard XIAO ESP32-S3**, powered through its USB-C socket from the
computer. Its **5V pin is USB VBUS**. The OLED and encoder use the board's 3V3
output. The single WS2812B and its AHCT buffer use 5V. All grounds are common.
Leave the battery pads unconnected. Use thin, directly soldered wires instead
of pin headers in this enclosure.

## Pin assignment

| XIAO label | ESP32-S3 GPIO | Connect to |
| --- | --- | --- |
| D0 | GPIO1 | Encoder CLK / A |
| D1 | GPIO2 | Encoder DT / B |
| D3 | GPIO4 | Encoder SW, active low |
| D4 | GPIO5 | OLED SDA |
| D5 | GPIO6 | OLED SCL |
| D6 | GPIO43 | AHCT buffer A input, then WS2812B data |
| 3V3 | — | OLED VCC and KY-040 `+` |
| 5V | USB VBUS | Pixel +5V and buffer VCC |
| GND | — | OLED, encoder, pixel and buffer grounds |

Enable pull-ups on the three encoder inputs. A KY-040 board with onboard
pull-ups must be powered from **3.3 V** so those pull-ups cannot feed 5 V to the
ESP32-S3. Any OLED I2C pull-ups likewise belong on 3.3 V. Check the module's
actual printed GND/VCC order; cheap OLED boards vary.

D2/GPIO3 is deliberately unused because it is a strapping pin. Native USB
GPIO19/20, BOOT/GPIO0 and onboard LED GPIO21 are not reassigned. D6 is used for
the pixel instead of UART TX; diagnostics should use native USB.

## Pixel circuit

```text
XIAO D6 / GPIO43 ─────── A     SN74AHCT1G125     Y ── 330 Ω ── WS2812B DIN
                    │          VCC = 5 V                         +5V = VBUS
                  100 kΩ       /OE = GND                         GND = GND
                    │          GND = GND                         DOUT unused
                   GND
```

For the TI DBV / DCK five-pin package, `/OE=1`, `A=2`, `GND=3`, `Y=4`,
`VCC=5`. Verify the breakout's labels instead of assuming header order matches
package pin order. Tie `/OE` low; the 100 kΩ pulldown keeps A defined at boot.
Use a **74AHCT** buffer, not an HC-only part or an I2C MOSFET level shifter.

Place one 100 nF ceramic capacitor directly across the buffer's VCC/GND and
one across the pixel's +5V/GND if its carrier does not already have one.
Put the 330 Ω resistor close to pixel DIN. A 47 µF, ≥10 V capacitor across the
5 V feed near the front reduces local supply transients; connect its marked
negative lead to GND. Keep the pixel ground and data wires together.

The completed shifter/resistor assembly fits an **18 × 12 × 4 mm** insulated
envelope on the left inside wall, forward of the XIAO. Insulate and secure the capacitor inside the front cavity. Run the three pixel
wires along the inside wall to the small top LED carrier; leave the OLED
and encoder clear. The weights sit in the two floor recesses.

## Power and operation assumptions

The computer provides power; control remains local through the encoder and
BLE to the existing receiver. A desktop companion app is not required by
this hardware design. Reserve a **5 V / 500 mA USB supply budget** and measure
the completed unit; this is a design allowance, not a measured current draw.
Run BLE with Wi-Fi disabled unless a later feature needs Wi-Fi. Start the
single pixel around **12.5% brightness**; full white can draw roughly 60 mA
with older WS2812B variants. Do not drive a large strip from this wiring plan.

The controller loses power if the computer removes USB power during sleep or
shutdown. Boot must read the receiver's state without sending a new status.
Battery charging behavior and the nRF52840 low-power targets do not apply to
this USB controller.

## Sources

- [Seeed XIAO ESP32-S3 pinout and power](https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/)
- [TI SN74AHCT1G125 datasheet and package information](https://www.ti.com/product/SN74AHCT1G125)
- [Adafruit NeoPixel logic-level guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/logic-level)
