# Fit report — measured revision 4

Dimensions are millimeters. The user's measurements drive the OLED, encoder,
strip and weight models. Seeed's STEP drives XIAO fit. Clearances below are
nominal CAD gaps, not guarantees of printed tolerance.

| Part | Supplied geometry | Fit provided |
| --- | --- | --- |
| Weights, quantity 2 | Each 20 × 33.5 × 6.5, including foam adhesive | 41 × 34.1 well; 0.25 at outer sides, 0.5 between weights; 0.7 below carrier; at least 2.4 solid floor |
| Encoder PCB | 19.25 × 26.4 × 1.5; solder extends 2 below | Entire underside solder envelope reserved; board supported through encoder box, no locating pegs through uncertain holes |
| Encoder box | 12 × 12 × 7, measured asymmetric offsets | 12.4 × 12.4 locator; 0.2 per side and 0.25 above; header faces front |
| Registration tab | 1.2 above box; plan dimensions unspecified | Conservative 12 × 3 envelope; slot continues down for insertion; 0.25 clearance above |
| Collar | Diameter 6.8, length 7 | Diameter 7.2 roof hole; enlarged knob underside clearance |
| Shaft | Diameter 6, exposed length 13.25; flat chord 5.4 | D socket radius 3.1, flat clearance 0.15; original outside knob shape |
| Button movement | Travel not supplied | 1 mm sampled press allowance; knob stands 1.2 above roof and retains 0.2 at full allowance |
| Encoder header | Plastic 12.45 × 2.5 × 2.45; pins 2.4 above, 4.7 beyond board, diameter 0.64 | Full measured plastic and bent pins retained; separate 13.5 × 8.5 × 3 connector allowance |
| OLED PCB | 27.6 × 27.9 × 1.25 | Side and end guides provide 0.2 each; corner stops contact PCB front |
| OLED glass | 26.6 × 19.2, 2 above PCB front | 0.5 gap from faceplate rear; no supports press on glass |
| OLED active area | 25.5 × 14.5, 5 from top and 0.75 from left | 26.2 × 15.2 throat, centered on measured active area; front bevel opens to 29.2 × 18.2 at the face surface |
| OLED solder and ribbon | Front solder 1.85; centered 14.5 × 2.5 board notch; ribbon about 2 above board | Untrimmed solder reserved; central lower relief keeps stops and glue clear of ribbon |
| OLED header | 10 × 2 footprint, plastic 2 and pins another 5.8 behind PCB | Full header and pins retained; separate 10.8 × 8 × 2.6 connector allowance |
| Mini NeoPixel strip | 5 × 17.6 × 1.4, centered LED | 5.4 wide holder; 0.2 per side/end, 0.2 mounting tape allowance; no trimming required |
| Diffuser | Added printed part | Diameter 5 visible stem, 6.4 flange, 2.4 total thickness; 0.15 stem and 0.2 flange radial clearance; 1.5 gap to LED envelope |
| XIAO ESP32-S3 | Manufacturer reference STEP | 0.21 PCB side clearance, 0.3 mounting tape, USB tip about 0.11 beyond rear wall; 9.8 × 4.6 USB opening |

## Weight capacity and preserved shape

Two weights fill the usable flat-bottom compartment in one layer. Three would
require another row or extra width beyond the existing rear compartment; the
raised front nose is excluded. Both weights adhere directly to the floor.
The base extends down 9.5 mm; the curved nose continues into the extension.
The original outside width/depth, vertical rear wall, display angle and closure
are retained. No separate bottom cover is introduced.

## Diffuser retention

The diffuser is inserted from behind the faceplate. Its 6.4 mm flange cannot
pass through the 5.3 mm front hole. The strip holder blocks rearward movement.
Four short tabs retain the holder: insert it from behind, 3 mm above its final
position, then slide it down. A small top glue bead prevents it sliding back
up. A tiny perimeter adhesive dab can remove the flange's nominal axial play;
keep adhesive out of the optical path. Transparent PETG at 100% infill is the
starting print specification; diffusion and brightness have not been measured.

## Checked digitally

- Every printable part is a valid single solid and a watertight connected mesh.
- No nominal overlap of measured components with printed parts or other modules.
- Untrimmed solder, complete headers, assumed connector envelopes and ribbon
  clearance are included, rather than checking bare PCB rectangles alone.
- Sampled knob rotation and a 1 mm press, encoder insertion before ballast,
  weight loading, empty carrier loading and XIAO insertion.
- Diffuser insertion and capture, holder entry/slide, strip insertion and
  closure of the populated faceplate.
- An unobstructed face-normal view of the entire measured active display area.
- Continuous floor beneath both weights and unchanged source geometry outside
  explicitly allowed edits, with a 0.01 mm³ numerical boolean tolerance.
- Three Bambu Studio projects sliced with support settings included; all
  project meshes match the delivered STLs.

Detailed results: [geometry](output/validation/geometry.json),
[fit](output/validation/fit.json), [slicing](output/validation/slicing.json).

## Measurements that remain approximate

The encoder's 5.4 mm dimension is **confirmed along the flat face**, giving a
flat plane 1.308 mm from the shaft center. Hole positions are interpreted as
edge clearances; small inconsistencies do not affect fit because there are no
printed locating pins. The encoder's approximate 1.9 mm pin spacing is modeled
conservatively as a clear gap (2.54 mm pitch); no mating connector is fabricated.

Registration-tab width/depth, actual push travel and mating connector housings
were not supplied. Their allowances are explicit above. Flexible leads and the
XIAO antenna are routed during assembly; they are not fully modeled harnesses.
Actual display controller/resolution and pixel color order need bench verification.
No physical print, assembly, USB-plug housing fit or optical test is claimed.
