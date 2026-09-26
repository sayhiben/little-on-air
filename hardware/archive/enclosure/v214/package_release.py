"""Create v2.14 alongside the preserved v2.13 release, changing only part 01."""
from pathlib import Path
import csv,hashlib,io,json
BASE=Path(__file__).resolve().parents[1];ROOT=BASE.parents[1];WORK=BASE/'output/v214'
OLD=ROOT/'release/little-on-air-enclosure-v2.13';OUT=ROOT/'release/little-on-air-enclosure-v2.14'
provenance={}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def put(rel,data,source=None):
 p=OUT/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data.encode('utf-8') if isinstance(data,str) else data)
 provenance[rel]={'source':str(source.relative_to(ROOT)).replace('\\','/'),'source_sha256':sha(source),'exact_copy':p.read_bytes()==source.read_bytes()} if source else {'source':'v2.14 release documentation/generated data','exact_copy':False}
def cp(src,rel):put(rel,src.read_bytes(),src)
def rows(rel,values):
 s=io.StringIO(newline='');csv.writer(s).writerows(values);put(rel,s.getvalue())
def main():
 for name in ('native-build.json','native-validation.json','final-native-check.json','printing-validation.json','bridge-validation.json'):
  assert json.loads((WORK/name).read_text())['passed'],name
 assert all(q['watertight'] and q['connected_solids']==1 for q in json.loads((WORK/'mesh-validation.json').read_text()))
 for p in OLD.rglob('*'):
  if not p.is_file():continue
  rel=p.relative_to(OLD).as_posix()
  if rel in ('MANIFEST.json','SHA256SUMS.txt','validation/release-audit.json','reference/routing-map.svg','reference/previews/routing-map.png'):continue
  if rel.startswith(('cad/','bambu-studio/')):continue
  cp(p,rel)
 cp(WORK/'stl/01-front-optical-bezel.stl','stl/01-front-optical-bezel.stl')
 for name in ('little-on-air-v214.f3d','little-on-air-v214-assembly.step'):cp(WORK/name,'cad/'+name)
 for kind in ('all-plates','front-only'):
  name=f'on-air-v214-X1C-{kind}.3mf';cp(WORK/'bambu-studio'/kind/name,'bambu-studio/'+name)
 for name in ('native-build.json','native-validation.json','final-native-check.json','mesh-validation.json','bridge-validation.json'):cp(WORK/name,'validation/cad-v214/'+name)
 cp(WORK/'printing-validation.json','validation/printing.json')
 for name in ('front-wiring','roof-toolpaths'):
  cp(WORK/(name+'.svg'),'reference/'+name+'.svg');cp(WORK/(name+'.png'),'reference/previews/'+name+'.png')
 for p in (WORK/'views').glob('*.png'):cp(p,'reference/views/v214-'+p.name)
 cp(BASE/'v214/FRONT-WIRING.md','guides/FRONT-WIRING.md')

 readme=(OLD/'README.md').read_text(encoding='utf-8').replace('v2.13','v2.14').replace('v213','v214')
 readme=readme.replace('**120 × 60 × 24 mm**','**129 × 69 mm front / 120 × 60 × 24 mm rear body**')
 readme=readme.replace('6 h 15 min / 71.30 g','6 h 49 min / 78.61 g').replace('One editable and sliced project containing all three plates','Complete three-plate project plus a replacement-frame-only project; both editable and sliced')
 readme=readme.replace('The project uses your three-plate layout with the spare keeper removed and the requested material profiles restored.','The project keeps your three-plate layout, with the rear housing shifted 9 mm to make room for the wider frame. There is one keeper, and all other meshes, painting and material profiles are preserved.')
 readme=readme.replace('## Start here','## Start here')
 readme=readme.replace('## Start', '**Upgrading an existing build:** print only [the replacement front frame](bambu-studio/on-air-v214-X1C-front-only.3mf), then follow [front wiring and hot-glue LED mounting](guides/FRONT-WIRING.md). All other printed and laser-cut parts remain unchanged. The front expands by 4.5 mm on each side and adds covered wire passages around the screw bosses. Keep the frame’s 45° bridge-angle override.\n\n## Start',1)
 # The baseline uses a different heading in some revisions; keep the upgrade
 # information present without relying on that heading's wording.
 if '**Upgrading an existing build:**' not in readme:
  head,rest=readme.split('\n',1);readme=head+'\n\n**Existing build:** use the [front-only project](bambu-studio/on-air-v214-X1C-front-only.3mf) and [front wiring guide](guides/FRONT-WIRING.md). All other parts are unchanged; keep the frame’s 45° bridge angle.\n'+rest
 put('README.md',readme)
 build=(OLD/'guides/BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8').replace('enclosure v2.13','enclosure v2.14')
 oldpara=next(p for p in build.split('\n\n') if p.startswith('Use flexible stranded wire sized'))
 build=build.replace(oldpara,'The front LED passages now accept flexible insulated wire up to **1.8 mm outside diameter**, subject to the actual printed fit. Follow the [front routing and mounting guide](FRONT-WIRING.md) and [frame section diagram](../reference/front-wiring.svg). Reuse the fitted rear harness: its unchanged limits remain up to 0.9 mm OD for individual leads and compact three-wire bundles, and up to 0.8 mm for constrained paired routes. The [rear coordinate record](../reference/routing-coordinates.json) and [length allowances](../reference/harness-length-guide.csv) preserve rear routing only; the old H2–H4 paths are superseded. Leave service slack and trim after fitting actual connectors.')
 build=build.replace('Route the three-wire chain through the frame\'s passages.','Feed loose LED leads through the widened frame passages before soldering both ends, following [FRONT-WIRING.md](FRONT-WIRING.md). Secure the modules with small hot-glue anchors, retaining the original floor height and keeping emitters/pads clear. The interfering side lips are removed. Check real wires and joints before installing the optical retainer.')
 put('guides/BUILD-AND-ASSEMBLY.md',build)
 wiring=(OLD/'guides/WIRING.md').read_text(encoding='utf-8').replace('enclosure v2.13','enclosure v2.14')
 wiring+='\n\nThe v2.14 frame uses the same circuit. Follow [FRONT-WIRING.md](FRONT-WIRING.md) for its wider inter-LED passages; use the actual module DIN/DOUT labels.\n'
 put('guides/WIRING.md',wiring)
 printing=(OLD/'guides/PRINTING.md').read_text(encoding='utf-8').replace('v213','v214')
 printing=printing.replace('This release retains your three-plate arrangement and painted insert, restores the requested filament profiles, and removes the spare guide keeper.','This release replaces frame 01 with its wider wiring revision. The rear housing moves 9 mm on plate 1 to maintain spacing; every other mesh, painting and print setting is preserved.')
 printing=printing.replace('4 h 46 min / 60.59 g','5 h 20 min / 67.90 g').replace('6 h 15 min / 71.30 g','6 h 49 min / 78.61 g')
 printing+='\n\n## Replacement frame only\n\nUse [on-air-v214-X1C-front-only.3mf](../bambu-studio/on-air-v214-X1C-front-only.3mf) for an existing build: approximately **2 h 03 min / 25.08 g**, black PLA+ only. No support. Keep its **45° bridge-angle override** when re-slicing; automatic direction creates unsuitable long roof spans. Inspect the [roof toolpaths](../reference/roof-toolpaths.svg) and [front assembly instructions](FRONT-WIRING.md). Filament slots 2/3 are unused in this one-object file.\n'
 put('guides/PRINTING.md',printing)

 parts=list(csv.reader((OLD/'PARTS.csv').open(encoding='utf-8',newline='')))
 for r in parts[1:]:
  if r[0]=='01':r[1]='Wider front frame with enclosed wire loop';r[5]='v2.14 front-only revision'
 rows('PARTS.csv',parts)
 bom=list(csv.reader((OLD/'BOM.csv').open(encoding='utf-8',newline='')))
 for r in bom[1:]:
  if r[0]=='P01':r[2]='Wider front frame with enclosed LED cable loop'
  if r[0]=='LED1-4':r[4]='Original front alignment floors; small hot-glue anchors; emitter inward'
  if r[0]=='W1':r[4]='Unchanged rear individual leads and compact bundles; exclude revised front H2-H4'
 bom.extend([['W_LED','Cut to fit','Flexible stranded 22 or 24 AWG LED interconnect wire','Actual insulation OD <=1.8 mm; prefer flexible 24 AWG for easier threading','Front perimeter loop; keep solder joints and splices in open bays','User owned; measure actual insulation'],['A_LED','Small quantity','Hot glue','Small corner/back anchors; no glue under optical datum or on emitter/pads','Four LED modules on original seating floors','User selected mounting method']])
 rows('BOM.csv',bom)
 coords=json.loads((OLD/'reference/routing-coordinates.json').read_text())
 coords['routes']=[r for r in coords['routes'] if not r[0].startswith(('H2 ','H3 ','H4 '))]
 coords['v214_note']='Rear and H1 service routes unchanged. Front H2-H4 are superseded by FRONT-WIRING.md and front-wiring.svg; no old deep-cavity front paths are specified here.'
 put('reference/routing-coordinates.json',json.dumps(coords,indent=2))
 lengths=list(csv.reader((OLD/'reference/harness-length-guide.csv').open(encoding='utf-8',newline='')))
 for r in lengths[1:]:
  if r[0].startswith(('H2 ','H3 ','H4 ')):
   r[1]='Measure after dry routing';r[2]='Cut generously; trim after fitting';r[3]='v2.14 covered perimeter; original deep-cavity route/length superseded. Each conductor may differ.'
 rows('reference/harness-length-guide.csv',lengths)
 checks=list(csv.reader((OLD/'guides/COMMISSIONING.csv').open(encoding='utf-8',newline='')))
 checks.insert(1,['v2.14 front wiring','Wire OD <=1.8 mm; thread test around all used bosses; no roof sag pinching wires; original optical floors; hot-glue anchors clear of emitters/pads','',''])
 checks.insert(2,['v2.14 roof printing','Part 01 bridge angle 45 degrees; no internal support; inspect actual roofs before feeding wire','',''])
 rows('guides/COMMISSIONING.csv',checks)
 put('RELEASE-NOTES.md','# Enclosure v2.14\n\nOnly front frame 01 changes: 4.5 mm wider per side, a covered 4.2 × 6.3 mm perimeter wire loop outside all four corner and both central optical-retainer bosses, inward access windows, and removed LED side lips above the original optical floors. The new rim preserves clearance for the original reset collar. All other CAD components, production STLs, acrylic SVGs and optional laminate parts are unchanged. No new fastener or electronic component is required.\n\nIncludes an updated three-plate Bambu project and a replacement-frame-only project. Part 01 has a required 45° bridge-angle override; rear housing 05 moves 9 mm in plate Y. Black/white PLA+ insert painting, clear PETG guide fills, one keeper, disabled first-layer inspection and all other part settings are retained.\n\nThe native comparisons, interference/motion checks, wire reservations, STL topology and actual sliced roof paths were reviewed. Use [FRONT-WIRING.md](guides/FRONT-WIRING.md) for assembly and the limits of those checks. Physical printing and assembly have not been performed for this revision.\n\nThe electrical circuit and included firmware v0.1.2 are unchanged. The capacitor/resistor soldering guide is included; external NeoPixel firmware remains pending. v2.13 is preserved separately.\n')
 put('validation/README.md','# Validation scope\n\n`cad-v214/` contains the current native component comparison, assembly and wire passage checks, reset collar correction/travel, final feature/USB checks, mesh topology and roof-span audit. `printing.json` validates both new Bambu projects and the unchanged insert colors/guide fill. `release-audit.json` verifies the delivered files and archive.\n\n`cad-v213/` and `unchanged-v28/` are preserved historical evidence for unchanged parts. Their old front H2-H4 harness paths are superseded; use the v2.14 wire-passage checks and front wiring guide. Historical JSON paths identify original workspace sources.\n\nThe current correction removes added material only, so completed wire and front-closure collision checks remain valid. Reset movement is separately rechecked after the correction. Actual wire insulation, solder, bridges, optical performance, charging and firmware commissioning remain physical tasks.\n')
 manifest=json.loads((OLD/'MANIFEST.json').read_text());manifest.pop('files',None);manifest.pop('validated',None)
 manifest.update({'enclosure_version':'2.14','packaged_date':'2026-09-18','bambu_projects':2,'changed_production_parts':['01'],'front_bounds_mm':[129,69,11],'rear_body_bounds_mm':[120,60,24],'provenance':provenance})
 (OUT/'MANIFEST.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
 print(OUT)
if __name__=='__main__':main()
