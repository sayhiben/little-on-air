#!/usr/bin/env python3
"""Render the firmware's actual home-screen code using its pinned Adafruit GFX.

Run under Linux/WSL after PlatformIO installs dependencies. Requires g++ and Pillow.
Hardware transport is stubbed; fonts, drawing primitives and layout are real GFX.
"""
import argparse
from pathlib import Path
import subprocess
from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, default=ROOT / 'build-buddy-ui')
args = parser.parse_args()
out = args.output.resolve()
out.mkdir(parents=True, exist_ok=True)
gfx = ROOT / 'apps/controller-esp32s3/.pio/libdeps/xiao_esp32s3/Adafruit GFX Library'
subprocess.run(['g++', '-std=c++11', '-O2', '-DARDUINO=100',
                '-I', str(ROOT / 'tests/oled/host'), '-I', str(gfx),
                '-I', str(ROOT / 'apps/controller-esp32s3/src'), '-I', str(ROOT / 'include'),
                str(ROOT / 'tests/oled/render.cpp'), str(gfx / 'Adafruit_GFX.cpp'),
                '-o', str(out / 'render')], check=True)
subprocess.run([str(out / 'render'), str(out)], check=True)
names = ['off', 'warn', 'on-air', 'okay', 'request', 'special', 'preview', 'offline',
         'first-start', 'sending', 'confirmed', 'not-checked', 'pair-help']
sheet = Image.new('RGB', (3 * 416, ((len(names) + 2) // 3) * 236 + 52), '#111722')
draw = ImageDraw.Draw(sheet)
draw.text((18, 15), 'Little On Air / Buddy UI - actual 128x64 firmware frames, enlarged 3x', fill='#dae7ed')
for index, name in enumerate(names):
    x, y = index % 3 * 416 + 16, index // 3 * 236 + 50
    frame = Image.open(out / f'{name}.pgm').convert('RGB').resize((384, 192), Image.Resampling.NEAREST)
    sheet.paste(frame, (x, y))
    draw.text((x, y + 201), name.replace('-', ' ').upper(), fill='#b8cdda')
sheet.save(out / 'oled-preview.png')
print(out / 'oled-preview.png')
