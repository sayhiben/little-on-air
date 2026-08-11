# Power notes

The firmware uses the board's DC/DC mode, hardware PWM, kernel idle sleep,
disabled application USB/console logging, and disabled UART, I2C, SPI, QSPI,
and IEEE 802.15.4 peripherals. The controller scans only for a command,
startup reconciliation, or bounded recovery. The receiver advertises at about
one-second intervals when bonded and at 100 ms only during a 60-second pairing
window.

The v0 measurement gates, with all LED channels off, are:

- Controller, synced and not scanning: no more than 150 uA average.
- Receiver, bonded and advertising: no more than 300 uA average.

These are hardware acceptance targets, not modeled values. Record actual meter
results in a release issue before declaring them met.

Solid LEDs dominate battery usage. The default PWM ceiling is 12.5%, and the
red/green/blue calibration defaults are 100%, 65%, and 50% of that ceiling.
Change the CMake cache variables only after checking color balance and battery
runtime:

```sh
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -- \
  -DLOA_LED_BRIGHTNESS_PERMILLE=80
```

The XIAO charger is intended for a single-cell LiPo. Use a protected cell with
correct polarity and follow Seeed Studio's battery guidance.
