# ESP32-S3 desk controller

USB-powered Seeed XIAO ESP32-S3 controller for the existing Little On Air BLE
receiver. This application uses Arduino-ESP32 with pinned PlatformIO packages.
The nRF52840 controller in `../controller` and receiver in `../receiver` remain
separate Zephyr applications; their UF2 files cannot be flashed to this board.

## Wiring

| Part | XIAO label | ESP32 GPIO |
| --- | --- | --- |
| SSD1306 128×64 OLED SDA | D4 | 5 |
| OLED SCL | D5 | 6 |
| Encoder CLK | D0 | 1 |
| Encoder DT | D1 | 2 |
| Encoder SW | D3 | 4 |
| One RGB NeoPixel DIN, through 330 Ω | D7 | 44 |

OLED and encoder VCC use 3V3. NeoPixel power uses 5V. All grounds are common.
Pixel DOUT is unused. USB diagnostics use the native USB peripheral, leaving
GPIO44 available for the pixel. OLED address 0x3C or 0x3D is detected at boot.
The pixel uses GRB, 800 kHz and a default brightness limit of 24/255.

## Controls

- **Turn:** preview Off → Warn → On Air → Okay → Request → Special; turn backward
  to go the other way. Turning does not change the sign.
- **Press:** set the selected mood. When unpaired, start connecting to a sign.
- **Hold 1.2 seconds:** open the menu; hold again to return home.
- **Menu:** Back to my sign, Check my sign, Connect a sign, Light test, Forget this sign.
- **Forget this sign:** defaults to Keep my sign. Turn to Forget sign and press to erase.
  Keep the sign powered: firmware 0.4.0 clears both devices' pairing, then a
  press connects them again. If the sign cannot be reached, the OLED shows
  the five-reset recovery instructions below.
  Holding the knob during boot never clears a bond or sends a command.

The OLED buddy has a different expression for each mood: sleepy when Off,
sunglasses when On Air, and starry eyes for Special. Large text shows the
selection; **PICK A MOOD** and **Sign: ...** distinguish a preview from the
confirmed state. **SIGN IS OFFLINE** and **Last: ...** identify cached state that
has not been verified. A write response alone is not treated as confirmation.

The controller pixel stays at the confirmed state while you browse: red = On Air,
warm amber = Warn, steady green = Okay, flashing green = Request, a slowly changing
rainbow = Special, dark = Off. Unknown/offline uses a steady dim white marker.
Request flashes 600 ms on / 600 ms off. Special flows through a 20-second cycle;
the receiver's four corner pixels form a diagonal rainbow wash. Both devices
animate locally, so their phases need not match exactly.

The display dims after 30 seconds and turns off after two minutes without user
interaction. The first gesture wakes it without changing or sending a state.
The pixel continues displaying the status. Menus cancel after 30 seconds idle;
Hardware Test exits after 60 seconds idle. Background state reads do not reset
the display's inactivity timer.

**Hardware Test** labels the OLED with the commanded pixel color and input
counters. Turn or press to cycle Off / Red / Green / Blue / White / Yellow.
Hold to exit. This mode neither sends nor persists a receiver state.

## Build, flash, and inspect

From the repository root, with Python 3.10+:

```sh
python -m pip install platformio==6.1.18
python -m platformio run -d apps/controller-esp32s3
python -m platformio device list
python -m platformio run -d apps/controller-esp32s3 -t upload --upload-port COM4
python tools/controller_serial.py --port COM4 --command status
python tools/controller_serial.py --port COM4 --command "test red" --duration 30
python tools/controller_serial.py --port COM4 --command exit
```

Replace COM4 with the detected port. On this Windows workspace the Python
environment is `.venv\Scripts\python.exe`. The uploader writes and verifies the
bootloader, partition table and app; it does not erase the NVS bond/state area.
If USB upload cannot connect, hold BOOT, tap RESET, release BOOT and retry.

USB commands: `help`, `status`, `test`, `test red` (also off/green/blue/white/yellow),
`next`, `exit`, `menu`, `sync`, `pair`, `send off|warn|on-air|okay|request|special`.
`send` uses the same real BLE transaction and exact acknowledgment checks as
pressing the encoder; it rejects unpaired/busy requests and unknown states.
`pair` explicitly opens the same timed
pairing operation as the menu. Input events and BLE results are logged at 115200.
Firmware 0.2.3 adds `pixel 1 red` (indices 1–4 and the six hardware-test colors)
and `pixel end` for receivers with the individual-pixel characteristic. These
temporary front-light tests use encrypted write/read-back without changing the
saved receiver status; they end after two minutes or a regular status command.
Opening the provided monitor leaves reset control lines deasserted.
No USB command erases bonds or pretends to acknowledge a receiver command.

The full build outputs are under `.pio/build/xiao_esp32s3/`. `firmware.bin` alone
is the application at offset 0x10000; use PlatformIO to flash all required images.
Change `LOA_ENCODER_DIRECTION` to -1 if the physical encoder direction is reversed.

## Pairing with the nRF52840 receiver

1. Power the receiver. If it still has an old controller bond, clear that bond
   first using the five-reset procedure below.
2. On an unpaired receiver, one reset opens its 60-second pairing window.
3. On an unpaired controller, press to connect; otherwise hold the encoder,
   select **Connect a sign**, and press.
4. The controller scans for up to 45 seconds inside a 60-second operation budget,
   establishes an encrypted Secure Connections bond, and reads the receiver state.
5. Confirm the OLED shows **YOUR SIGN**, then turn and press to set a mood.

Only the stored bonded identity is contacted during ordinary sync/send. A missing
peer key reports a failure instead of silently forgetting/replacing the bond.
To replace the receiver, explicitly Forget this sign on the controller and clear the
receiver's old bond before pairing again.

### Reconnecting after Forget this sign

With controller **0.4.0** and the matching receiver update, keep the sign on,
choose **Forget this sign → Forget sign**, wait for **Ready to connect**, then
press the knob. The sign erases its bond and saved mood, restarts in Off, and
opens a 60-second pairing window. Its small onboard LED flashes red while
pairing and stays red after connecting. The front pixels show only the mood.

If the sign was off, out of range, or running older firmware, Forget still clears
the controller's pairing and displays **LET'S RECONNECT**. On the updated sign:

1. Leave the sign powered and press its rectangular RESET button **five times,
   about two seconds apart**. Let the application LED return between presses.
   Do not double-click: rapid double-reset enters the firmware bootloader.
2. After the fifth press, the sign clears its pairing and mood and flashes red.
3. Press the controller knob to connect within 60 seconds. If that window has
   expired, tap the sign's RESET once and press the knob again.

Six seconds of uninterrupted application runtime cancels an incomplete reset
sequence; power cycling also cancels it. Holding RESET does not run a timed
gesture because it holds the processor in reset. Ordinary power cycling and
application-only firmware updates preserve the bond.

If the controller still holds an old bond after physically resetting the sign,
choose **Forget this sign** there before pressing to connect. Recovery needs no
computer or special firmware. See [the pairing/power update](../../docs/PAIRING_POWER_UPDATE.md)
for the fix, build profiles, and hardware validation. Earlier receiver firmware
still requires the [diagnostic USB recovery](../../docs/PAIRED_BENCH.md#diagnostic-receiver-usb-commands).

## Behavior and compatibility

The shared C protocol/status implementations are built directly from the root
`src/` directory. UUIDs and the six-byte version-1 payload are unchanged. The
receiver remains the authority: subscribe to indications, write with response,
then require an exact transaction-ID **and** status match. A lost indication can
be recovered by an exact matching read. Failure marks the cached state unverified
and schedules read-only reconciliation with 1/2/4-second backoff; it never replays
the user's command. After three failed retries, manual Sync/press is required.
Successful operation resumes a read once per minute.
These background checks do not show connection messages, wake the OLED, restart
animations, or flash the bonded receiver's lights. A press during a background
check queues that selection until the read succeeds; failures never replay it.

Firmware `esp32s3-0.3.0` appends Request (wire value 4) and Special (5), preserving
values 0–3. Update the receiver before selecting either new mood. Old firmware
rejects the new values. Return to Off before rolling either device back.

BLE runs on a worker task, with an eight-second ordinary-operation budget; the
UI stops scans/connections at the deadline while continuing to read controls.
Connections close after each transaction to preserve receiver battery life.
Firmware `esp32s3-0.2.2` retries one BLE connection-establishment (`0x3e`)
failure before any command is sent, within the same eight-second deadline.
NimBLE persists bonds; Preferences stores only acknowledged/read-back state.
The pinned NimBLE 2.5.1 host is compiled through `nimble_guard.py`, which disables
its automatic missing-key pairing branch before GAP notification. The GAP
listener then translates that error to authentication failure. Normal operations
require a saved encryption key and make one encryption attempt. The storage
callback replaces only the same peer's obsolete private-address mapping when
that cache fills; it never evicts pairing keys to make room. Explicit Forget
clears residual key records as well as the listed bond.
Legacy BLE pairing is compiled out. Just Works has no passkey MITM protection,
as in the original receiver firmware.

## Tests

Host tests use CMake, a C/C++ compiler, and CTest (Linux/macOS or WSL):

```sh
cmake -S apps/controller-esp32s3/test -B build-desk-tests
cmake --build build-desk-tests
ctest --test-dir build-desk-tests --output-on-failure
```

They cover contact bounce/reversal/invalid encoder transitions, button debounce,
boot-held suppression, hold/release behavior, clock wrap, shared wire encoding,
malformed packets, exact ACK matching, cached-state trust, and preview preservation.
They also cover all six wire values, Request boundaries, Special's period and
bounded brightness, and background checks while the OLED is asleep. Reset tests
run the actual settings-backed counter and durable remote-reset request with
simulated pin/power/software resets, flash failures, and timeout work. Output
tests check that all six moods and individual pixel tests leave the onboard
power LED independent, with separate brightness limits. A thousand simulated
private-address rotations exercise the real storage callback without deleting
keys; the pinned-host patch refuses unrecognized source changes. After a
PlatformIO build, `python tools/render_buddy_ui.py` (g++ and Pillow required)
renders the actual Adafruit GFX home-screen code and checks text bounds.

See [the six-mood update](../../docs/BUDDY_UPDATE.md) for the receiver build,
blink diagnosis, and validation status.

See [the initial bench results](../../docs/ESP32S3_BENCH.md) for controller hardware
observations and [the pairing/power update](../../docs/PAIRING_POWER_UPDATE.md) for current
paired hardware checks.

Reference: [Seeed pin multiplexing](https://wiki.seeedstudio.com/xiao_esp32s3_pin_multiplexing/),
[PlatformIO XIAO ESP32-S3 target](https://docs.platformio.org/en/latest/boards/espressif32/seeed_xiao_esp32s3.html),
[NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino/tree/2.5.1).
