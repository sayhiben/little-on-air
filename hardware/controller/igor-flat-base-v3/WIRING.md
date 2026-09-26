# USB-powered ESP32-S3 controller wiring

Use the standard XIAO ESP32-S3, powered by computer USB-C. Leave its battery
pads unconnected. OLED and encoder use 3.3 V; the NeoPixel and AHCT buffer use
the board's USB 5V pin. All grounds are common. Use directly soldered thin
wires and no pin headers.

| XIAO label | GPIO | Connection |
| --- | --- | --- |
| D0 | 1 | Encoder CLK / A |
| D1 | 2 | Encoder DT / B |
| D3 | 4 | Encoder SW, active low |
| D4 | 5 | OLED SDA |
| D5 | 6 | OLED SCL |
| D6 | 43 | AHCT input, then pixel data |
| 3V3 | — | OLED VCC and encoder + |
| 5V | USB VBUS | Pixel and buffer VCC |
| GND | — | All grounds |

Enable pull-ups on encoder inputs. Power KY-040 pull-ups and OLED I2C pull-ups
from 3.3 V. Check each module's printed VCC/GND order. D2/GPIO3 is a strapping
pin and remains unused; native USB GPIO19/20 and BOOT/GPIO0 are not reassigned.

## One front NeoPixel

The mount is for a **5 mm through-hole addressable NeoPixel**, such as
[Adafruit 1938](https://www.adafruit.com/product/1938), with a flange at most
6 mm across. This replaces the earlier 10 × 10 mm carrier. The model allows
7 mm for the body and 7 mm behind the flange for trimmed, insulated leads.
Check the actual dimensions and vendor pinout before printing. An ordinary
four-lead RGB LED is electrically different and cannot be substituted.

Adafruit listed 1938 out of stock when checked on 2026-09-15; a mechanically
compatible addressable pixel can be used after checking its dimensions and
pinout. The flange sits in the rear shoulder and is secured with adhesive.

```text
XIAO D6 ── A  [SN74AHCT1G125, VCC=5 V]  Y ── 330 ohm ── Pixel DIN
           │          /OE = GND                         DOUT unused
         100 kohm                                       +5V = USB 5V
           │                                           GND = common
          GND
```

For TI's five-pin DBV/DCK package: /OE=1, A=2, GND=3, Y=4, VCC=5. Check
breakout labels separately. Use an **AHCT** buffer for 3.3 V input at 5 V supply.
Tie /OE low and put the 100 kohm pulldown on A.

Fit **100 nF across the pixel's power leads**, close to the LED, plus 100 nF
at the buffer supply. Fit a 47 µF capacitor rated at least 10 V across 5V/GND
near the front wiring; observe polarity. Put the 330 ohm resistor close to DIN.
Insulate every trimmed LED lead and solder joint. Dress the local capacitor
clear of the display and faceplate closure.

Secure the insulated buffer/resistor assembly within 18 × 12 × 4 mm against
the left inner wall. Keep the capacitor within a 6.3 mm diameter × 8.5 mm
envelope in the front cavity. Route the XIAO antenna on upper plastic, away
from weights.

Adafruit 1938 specifies **RGB color order**; many flat 5050 modules use GRB.
Set the driver for the actual pixel and confirm the three colors individually.
Start at low brightness. Reserve a 5 V / 500 mA USB supply budget and measure
the complete controller; this is a design allowance, not measured consumption.

The computer may remove USB power during sleep or shutdown. The intended
firmware reads receiver state at boot without issuing a new status command.
The ESP32-S3 firmware port remains unfinished.

## References

- [Seeed XIAO ESP32-S3 pin map and power](https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/)
- [TI SN74AHCT1G125](https://www.ti.com/product/SN74AHCT1G125)
- [Adafruit 5 mm NeoPixel](https://www.adafruit.com/product/1938)
- [Adafruit logic-level guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/logic-level)
