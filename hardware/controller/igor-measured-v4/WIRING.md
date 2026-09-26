# USB-powered measured controller

The standard XIAO ESP32-S3 is powered through computer USB-C. Leave battery
pads unconnected. Power the encoder pull-ups and compatible I2C OLED from
3.3 V; power the single NeoPixel and AHCT buffer from USB 5 V. Join all grounds.
The proposed GPIO assignment follows [Seeed's pin map](https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/).

| XIAO label | GPIO | Connection |
| --- | --- | --- |
| D0 | 1 | Encoder CLK / A |
| D1 | 2 | Encoder DT / B |
| D3 | 4 | Encoder SW, active low |
| D4 | 5 | OLED SDA |
| D5 | 6 | OLED SCL |
| D6 | 43 | AHCT input, then pixel DIN |
| 3V3 | — | OLED VCC and encoder + |
| 5V | USB VBUS | Pixel and buffer VCC |
| GND | — | All grounds |

Enable encoder input pull-ups. Follow each module's printed pin labels; a
four-pin header does not establish pin order or identify the display driver.
Keep I2C pull-ups at 3.3 V. This mechanical revision retains the encoder and
OLED headers; use soldered wires at the XIAO, whose tall pin headers are not
modeled. D2/GPIO3 is left unused and native USB pins are not reassigned.

## Mini NeoPixel strip

Use the user's **17.6 × 5 × 1.4 mm segment**, with the LED centered behind the
diffuser. The exact Adafruit strip SKU was not supplied. Connect the pad marked
**DIN** or the input end indicated by its arrow; leave DOUT unused. Confirm
color order by lighting red, green and blue separately at low brightness.
Do not reuse the revision 3 through-hole pixel assumption.

```text
XIAO D6 ── A  [SN74AHCT1G125, VCC=5 V]  Y ── 330 ohm ── Strip DIN
           │          /OE = GND                         DOUT unused
         100 kohm                                       +5V = USB 5V
           │                                           GND = common
          GND
```

Use the AHCT family for the 3.3-to-5 V data buffer and check the package or
breakout pinout. Tie /OE low. This circuit uses a 100 kohm input pulldown and
a 330 ohm series resistor near DIN. [TI SN74AHCT1G125](https://www.ti.com/product/SN74AHCT1G125),
[Adafruit signal and power guidance](https://learn.adafruit.com/adafruit-neopixel-uberguide/best-practices).

Provide 100 nF bypassing close to the pixel and buffer; account for bypassing
already fitted to the strip. Retain the prototype's compact 47 µF, at least
10 V bulk capacitor near the front power wiring, observing polarity. This is
a one-pixel design allowance and needs a bench check; Adafruit's general guide
recommends larger bulk capacitance for larger pixel installations. Do not force
a larger capacitor into the reserved 6.3 mm diameter × 8.5 mm space.

Keep the insulated buffer/resistor assembly within 18 × 12 × 4 mm against the
left inner wall. Route strip-end wires outside its narrow holder channel and
provide strain relief after dry-fitting. Keep the antenna against upper plastic
away from weights. The complete harness and antenna have not been fit-tested.

Budget up to 5 V / 500 mA for this prototype and measure actual consumption;
this is not a measured current claim. Computer sleep or shutdown may remove
USB power. The intended firmware reads receiver state at boot without sending
a new status. See [firmware status](FIRMWARE.md).
