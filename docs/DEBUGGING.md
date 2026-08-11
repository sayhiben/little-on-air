# USB diagnostics

The normal firmware disables USB and logging to save battery power. The two
optional debug profiles enable reconnecting USB CDC logs with distinct product
IDs, so both boards can be traced from one computer:

- Controller: USB PID `0005`, shown as `CTRL` by the tail tool.
- Receiver: USB PID `0006`, shown as `RECV` by the tail tool.

From the west workspace root, build the diagnostic images with the extra
configuration and overlay. Replace `$PWD/little-on-air` if the checkout uses a
different path:

```sh
west build -p always -b xiao_ble/nrf52840 little-on-air/apps/controller \
  -d build/controller-debug -- \
  -DEXTRA_CONF_FILE=debug.conf \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/little-on-air/boards/xiao_ble_nrf52840_debug.overlay"

west build -p always -b xiao_ble/nrf52840 little-on-air/apps/receiver \
  -d build/receiver-debug -- \
  -DEXTRA_CONF_FILE=debug.conf \
  -DEXTRA_DTC_OVERLAY_FILE="$PWD/little-on-air/boards/xiao_ble_nrf52840_debug.overlay"
```

Flash each UF2 to its matching board. Install pyserial and tail both ports;
the tool follows USB disconnects and reconnects caused by reset-button boots:

```sh
python -m pip install pyserial
python little-on-air/tools/tail_serial.py
```

Use `--duration 60` for a bounded capture. Diagnostic images are intended only
for bench testing: USB and logging materially increase idle power. Reflash the
normal controller and receiver builds before measuring battery current.
