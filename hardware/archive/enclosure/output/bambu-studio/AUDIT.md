# Double-check results

The digital checks pass. No case geometry or slicing changes were needed during this audit. The manual project's stale preview images were refreshed, and this ZIP now includes the acrylic SVG and assembly instructions so its document links work after extraction.

| Check | Result |
|---|---|
| Printed parts | Nine assembly parts plus three fit samples; one of each on the intended plate |
| Mesh integrity | All twelve are single closed solids with consistent face winding |
| Mesh fidelity | Project geometry matches the original oriented STL exports at 0.001 mm coordinate precision |
| Units and bed placement | Millimetres, original scale, on the bed, clear of the bed exclusion area |
| Part spacing | No overlap, including a conservative 3.5 mm allowance around each part for brim/support |
| Saved process | Both variants reopened and saved through Bambu Studio without changing any customized process setting |
| Supports | Carrier underside and control flanges supported; backplate nut pockets have no generated support |
| AMS lettering | Eight black model layers, then two white layers; exactly one automatic change |
| Manual lettering | Exactly one pause before layer 9, after the 1.6 mm black base |
| Acrylic artwork | Exact keyed cut outline; rear mirror correct; letter contour approximation differs from the STL by less than 0.09 mm at sampled boundary points |
| Native Fusion | Fresh check: no unhealthy features and no modeled interference, including reference hardware |
| Slicing | All four plates completed without reported slicing warnings |

The four M3 × 25 screws pass from the front into nuts captured in integral backplate bosses. The modeled heads sit 0.2 mm below the front; the tips stop 0.5 mm before the inside of the 1.3 mm rear skin. The flat wall-facing surface remains closed.

The existing X1 Carbon / 0.4 mm / Generic PETG setup remains selected. Total AMS estimate is approximately **5 h 38 min and 95 g**, including the fit samples. The print job has not been sent to a printer.

Physical fit is still unverified. Print the coupons and small controls first, then check actual M3 hardware, measured acrylic thickness, LED/solder envelopes, both USB cable plugs, reset travel and DPDT switch throw. The Fusion electronics are reference envelopes; collision-free CAD does not confirm those physical measurements.

Detailed results are in `audit/independent-audit.json` and `audit/roundtrip-verification.json`. Printing instructions are in `PRINT-SETUP.md` and assembly instructions are in `ASSEMBLY.md`.
