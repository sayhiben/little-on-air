# Little On Air: FDM and acrylic files

Print one of each of the nine separate files in `stl/`. Part 02 is acrylic and has no STL.
All STL coordinates are millimetres; import at 100% scale and select mm if asked.
The supplied orientations place every part on Z=0. Keep them for the first slicing pass.

## FDM setup

Starting setup: PETG, 0.4 mm nozzle, 0.2 mm layers, four walls on structural parts.
Use solid infill for the small controls and keepers. Use your calibrated filament profile.
The files are meshes, not sliced jobs: inspect the layer preview and add selective supports
where listed. The carrier has a supported partition; none of these files contains support geometry.

| Part | Bed orientation | Support / color notes |
| --- | --- | --- |
| 01-body-and-front-frame | Front face down | Support internal ledges, the reset guide, and USB/slider opening roofs where needed. |
| 03-black-and-white-backing | Flat black back down; letters up | No supports. Black through Z=1.6 mm; white from Z=1.6 to 2.0 mm. |
| 04-optical-and-electronics-tray | LED fingers toward bed; board mounts up | Support beneath the optical partition, which begins about 2.925 mm above the bed, and beneath projecting latches. Clean the latch slots. |
| 05-charger-keeper | Broad U clip face down; locating pegs up | Normally no supports; inspect the retaining tabs in preview. |
| 06-xiao-keeper | Outer fork face down; locating pegs up | Normally no supports; use a brim if the narrow fingers lift. |
| 07-captive-reset-plunger | Wide finger stem end down; narrow contact tip up | Use a small brim and selective support under the flange rim. Keep support off the sliding stem and contact tip. |
| 08-captive-power-slider | External finger pad down | Selective supports under the projecting internal flange; keep the switch socket clear. |
| 09-switch-keeper | Rear bridge face down; locating legs up | Normally no supports; inspect the leg transitions. |
| 10-wall-back-plate | Flat wall-facing surface down; nut blocks up | Inspect the short roofs over nut-loading slots. Avoid trapped supports in blind nut/screw pockets. |

For part 03, add a manual filament change **after the 1.6 mm black base**,
before printing any white lettering. With uniform 0.2 mm layers this is after eight
black layers, then two white layers. STL does not store colors or pauses.

## Acrylic

Use `acrylic/02-acrylic-rear-engrave-and-cut.svg` at **104 x 38 mm**.
The stock is nominally **3.175 mm (1/8 inch)**. A 3.0 mm sheet needs its fit checked.
Place the acrylic's eventual rear face upward. The lettering and keyed corner are
already mirrored together: **do not mirror the file again**.

1. Blue ENGRAVE layer: fill/raster engrave the letters, leaving the letter holes clear.
2. Red CUT layer: vector cut the single closed outside outline, after engraving.
3. Flip the finished piece left-to-right for installation. ON AIR reads normally
   through its front, and the keyed corner is at the upper left when viewed from the front.

All lettering is converted to paths; no font installation is required. The outline
has no kerf offset. Calibrate the cut/engrave settings on scrap of the same acrylic
and apply any needed kerf compensation in the laser software. Keep the light-entry edges clean.

## First-fit checks

Start with the three files in `fit-samples/`, then the small keepers, plunger and slider.
These check the M3 head/nut pockets, LED/acrylic interface and reset guide. The M3 sample
is deliberately shorter than the case, so a 25 mm screw extends through that sample.
Digital mesh checks passed; physical fit has not been tested. Confirm actual board
and solder dimensions, reset travel, DPDT throw and acrylic thickness before full fabrication.

The back uses four M3 x 25 socket-head screws inserted from the front and four M3 nuts
loaded sideways into the backplate's integral mounting blocks. No screw exits the rear face.

See `ASSEMBLY.md` for the full installation order and remaining measurements.
