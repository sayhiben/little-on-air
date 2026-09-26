# Repository guidance

This file is the shared project guidance for coding agents. Read the
[product manual](README.md), [developer guide](CONTRIBUTING.md) and
[workspace guide](docs/WORKSPACE.md) first, then the application or hardware
documentation relevant to the task. Follow the user's
current instructions and preserve unrelated work.

## Project map

- `apps/controller-esp32s3/`: current OLED/encoder controller; Arduino and
  PlatformIO. Package pins are in `platformio.ini`.
- `apps/receiver/`: Zephyr nRF52840 receiver. The assembled sign uses the padded
  375 ns four-pixel configuration by default. There are no legacy firmware targets.
- `src/`, `include/little_on_air/`: portable protocol, status, receiver processing,
  persistence, reset handling and output behavior.
- `boards/`: the receiver board overlay and optional USB diagnostic overlay.
- `tests/host/`: host checks for both devices; `tests/unit/`: Zephyr core checks.
- `tests/`, `tools/`: host/core regressions, serial helpers and display/pixel checks.
- `hardware/enclosure/v215/`, `hardware/enclosure/output/v215/`: current receiver CAD
  tooling and outputs. `hardware/controller/igor-measured-v4/` is the current
  controller design.
- `hardware/archive/`: preserved historical designs and some helpers still
  imported by current enclosure tools. Check dependencies before moving files.
- `release/`: published manufacturing bundles and checksum manifests. Their
  bundled firmware can predate the current application source.

## Keep the workspace organized

Use `build/<configuration>/` for generated builds, tests, previews and simulations.
PlatformIO's `.pio/` layout is the existing exception. Use `.local/scratch/` for
temporary work. Do not add new root-level `build-*` or `tmp*` directories.

`.local/firmware/`, `.local/bench/` and `.local/archive/` contain preserved local
records, including flashed firmware, device backups and physical observations;
they are not disposable build caches. Keep them out of Git. Reuse installed
`.venv/`, `.zephyr-sdk/`, `.zephyr-workspace/` and `.tool-bin/` dependencies.
Do not edit downloaded SDK or PlatformIO library sources to implement fixes.

The developer guide's Zephyr commands assume the repository is inside a
configured west workspace. This Windows checkout also has a nested
`.zephyr-workspace/`; inspect
its configuration and existing SDK paths before building. Use Linux/WSL for host
tests and OLED rendering. Configure separate build directories for Windows and
WSL: CMake caches contain absolute paths and must not be relocated or shared
between those environments.

Preserve archived manufacturing bytes and published release checksums. Avoid
bulk formatting or line-ending normalization of CAD exports, generated reports,
upstream references and historical snapshots. Follow `.gitattributes`. For a new
hardware revision, use the current tooling and update the appropriate guides,
validation evidence and release manifests deliberately.

## Behavior to preserve

- The receiver is authoritative. Persist and apply a command before acknowledging
  it; require both transaction ID and status to match. Duplicate transactions
  must remain idempotent. A write response or cached state is not confirmation.
- Preserve the version-1 six-byte wire layout and status values unless the task
  explicitly includes a compatibility/versioning change. Shared behavior belongs
  in the common C code where practical.
- Ordinary sync/send must not silently replace pairing keys. Preserve the pinned
  NimBLE guard and bond-store regressions; explicit Pair/Forget controls pairing.
- Preserve nRESET, the factory UF2 bootloader, and rapid double-reset recovery.
  The five-press application gesture uses paced physical resets, not a long hold.
- Keep the receiver's power LED independent of its mood pixels. Background
  reconciliation must not flash the sign, wake the OLED or restart animations.
- Do not infer physical validation from a successful build, simulation, CAD audit
  or slicer check. Record what was actually observed in the relevant bench guide.

Flashing, erasing bonds and sending hardware-test commands affect connected
devices. Perform those actions when they are within the user's requested task;
ordinary code validation does not need device state changes.

## Validation

Match checks to the change. Documentation-only changes need link/path review and
`git diff --check`; do not rebuild firmware solely for a prose edit. Firmware
changes should run the relevant existing tests and builds. CI configuration in
[.github/workflows/ci.yml](.github/workflows/ci.yml) is the reference for the full
matrix; complete required checks before merging.

Commands below run from the repository root in a configured environment:

```sh
cmake -S tests/host -B build/desk-tests
cmake --build build/desk-tests
ctest --test-dir build/desk-tests --output-on-failure
python -m platformio run -d apps/controller-esp32s3
west twister -T tests/unit -v --inline-logs --integration --outdir build/twister
```

For receiver/shared-code changes, build the normal receiver and its USB diagnostic
configuration using CONTRIBUTING.md and CI commands. For pixel changes, run
`tools/simulate_pixels.py` against the actual generated header from that build.
For OLED changes, run `tools/render_buddy_ui.py` after PlatformIO dependencies
are installed and inspect the generated preview.

C sources and headers follow the pinned Zephyr tree's `.clang-format`; use that
style when checking changed code. Keep package pins unless an upgrade is part of
the task. Prefer regressions that exercise real shared behavior and failure
paths rather than duplicating implementation details in tests.

For CAD changes, follow the current design's own regeneration and audit workflow.
Keep exploratory source separate from published print files, and state any
remaining physical fit or assembly checks.

## Git and handoff

Check branch, working-tree and worktree state before changes. Use a feature
branch for repository work; preserve unrelated edits and local records. Review
the final diff, including generated files and archive moves. Do not force-push,
discard work or delete branches as routine cleanup.

When the user has requested committing, pushing or merging, carry that work
through the applicable checks and verify the final local/remote state. Summarize
the result, validation performed and any remaining limitations. Keep this file
as the canonical guidance and [CLAUDE.md](CLAUDE.md) as its entry point for Claude.
