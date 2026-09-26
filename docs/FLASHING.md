# Flash the current device pair

The supported pair is a **XIAO ESP32-S3 OLED/encoder controller** and a
**XIAO nRF52840 four-pixel sign**. Update them together. Firmware in old
manufacturing bundles is historical; use the current CI/release firmware bundle
or build the current source. No legacy controller UF2 is produced.

## Identify the images

Extract `little-on-air-v<version>.zip`. Its `manifest.json` records the source
revision, board roles, controller offsets and file hashes. Check the ZIP's
`.sha256` before extraction and `SHA256SUMS` inside the extracted directory.
On Linux/WSL, run `sha256sum -c SHA256SUMS` from that directory. On PowerShell,
use `Get-FileHash -Algorithm SHA256 <path>` and compare with the manifest.

| Folder | Files | Device |
| --- | --- | --- |
| `controller/` | `bootloader.bin`, `partitions.bin`, `boot_app0.bin`, `firmware.bin`, `firmware.elf` | XIAO ESP32-S3 |
| `receiver/` | `zephyr.uf2`, `zephyr.elf` | XIAO nRF52840 sign, four-pixel 375 ns configuration |

ELF files are debugger symbols; they are not files to copy onto a UF2 drive.
The normal receiver image has no USB console. The receiver debug image is a
separate CI artifact and uses the same pixels, pins and application behavior.

## Controller: ESP32-S3

The controller uses USB power normally. From a configured source checkout,
PlatformIO builds and uploads all required images with the correct offsets:

```sh
python -m platformio run -d apps/controller-esp32s3
python -m platformio device list
python -m platformio run -d apps/controller-esp32s3 -t upload --upload-port COM4
```

Replace COM4 with the actual controller port (`/dev/ttyACM0`, for example, on
Linux). For a downloaded bundle, install the matching esptool in your Python
environment and run from the extracted bundle directory:

```sh
python -m pip install esptool==4.9.0
python -m esptool --chip esp32s3 --port COM4 --baud 460800 write_flash \
  0x0 controller/bootloader.bin \
  0x8000 controller/partitions.bin \
  0xe000 controller/boot_app0.bin \
  0x10000 controller/firmware.bin
```

The backslash continuation above is for a Linux shell; in PowerShell put the
command on one line or use PowerShell's backtick continuation. If automatic
upload cannot enter the ROM downloader, use the board's BOOT/RESET controls
according to the XIAO ESP32-S3 procedure; do not erase flash as a first remedy.

These individual writes leave NVS/bond storage in the gaps intact. Do not use
`erase_flash`, restore a historical full-flash backup, or substitute a merged
image padded across the NVS region for an ordinary update. The normal physical
knob is an application control, not the board's BOOT button.

## Sign: nRF52840

Before connecting **either** sign USB port, set POWER OFF. With both USB ports
unplugged, select PROGRAM. Connect **XIAO USB only** for firmware service; leave
charger USB unplugged. Never connect both ports or use receiver USB in RUN.

1. With POWER OFF / PROGRAM, connect a data cable to XIAO USB.
2. Rapidly double-tap RESET. Identify the removable factory boot volume, commonly
   `XIAO-SENSE` or `XIAO-BOOT` depending on the installed bootloader.
3. Copy `receiver/zephyr.uf2` to that volume. Wait for programming and restart.
4. Unplug XIAO USB. With POWER still OFF, select RUN, then POWER ON.
5. Check saved mood, pairing, all six moods and the independent red power light.

A local normal build produces `build/receiver/zephyr/zephyr.uf2`:

```sh
west build -b xiao_ble/nrf52840 apps/receiver -d build/receiver
```

Application-only UF2 updates preserve the factory bootloader, reserved flash,
settings, bond and saved mood. Keep nRESET as hardware reset; do not mass-erase
or overwrite UICR. SWD is not required for normal installation or recovery.

## Pairing recovery after an update

A normal update should retain pairing. Check power and use **Check my sign**
first. If pairing records are mismatched, use the controller's **Forget this
sign** with the sign powered nearby. If necessary, reset the sign's pairing with
five separate RESET presses about two seconds apart, then press the unpaired
controller knob during the 60-second pairing window. This paced sequence is
different from the rapid double tap used for UF2 recovery.

See the [product manual](https://github.com/sayhiben/little-on-air/blob/main/README.md)
and [developer guide](https://github.com/sayhiben/little-on-air/blob/main/CONTRIBUTING.md)
for controls, commissioning, build setup and diagnostics. Flashing instructions
in historical manufacturing snapshots describe their own old firmware.
