#!/usr/bin/env python3
"""Send diagnostic commands to the ESP32-S3 controller and capture USB output."""
import argparse
import time

import serial
from serial.tools import list_ports


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--port", help="Explicit serial port; otherwise find the single ESP32 USB device")
    parser.add_argument("--command", action="append", default=[], help="Line to send; repeat for multiple commands")
    parser.add_argument("--duration", type=float, default=3)
    args = parser.parse_args()
    port = args.port
    if not port:
        candidates = [p.device for p in list_ports.comports() if p.vid == 0x303A and p.pid == 0x1001]
        if len(candidates) != 1:
            parser.error(f"Expected one ESP32 USB device; found {candidates}. Use --port.")
        port = candidates[0]
    connection = serial.Serial(port=None, baudrate=115200, timeout=0.1, write_timeout=1)
    # Set control lines before opening: do not reset the board while observing it.
    connection.dtr = True
    connection.rts = False
    connection.port = port
    connection.open()
    with connection:
        time.sleep(0.2)
        for command in args.command:
            connection.write((command + "\n").encode("ascii"))
        end = time.monotonic() + args.duration
        while time.monotonic() < end:
            line = connection.readline()
            if line:
                print(line.decode("utf-8", errors="replace").rstrip(), flush=True)


if __name__ == "__main__":
    main()
