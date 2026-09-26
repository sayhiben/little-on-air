#!/usr/bin/env python3
"""Send real BLE commands through the desk controller and verify exact ACKs.

Optionally capture the receiver USB log while it is in OFF/PROGRAM mode.
This does not establish optical output; observe the sign separately on battery.
"""
import argparse
import contextlib
import json
import re
import time
from pathlib import Path

import serial


def connect(port):
    connection = serial.Serial(port=None, baudrate=115200, timeout=0, write_timeout=1)
    connection.dtr = True
    connection.rts = False
    connection.port = port
    connection.open()
    return connection


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--controller', required=True)
    parser.add_argument('--receiver')
    parser.add_argument('--states', nargs='+', choices=['off', 'warn', 'on-air', 'okay', 'request', 'special'],
                        default=['warn', 'on-air', 'okay', 'off'])
    parser.add_argument('--cycles', type=int, default=1)
    parser.add_argument('--dwell', type=float, default=2)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    results = []
    origin = time.monotonic()
    with contextlib.ExitStack() as stack:
        log = stack.enter_context(args.output.with_suffix('.log').open('w', encoding='utf-8'))
        ports = {'CTRL': stack.enter_context(connect(args.controller))}
        if args.receiver:
            ports['RECV'] = stack.enter_context(connect(args.receiver))
        buffers = {name: b'' for name in ports}

        def emit(role, line):
            text = f'{time.monotonic() - origin:8.3f} {role} | {line}'
            print(text, flush=True)
            log.write(text + '\n')
            log.flush()

        def read_lines():
            lines = []
            for role, port in ports.items():
                buffers[role] += port.read(port.in_waiting)
                while b'\n' in buffers[role]:
                    raw, buffers[role] = buffers[role].split(b'\n', 1)
                    line = re.sub(r'\x1b\[[0-9;]*m', '', raw.decode(errors='replace')).strip()
                    emit(role, line)
                    lines.append((role, line))
            return lines

        def drain(seconds):
            end = time.monotonic() + seconds
            while time.monotonic() < end:
                read_lines()
                time.sleep(.01)

        def send(command):
            emit('HOST', command)
            ports['CTRL'].write((command + '\n').encode('ascii'))

        drain(.3)
        send('exit')
        drain(.2)
        try:
            for target in args.states * args.cycles:
                started = time.monotonic()
                request = None
                ack = None
                send('send ' + target)
                while time.monotonic() - started < 12:
                    for role, line in read_lines():
                        if role != 'CTRL':
                            continue
                        match = re.fullmatch(r'REQUEST op=1 tx=([0-9a-f]+) status=(\S+)', line)
                        if match:
                            request = match.groups()
                        match = re.fullmatch(
                            r'RESULT op=1 success=(\d) bonded=(\d) tx=([0-9a-f]+) '
                            r'status=(\S+) detail=(.*)', line)
                        if match:
                            ack = match.groups()
                    if ack:
                        break
                    time.sleep(.01)
                passed = bool(request and ack and request[1] == target and ack[0:2] == ('1', '1')
                              and ack[2:4] == request)
                result = {'state': target, 'request': request, 'ack': ack, 'passed': passed,
                          'seconds': round(time.monotonic() - started, 3)}
                results.append(result)
                emit('CHECK', json.dumps(result))
                if not passed:
                    raise RuntimeError(f'No exact acknowledged {target} command')
                send('status')
                drain(args.dwell)
        finally:
            args.output.write_text(json.dumps(results, indent=2) + '\n', encoding='utf-8')
    print(f'PASS: {len(results)} exact BLE acknowledgments', flush=True)


if __name__ == '__main__':
    main()
