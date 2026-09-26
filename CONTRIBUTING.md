# Little On Air developer guide

Start here to assemble the hardware, reproduce the firmware, understand the
implementation or change a feature. The [README](README.md) is the end-user
manual. [AGENTS.md](AGENTS.md) is the shared guidance for coding agents;
[docs/WORKSPACE.md](docs/WORKSPACE.md) explains this checkout's local records.

## Contents

- [Current system and sources of truth](#current-system-and-sources-of-truth)
- [Repository map](#repository-map)
- [Hardware and bill of materials](#hardware-and-bill-of-materials)
- [Software architecture](#software-architecture)
- [Protocol and persistence](#protocol-and-persistence)
- [Development environment](#development-environment)
- [Build and flash](#build-and-flash)
- [Validation](#validation)
- [Diagnostics and bench work](#diagnostics-and-bench-work)
- [Implementing changes](#implementing-changes)
- [CAD and manufacturing workflow](#cad-and-manufacturing-workflow)
- [CI, releases and contribution workflow](#ci-releases-and-contribution-workflow)
- [Further references](#further-references)

## Current system and sources of truth

| Component | Current implementation | Entry point |
| --- | --- | --- |
| Desk controller | USB-powered XIAO ESP32-S3, OLED, rotary push encoder, one NeoPixel; Arduino/PlatformIO; firmware `esp32s3-0.4.0` | [Application](apps/controller-esp32s3/README.md) |
| Sign receiver | XIAO nRF52840, Zephyr 4.3.0, four external pixels, independent red power indicator | [Receiver source](apps/receiver/src/main.c) and [default build](#four-pixel-nrf52840-receiver) |
| Controller enclosure | Igor measured v4, including measured OLED/encoder/strip envelopes | [Design](hardware/controller/igor-measured-v4/README.md) |
| Sign enclosure | v2.15, with open-backed frame wire channels and its original housing/yoke | [Tooling](hardware/enclosure/v215/README.md) and [manufacturing bundle](release/little-on-air-enclosure-v2.15/README.md) |

Use current source and build configuration for implemented behavior, the current
design guides for assembly, and dated bench records for physical observations.
Older documents and packaged source snapshots describe the versions they shipped
with. A passing build, CAD fit check or waveform simulation is not a new physical
validation result.

**Manufacturing firmware is independently versioned.** The enclosure ZIPs retain
the older 0.1.2 firmware snapshot, which drives onboard RGB only. They are not the
current four-pixel firmware distribution. Build the profile below for the
assembled sign. Local verified images may exist under `.local/firmware/current/`,
but a fresh clone does not contain them. Check their manifests and hashes before
reusing them. The [current pairing/power record](docs/PAIRING_POWER_UPDATE.md)
identifies the physically checked application images and observations.

This is one bespoke device pair. Only the current ESP32-S3 controller and
four-pixel nRF52840 receiver are maintained. Retired firmware and comparison
profiles are available through Git history, not active build targets; see
[firmware history](docs/HISTORY.md). USB diagnostics instrument the same current
receiver firmware.

## Repository map

| Path | Responsibility |
| --- | --- |
| `apps/controller-esp32s3/` | Current Arduino application, pinned PlatformIO packages, host tests and build scripts |
| `apps/receiver/` | Zephyr peripheral application, GATT server, reset intent and padded SPI transport |
| `include/little_on_air/`, `src/` | Shared C interfaces and implementation: protocol, status, receiver processing, persistence, reset and pixel encoding |
| `boards/` | Complete nRF52840 sign overlay and optional USB debug overlay |
| `apps/receiver/CMakeLists.txt` | Receiver sources and brightness/calibration definitions |
| `tests/` | Host checks for both devices, Zephyr core regressions and real-GFX OLED rendering harness |
| `tools/` | Pixel simulations, OLED/manual rendering, serial helpers and paired bench runner |
| `.github/workflows/`, `.github/actions/` | CI, release workflow and cached Zephyr setup |
| `hardware/enclosure/v215/`, `hardware/enclosure/output/v215/` | Current receiver tooling and generated CAD/print evidence |
| `hardware/controller/igor-measured-v4/` | Current controller CAD, BOM, wiring, assembly and output |
| `hardware/archive/` | Historical designs; also helpers imported by current enclosure scripts |
| `release/` | Versioned manufacturing directories, ZIPs and checksum manifests |
| `docs/` | Architecture detail, electrical/firmware guides, bench evidence and manual images |
| `build/<configuration>/` | Ignored disposable builds, tests, simulations and previews |
| `.local/` | Ignored local firmware snapshots, bench evidence, archives and scratch files |

Keep temporary work in `.local/scratch/`. Do not add root-level `build-*` or
`tmp*` directories. PlatformIO's application-local `.pio/` directory is the
existing build-layout exception. Preserve `.local/firmware/`, `.local/bench/`
and `.local/archive/`; they contain records and backups, not disposable caches.
Do not move or normalize historical manufacturing files to tidy a code change.

## Hardware and bill of materials

The tables below are a working overview. Use the linked design BOMs and assembly
guides for exact fit, fasteners, source parts and print orientation. Match actual
modules to their measured envelopes before buying substitutes. Neither a board
name nor a successful CAD interference check proves electrical compatibility.

### ESP32-S3 controller BOM

| Quantity | Part | Required detail |
| --- | --- | --- |
| 1 | Seeed XIAO ESP32-S3 | Standard board without Sense expansion; computer USB-C power |
| 1 | SSD1306 I²C OLED, 128×64 | Measured PCB 27.6 × 27.9 × 1.25 mm; four-pin header retained; 0x3C or 0x3D |
| 1 | Rotary push encoder module | Measured PCB 19.25 × 26.4 × 1.5 mm; right-angle five-pin header |
| 1 | Mini NeoPixel strip segment | 17.6 × 5 × 1.4 mm; one centered LED, retained strip segment |
| 1 | AHCT level shifter | SN74AHCT1G125 or suitable small board; insulated envelope ≤18 × 12 × 4 mm |
| 1 each | 330 Ω series resistor; 100 kΩ pulldown | Series near pixel DIN; pulldown on buffer input |
| 2 | 100 nF bypass capacitors | Pixel and buffer; account for suitable already-fitted bypasses |
| 1 | 47 µF bulk capacitor, ≥10 V | Prototype allowance; body ≤6.3 mm diameter × 8.5 mm; verify on bench |
| 2 | Adhesive wheel weights | Each 20 × 33.5 × 6.5 mm including supplied adhesive |
| 1 set | Printed shell, faceplate, knob, diffuser, strip holder and XIAO carrier | Two decorative inlays optional; clear PETG diffuser, other parts PLA |
| As needed | Flexible wire, insulation, thin mounting tape, adhesive and USB-C data cable | Keep joints out of the LED channel and moving encoder/OLED envelopes |

Detailed sources: [BOM](hardware/controller/igor-measured-v4/BOM.csv),
[assembly](hardware/controller/igor-measured-v4/ASSEMBLY.md),
[mechanical wiring guide](hardware/controller/igor-measured-v4/WIRING.md),
[firmware wiring](apps/controller-esp32s3/README.md).

### Controller pin map

The current firmware definitions in
[main.cpp](apps/controller-esp32s3/src/main.cpp) are authoritative:

| Signal | XIAO label | ESP32-S3 GPIO | Notes |
| --- | --- | --- | --- |
| Encoder CLK | D0 | 1 | Quadrature input |
| Encoder DT | D1 | 2 | Quadrature input |
| Encoder push switch | D3 | 4 | Active-low input with pull-up |
| OLED SDA | D4 | 5 | I²C |
| OLED SCL | D5 | 6 | I²C |
| NeoPixel data | **D7** | **44** | GRB, 800 kHz; via buffer for a 5 V pixel |

Power the OLED and encoder from 3V3, and the pixel/buffer from USB 5 V with a
common ground. Check the actual module pin order; do not assume connector order
from another OLED or encoder model. The early measured-v4 mechanical wiring
document proposed **D6/GPIO43** for the pixel. The implemented and bench-recorded
controller uses **D7/GPIO44**. Follow the current application pin map; the
published mechanical snapshot is preserved rather than silently rewritten.

### Receiver BOM

| Quantity | Part | Required detail |
| --- | --- | --- |
| 1 | Seeed XIAO nRF52840 | Headerless; retain factory UF2 bootloader and nRESET |
| 1 | Protected TP4056 USB-C charger module | Verify actual board, protection circuit and charge-current setting against the cell |
| 1 | Single-cell LiPo, 1000 mAh design envelope | Approximately 52 × 21 × 10 mm; verify polarity, protection and permitted charge current |
| 4 | Side-light NeoPixels | Approximately 8 × 8 × 2 mm; front-corner illumination |
| 1 | SPDT POWER switch | Large main load switch; specified SS12F15G5 form |
| 1 | DPDT RUN/PROGRAM switch | Small mode switch; isolates XIAO BAT+ and pixel data |
| 1 each | 680 µF capacitor, ≥6.3 V; 330 Ω resistor | Bulk capacitor design envelope 8 mm diameter × 11.5 mm; data resistor near pixel input |
| 9 each | M3×8 button-head screws and M3 nuts | Nuts 5.5 mm across flats × 2.4 mm thick; see assembly allocation |
| 1 | Clear PMMA face | 104 × 38 mm; measured thickness must match the frame fit |
| 1 set | v2.15 printed case parts and light guides | Use the complete v2.15 housing, yoke and open-channel frame set |
| As needed | Disconnect pigtail, wire, insulation, anchors and mounting materials | Rear fine wire and front 22/24 AWG routes must meet the published OD envelopes |

Detailed sources: [receiver BOM](release/little-on-air-enclosure-v2.15/BOM.csv),
[build and assembly](release/little-on-air-enclosure-v2.15/guides/BUILD-AND-ASSEMBLY.md),
[rear wiring](release/little-on-air-enclosure-v2.15/guides/WIRING.md),
[front wiring](release/little-on-air-enclosure-v2.15/guides/FRONT-WIRING.md).
Verify charge termination/indicators on the fitted module; the project does not
provide an OLED fuel gauge or a measured battery-runtime guarantee.

### Receiver electrical topology

~~~mermaid
flowchart LR
    Cell[LiPo cell] --> Charger[Protected TP4056: B+ / B-]
    Charger -->|OUT+| Power[POWER switch]
    Power --> Rail[Switched battery rail]
    Rail --> Pixels[Four NeoPixels + bulk capacitor]
    Rail --> ModeA[MODE pole A: RUN only]
    ModeA --> Bat[XIAO BAT+]
    Data[XIAO D2] --> ModeB[MODE pole B: RUN only]
    ModeB --> Resistor[330 ohm series resistor]
    Resistor --> Din[Pixel 1 DIN]
~~~

Use the protected **OUT−** as the common load ground for the XIAO, pixels and
capacitor. Do not bridge cell B− to OUT− and bypass the protection stage. MODE
in PROGRAM opens the BAT+ and data paths. The capacitor goes across the switched
pixel supply with correct polarity. Follow the published diagrams for switch
lug orientation; the topology diagram does not specify physical lug numbers.

| Signal | nRF52840 pin | Function |
| --- | --- | --- |
| XIAO D2 | P0.28 | Pixel SPI MOSI/data, through MODE and series resistor |
| XIAO D8 | P1.13 | Allocated SPI clock; not connected to NeoPixels |
| Onboard red / green / blue | P0.26 / P0.30 / P0.06 | Active-low PWM RGB; current sign uses red as independent power indicator |
| RESET | nRESET | Hardware reset and factory double-reset bootloader recovery |

Viewed from the front, the data chain is **1 lower-left → 2 lower-right →
3 upper-right → 4 upper-left**. Connect each DOUT to the next DIN; the last DOUT
is unused. Keep grounds continuous. The current 375 ns profile is selected
deliberately for the assembled sign's pixels.

**USB modes:** normal use is POWER ON / RUN with both receiver USB ports
unplugged. Before either USB connection, set POWER OFF, select PROGRAM with
USB removed, and connect only one port: charger USB for charging, XIAO USB for
programming. Unplug USB before selecting RUN and powering on. There is no
automatic interlock or load-sharing power path. See the
[manual's power table](README.md#power-and-charging) and
[bench connection procedure](docs/PAIRED_BENCH.md#connections).

## Software architecture

~~~mermaid
flowchart LR
    Input[Encoder + button] --> UI[ESP32 main loop: selection / display / sleep]
    UI -->|LinkRequest| Worker[Single BLE worker]
    Worker -->|LinkResult| UI
    UI --> OLED[OLED + confirmed-mood pixel]
    Worker <-->|Encrypted GATT transactions| Server[Zephyr receiver BLE server]
    Server --> Core[Shared receiver processor]
    Core --> Store[NVS settings]
    Core --> Output[Shared status output]
    Output --> SPI[Padded SPI pixel transport]
    SPI --> Sign[Four sign pixels]
    Server --> PowerLED[Independent power / pairing indicator]
~~~

### Controller implementation

The Arduino loop handles input, selection, screen state, local pixel animation,
USB diagnostics and display power. BLE work runs on a dedicated FreeRTOS task
so scanning or reconnecting does not block the knob or OLED. Radios connect for
operations, not as a permanent streaming link.

| Source | What to change here |
| --- | --- |
| [main.cpp](apps/controller-esp32s3/src/main.cpp) | Pin setup, menus, screen transitions, sleep, Preferences cache, serial commands and application scheduling |
| [controller.hpp](apps/controller-esp32s3/src/controller.hpp) | Host-testable encoder/button handling, selected/confirmed state and exact acknowledgement checks |
| [buddy_ui.hpp](apps/controller-esp32s3/src/buddy_ui.hpp) | Shared home-screen and pairing-help drawing, text and buddy expressions |
| [receiver_link.hpp](apps/controller-esp32s3/src/receiver_link.hpp), [receiver_link.cpp](apps/controller-esp32s3/src/receiver_link.cpp) | Request/result types, BLE worker, scan/connect/security/read/write/Forget/pixel operations |
| [bond_store.cpp](apps/controller-esp32s3/src/bond_store.cpp) | Bond-store handling and private-address bookkeeping without evicting the paired identity |
| [nimble_guard.py](apps/controller-esp32s3/nimble_guard.py) | Build-time guard on the pinned NimBLE source to prevent implicit repair/re-pair during ordinary operations |
| [shared_sources.py](apps/controller-esp32s3/shared_sources.py) | Bring shared C status/protocol sources into the PlatformIO build |

Keep three concepts separate: **selected** is the knob preview, **confirmed** is
the last accepted receiver state, and **verified** says whether the cached state
has been checked in the current connection state. Loading Preferences does not
make a value verified. The local pixel follows confirmed state only while
verified; otherwise it is dim white. Startup reads and never advances a mood.

The link worker has an 8192-byte stack and bounded queues. Normal operations
have an eight-second overall budget; pairing allows 60 seconds, including a
scan of up to 45 seconds. After sending, the worker waits for an indication and
can fall back to a state read. It must match both transaction ID and status.
Connection retries before a write are different from replaying a command after
an ambiguous result: do not add automatic post-write replays.

Background reconciliation runs roughly every 60 seconds on the home screen,
with 1/2/4-second read-only recovery retries. A click during a background read
can queue the chosen send; a failed read drops it and asks the user to retry.
Unchanged reads must not wake the OLED, rewrite flash or restart animations.

### Receiver implementation

| Source | Responsibility |
| --- | --- |
| [main.c](apps/receiver/src/main.c) | Initialize outputs and Bluetooth/settings, resolve reset intent, restore saved state, start service |
| [ble_server.c](apps/receiver/src/ble_server.c) | GATT permissions and callbacks, pairing windows, advertisement policy, indications and diagnostic commands |
| [pair_reset.c](apps/receiver/src/pair_reset.c) | Persist paired reset intent and schedule restart |
| [device_indicator.c](apps/receiver/src/device_indicator.c) | Independent red power/pairing indicator |
| [mood_indicator.c](apps/receiver/src/mood_indicator.c) | Schedule current moods without restarting unchanged animations |
| [status_output.c](apps/receiver/src/status_output.c) | Drive front pixels and independent onboard power light |
| [padded_pixels.c](apps/receiver/src/padded_pixels.c) | SPI transfer of explicitly encoded WS2812 frames with low reset padding |

The receiver owns the truth. Its readable state and acknowledgement reflect
accepted commands, not a controller's desired state. On boot it restores valid
saved state and starts output independently of the controller. Bonded advertising
is about once per second; the unpaired pairing window uses faster advertising.

### Shared C core

| Module under `src/` | Responsibility |
| --- | --- |
| `status.c` | Stable mood enumeration, labels, colors and animated corner colors |
| `protocol.c` | Versioned wire encode/decode and validation |
| `receiver_processor.c` | Validate, deduplicate, persist, apply and acknowledge |
| `record.c`, `store.c` | Durable record encoding/CRC and Zephyr settings adapter |
| `reset_gesture.c`, `reset_input.c` | Paced reset counting, persistence and reset-reason handling |
| `ws2812_frame.c` | SPI symbol encoding and leading/trailing reset padding |

Portable interfaces are in [include/little_on_air/](include/little_on_air/).
[The receiver CMake file](apps/receiver/CMakeLists.txt) compiles the portable core
and its hardware adapters. Receiver-only output/scheduling code and private
headers live under `apps/receiver/src/`. The ESP32-S3 application compiles shared
status/protocol sources through its PlatformIO script. Keep portable behavior
in shared C and hardware-specific behavior in its owning application.

### Output and timing

Status values are fixed: `0 Off`, `1 Warn`, `2 On Air`, `3 Okay`, `4 Request`,
`5 Special`. Raw RGB for Warn is `(255,112,0)`, On Air `(255,0,0)` and Okay
`(0,255,0)`. Request is green for 600 ms then off for 600 ms. Special advances
every 50 ms across a 20-second cycle with corner hue offsets `[0,140,224,84]`.
Separate devices have independent animation phase.

Default external sign brightness is **160 permille (16%)**, controlled by
`LOA_PIXEL_BRIGHTNESS_PERMILLE`. Onboard RGB uses 125 permille and channel
calibration R=1000, G=650, B=500. The ESP32 pixel uses brightness **24/255**;
the build bounds it to 1–64. These are digital drive limits, not optical
measurements. Older bench documents may describe an earlier brightness setting.

The assembled sign uses the repository's padded SPI driver: 8 MHz SPI,
10-bit symbols, `0x380` for zero and `0x3f0` for one. Each LED bit is 1.25 µs;
zero is 375 ns high/875 ns low, one is 750 ns high/500 ns low. Leading and trailing
low padding provide at least 300 µs reset time. This is the only supported
transport configuration. Validate it against the generated devicetree header,
not only a hand-written timing table.

The independent red power light is steady when bonded, 250 ms on/250 ms off
during pairing, and 1800 ms on/200 ms off when unpaired outside the window. Mood
changes, background radio activity and Off must not repurpose this indicator.

## Protocol and persistence

### GATT contract

All UUIDs share the suffix `-6b7e-4c80-9f2a-f9b9d7e2a601`:

| UUID prefix | Characteristic | Access and payload |
| --- | --- | --- |
| `7f6c0000` | Service | Primary service |
| `7f6c0001` | Command | Encrypted write with response; six-byte mood command |
| `7f6c0002` | State | Encrypted read and indication; same six-byte layout |
| `7f6c0003` | Pixel test | Encrypted read/write of version, index, R, G, B |
| `7f6c0004` | Pairing control | Current bonded/encrypted peer only; six-byte Forget request |

Version-1 mood messages:

| Offset | Bytes | Encoding |
| --- | --- | --- |
| 0 | 1 | Version, exactly `1` |
| 1 | 4 | Transaction ID, unsigned little-endian |
| 5 | 1 | Status, `0` through `5` as listed above |

For example, On Air with transaction `0x12345678` is
`01 78 56 34 12 02`. Reject malformed lengths, unknown versions and unknown
statuses. All six moods use this layout. Update the two devices as a matched pair; the
project does not maintain compatibility with retired firmware versions.

~~~mermaid
sequenceDiagram
    participant C as Controller worker
    participant R as Receiver
    participant S as Persistent store
    participant L as Lights
    C->>R: Connect, encrypt, subscribe to state indications
    C->>R: Write version + transaction + status
    R->>R: Validate and check duplicate
    R->>S: Persist candidate state
    S-->>R: Success
    R->>L: Apply mood
    L-->>R: Success
    R->>R: Update readable state
    R-->>C: Indicate matching transaction + status
    Note over C,R: ATT write success alone is not confirmation
    opt Indication not received
        C->>R: Read state
        R-->>C: Current transaction + status
    end
    C->>C: Verify exact match, then cache and display
~~~

An exact duplicate transaction/status skips persistence and output but is
acknowledged again. Reusing the current transaction ID with a different status
is rejected. Persistence failure must prevent application; output failure must
prevent a successful acknowledgement. Since persistence precedes output, an
output failure can leave a durable candidate that will be retried on boot—do not
treat a failed operation as proof that the receiver retained the old record.

Pixel-test bytes are version `1`, zero-based corner index `0..3`, R, G and B;
index `255` ends the test. USB helpers use human-facing indices `1..4`. Tests
expire after 120 seconds and do not replace the saved mood. They affect physical
hardware and should only be used as part of deliberate bench work.

### Durable state

| Store | Record | Rules |
| --- | --- | --- |
| Zephyr settings/NVS | `loa/state` | 14-byte record with magic, schema, status, transaction ID and CRC-32; invalid records fall back to Off |
| Zephyr Bluetooth settings | Bond/identity data | One paired peer; ordinary reconnect must use stored identity and keys |
| Zephyr settings | `loa_reset/count` | Paced pin-reset count; loaded before evaluation |
| Zephyr settings | `loa_pair/pending` | Durable explicit Forget intent; processed/retried at boot |
| ESP32 Preferences | Namespace `loa-desk`, key `state` | Six-byte last-confirmed protocol record; loading it leaves state unverified |
| NimBLE storage | Bond and peer identity records | Separate from the display cache; preserve keys during normal sync/send |

The XIAO's stock 32 KiB storage partition is retained. Do not resize partitions,
erase NVS or restore a full-flash backup as an ordinary application update.

### Pairing, Forget and reset recovery

Pairing uses encrypted Secure Connections Just Works, with no user-entered PIN.
Both applications limit bonds to one partner. The receiver accepts initial
pairing during a 60-second window; normal reconnects use the bonded identity.
Do not add automatic key deletion or security retries that silently re-pair.

Explicit Forget sends six bytes: version `1`, opcode `1`, then a nonzero 32-bit
request ID in little-endian order. The receiver accepts it only from the bonded,
encrypted connection, persists `loa_pair/pending`, then schedules a reboot after
1.5 seconds. Startup removes bonds and saved mood, clears the durable intent,
and opens a pairing window in Off. Interrupted cleanup is retried at boot. The
controller disconnects before deleting its own keys. If the sign is unreachable
or cannot confirm the reset intent, explicit Forget still clears the controller's keys
and displays physical recovery instructions.

Five physical reset-pin boots about two seconds apart trigger the same receiver
cleanup. Only `RESETREAS.RESETPIN` advances the count after settings load; power
or software resets clear a partial count. Six seconds of uninterrupted runtime
also clears it. A failed count write must never authorize an erase. A long hold
is not five presses. Preserve nRESET, the factory bootloader and rapid
double-reset UF2 recovery; do not use UICR changes to turn RESET into a GPIO.

The pinned NimBLE guard and bond-store tests cover an additional invariant:
rotation or exhaustion of private-address cache entries for the same bonded
identity must not evict or replace its pairing keys. Implement library fixes
through the checked-in build integration, never by editing downloaded `.pio`
sources or SDK files directly.

## Development environment

### Pinned components

| Component | Version/source |
| --- | --- |
| Zephyr | v4.3.0, commit `3568e1b6d5cdd51a6b964a2a1d6d29200fea2056` in [west.yml](west.yml) |
| Zephyr SDK | Pinned Zephyr tree's `SDK_VERSION`: 0.17.4; ARM toolchain |
| PlatformIO Core | 6.1.18 in CI |
| PlatformIO Espressif32 | 6.12.0; board `seeed_xiao_esp32s3`; Arduino framework |
| NimBLE-Arduino | 2.5.1 |
| Adafruit SSD1306 / GFX / BusIO | 2.5.15 / 1.12.6 / 1.17.4 |
| Adafruit NeoPixel | 1.15.2 |
| CI host | Ubuntu 22.04, Python 3.12 |
| OLED image composition | Pillow 10.4.0 in CI |

[platformio.ini](apps/controller-esp32s3/platformio.ini) and `west.yml` are the
package authorities. Keep pins unless upgrading dependencies is part of the
change. Native USB CDC and the ESP32 USB mode are build flags; serial support
must not depend on an external UART adapter.

### Fresh Linux or WSL setup

Use Linux/WSL for host tests, OLED rendering and the Zephyr CI-equivalent checks.
Zephyr 4.3 requires Python ≥3.10, CMake ≥3.20.5 and dtc ≥1.4.6. Start with the
[pinned Zephyr installation guide](https://github.com/zephyrproject-rtos/zephyr/blob/3568e1b6d5cdd51a6b964a2a1d6d29200fea2056/doc/develop/getting_started/index.rst)
for your OS. On Ubuntu x86-64, install the host prerequisites:

~~~sh
sudo apt update
sudo apt install --no-install-recommends git cmake ninja-build gperf ccache \
  dfu-util device-tree-compiler wget python3-dev python3-venv python3-tk \
  xz-utils file make gcc g++ gcc-multilib g++-multilib libsdl2-dev libmagic1
~~~

On ARM64, omit the unavailable multilib packages. Configure a fresh west
workspace around the repository; do not nest this inside an existing west
workspace:

~~~sh
mkdir little-on-air-workspace
cd little-on-air-workspace
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install west platformio==6.1.18 Pillow==10.4.0 pyserial
git clone https://github.com/sayhiben/little-on-air.git little-on-air
west init -l little-on-air
west update
west zephyr-export
west packages pip --install
west sdk install -t arm-zephyr-eabi
cd little-on-air
~~~

`west update` checks out the manifest-pinned Zephyr and dependencies; SDK install
uses that Zephyr tree's SDK selection. Re-activate the virtual environment in a
new shell. Verify with `west topdir`, `west list zephyr`, `cmake --version`,
`python --version` and `python -m platformio --version` before debugging builds.
PlatformIO installs its pinned framework/libraries on the first build.

### Existing Windows checkout

Inspect and reuse `.venv/`, `.zephyr-sdk/`, `.zephyr-workspace/` and `.tool-bin/`
before installing another toolchain. This checkout's nested west workspace can
use `manifest.path = zephyr`; it is not the fresh application-manifest layout
above. Inspect `.zephyr-workspace/.west/config` and run west inspection commands
from inside that workspace. Do not blindly reinitialize it or update to an
unrelated manifest.

PlatformIO can run directly in PowerShell:

~~~powershell
.\.venv\Scripts\python.exe -m platformio run -d apps/controller-esp32s3
~~~

Host rendering/tests need Linux tools; use WSL with its own Python environment.
Use distinct build directories for Windows and WSL, such as `build/desk-tests`
and `build/desk-tests-wsl`. CMake caches contain absolute platform paths: do not
move them or reuse one environment's build tree in the other. Likewise, avoid
simultaneous Windows/WSL PlatformIO builds against the same `.pio` tree. For a
clean independent Zephyr workspace, use the fresh WSL setup above.

## Build and flash

All following shell commands run **from the repository root**, with the relevant
environment active. Zephyr commands require the repository to be inside the
configured west workspace. Give each configuration a separate build directory;
after changing cached CMake options, use a fresh directory or deliberate pristine
reconfiguration (`west build -p always ...`).

### ESP32-S3 controller

~~~sh
python -m platformio run -d apps/controller-esp32s3
python -m platformio device list
# Replace the example port with the controller's actual port.
python -m platformio run -d apps/controller-esp32s3 -t upload --upload-port COM4
~~~

On Linux the port may be `/dev/ttyACM0` instead. Outputs are under
`apps/controller-esp32s3/.pio/build/xiao_esp32s3/`: `firmware.bin`, `firmware.elf`,
`bootloader.bin` and `partitions.bin`. Prefer PlatformIO upload so all pieces
use the board's correct offsets. The application alone is at `0x10000` in this
configuration; it is not a complete blank-chip image. Ordinary upload preserves
NVS/bonds. Do not run a full-chip erase to work around a normal upload issue.
See [application flashing details](apps/controller-esp32s3/README.md#build-flash-and-inspect).

### Four-pixel nRF52840 receiver

The normal receiver build includes all four pixels, the 375 ns padded SPI
transport, encrypted diagnostics and the independent red power indicator:

~~~sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver
~~~

The complete pin map and timing live in `boards/xiao_ble_nrf52840.overlay`;
`apps/receiver/prj.conf` enables the required drivers. There are no additional
pixel fragments, alternative profiles or onboard-only firmware target. The
driver asserts the actual devicetree timing, mapping and DMA limits at build time.

### USB diagnostic receiver

Normal builds disable USB console/logging. To build the matching four-pixel
profile with native USB CDC diagnostics, add the debug configuration and overlay:

~~~sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver-debug -- \
  -DEXTRA_CONF_FILE=debug.conf \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/boards/xiao_ble_nrf52840_debug.overlay"
~~~

USB diagnostic operation in OFF/PROGRAM is not the same electrical setup as
the battery-powered sign in RUN. Do not connect receiver USB during normal
battery/pixel operation simply to capture logs. Use controller-side diagnostics
for those paired tests and record the power arrangement.

### Flashing the nRF52840 safely

1. Save the intended image, source revision, build configuration and SHA-256 if
   it will be used for physical validation. Do not overwrite a known-good local
   snapshot with an untested candidate.
2. For the assembled sign, POWER OFF, unplug both USB ports, select PROGRAM,
   then connect **XIAO USB only** with a data cable.
3. Rapidly double-tap RESET to enter the factory UF2 bootloader. A removable
   XIAO boot volume should appear; identify the actual mounted device.
4. Copy the chosen build's `zephyr/zephyr.uf2` onto that volume and allow it to
   finish and reboot. Retain the accompanying ELF for symbols.
5. Unplug XIAO USB. With POWER still OFF, select RUN, then POWER ON. Check the
   sign and its saved pairing/mood before continuing.

Follow [FLASHING.md](docs/FLASHING.md) for bootloader details and board variants.
Preserve the factory bootloader, partition layout, reset pin and settings. Do not
mass-erase, overwrite UICR or restore historical full-flash backups as a routine
update. Backups can contain stale device identities and bond keys. The current
controller takes ESP32 binary images; only the receiver takes UF2.

## Validation

Match the checks to the change. Documentation-only edits need link/path review,
visual review of changed illustrations and `git diff --check`, not a local
firmware rebuild. Complete required CI before merging. A physical claim needs a
dated observation with device configuration, not just a green CI badge.

| Change | Required relevant checks |
| --- | --- |
| Shared protocol/state/persistence/reset | Host regressions, Zephyr unit suite, ESP32 build and normal/diagnostic receiver builds; pairing/recovery bench checks if hardware behavior changes |
| ESP32 input/menu/BLE/bond handling | Host regressions, PlatformIO build; actual control/reconnect/Forget tests when behavior changes |
| OLED layout/text | PlatformIO dependencies, actual-GFX renderer, bounds checks and visual inspection; refresh manual images when affected |
| Pixel output/timing | Host output tests, normal and diagnostic receiver builds, matching-header waveform simulation, optical/electrical bench observation |
| CAD/wiring | Current design's native geometry, fit, mesh, slicer and release audits; physical assembly/commissioning separately |
| Build/CI/dependencies | All CI jobs from a clean setup; exercise cache miss/hit if cache behavior changed |

### Host and core regressions

~~~sh
cmake -S tests/host -B build/desk-tests
cmake --build build/desk-tests
ctest --test-dir build/desk-tests --output-on-failure
west twister -T tests/unit -v --inline-logs --integration --outdir build/twister
~~~

The six host suites cover controls/protocol/state, real indicator scheduling,
durable pairing reset and paced-reset counting, real output behavior,
bond-store/private-address churn, and the pinned NimBLE guard. They include
failure paths and repeated address rotation rather than only happy paths. The
Zephyr suite currently has 14 core cases using its configured unit-test target.
See the [host test configuration](tests/host/CMakeLists.txt), tests under `tests/`,
and [Zephyr cases](tests/unit/). Retired-controller and obsolete blink-pattern
cases were removed with their implementations; current ESP32 acknowledgement,
receiver persistence, pairing, reset, animation and bond regressions remain.

### OLED and manual screenshots

After PlatformIO has installed the pinned GFX library, run under Linux/WSL:

~~~sh
python tools/render_buddy_ui.py --output build/manual-oled
python tools/render_manual_screens.py --frames build/manual-oled --output docs/images/manual
~~~

The first tool compiles [tests/oled/render.cpp](tests/oled/render.cpp) with the
actual `buddy_ui.hpp` and Adafruit GFX. Hardware transport is stubbed; layout,
fonts and drawing primitives are real. It checks 13 frames for 128×64 text
bounds and writes PGM frames plus a contact sheet. The second composes the
manual's mood, state and pairing panels without changing screen pixels. Inspect
the PNGs, including at the README's rendered size. These are reproducible UI
renders, not photographs or proof of OLED electrical operation. Diagram sources
and provenance are in [docs/images/manual/README.md](docs/images/manual/README.md).

### Pixel waveform checks

Build the receiver first, then point the simulation at that build's actual
generated devicetree header:

~~~sh
python tools/simulate_pixels.py \
  --devicetree-header build/receiver/zephyr/include/generated/zephyr/devicetree_generated.h
~~~

The simulation compiles the real shared encoder, exercises static and animated
frames, checks channel/corner order, symbols, timing and low padding, and writes
JSON plus SPI-byte evidence under `build/pixel-simulation/`. The current suite
uses 3,359 frame vectors and 10,055 waveform checks. This verifies encoded output,
not signal integrity, power wiring, color balance or physical pixel acceptance.

### Formatting and physical acceptance

C sources/headers use the pinned Zephyr tree's `.clang-format`. CI checks every
tracked `.c` and `.h` with that style. Match nearby C++/Python style and avoid
unrelated formatting churn. Run `git diff --check` before committing; respect
`.gitattributes` for binary CAD and preserved snapshots.

For physical work, follow [HARDWARE_ACCEPTANCE.md](docs/HARDWARE_ACCEPTANCE.md),
the current assembly guide and [paired bench procedure](docs/PAIRED_BENCH.md).
Check the actual power arrangement, all six moods, independent red indicator,
saved state after restart, offline handling, pairing/Forget recovery, control
sleep/wake and reset bootloader recovery when relevant. Record what was observed
and what remains unchecked; retain image hashes and device/case revisions.

## Diagnostics and bench work

The controller's native USB serial console uses 115200 baud. It accepts commands
without requiring the OLED menu. Discover the actual port with PlatformIO;
install `pyserial` in the active Python environment for the helpers.

~~~sh
python -m platformio device list
python tools/controller_serial.py --port COM4 --command status
python tools/controller_serial.py --port COM4 --command sync
~~~

| Controller command | Effect |
| --- | --- |
| `help`, `status` | List commands or inspect firmware, selection, confirmed state and connection information |
| `menu` | Open settings |
| `sync` | Read the sign without changing its mood |
| `pair` | Explicit connection/pair operation for an unpaired controller |
| `send off`, `send warn`, `send on-air`, `send okay`, `send request`, `send special` | Send a mood to physical hardware |
| `test`, `test red`, `next`, `exit` | Enter/control/leave the controller's local light test |
| `pixel 1 red` through `pixel 4 red` | Set an individual receiver corner for a temporary diagnostic test; supported named colors are listed by `help` |
| `pixel end` | End the receiver pixel test and resume normal mood output |

Pair/reset and output-test commands change device state. Use them only for a
requested bench operation, with the devices in the correct electrical mode.
There is no substitute for the explicit on-screen Forget confirmation in the
normal user workflow. A receiver diagnostic build additionally exposes
`status`, `pair-reset`, `reboot` and `bootloader`; the last three deliberately
change device state. See [DEBUGGING.md](docs/DEBUGGING.md).

For an intentional battery-powered paired run, controller USB can log commands
and acknowledgements while receiver USB remains unplugged:

~~~sh
python tools/paired_bench.py --controller COM4 \
  --states off warn on-air okay request special --cycles 1 --dwell 2 \
  --output .local/bench/candidate-six-moods.json
~~~

Choose a new output filename for each retained run. The optional `--receiver`
port captures diagnostic serial when a safe receiver USB setup is appropriate;
that is not the same as a battery/RUN optical test. Read both firmware responses
and actual lights. An exact transaction acknowledgement proves protocol
acceptance, not that every LED visibly emitted the intended color.

| Development problem | Investigate |
| --- | --- |
| `west` cannot find the workspace | Check current directory and `.west/config`; this checkout's nested workspace differs from the fresh-clone layout |
| CMake references another OS/path | Create a new build directory; do not transplant the cache |
| Build changes do not affect pixels | Check selected `.conf` files, overlay order, generated header and the actual flashed UF2 hash |
| OLED renderer cannot find GFX | Run PlatformIO dependency installation/build first; use Linux g++ and Pillow |
| LED on controller never responds | Check current D7/GPIO44 against the older mechanical D6 proposal, ground, supply and buffer |
| Receiver USB console absent | Normal receiver firmware has USB disabled; use a diagnostic build and proper OFF/PROGRAM isolation |
| Security error after updating one peer | Inspect bond/identity logs and firmware compatibility; use explicit Forget/re-pair, not automatic key replacement in ordinary sync |
| New mood fails on one peer | Check both firmwares support status values 4/5 and share the same wire contract |
| Pixel glitch appears only on hardware | Check power, common ground, data routing/level, resistor and actual pulse shape; a simulation cannot validate those |

## Implementing changes

### A useful development loop

1. Inspect `git status`, branch and worktrees. Start a feature branch from current
   main; preserve unrelated local edits and records.
2. Find the owning layer in the source map and read its tests. State the expected
   behavior, including failure/offline/restart cases, before changing it.
3. Put portable behavior in shared C or the existing host-testable controller
   helpers. Keep GPIO, transport and storage adapters at their platform boundary.
4. Add focused regressions for changed behavior and failure paths, then run the
   appropriate builds and checks above. Do not add tests that merely repeat the
   implementation or rebuild firmware for a prose edit.
5. Update the user manual when controls/visible behavior change, developer docs
   when contracts/setup change, and bench records only after actual observations.
6. Review the complete diff and CI before merging. Preserve compatibility and
   package pins unless the task explicitly includes changing them.

### Add or adjust a mood

Start in `include/little_on_air/status.h` and `src/status.c`. Preserve existing
numeric values and the six-byte protocol unless making an explicit versioned
change. Update validation/rotation and controller labels, taglines, expressions
and menu/serial parsing as needed. Update the real OLED cases, shared status and
receiver tests, pixel simulation expectations, user color table and screenshots.
Build the current controller and receiver, check persistence of the new value,
and update both devices together. Invalid/unknown values must still be rejected;
removing legacy support does not remove protocol validation or recovery.

### Change OLED, input or settings behavior

Home and pairing-help drawing lives in `buddy_ui.hpp`; other screens and menu
transitions live in `main.cpp`. Keep drawing driven by explicit state and avoid
doing BLE work inside drawing/input callbacks. Preserve the hold-release rule,
boot-held suppression, wake-only first gesture and selected/confirmed/verified
distinction. Run host input/state tests and render all screens. Check long text,
offline/unknown values, working notices and menu cancellation. Refresh manual
screens only from the real renderer; do not paint desired text over screenshots.

### Change transport, pairing or persistence

Read both `receiver_link.cpp` and `apps/receiver/src/ble_server.c`, then the
shared processor/protocol and bond/reset tests. Add negative cases for malformed
packets, stale or wrong acknowledgements, duplicate transactions, failed storage,
disconnects and restart during reset intent. Keep subscription before command
write, exact acknowledgement matching and persistence-before-application.
Sync must remain read-only; key replacement must remain explicit. New stored
fields require a schema/migration/recovery decision. New protocol fields require
a compatibility/versioning decision and coordinated firmware updates.

### Change brightness, pixels, pins or power behavior

Zephyr brightness/calibration is in `apps/receiver/CMakeLists.txt`; ESP32 brightness and
pins are in `platformio.ini`/`main.cpp`. Receiver pixel configuration spans
`apps/receiver/prj.conf`, the receiver board overlay, `padded_pixels.c` and
`ws2812_frame.c`. Check both generated configuration and hardware wiring. Preserve
the independent power indicator and no-flash/no-phase-reset reconciliation.
For timing changes, run the current waveform simulation and measure the real hardware.
For brightness changes, check electrical load and optical result; do not infer
runtime or thermal safety from a numeric brightness limit. Update BOM/wiring
and assembly guidance deliberately if a pin or component changes.

## CAD and manufacturing workflow

Hardware outputs and release checksums are versioned evidence. Keep exploratory
geometry separate from print files. Do not regenerate an existing published
bundle merely to make timestamps or documentation match current firmware.

### Current receiver case: v2.15

[The v2.15 guide](hardware/enclosure/v215/README.md) describes the open-backed
channel change. The builder imports archived geometry/mesh/G-code helpers and
the v2.14 validation record; do not delete those as unused history. In a
configured Fusion MCP environment, the documented regeneration path is:

~~~sh
python hardware/archive/enclosure/fusion_client.py run hardware/enclosure/v215/open_channels.py
python hardware/enclosure/v215/prepare_prints.py
python hardware/enclosure/v215/audit_prints.py
python hardware/enclosure/v215/routing_diagram.py
~~~

This requires the existing Fusion setup, NumPy and the configured Bambu Studio
slicer paths. It writes under `hardware/enclosure/output/v215/`; print preparation
generates projects and does not start a printer job. Render the generated
`front-wiring.svg` to PNG before packaging. Review native geometry, meshes, fit,
toolpaths and preserved placement/paint payloads. In v2.15 the former channel-roof
layer must no longer contain bridge extrusions.

`package_release.py` **and** `audit_release.py` write the release directory,
manifest, checksums and ZIP; they are not read-only audits. For a new revision,
choose new output and release paths first, then complete native/slicer checks
before packaging. Preserve the published v2.15 and archived v2.16 bytes.

### Current controller: Igor measured v4

Use [its design guide](hardware/controller/igor-measured-v4/README.md), pinned
[CAD requirements](hardware/controller/igor-measured-v4/requirements.txt) and
the measured component envelopes. In a suitable CAD Python environment:

~~~sh
python -m pip install -r hardware/controller/igor-measured-v4/requirements.txt
cd hardware/controller/igor-measured-v4
python run_cad.py build
python run_cad.py validate_fit
python prepare_prints.py
python render_views.py
# Only when deliberately producing the corresponding manufacturing package:
python package.py
~~~

Use `run_cad.py` as documented to separate genuine CAD failures from the known
OpenCascade interpreter-teardown issue. Check the shell, OLED ribbon/header,
encoder, strip, weights, board carrier, plug envelope and cable routing. Preserve
upstream Igor attribution and license information in
[SOURCES.md](hardware/controller/igor-measured-v4/SOURCES.md). Physical print fit,
assembly and electrical commissioning remain separate from digital validation.

## CI, releases and contribution workflow

[CI](.github/workflows/ci.yml) has three jobs:

- **ESP32-S3 controller:** six host suites, PlatformIO build, actual-GFX bounds
  rendering, and upload of the controller's four flash images, ELF and preview.
- **test-and-build:** whitespace and pinned-style C formatting, 14 Zephyr core
  tests, normal and USB diagnostic receiver builds, current waveform simulation,
  then reports and receiver images.
- **Current firmware bundle:** after both builds pass, package the tested current
  pair with a source-revision manifest, individual file checksums, flashing guide,
  ZIP and ZIP checksum. This exercises release packaging on every PR.

The required main-branch check remains `test-and-build`; all three jobs should
pass before merging. PRs run the full matrix. Keep required check names stable
and avoid path filters that leave a protected branch waiting for a skipped check.

### Caching

The local [setup-zephyr action](.github/actions/setup-zephyr/action.yml) wraps the
official Zephyr setup action. SDK, pip downloads and compiler objects are cached;
the wrapper additionally caches west source dependencies by manifest and setup
configuration. It recreates workspace configuration rather than caching `.west`.
The HAL filter includes Nordic only; extend it deliberately for another vendor.

PlatformIO caches download/package/platform directories and application library
dependencies, keyed by OS/architecture, Core 6.1.18 and `platformio.ini`. Generated
application build output is not cached. Builds/tests still run after cache restore;
a miss repopulates dependencies. When changing setup or pins, check cold and warm
behavior rather than using old local dependencies as proof of reproducibility.

### Versions, releases and recovery

The root [VERSION](VERSION) is the **device-pair bundle version**, now `0.4.0`.
The ESP32 version string is in `main.cpp`; packaging requires it to agree with
VERSION. The receiver is identified by its source revision, configuration and
image hash; VERSION is not automatically embedded as a Zephyr runtime string.
Hardware revisions remain independent of the firmware bundle version.

The [tagged release workflow](.github/workflows/release.yml) checks `v*.*.*` tags
against VERSION and calls the same CI workflow. Only after every test/build and
packaging job succeeds does it publish that already-tested ZIP and its checksum.
The ZIP contains ESP32 bootloader, partition table, OTA initializer, application
and ELF; the normal four-pixel receiver UF2/ELF; FLASHING.md; manifest.json; and
SHA256SUMS. The USB diagnostic image is a separate CI artifact for servicing,
not the normal release image. Published manufacturing ZIPs retain their old
snapshots as historical artifacts and are not active firmware distributions.

`tools/package_firmware.py` packages without flashing or publishing. Its inputs
are staged controller files (including the pinned framework's `boot_app0.bin`)
and the receiver's `zephyr.uf2`/`zephyr.elf`. It rejects missing/empty images,
version mismatch and reuse of an existing output bundle directory:

~~~sh
python tools/package_firmware.py \
  --controller-dir build/controller-images \
  --receiver-dir build/receiver-images \
  --output build/firmware-release \
  --revision "$(git rev-parse HEAD)"
~~~

See CI's staging steps for the exact source paths. Flash ESP32 images at their
individual manifest offsets; a combined, padded image can overwrite NVS in the
gaps. Keep known-good application images and source/configuration hashes for
recovery, but do not maintain old product targets or restore stale full-flash
bond records. After updating the pair, check saved state, pairing and all six
moods using the proper USB isolation sequence. Creating a tag publishes a
release; do not tag just to test packaging.

### Git review and handoff

Use a feature branch (`codex/` for agent-created work), inspect worktrees first,
and preserve unrelated changes. Review the full diff, including generated images,
archive moves and manifests. Do not force-push, discard local work or delete
branches as routine cleanup. Preserve manufacturing byte identity and follow
`.gitattributes`.

A useful PR explains the problem and resulting behavior, compatibility/hardware
implications, checks run, and remaining physical validation. After required checks
pass, merge when authorized and verify local main and remote main agree. When the
user requests commit/push/merge, carry it through rather than stopping at a local
commit. Keep the end-user manual and this guide aligned with the final change.

## Further references

- [Workspace guide](docs/WORKSPACE.md): local toolchains, retained firmware and bench records.
- [Architecture](docs/ARCHITECTURE.md): current device roles and implementation map.
- [ESP32 controller guide](apps/controller-esp32s3/README.md): application wiring and command details.
- [Pairing and power update](docs/PAIRING_POWER_UPDATE.md): current physical observations and hashes.
- [Buddy/six-mood update](docs/BUDDY_UPDATE.md): UI, reconciliation and animation history.
- [Power](docs/POWER.md), [debugging](docs/DEBUGGING.md), [flashing](docs/FLASHING.md).
- [Firmware history](docs/HISTORY.md): retired targets and dated bench evidence, including the 375 ns selection.
- [Hardware index](hardware/README.md), [design archive](hardware/archive/README.md), [release index](release/README.md).
- [MIT license](LICENSE); retain the upstream attribution shipped with hardware sources.
