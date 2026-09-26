#!/usr/bin/env python3
"""Compose user-manual panels from render_buddy_ui.py's actual OLED frames.

Requires Pillow. Run render_buddy_ui.py first; no firmware screen is recreated
or retouched here. Nearest-neighbor scaling preserves every display pixel.
"""
import argparse
import colorsys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
BACKGROUND = "#f3f6f5"
INK = "#183b39"
MUTED = "#4e6664"
CARD_WIDTH = 416
CARD_HEIGHT = 304
GAP = 24
MARGIN = 24


def panel(frames, output, filename, title, entries):
    rows = (len(entries) + 1) // 2
    width = MARGIN * 2 + CARD_WIDTH * 2 + GAP
    sheet = Image.new("RGB", (width, 84 + rows * (CARD_HEIGHT + GAP)), BACKGROUND)
    draw = ImageDraw.Draw(sheet)
    heading = ImageFont.load_default(size=26)
    label = ImageFont.load_default(size=20)
    caption = ImageFont.load_default(size=16)
    draw.text((MARGIN, 20), title, fill=INK, font=heading)
    draw.text((MARGIN, 54), "Actual 128 x 64 OLED frames | enlarged 3x", fill=MUTED, font=caption)
    for index, (name, heading_text, detail, color) in enumerate(entries):
        x = MARGIN + (index % 2) * (CARD_WIDTH + GAP)
        y = 84 + (index // 2) * (CARD_HEIGHT + GAP)
        draw.rounded_rectangle((x, y, x + CARD_WIDTH - 1, y + CARD_HEIGHT - 1),
                               radius=12, fill="white", outline="#d5dfdc", width=1)
        draw.text((x + 16, y + 16), heading_text, fill=INK, font=label)
        with Image.open(frames / f"{name}.pgm") as source:
            if source.size != (128, 64):
                raise ValueError(f"{name}: expected a 128 x 64 firmware frame")
            frame = source.convert("RGB").resize((384, 192), Image.Resampling.NEAREST)
        sheet.paste(frame, (x + 16, y + 49))
        for text_value in (heading_text, detail):
            font = label if text_value == heading_text else caption
            if draw.textlength(text_value, font=font) > CARD_WIDTH - 32:
                raise ValueError(f"Caption would overflow: {text_value}")
        if color == "rainbow":
            for column in range(384):
                rgb = tuple(round(channel * 255) for channel in
                            colorsys.hsv_to_rgb(column / 384, 0.8, 0.85))
                draw.line((x + 16 + column, y + 251, x + 16 + column, y + 260), fill=rgb)
        elif color:
            draw.rounded_rectangle((x + 16, y + 251, x + 399, y + 260), radius=4, fill=color)
        draw.text((x + 16, y + 272), detail, fill=MUTED, font=caption)
    path = output / filename
    sheet.save(path)
    print(path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--frames", type=Path, default=ROOT / "build/manual-oled")
    parser.add_argument("--output", type=Path, default=ROOT / "docs/images/manual")
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    panel(args.frames, args.output, "moods.png", "Pick a mood. Press to send it.", [
        ("off", "OFF", "Dark | Taking a break", "#283b3b"),
        ("warn", "WARN", "Steady amber | One moment", "#ff9d25"),
        ("on-air", "ON AIR", "Steady red | I'm live", "#e54442"),
        ("okay", "OKAY", "Steady green | Come say hi", "#30a762"),
        ("request", "REQUEST", "Flashing green | A little help?", "#30a762"),
        ("special", "SPECIAL", "Flowing rainbow | Let's glow", "rainbow"),
    ])
    panel(args.frames, args.output, "states.png", "Selected is different from confirmed.", [
        ("preview", "PREVIEW", "Special selected; sign still On Air", None),
        ("sending", "SENDING", "Wait for the sign's reply", None),
        ("confirmed", "CONFIRMED", "A completed On Air request", None),
        ("offline", "OFFLINE", "Last known; not a live reading", None),
    ])
    panel(args.frames, args.output, "pairing.png", "Connect a sign or recover a pairing.", [
        ("first-start", "FIRST CONNECTION", "Open pairing on sign; press knob", None),
        ("pair-help", "RECOVERY", "Five separate, paced RESET presses", None),
    ])


if __name__ == "__main__":
    main()
