#!/usr/bin/env python3
"""Package the current controller/receiver pair without flashing or publishing."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import zipfile


ROOT = Path(__file__).resolve().parents[1]
CONTROLLER_IMAGES = {
    "bootloader.bin": "0x0",
    "partitions.bin": "0x8000",
    "boot_app0.bin": "0xe000",
    "firmware.bin": "0x10000",
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--controller-dir", type=Path, required=True)
    parser.add_argument("--receiver-dir", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--revision", required=True, help="Full source Git commit SHA")
    args = parser.parse_args()
    version = (ROOT / "VERSION").read_text().strip()
    if not re.fullmatch(r"\d+\.\d+\.\d+", version):
        parser.error("VERSION must be a three-component release version")
    if not re.fullmatch(r"[0-9a-f]{40}", args.revision):
        parser.error("--revision must be a full Git commit SHA")
    controller_version = re.search(
        r'firmwareVersion\[\] = "([^"]+)"',
        (ROOT / "apps/controller-esp32s3/src/main.cpp").read_text(),
    ).group(1)
    if controller_version != f"esp32s3-{version}":
        parser.error("VERSION and the current controller firmware version must agree")
    sources = {
        **{f"controller/{name}": args.controller_dir / name
           for name in [*CONTROLLER_IMAGES, "firmware.elf"]},
        **{f"receiver/{name}": args.receiver_dir / name
           for name in ["zephyr.uf2", "zephyr.elf"]},
        "FLASHING.md": ROOT / "docs/FLASHING.md",
    }
    for name, source in sources.items():
        if not source.is_file() or source.stat().st_size == 0:
            parser.error(f"Missing or empty {name}: {source}")
    # Separate images preserve the gaps containing NVS/bonds during an update.
    # Do not replace this with a merged image padded across the whole address span.
    manifest = {
        "version": version,
        "source_revision": args.revision,
        "controller": {"board": "seeed_xiao_esp32s3", "version": controller_version,
                       "flash_offsets": CONTROLLER_IMAGES},
        "receiver": {"board": "xiao_ble/nrf52840", "profile": "four-pixel-375ns",
                     "usb_diagnostics": False},
        "sha256": {name: digest(source) for name, source in sources.items()},
    }
    destination = args.output.resolve()
    bundle = destination / f"little-on-air-v{version}"
    # Never quietly mix a new release with leftovers from a previous package.
    bundle.mkdir(parents=True, exist_ok=False)
    for name, source in sources.items():
        target = bundle / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, target)
    (bundle / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    members = sorted(file for file in bundle.rglob("*") if file.is_file())
    (bundle / "SHA256SUMS").write_text("".join(
        f"{digest(file)}  {file.relative_to(bundle).as_posix()}\n" for file in members))
    archive = destination / f"{bundle.name}.zip"
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as output:
        for file in sorted(bundle.rglob("*")):
            if file.is_file():
                output.write(file, file.relative_to(destination).as_posix())
    archive.with_suffix(".zip.sha256").write_text(f"{digest(archive)}  {archive.name}\n")
    print(archive)


if __name__ == "__main__":
    main()
