# Flashing

## Release images

Download the controller and receiver UF2 files from the matching GitHub
Release. Do not swap their roles.

For each board:

1. Connect USB-C.
2. Double-tap reset quickly. A `XIAO-SENSE` mass-storage drive appears on the
   factory Sense bootloader used by our test boards; other factory revisions
   may label it `XIAO-BOOT`.
3. Copy the appropriate `.uf2` file onto that drive.
4. Wait for the board to program itself, eject, and restart.

Application-only UF2 updates leave the bootloader, SoftDevice reservation,
bond, and saved status partitions intact.

## Local images

After a local build, use:

- `build/controller/zephyr/zephyr.uf2` for the remote.
- `build/receiver/zephyr/zephyr.uf2` for the display.

The release workflow also publishes ELF files for an SWD debugger. SWD is not
required for ordinary installation or recovery because v0 never repurposes the
reset pin.

## Factory pairing reset

Five paced reset presses are an application gesture. Do the controller's five
presses first, then the receiver's while the controller is trying to pair.
Wait for the LED after each of the first four presses. A rapid double tap is
intentionally still interpreted by the factory bootloader and will open
`XIAO-BOOT` instead. If the 60-second pairing windows do not overlap, one more
press on either unpaired board reopens its window.
