#!/usr/bin/env python3
"""Compile the real padded encoder, then decode its waveform with an independent model.

This is a digital signal simulation, not an nRF52840 or electrical emulator.
Use Linux/WSL with a host C compiler. No third-party Python packages required.
"""
import argparse
import hashlib
import itertools
import json
import random
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def require(condition, message):
    if not condition:
        raise AssertionError(message)


def waveform(encoded, clock_ns, startup_ns=0, gap_ns=0, noise=False, dma_chunk=65535):
    """Model MSB preload before the clock and an optional DMA split."""
    runs = []

    def add(level, duration):
        if duration <= 0:
            return
        if runs and runs[-1][0] == level:
            runs[-1] = (level, runs[-1][1] + duration)
        else:
            runs.append((level, duration))

    if noise:
        # An incomplete previous pulse train must be discarded by leading LOW.
        for level, duration in [(1, 750), (0, 500), (1, 250), (0, 1000), (1, 750)]:
            add(level, duration)
    first = (encoded[0] >> 7) & 1
    add(first, startup_ns)
    for index, byte in enumerate(encoded):
        if index and index % dma_chunk == 0:
            # The outgoing last bit and incoming first bit are both zero here.
            add(encoded[index - 1] & 1, gap_ns)
            add((byte >> 7) & 1, startup_ns)
        for shift in range(7, -1, -1):
            add((byte >> shift) & 1, clock_ns)
    add(0, 300_000)  # Original driver's post-transfer wait, assuming idle LOW.
    return runs


def decode(runs, reset_ns):
    """A deliberately simple pulse-width receiver: >=550 ns high is a one.

    Reset/latch on a continuous LOW interval. An overlong first pulse may be
    interpreted as one in this fault model; actual pixel ICs can differ.
    """
    bits, frames = [], []
    for level, duration in runs:
        if level:
            bits.append(int(duration >= 550))
        elif duration >= reset_ns:
            if len(bits) >= 96:
                require(len(bits) == 96, f"Unexpected data pulse count: {len(bits)}")
                channels = [sum(bits[i + j] << (7 - j) for j in range(8))
                            for i in range(0, 96, 8)]
                frames.append([(channels[i + 1], channels[i], channels[i + 2])
                               for i in range(0, 12, 3)])
            bits = []
    return frames


def check_nominal_waveform(runs, pixels, timing, reset_ns):
    """Check every HIGH/LOW pair against independently specified target timings.

    This uses neither the C encoder's symbol constants nor the permissive
    fault-model decoder. Include the final data LOW before the reset padding.
    """
    bits = [int(bool(channel & (1 << shift)))
            for red, green, blue in pixels
            for channel in (green, red, blue) for shift in range(7, -1, -1)]
    require(len(runs) == 1 + 2 * len(bits), "Missing or extra data transitions")
    require(runs[0] == (0, reset_ns), "Incorrect leading reset")
    for index, bit in enumerate(bits):
        high, low = timing[bit]
        if index == len(bits) - 1:
            low += reset_ns + 300_000  # Trailing padding and original driver wait.
        require(runs[1 + 2 * index] == (1, high), f"Bit {index}: HIGH duration/order")
        require(runs[2 + 2 * index] == (0, low), f"Bit {index}: LOW duration/order")


def chunk_lengths(length, maximum):
    return [min(maximum, length - start) for start in range(0, length, maximum)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--profile", choices=["padded", "timing375"], default="padded")
    parser.add_argument("--output", type=Path)
    parser.add_argument("--compiler", default="cc")
    parser.add_argument("--devicetree-header", type=Path)
    parser.add_argument("--reference-encoder", type=Path,
                        help="Optional previously compiled encoder for byte-exact regression")
    args = parser.parse_args()
    timing375 = args.profile == "timing375"
    if args.devicetree_header is None:
        args.devicetree_header = ROOT / f"build/receiver-pixels-{args.profile}" / "zephyr/include/generated/zephyr/devicetree_generated.h"
    output = (args.output or ROOT / ("build/pixel-simulation-timing375" if timing375
                                    else "build/pixel-simulation")).resolve()
    output.mkdir(parents=True, exist_ok=True)
    runner = output / "encode_frames"
    defines = ["-DCONFIG_LOA_PIXELS_TIMING_375NS=1"] if timing375 else []
    subprocess.run([args.compiler, "-std=c11", "-O2", "-Wall", "-Wextra", "-Werror",
                    *defines,
                    "-I", str(ROOT / "include"), str(ROOT / "src/ws2812_frame.c"),
                    str(ROOT / "tests/pixels/encode_frames.c"), "-o", str(runner)], check=True)
    subprocess.run([str(runner), "--self-test"], check=True)
    info = json.loads(subprocess.check_output([str(runner), "--info"]))
    generated = args.devicetree_header.read_text()
    build_config = (args.devicetree_header.parents[3] / ".config").read_text()
    require(("CONFIG_LOA_PIXELS_TIMING_375NS=y" in build_config) == timing375,
            "Host profile differs from the built firmware Kconfig")
    require("CONFIG_LOA_PIXELS_PADDED_SPI=y" in build_config,
            "Built firmware does not use the padded driver")
    require("CONFIG_WS2812_STRIP_SPI=y" not in build_config,
            "Upstream eight-bit-symbol driver must be disabled")
    alias = re.search(r"#define DT_N_ALIAS_loa_pixels\s+(\S+)", generated)
    require(alias is not None, "Built firmware has no front pixel alias")
    node = alias[1]
    bus_node = node.rsplit("_S_", 1)[0]
    dma_bits = int(re.search(rf"#define {bus_node}_P_easydma_maxcnt_bits (\d+)", generated)[1])
    dma_max = (1 << dma_bits) - 1
    bus_max = int(re.search(rf"#define {bus_node}_P_max_frequency (\d+)", generated)[1])
    require(info["spi_hz"] <= bus_max, "SPI frequency would be clamped by the driver")
    for prop, key in [("spi-max-frequency", "spi_hz"), ("reset-delay", "reset_us"),
                      ("bits-per-symbol", "symbol_bits"), ("spi-zero-frame", "zero_symbol"),
                      ("spi-one-frame", "one_symbol"), ("chain-length", "pixels")]:
        built = re.search(rf"#define {node}_P_{prop.replace('-', '_')} (\d+)\b", generated)
        require(built and int(built[1]) == info[key], f"Built firmware differs: {prop}")
    for index, expected in enumerate([2, 1, 3]):
        mapping = re.search(rf"#define {node}_P_color_mapping_IDX_{index} (\d+)\b", generated)
        require(mapping and int(mapping[1]) == expected, "Built firmware color order differs")
    colors = {"off": (0, 0, 0), "red": (31, 0, 0), "green": (0, 31, 0),
              "blue": (0, 0, 31), "white": (31, 31, 31), "yellow": (31, 31, 0)}
    cases = []
    for name, color in colors.items():
        cases.append((f"all-{name}", [color] * 4))
        for pixel in range(4):
            frame = [(0, 0, 0)] * 4
            frame[pixel] = color
            cases.append((f"pixel-{pixel + 1}-{name}", frame))
    cases.append(("mixed", [colors[name] for name in ("red", "green", "blue", "white")]))
    basic_count = len(cases)
    for pixel, channel, value in itertools.product(range(4), range(3), range(256)):
        frame = [[0, 0, 0] for _ in range(4)]
        frame[pixel][channel] = value
        cases.append((f"sweep-{pixel}-{channel}-{value}", [tuple(c) for c in frame]))
    rng = random.Random(20260924)
    for n in range(256):
        cases.append((f"random-{n}", [tuple(rng.randrange(256) for _ in range(3)) for _ in range(4)]))
    source = bytes(channel for _, pixels in cases for pixel in pixels for channel in pixel)
    result = subprocess.run([str(runner)], input=source, stdout=subprocess.PIPE, check=True).stdout
    if args.reference_encoder:
        require(args.reference_encoder.resolve() != runner.resolve(),
                "Reference must be a separate preserved encoder")
        reference = subprocess.run([str(args.reference_encoder.resolve())], input=source,
                                   stdout=subprocess.PIPE, check=True).stdout
        require(result == reference, "Byte-exact regression against prior encoder failed")
    length, pad = info["frame_bytes"], info["reset_bytes"]
    require(len(result) == len(cases) * length, "Output frame count mismatch")
    require(1_000_000_000 % info["spi_hz"] == 0, "Non-integral simulation clock")
    clock_ns = 1_000_000_000 // info["spi_hz"]
    require(pad * 8 * clock_ns >= info["reset_us"] * 1000, "Insufficient reset padding")
    require(length <= dma_max, "Frame crosses the configured DMA boundary")
    for boundary in range(255, length, 255):
        require(boundary < pad or boundary > length - pad,
                "Payload crosses the optional stress-test boundary")
    timing = [(375, 875), (750, 500)] if timing375 else [(250, 1000), (750, 500)]
    require(info["spi_hz"] == (8_000_000 if timing375 else 4_000_000), "Unexpected clock")
    require(length == (720 if timing375 else 360), "Unexpected transfer size")
    # Ranges from the older WS2812B reference, not a claim about the unknown IC.
    legacy_ranges = [(250, 550), (700, 1000), (650, 950), (300, 600)]
    margins = []
    for duration, (minimum, maximum) in zip(sum((list(pair) for pair in timing), []), legacy_ranges):
        require(minimum <= duration <= maximum, "Nominal timing exceeds legacy reference")
        margins.append(min(duration - minimum, maximum - duration))
    checks = 0
    saved = {}
    for index, (name, pixels) in enumerate(cases):
        encoded = result[index * length:(index + 1) * length]
        require(encoded[:pad] == bytes(pad) and encoded[-pad:] == bytes(pad), name + ": padding")
        base = waveform(encoded, clock_ns, dma_chunk=dma_max)
        check_nominal_waveform(base, pixels, timing, info["reset_us"] * 1000)
        require(decode(base, 300_000) == [pixels], name + ": round-trip mismatch")
        checks += 1
        if index < basic_count:
            saved[name] = encoded
            for startup, gap, reset, noise, chunk in itertools.product(
                    [0, 250, 500, 1000, 5000, 20_000], [0, 10_000, 500_000],
                    [50_000, 280_000, 300_000], [False, True], [dma_max, 255]):
                runs = waveform(encoded, clock_ns, startup, gap, noise, chunk)
                require(decode(runs, reset) == [pixels], f"{name}: injected-startup/gap fault")
                checks += 1
    red = saved["pixel-1-red"]
    # Compare the same payload without the new padding, under the hypothesized fault.
    unpadded = red[pad:-pad]
    old_runs = waveform(unpadded, clock_ns, startup_ns=1000)
    new_runs = waveform(red, clock_ns, startup_ns=1000)
    old_color = decode(old_runs, 50_000)[0][0]
    new_color = decode(new_runs, 50_000)[0][0]
    require(old_color == (31, 128, 0), "Injected fault-model negative control failed")
    require(new_color == (31, 0, 0), "Padding must remove the modeled startup error")
    (output / "pixel-1-red.spi.bin").write_bytes(red)
    (output / "all-off.spi.bin").write_bytes(saved["all-off"])
    report = {
        "result": "PASS", "profile": args.profile, "config": info, "frame_vectors": len(cases),
        "nominal_high_low_ns": {"zero": timing[0], "one": timing[1]},
        "nominal_bit_period_ns": sum(timing[0]),
        "nominal_pulse_pairs_checked": len(cases) * 96,
        "legacy_reference_minimum_margin_ns": min(margins),
        "legacy_reference_source": "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf",
        "encoded_frames_sha256": hashlib.sha256(result).hexdigest(),
        "byte_exact_reference_passed": True if args.reference_encoder else None,
        "waveform_checks": checks, "payload_us": (length - 2 * pad) * 8 * clock_ns / 1000,
        "total_clocked_frame_us": length * 8 * clock_ns / 1000,
        "configured_dma_counter_bits": dma_bits,
        "configured_dma_chunks_bytes": [length],
        "extra_stress_test_dma_chunks_bytes": chunk_lengths(length, 255),
        "payload_byte_range_zero_based": [pad, length - pad - 1],
        "modeled_first_pixel_rgb": {"requested": [31, 0, 0], "without_padding": old_color,
                                     "with_padding": new_color},
        "fault_sweep": {"startup_preload_ns": [0, 250, 500, 1000, 5000, 20_000],
                        "dma_pause_ns": [0, 10_000, 500_000],
                        "reset_threshold_ns": [50_000, 280_000, 300_000],
                        "preceding_partial_frame": [False, True]},
        "limitations": ["Digital waveform model, not an ESP32/nRF52840 emulator.",
                        "SPI clock and DMA behavior are modeled, not measured.",
                        "The green-bit fault is deliberately injected, not independently discovered.",
                        "Unpadded comparison strips padding from this profile; it does not execute old firmware.",
                        "Legacy datasheet timing checks do not establish compatibility with the unknown pixels.",
                        "Does not establish the cause of the physical green pixel.",
                        "No model of voltage, wiring, RGBW devices, or exact pixel IC tolerances."],
        "illustration_runs_ns": {"unpadded_with_fault": old_runs, "padded_with_fault": new_runs},
    }
    (output / "simulation.json").write_text(json.dumps(report, indent=2) + "\n")
    print(f"PASS {len(cases)} frame vectors; {checks} waveform checks")
    print(f"Nominal HIGH/LOW ns: zero={timing[0]}, one={timing[1]}; {len(cases) * 96} pulse pairs checked")
    print(f"LOW {info['reset_us']} us + DATA {report['payload_us']:g} us + LOW {info['reset_us']} us")
    print(f"Injected 1 us startup fault, same profile: unpadded RGB={old_color}; padded RGB={new_color}")
    print(f"Report: {output / 'simulation.json'}")


if __name__ == "__main__":
    main()
