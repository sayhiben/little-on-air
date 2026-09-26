# Firmware included with the manufacturing release

Enclosure revision **2.16** and firmware version **0.1.2** are separate version numbers. The earlier v0.1.2 firmware snapshot is preserved under `firmware/`; its exact commit is recorded in the release manifest. It is not a statement of the current development repository’s firmware capabilities. This packaging task does not change, build or flash firmware.

The bundled snapshot uses `src/status_output_pwm.c` and the board's `pwm_red`, `pwm_green` and `pwm_blue` aliases. It operates the **onboard RGB LEDs**, including the XIAO indicator visible through the new front guide. It does **not** configure or drive the four external NeoPixels on D2/P0.28.

The two-switch wiring guide reserves D2/P0.28 for the external data chain. To finish the illuminated display, use and validate an external addressable-pixel driver configured for the actual four modules, their protocol/color order, the data pin and a conservative brightness ceiling. Startup, low-cell-voltage behavior and current must then be tested with the physical harness. The PWM brightness setting alone does not add an addressable LED output.

The source ZIP contains the repository's firmware build, flashing, pairing and diagnostics guides, plus its pinned dependency manifest. The Zephyr toolchain/dependencies and generated local build directories are not included. No ambiguous local UF2 or ELF was selected as a release binary.

For USB work on the assembled sign, the enclosure's operating procedure takes precedence over the generic source flashing instructions: **POWER off, MODE in PROGRAM, only the XIAO USB plugged in**. Double-tap the front reset to use the factory bootloader as described in the source's `docs/FLASHING.md`. MODE selects electrical isolation; it does not enter the bootloader automatically. Unplug USB before selecting RUN and turning POWER on.
