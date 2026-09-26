# Product manual images

The OLED panels are rendered from the firmware, not camera captures. They use
`apps/controller-esp32s3/src/buddy_ui.hpp`, the pinned Adafruit GFX font/drawing
implementation, and `tests/oled/render.cpp`. The examples describe controller
firmware `esp32s3-0.4.0`; their initial source baseline is commit `3b9a9a0`.

Regenerate from the repository root under Linux/WSL, after PlatformIO has
installed the application's dependencies and Pillow is available:

```sh
python tools/render_buddy_ui.py --output build/manual-oled
python tools/render_manual_screens.py --frames build/manual-oled --output docs/images/manual
```

`moods.png` shows six confirmed moods. Its added color bars are explanatory,
approximate swatches; the OLED is monochrome. `states.png` compares independent
preview, sending, confirmed and offline examples. The panels intentionally use
different moods and are not successive frames of a single transaction.
`pairing.png` shows first connection and physical recovery instructions. Every
OLED pixel is preserved at 3× nearest-neighbor scale. CI uses Pillow 10.4.0.

`devices.svg` and `power-modes.svg` are original, editable vector illustrations.
The device map follows the Igor measured-v4 controller and v2.15 receiver
assembly guides. It identifies controls, not dimensions, switch-lug orientation
or exact connector spacing. Colors do not certify printed material or LED color.
The power map follows the receiver's documented OFF/PROGRAM isolation sequence.
These files are documentation artwork, not manufacturing geometry.

When changing the UI, regenerate and visually inspect all three panels; keep
labels consistent with the real screen text. When changing hardware, update the
SVG sources against the relevant assembly/wiring guides. Preserve published CAD
exports and release checksums. All images have textual equivalents in the
[product manual](../../../README.md).
