# v2 validation results

The revised enclosure implements the rear-mounted fixtures and independent optical assembly. Seven main FDM parts replace the earlier carrier and separate stationary keepers. The case is 120 × 60 × 34 mm.

## Checks completed

| Check | Result |
|---|---|
| Native Fusion features | 868 timeline entries checked; no feature errors or warnings |
| Solid interference | No positive-volume collisions in the modeled default assembly, including screws and nuts |
| Assembly and control movement | All 13 sampled insertion, closure and travel checks passed (913 poses; no overlap above 0.001 mm³) |
| Main STLs | Seven separate, closed, consistently oriented, connected solids; millimeters; on Z=0 |
| Optional parts and fit sections | Two closed laminate rings and eight closed sections clipped from production geometry |
| Artwork registration | Actual STL lettering matches the shared laser master within 0.00000874 mm; outlines coincide |
| SVG operations | Closed vector paths; 104 × 38 mm; rear acrylic text and key mirrored together; blue Fill, red Line |
| Bambu Studio | Three plates sliced without warnings; all project meshes match the exported STLs |
| Color transition | Black through 1.6 mm; white begins on the layer ending at 1.7 mm; graphic finishes at 2.5 mm |
| Native Bambu save | AMS project opened, all plates sliced, graphic preview inspected, and project saved with native previews |

## Manufacturing consequences

The optical retainer has about 1,002 mm² of bed contact and no elevated horizontal undersides. The open electronics yoke has about 840 mm² of bed contact. This removes the previous carrier's broad, suspended 4,140 mm² underside. Remaining short bridges are mainly fastener pockets and small locating/control details.

The USB openings and reset guide are open toward the assembly face until the yoke is installed. Its integrated caps then close them. This allows straight board/control insertion while retaining broad print contact. The DPDT fork also admits the actuator from the front. The front-inserted closure screws terminate in blind rear-housing bosses; the wall surface remains closed.

## Bambu estimates

- Main AMS build: 5 h 19 min; 86.6 g.
- Main manual-swap build: 5 h 13 min; 84.9 g; manual swap time is additional.
- Separate fit-check plate: 1 h 24 min; 18.7 g.

These are slicer estimates for the included X1 Carbon / 0.4 mm / Generic PETG profile.

## Scope of validation

Movement checks sample translations every 0.25 mm for insertion, with finer spacing for control travel. They validate the documented paths through the nominal solids, not every possible orientation. Wiring, solder joints, compliance, print shrinkage and loads are not simulated. No physical prototype or optical brightness test has been performed.

Use the fit project first. Actual acrylic thickness, charger dimensions, XIAO populated envelope/reset position and USB cable overmolds remain the important physical checks. The confirmed DPDT actuator is 1.42 × 1.42 × 1.83 mm, with about 2.58 mm movement in a 4 mm opening.

The optional laminate rings passed mesh checks; the default collision/travel study uses the printed graphic. Assembly dimensions for the alternative are documented in the build guide.
