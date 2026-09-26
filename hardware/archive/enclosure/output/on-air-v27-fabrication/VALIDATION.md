# v2.7 validation

- Native Fusion: no feature errors or measured-envelope overlaps. 14 fresh assembly/control motion checks passed, plus sight-line, pad-exit and pre-soldered insertion probes.
- USB checks include a 0.15 mm enlarged socket envelope and reset motion against the PCB/USB/LED. Optical screw heads clear the keeper during closure.
- All eight nut loading paths and common M3×8 stacks checked. Nut engagement is the full 2.4 mm thickness; all screw tips remain inside blind clearances.
- 45 native wire-route, auxiliary-bay and individual LED-exit reservations pass against the assembly, including actual hardware. Revised routes replace earlier path results against unchanged solids.
- 120 route pairs checked for simultaneous wire packing. Contacts are allowed only in the documented terminal/junction bays, where leads are spread during assembly.
- 18 STL meshes are watertight, each one connected solid with positive bed contact and Z=0 in its print orientation.
- Nine Bambu projects sliced with no warnings; saved meshes match the corresponding STLs. First-layer inspection is absent, bed leveling remains, normal heater shutdown is present. Only manual graphic plates contain a deliberate filament-change pause.
- The packaged four-part eSUN PLA+ fit project also opened and sliced in the Bambu Studio GUI, showing 2 h 8 min and 34.25 g, with no warnings. No print was sent.
- Saved Fusion archive re-imports with matching body volumes and no static overlaps. Laser SVGs exactly match the previous validated optical files.

These are geometric, envelope and slicer checks. They do not certify physical printer tolerances, switch actuation force, cable overmould fit, optical output, radio range, charge-current suitability or thermal behavior. Use the physical fit plate and retained commissioning procedure. No hardware operation has been started.
