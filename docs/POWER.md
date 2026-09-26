# Power for the current devices

The desk controller is a USB-powered XIAO ESP32-S3 and has no battery. Its OLED
dims after 30 seconds and turns off after two minutes; the first gesture wakes
it without sending a command. Its mood pixel uses brightness 24/255. Background
reads do not wake the OLED or restart the animation.

The sign uses a single-cell LiPo, protected TP4056 charger, POWER switch and
RUN/PROGRAM isolation switch. Normal use is battery-powered RUN with both sign
USB ports unplugged. For charging or firmware service, POWER OFF, select PROGRAM
with USB removed, then connect only the intended port. Unplug USB before
selecting RUN and powering on. See the [manual power table](../README.md#power-and-charging)
and [current wiring guide](../release/little-on-air-enclosure-v2.15/guides/WIRING.md).

The normal receiver disables USB console/logging and unused UART, I²C, QSPI and
802.15.4 peripherals. SPI2 is enabled for the four front pixels, and PWM drives
the independent onboard indicator. Bonded advertisements are about one second
apart; the unpaired 60-second pairing window uses 100 ms intervals. Animation
runs on the receiver without continuous radio traffic.

Front-pixel brightness is 160 permille (16%). Onboard RGB brightness is 125
permille with R/G/B calibration 1000/650/500; the current power indicator is red.
These receiver definitions live in `apps/receiver/CMakeLists.txt`. The power
light remains on when the mood is Off, so Off does not mean zero power draw.

No current battery-runtime guarantee or measured idle-current specification is
claimed. Retired controller microamp targets do not apply to the ESP32-S3 desk
controller. Measure the actual assembled sign, battery voltage, instruments,
firmware hash, mood, brightness and power arrangement. Check color, load and
thermal behavior before changing brightness. Verify the charger's actual IC,
current setting and indicators against the fitted cell; do not infer them from
a generic TP4056 board name. USB diagnostic builds are for servicing, not normal
power measurements.
