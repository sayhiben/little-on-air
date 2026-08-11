# Contributing

Use a feature branch and keep shared behavior in the hardware-independent core
where practical. Before opening a pull request, run:

```sh
west twister -T little-on-air/tests -v --inline-logs
west build -b xiao_ble/nrf52840 little-on-air/apps/controller -d build/controller
west build -b xiao_ble/nrf52840 little-on-air/apps/receiver -d build/receiver
```

New protocol fields require a versioning and compatibility decision. Changes
to reset handling must preserve rapid double-tap UF2 recovery. Hardware-facing
changes should update the acceptance checklist and include measured results.
