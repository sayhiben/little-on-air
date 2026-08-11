#!/usr/bin/env python3
"""Tail reconnecting Little On Air controller and receiver USB logs."""

import argparse
import re
import time

import serial
import serial.tools.list_ports


USB_VID = 0x2FE3
ROLE_BY_PID = {
    0x0005: "CTRL",
    0x0006: "RECV",
}
ANSI_ESCAPE = re.compile(r"\x1b\[[0-9;]*m")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--duration",
        type=float,
        help="stop after this many seconds instead of waiting for Ctrl+C",
    )
    return parser.parse_args()


def visible_ports() -> dict[str, str]:
    return {
        port.device: ROLE_BY_PID[port.pid]
        for port in serial.tools.list_ports.comports()
        if port.vid == USB_VID and port.pid in ROLE_BY_PID
    }


def main() -> None:
    args = parse_args()
    deadline = time.monotonic() + args.duration if args.duration else None
    open_ports: dict[str, tuple[str, serial.Serial]] = {}

    try:
        while deadline is None or time.monotonic() < deadline:
            visible = visible_ports()
            for device, role in visible.items():
                if device in open_ports:
                    continue
                try:
                    port = serial.Serial(device, 115200, timeout=0)
                    port.dtr = True
                    open_ports[device] = (role, port)
                    print(f"{role} | connected {device}", flush=True)
                except serial.SerialException:
                    pass

            for device, (role, port) in list(open_ports.items()):
                if device not in visible:
                    port.close()
                    del open_ports[device]
                    print(f"{role} | disconnected {device}", flush=True)
                    continue

                try:
                    while port.in_waiting:
                        raw = port.readline()
                        if raw:
                            line = ANSI_ESCAPE.sub(
                                "", raw.decode("utf-8", errors="replace")
                            ).rstrip()
                            print(f"{role} | {line}", flush=True)
                except (OSError, serial.SerialException):
                    port.close()
                    del open_ports[device]

            time.sleep(0.03)
    except KeyboardInterrupt:
        pass
    finally:
        for _, port in open_ports.values():
            port.close()


if __name__ == "__main__":
    main()
