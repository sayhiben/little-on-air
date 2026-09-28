# Workspace guide

Start with [the product manual](../README.md) for using the devices,
[the developer guide](../CONTRIBUTING.md) for implementation and builds, and
[the hardware index](../hardware/README.md) for the current physical designs.

| Location | Contents |
| --- | --- |
| `apps/`, `src/`, `include/`, `boards/` | Firmware applications, shared code and board configuration |
| `tests/`, `tools/`, `.github/` | Tests, development helpers and CI |
| `docs/` | Setup instructions, architecture and dated bench records |
| `hardware/enclosure/v215/` | Current receiver enclosure tooling |
| `hardware/enclosure/output/v215/` | Current enclosure CAD and manufacturing evidence |
| `hardware/controller/igor-measured-v4/` | Current controller CAD, source, guides and print projects |
| `hardware/archive/` | Earlier hardware designs and intermediate work |
| `release/` | Published manufacturing bundles, including versioned historical releases |
| `build/` | Disposable local build, test, simulation and preview output; ignored by Git |
| `.local/` | Local firmware snapshots, bench evidence and scratch work; ignored by Git |

## Day-to-day outputs

Use a subdirectory of `build/` for each configuration. CMake caches contain
absolute paths: configure a new directory rather than moving an old build tree.
Examples, from the repository root in a configured development environment:

```sh
cmake -S tests/host -B build/desk-tests
cmake --build build/desk-tests
ctest --test-dir build/desk-tests --output-on-failure
python tools/render_buddy_ui.py
```

The OLED helper defaults to `build/buddy-ui/`. Pixel simulation defaults to
`build/pixel-simulation/`, reading the normal receiver build's generated header
under `build/receiver/`. The receiver always uses the current four-pixel 375 ns
configuration; see the [build guide](../CONTRIBUTING.md#four-pixel-nrf52840-receiver).

Host tests and rendering use Linux/WSL. PlatformIO manages its build output and
downloaded libraries under `apps/controller-esp32s3/.pio/`.

Keep new scratch files in `.local/scratch/`. Save firmware that was actually
flashed or used for physical validation separately from disposable build trees.

## Preserved local work

The September 26 cleanup removed obsolete build trees, slicer intermediates,
test-run output and Python caches. It retained these local-only records:

- `.local/firmware/current/`: the recorded ESP32-S3 0.4.0 and normal/diagnostic
  receiver images, their original manifest, and supporting bootloader,
  partition, ELF and receiver configuration files.
- `.local/firmware/previous/buddy-0.3.0/`: the earlier firmware bundle.
- `.local/bench/`: existing OLED previews and pixel simulation reports, grouped
  by their original output directory names.
- `.local/archive/2026-09-26/tmp/`: physical bench captures, flash backups and
  scratch material formerly under `tmp/`.
- `.local/archive/2026-09-26/cleanup/`: the cleanup inventory and move record.

These files are specific to this checkout and are not included in a fresh clone.
Archived manifests and logs retain their original paths and observations.
Full-flash backups include historical device state; use the documented
application images for ordinary flashing.

The installed `.venv/`, `.zephyr-sdk/`, `.zephyr-workspace/` and `.tool-bin/`
remain in place so cleanup does not require reinstalling the toolchain.
The `.local/` records are not disposable build caches.

The [September 27 brightness bench](BRIGHTNESS_BENCH.md) retains the flashed
0.5.0 images and validation manifest in
`.local/firmware/brightness-0.5.0-2026-09-27/`, with serial logs and private flash
backups in `.local/bench/brightness-2026-09-27/`. The older `current/` snapshot
above still preserves the September 26 firmware; it was not overwritten.

## Historical hardware

Use the [hardware archive index](../hardware/archive/README.md) to find older
designs. Released ZIPs and their checksums keep their published paths under
`release/`. Current enclosure tooling still imports a few archived geometry and
print-audit helpers, so retain the archive when working on enclosure CAD.
