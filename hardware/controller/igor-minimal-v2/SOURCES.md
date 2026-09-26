# Source geometry and references

Retrieved 2026-09-14 (local date).

## Exact Project IGOR basis

- Requested model: [Printables 1019283 — Project IGOR](https://www.printables.com/model/1019283-project-igor-open-source-offline-loyal-cheerful-fo).
- Creator: **UrbanCircles / Peter**.
- Creator-maintained repository: [UrbanCircles/igor](https://github.com/UrbanCircles/igor).
- Pinned commit: `7543085fe11f102f121f08aabd8f6c25c38bdf60`.
- Original STEP path: `3D Parts/Project IGOR v1 - shell, faceplate, basic hat (STEP).step`.
- Original 3MF path: `3D Parts/Project IGOR v1 - shell, faceplate, basic hat.3mf`.
- The STEP is copied byte-for-byte to `upstream/igor-v1.step`; SHA-256:
  `9645738bee23f74ca35bc64abd22047e27ce61a9ba0c0e83864a13e755bd8c33`.
- The original 3MF and repository MIT license are included alongside it.

Printables did not return the model page to the research fetcher. The original
geometry was obtained from the author's public repository, whose README describes
Igor's components and assembly. This remix does not use a traced
picture, unrelated enclosure or reconstructed approximation of Igor.

The creator's generic OLED description does not uniquely identify a currently
sold PCB. The original model's screen opening and mounting centers therefore
define compatibility. Match the actual module before printing the full shell.

## XIAO board reference

- [Seeed getting-started page and mechanical downloads](https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/).
- [Manufacturer 3D-model ZIP](https://files.seeedstudio.com/wiki/SeeedStudio-XIAO-ESP32S3/res/seeed-studio-xiao-esp32s3-3d_model.zip).
- `XIAO-ESP32S3 v2.step` is stored locally as `reference/xiao-esp32s3-seeed.step`
  for fit checks. It is manufacturer reference data, not an original Little
  On Air design. SHA-256:
  `870ad45c7af5d92324cec4c6ae65fbf86e3b049d5a97ab9ffd9039ebd73455dd`.

## Electrical references

- [Seeed pin map and USB power](https://wiki.seeedstudio.com/xiao_esp32s3_getting_started/).
- [TI SN74AHCT1G125](https://www.ti.com/product/SN74AHCT1G125).
- [Adafruit NeoPixel level shifting](https://learn.adafruit.com/adafruit-neopixel-uberguide/logic-level).

Wheel-weight dimensions in this revision are an explicit **maximum envelope**,
not a claim that all 5 g or all adhesive wheel weights are interchangeable.
