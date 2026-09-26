"""Curate v2.16, preserving all earlier releases and the firmware snapshot."""
from pathlib import Path
import csv,hashlib,io,json,re
BASE=Path(__file__).resolve().parents[1];ROOT=BASE.parents[1];WORK=BASE/'output/v216'
OLD=ROOT/'release/little-on-air-enclosure-v2.15';OUT=ROOT/'release/little-on-air-enclosure-v2.16';provenance={}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def put(rel,data,source=None):
 p=OUT/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data.encode('utf-8') if isinstance(data,str) else data)
 provenance[rel]={'source':source.relative_to(ROOT).as_posix(),'source_sha256':sha(source),'exact_copy':p.read_bytes()==source.read_bytes()} if source else {'source':'v2.16 rearward wiring documentation/generated data','exact_copy':False}
def cp(src,rel):put(rel,src.read_bytes(),src)
def rows(rel,values):
 s=io.StringIO(newline='');csv.writer(s).writerows(values);put(rel,s.getvalue())
def read(rel):return (OLD/rel).read_text(encoding='utf-8')
def replace(text,old,new):
 assert old in text,old
 return text.replace(old,new)
def main():
 for name in ('native-build','mechanical-validation','route-check','wire-separation','printing-validation'):
  assert json.loads((WORK/(name+'.json')).read_text())['passed'],name
 exclude={'MANIFEST.json','SHA256SUMS.txt','validation/release-audit.json','reference/routing-map.svg','reference/previews/routing-map.png','reference/routing-coordinates.json','reference/harness-length-guide.csv'}
 for p in OLD.rglob('*'):
  if not p.is_file():continue
  rel=p.relative_to(OLD).as_posix()
  if rel in exclude or rel.startswith(('cad/','bambu-studio/')):continue
  cp(p,rel)
 for name in ('05-rear-electronics-housing.stl','06-electronics-retaining-yoke.stl'):cp(WORK/'stl'/name,'stl/'+name)
 for name in ('little-on-air-v216.f3d','little-on-air-v216-assembly.step'):cp(WORK/name,'cad/'+name)
 for kind in ('all-plates','upgrade-parts'):
  name=f'on-air-v216-X1C-{kind}.3mf';cp(WORK/'bambu-studio'/kind/name,'bambu-studio/'+name)
 for name in ('native-build','mesh-validation','mechanical-validation','route-check','wire-separation','archive-roundtrip'):
  cp(WORK/(name+'.json'),'validation/cad-v216/'+name+'.json')
 cp(WORK/'printing-validation.json','validation/printing.json')
 for ext in ('svg','png'):cp(WORK/('front-wiring.'+ext),('reference/' if ext=='svg' else 'reference/previews/')+'front-wiring.'+ext)
 for p in (WORK/'views').glob('*.png'):cp(p,'reference/views/v216-'+p.name)
 cp(BASE/'v216/FRONT-WIRING.md','guides/FRONT-WIRING.md')
 readme=read('README.md').replace('v2.15','v2.16').replace('v215','v216')
 start=readme.index('**Upgrading an existing build:**');end=readme.index('## Start here')
 readme=readme[:start]+'''**Upgrading an existing build:** print [05 rear housing and 06 electronics yoke](bambu-studio/on-air-v216-X1C-upgrade-parts.3mf), then follow [the illustrated rearward wiring guide](guides/FRONT-WIRING.md). The existing v2.15 front frame, all other printed parts and the acrylic are unchanged. Open clearances in the housing and reinforced yoke let the LED leads turn rearward behind the optical mounts instead of around the outside corners. Lay the upper wires before clamping the yoke. No new parts or electrical components are needed.

'''+readme[end:]
 readme=replace(readme,'The mechanical files and wiring provisions are current; external-pixel firmware remains unfinished.','This hardware revision preserves that earlier snapshot; it does not publish or assess newer firmware work in the development repository.')
 readme=replace(readme,'The project keeps your three-plate layout, with the rear housing shifted 9 mm to make room for the wider frame. There is one keeper, and all other meshes, painting and material profiles are preserved.','The project keeps the approved three-plate positions from v2.15. Only the housing and yoke meshes change. There is one keeper; insert painting and the material profiles are preserved.')
 readme=readme.replace('6 h 36 min / 75.84 g','6 h 37 min / 75.81 g').replace('replacement-frame-only project','housing-and-yoke upgrade project').replace('Current committed firmware source snapshot','Preserved firmware v0.1.2 source snapshot')
 put('README.md',readme)
 build=read('guides/BUILD-AND-ASSEMBLY.md').replace('enclosure v2.15','enclosure v2.16')
 a=build.index('The front LED passages');b=build.index('### Connect the capacitor',a)
 build=build[:a]+'''The revised H1–H4 LED harness uses three separate flexible wires per run, each up to **1.8 mm insulation outside diameter**, laid rearward behind the optical screw heads and through the new open yoke grooves. Follow [FRONT-WIRING.md](FRONT-WIRING.md), its [diagram](../reference/front-wiring.svg), and the [nominal length guide](../reference/harness-length-guide.csv). Start overlong, dry-fit and trim; lane numbers describe tracks, not electrical pin numbers. Keep the fitted rear harness's compact leads (up to 0.9 mm OD, or 0.8 mm for constrained pairs) and dressed junctions clear of the new paths. Historical rear paths in [the coordinate record](../reference/routing-coordinates.json) are reference only and require dressing around this revision; old H1–H4 coordinates are superseded.

'''+build[b:]
 build=replace(build,'in the 12.5 × 5.7 × 5.6 space behind LED1','in the bottom interior at X70–82, Y5.2–8.4, depth 18–21.2 from the front face')
 build=replace(build,'The mated pigtail pair belongs in the left lower service bay, within 13 × 10 × 7.5 including its body.','The mated pigtail pair belongs in the left lower service bay, X4–17, Y14–24, depth 12–19.5, within 13 × 10 × 7.5 including its body.')
 build=replace(build,'lower-left → lower-right → upper-right → upper-left','lower-right → lower-left → upper-left → upper-right')
 build=replace(build,'Lay LED leads into the open-backed frame channels, following [FRONT-WIRING.md](FRONT-WIRING.md).','Shape LED leads rearward behind the optical mounts, following [FRONT-WIRING.md](FRONT-WIRING.md). The existing perimeter channels are optional; the checked routes now use the interior.')
 build=replace(build,'Install electronics yoke 06 with two M3×8 screws.','Lay H3 over the charger’s bare front face and H4 in the rear-open yoke grooves **before clamping the yoke**. Keep wires out of all board/switch contact seats. The relocated upper charger contact lands on bare board under the USB end; confirm it avoids solder and through-holes. Install electronics yoke 06 with two M3×8 screws.')
 put('guides/BUILD-AND-ASSEMBLY.md',build)
 wiring=read('guides/WIRING.md').replace('enclosure v2.15','enclosure v2.16')
 wiring=replace(wiring,'The v2.15 frame uses the same circuit. Follow [FRONT-WIRING.md](FRONT-WIRING.md) for its wider inter-LED passages; use the actual module DIN/DOUT labels.','The v2.16 housing/yoke revision uses the same circuit. Follow [FRONT-WIRING.md](FRONT-WIRING.md) for rearward LED routing. Viewed from the front, the planned chain is lower-right 1 → lower-left 2 → upper-left 3 → upper-right 4; confirm the actual DIN/DOUT labels.')
 put('guides/WIRING.md',wiring)
 cap=read('guides/CAPACITOR-AND-RESISTOR.md')
 cap=replace(cap,'LED1 is the lower-left module','LED1 is the lower-right module')
 cap=replace(cap,'Keep R1 close to DIN, in the reserved space behind that module.','Keep R1 near DIN in the bottom interior at X70–82, Y5.2–8.4, depth 18–21.2 from the front face. Follow the broad return bend shown in [the routing guide](FRONT-WIRING.md), keeping the remaining lead to DIN as short as this route allows.')
 cap=replace(cap,'or the remaining external-NeoPixel firmware work.','or validation of the external-NeoPixel firmware you use.')
 put('guides/CAPACITOR-AND-RESISTOR.md',cap)
 pr=read('guides/PRINTING.md').replace('v215','v216')
 pr=replace(pr,'This release opens the backs of frame 01’s wire channels. The v2.14 plate positions and every other part’s mesh, painting and print settings are preserved.','This release changes 05 rear housing and 06 electronics yoke for rearward LED wiring. The v2.15 plate positions, all other meshes, insert painting and material settings are preserved.')
 pr=pr.replace('5 h 07 min / 65.13 g','5 h 08 min / 65.11 g').replace('6 h 36 min / 75.84 g','6 h 37 min / 75.81 g')
 pr=replace(pr,'Other structural parts retain their intended unsupported bridges.','Parts 05 and 06 need no support; their new wire reliefs are open and have no added roof spans. Existing small hardware overhangs remain.')
 pr=replace(pr,'Bambu Studio 2.8.2.61','the installed Bambu Studio')
 pr=replace(pr,"Checks confirmed all 25 insert layers' colors, one keeper, correct materials and bed temperatures, support locations, and **332 long guide fill runs parallel to their axes**.","The unchanged insert mesh painting is preserved byte-for-byte and still slices with one color change. Checks confirmed one keeper, correct filament assignments, support locations, heater shutdown, and **332 long guide fill runs parallel to their axes**. The two new parts match their exported STLs and have no roof bridges across the new wire reliefs.")
 pr=pr.split('## Replacement frame only')[0]+'''## Existing-build upgrade: housing and yoke

Use [on-air-v216-X1C-upgrade-parts.3mf](../bambu-studio/on-air-v216-X1C-upgrade-parts.3mf): **05 rear housing + 06 electronics yoke**, approximately **3 h 06 min / 40.51 g**, black PLA+ only. Both are oriented on their original flat print planes and use no supports. Filament slots 2/3 are unused in this two-object file. Follow [the rearward wiring guide](FRONT-WIRING.md); reuse the existing frame, optics, reset and light guides. There is no need to re-cut the acrylic.
'''
 put('guides/PRINTING.md',pr)
 parts=list(csv.reader((OLD/'PARTS.csv').open(encoding='utf-8',newline='')))
 for r in parts[1:]:
  if r[0]=='05':r[1]='Rear housing with shallow LED-lead reliefs';r[5]='v2.16 rearward wiring'
  if r[0]=='06':r[1]='Reinforced electronics yoke with open wire grooves';r[5]='v2.16 rearward wiring; one charger contact relocated'
 rows('PARTS.csv',parts)
 bom=list(csv.reader((OLD/'BOM.csv').open(encoding='utf-8',newline='')))
 for r in bom[1:]:
  if r[0]=='P05':r[2]='Rear housing with shallow LED-lead reliefs'
  if r[0]=='P06':r[2]='Reinforced electronics yoke with open wire grooves'
  if r[0]=='R1':r[4]='H1 DATA -> R1 -> lower-right LED1 DIN; X70-82 Y5.2-8.4 depth18-21.2; see capacitor/resistor guide'
  if r[0]=='J1':r[4]='Left lower bay X4-17 Y14-24 depth12-19.5; accessible disconnect'
  if r[0]=='W1':r[4]='Existing compact rear leads; exclude revised H1-H4; keep clear of new LED routes'
  if r[0]=='W_LED':r[3]='Insulation OD <=1.8 mm; separate wires; prefer flexible 24 AWG';r[4]='Rearward H1-H4; open yoke grooves; lay before clamping; dry-fit actual pad exits'
  if r[0]=='A_LED':r[4]='LED modules on original floors; small insulation anchors in accessible areas away from seats'
 rows('BOM.csv',bom)
 oldcoords=json.loads(read('reference/routing-coordinates.json'))
 coords={'units':'mm','coordinates':'front-view XY; D positive rearward from front face (Fusion Z=-D)','revision':'2.16','wire_insulation_max_OD_mm':1.8,'clearance_envelope_diameter_mm':2.0,'bend_centerline_radius_mm':3,'pixel_order_front_view':['lower-right','lower-left','upper-left','upper-right'],'routes':json.loads((WORK/'candidate-routes.json').read_text()),'bays':json.loads((WORK/'mechanical-validation.json').read_text())['bays'],'historical_rear_routes':{'status':'Reference only, not revalidated against the new LED wires; dress compact rear leads and junctions clear of H1-H4. Old H1-H4 removed.','routes':[r for r in oldcoords['routes'] if not r[0].startswith(('H1','H2','H3','H4'))]},'limits':'Nominal LED pad-side exits only; excludes exact pad fanout, splices and solder blobs. Flexible-wire motion during closure is not simulated.'}
 put('reference/routing-coordinates.json',json.dumps(coords,indent=2))
 cp(WORK/'harness-length-guide.csv','reference/harness-length-guide.csv')
 put('reference/README.md','# Drawing and coordinate scope\n\nUse [front-wiring.svg](front-wiring.svg) and [routing-coordinates.json](routing-coordinates.json) for current v2.16 LED routes H1–H4. The nominal lengths are fitting references, not cut lengths. Lane numbers are not electrical pin numbers.\n\nThe historical rear coordinates are labeled separately inside the JSON; old H1–H4 coordinates are removed. Existing compact rear leads and junctions must be dressed around the current routes. Older assembly views show interfaces unchanged by v2.16; the `v216-` views show the revised parts.\n')
 checks=list(csv.reader((OLD/'guides/COMMISSIONING.csv').open(encoding='utf-8',newline='')))
 for r in checks[1:]:
  if r[0]=='v2.15 front wiring':r[0]='v2.16 LED wiring';r[1]='Separate insulation OD <=1.8; 3 mm nominal bends; routes loaded before yoke clamping; no pinched leads or strain at actual pads'
  if r[0]=='v2.15 open-channel print':r[0]='v2.16 replacement print';r[1]='New 05 and 06; grooves open and clean; frame and all other parts reused; inspect groove floor and contact gusset'
  if r[0]=='Charger support':r[1]='Both lower corners meet full-width stop; OUT solder clear; moved upper front pad contacts bare PCB under USB end'
  if r[0]=='Firmware':r[1]='Validate the installed external-pixel firmware and order; bundled older v0.1.2 snapshot is onboard-RGB only'
 rows('guides/COMMISSIONING.csv',checks)
 status=read('guides/FIRMWARE-STATUS.md')
 status=replace(status,'Enclosure revision **2.13**','Enclosure revision **2.16**')
 status=replace(status,'The current committed firmware source is included under `firmware/`; its exact commit is recorded in the release manifest.','The earlier v0.1.2 firmware snapshot is preserved under `firmware/`; its exact commit is recorded in the release manifest. It is not a statement of the current development repository’s firmware capabilities.')
 status=replace(status,'The existing firmware uses','The bundled snapshot uses').replace('the receiver still needs an external addressable-pixel driver','use and validate an external addressable-pixel driver')
 put('guides/FIRMWARE-STATUS.md',status)
 fw=read('firmware/README.md').replace('The source ZIP includes','This is the preserved older snapshot, not a newly selected firmware release. The source ZIP includes').replace('the four external NeoPixels are not implemented','this snapshot does not implement the four external NeoPixels')
 put('firmware/README.md',fw)
 put('RELEASE-NOTES.md','''# Enclosure v2.16

LED wiring now turns back into the electronics cavity with modeled 3 mm bend radii, behind the optical screw heads and through open mount reliefs. The v2.15 perimeter channels made the pad exits awkward. Clearing the installed upper electronics requires changes to **05 rear housing and 06 electronics yoke**, so those are the only replacement parts. The current front and every other printed/laser-cut part remain byte-identical.

The rear housing loses only 40.22 mm³ at shallow lead clearances beside POWER supports and ahead of MODE's terminal guard. Switch-body seats remain. The yoke gains reinforced rails, an open groove with a 1.95 mm floor, and one relocated charger contact beneath the USB end. That contact keeps its area, height and 0.15 mm nominal board-face clearance; a 45° gusset supports its underside for FDM. All other contact pads, board positions, reset/USB/guide interfaces and the nine M3×8 joints remain.

The planned chain is lower-right → lower-left → upper-left → upper-right, viewed from the front. Verify actual DIN/DOUT labels. H1–H4 use separate flexible wires up to 1.8 mm insulation OD; 2 mm clearance envelopes and 3 mm bends were checked. The service connector sits farther left, and the inline resistor has a bottom-interior bay near the lower-right first pixel. C1 stays in its existing right bay. No electrical components are added.

Twelve modeled runs clear all installed rigid solids and each other (66 pairs). Static and sampled yoke-insertion/front-closure checks pass. Both meshes are watertight single solids; both Bambu projects are re-sliced and audited. Upgrade printing takes about 3 h 06 min / 40.51 g black PLA+, without supports. The full project retains the approved three plates, one keeper, black/white PLA+ insert painting and clear PETG guide orientation/fill. First-layer inspection remains disabled for the prior timeout workaround.

Read [the illustrated installation guide](guides/FRONT-WIRING.md) before soldering and clamping the yoke. Actual LED pad fanout, solder blobs, insulation stiffness and printed fit still need physical checking; this revision has not been printed. Historical compact rear harness paths are reference only and must be dressed clear of the new LED routes. Electrical connections and the earlier bundled firmware snapshot are unchanged. No printer or laser job was sent.
''')
 put('validation/README.md','''# Validation scope

Current evidence is in `cad-v216/` and `printing.json`:

- Native build: only 05/06 changed; critical retained interfaces checked against v2.15. One charger contact is intentionally relocated. The final support gusset and residual-lip cleanup are included.
- Wire paths: twelve 2 mm diameter envelopes with 3 mm centerline bends checked against all installed rigid solids; 66 wire-pair separation checks. Optional laminate solids and old harness references are excluded. Exact copper pads, solder fillets, terminations and compact rear wiring are not included in this new wire-to-wire check.
- Mechanical validation: static checks and 31 sampled positions each for yoke insertion and front closure; reserved connector, resistor and slack bays. Flexible-wire motion is not simulated.
- Mesh validation: single connected watertight solids, positive volume and original print planes. Meshes were exported from a fresh import of the final native archive to avoid Fusion's stale tessellation cache after in-place edits.
- Printing: both editable/sliced projects match STLs; approved three-plate positions, materials and unchanged painting retained; no supports on 05/06 or bridges across new reliefs. Guide fill remains parallel to guide axes. Inspection remains disabled, bed leveling and heater shutdown retained.
- Release audit: file integrity, exact unchanged fabrication files, project meshes, optical contour registration and local guide links.

Earlier `cad-v215/`, `cad-v214/`, `cad-v213/` and `unchanged-v28/` files are historical evidence for unchanged interfaces, not validation of the current wiring or a successful physical print. The v2.14 tunnel roof passed slicing but failed physical bridging; no such roofs are reintroduced. No structural FEA, actual print fit or brightness/thermal qualification is claimed. Follow the physical commissioning checklist.
''')
 manifest=json.loads(read('MANIFEST.json'));manifest.pop('files',None);manifest.pop('validated',None)
 manifest.update({'enclosure_version':'2.16','packaged_date':'2026-09-24','bambu_projects':2,'changed_production_parts':['05','06'],'provenance':provenance})
 (OUT/'MANIFEST.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
 print(json.dumps({'release':str(OUT),'changed_parts':['05','06']},indent=2))
if __name__=='__main__':main()
