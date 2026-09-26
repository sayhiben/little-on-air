"""Package the open-channel revision without altering the preserved releases."""
from pathlib import Path
import csv,hashlib,io,json,re
BASE=Path(__file__).resolve().parents[1];ROOT=BASE.parents[1];WORK=BASE/'output/v215'
OLD=ROOT/'release/little-on-air-enclosure-v2.14';OUT=ROOT/'release/little-on-air-enclosure-v2.15';provenance={}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def put(rel,data,source=None):
 p=OUT/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data.encode('utf-8') if isinstance(data,str) else data)
 provenance[rel]={'source':str(source.relative_to(ROOT)).replace('\\','/'),'source_sha256':sha(source),'exact_copy':p.read_bytes()==source.read_bytes()} if source else {'source':'v2.15 open-channel revision documentation/generated data','exact_copy':False}
def cp(src,rel):put(rel,src.read_bytes(),src)
def rows(rel,values):
 s=io.StringIO(newline='');csv.writer(s).writerows(values);put(rel,s.getvalue())
def duration(seconds):
 mins=round(seconds/60);return f'{mins//60} h {mins%60:02d} min'
def main():
 native=json.loads((WORK/'native-build.json').read_text());printing=json.loads((WORK/'printing-validation.json').read_text())
 assert native['passed'] and printing['passed']
 assert all(q['watertight'] and q['connected_solids']==1 for q in json.loads((WORK/'mesh-validation.json').read_text()))
 exclude={'MANIFEST.json','SHA256SUMS.txt','validation/release-audit.json','reference/roof-toolpaths.svg','reference/previews/roof-toolpaths.png'}
 for p in OLD.rglob('*'):
  if not p.is_file():continue
  rel=p.relative_to(OLD).as_posix()
  if rel in exclude or rel.startswith(('cad/','bambu-studio/')):continue
  cp(p,rel)
 cp(WORK/'stl/01-front-optical-bezel.stl','stl/01-front-optical-bezel.stl')
 for name in ('little-on-air-v215.f3d','little-on-air-v215-assembly.step'):cp(WORK/name,'cad/'+name)
 for kind in ('all-plates','front-only'):
  name=f'on-air-v215-X1C-{kind}.3mf';cp(WORK/'bambu-studio'/kind/name,'bambu-studio/'+name)
 for name in ('native-build.json','mesh-validation.json'):cp(WORK/name,'validation/cad-v215/'+name)
 cp(WORK/'printing-validation.json','validation/printing.json')
 cp(WORK/'front-wiring.svg','reference/front-wiring.svg');cp(WORK/'front-wiring.png','reference/previews/front-wiring.png')
 for p in (WORK/'views').glob('*.png'):cp(p,'reference/views/v215-'+p.name)
 cp(BASE/'v215/FRONT-WIRING.md','guides/FRONT-WIRING.md')
 totalgrams=sum(sum(q['total_used_g'] for q in p['filaments']) for p in printing['slicing'])
 plate1=printing['slicing'][0];one=printing['front_only']
 total=f"{duration(printing['total_estimated_seconds'])} / {totalgrams:.2f} g"
 single=f"{duration(one['seconds'])} / {one['grams']:.2f} g"
 readme=(OLD/'README.md').read_text(encoding='utf-8').replace('v2.14','v2.15').replace('v214','v215')
 readme=readme.replace('covered wire passages','open-backed wire channels').replace('Keep the frame’s 45° bridge-angle override.','The wire-channel roofs have been removed after the physical bridging failure; lay wires in from the rear and secure them with small hot-glue anchors.')
 readme=readme.replace('6 h 49 min / 78.61 g',total)
 put('README.md',readme)
 build=(OLD/'guides/BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8').replace('enclosure v2.14','enclosure v2.15')
 build=build.replace('Feed loose LED leads through the widened frame passages before soldering both ends,','Lay LED leads into the open-backed frame channels,')
 put('guides/BUILD-AND-ASSEMBLY.md',build)
 wiring=(OLD/'guides/WIRING.md').read_text(encoding='utf-8').replace('enclosure v2.14','enclosure v2.15').replace('The v2.14 frame','The v2.15 frame')
 put('guides/WIRING.md',wiring)
 printing_doc=(OLD/'guides/PRINTING.md').read_text(encoding='utf-8').replace('v214','v215')
 printing_doc=printing_doc.replace('This release replaces frame 01 with its wider wiring revision. The rear housing moves 9 mm on plate 1 to maintain spacing; every other mesh, painting and print setting is preserved.','This release opens the backs of frame 01’s wire channels. The v2.14 plate positions and every other part’s mesh, painting and print settings are preserved.')
 printing_doc=printing_doc.replace('5 h 20 min / 67.90 g',f"{duration(plate1['seconds'])} / {sum(q['total_used_g'] for q in plate1['filaments']):.2f} g").replace('6 h 49 min / 78.61 g',total)
 printing_doc=printing_doc.split('## Replacement frame only')[0]
 printing_doc+=f'## Replacement frame only\n\nUse [on-air-v215-X1C-front-only.3mf](../bambu-studio/on-air-v215-X1C-front-only.3mf) for an existing build: approximately **{single}**, black PLA+ only. No support. The channel roofs and their bridge requirement are removed; the frame’s bridge angle returns to automatic (0). The actual slice has no bridge extrusion at the former roof layer. Existing small hardware features remain. Read [the open-channel assembly guide](FRONT-WIRING.md). Filament slots 2/3 are unused in this one-object file.\n'
 put('guides/PRINTING.md',printing_doc)
 parts=list(csv.reader((OLD/'PARTS.csv').open(encoding='utf-8',newline='')))
 for r in parts[1:]:
  if r[0]=='01':r[1]='Front frame with open-backed LED wire channels';r[5]='v2.15 front-only roof removal'
 rows('PARTS.csv',parts)
 bom=list(csv.reader((OLD/'BOM.csv').open(encoding='utf-8',newline='')))
 for r in bom[1:]:
  if r[0]=='P01':r[2]='Front frame with open-backed LED wire channels'
  if r[0]=='W_LED':r[4]='Lay in open front channels; keep solder joints/splices in open bays; glue anchors retain insulation'
  if r[0]=='A_LED':r[4]='LED modules on original floors and recessed wire bundles in channels'
 rows('BOM.csv',bom)
 coords=json.loads((OLD/'reference/routing-coordinates.json').read_text());coords['v215_note']='Front H2-H4 now lay into open-backed channels. Wires must be recessed and retained with small glue anchors. Rear routes unchanged.'
 put('reference/routing-coordinates.json',json.dumps(coords,indent=2))
 lengths=(OLD/'reference/harness-length-guide.csv').read_text(encoding='utf-8').replace('v2.14 covered perimeter','v2.15 open-backed perimeter')
 put('reference/harness-length-guide.csv',lengths)
 checks=list(csv.reader((OLD/'guides/COMMISSIONING.csv').open(encoding='utf-8',newline='')))
 for r in checks[1:]:
  if r[0]=='v2.14 front wiring':r[0]='v2.15 front wiring';r[1]='Wire OD <=1.8 mm; lay wires in open channels; glue anchors retain recessed bundle; emitters/pads clear'
  if r[0]=='v2.14 roof printing':r[0]='v2.15 open-channel print';r[1]='Open channel backs; no wire-roof bridging or internal supports; inspect walls and screw seats after printing'
 rows('guides/COMMISSIONING.csv',checks)
 put('RELEASE-NOTES.md','# Enclosure v2.15\n\nThe v2.14 wire-channel roofs did not bridge reliably in the user’s physical print. This revision removes those roofs and the ceilings above their LED/side access openings, changing only frame 01. The widened 129 × 69 mm footprint, 1.8 mm floor, outer walls, optical floors and fitted screw/control/guide areas remain.\n\nChannels open toward the rear. The narrower rear housing does not cover them completely; use small hot-glue anchors to keep insulated wires recessed. See [FRONT-WIRING.md](guides/FRONT-WIRING.md). No other part needs reprinting or laser cutting.\n\nThe supplied front-only and all-plate Bambu projects are re-sliced. No support or wire-roof bridge is generated for the frame; the special 45° bridge override is removed. All other meshes, painting, materials and plate positions are preserved. Native checks and mesh/slicer audits pass; this new revision still needs a physical print/assembly check.\n\nPrevious CAD/slicer passes did not establish real bridge performance. Historical validation records are preserved for unchanged interfaces, not as evidence that the v2.14 roofs printed successfully. Firmware and electrical wiring are unchanged.\n')
 put('validation/README.md','# Validation scope\n\n`cad-v215/` proves roof-only solid removal, preserved lower geometry and critical interfaces, unchanged native component geometry fingerprints, and one connected watertight frame mesh. `printing.json` checks both projects, no former wire-roof bridge paths, no frame support, and unchanged other meshes/painting/optical fill. `release-audit.json` verifies the delivered package.\n\nEarlier `cad-v214/`, `cad-v213/` and `unchanged-v28/` records are historical. The v2.14 roof passed slicing but failed the user’s physical bridge print; that limitation is why the roofs were removed. Previous collision checks remain applicable under verified solid removal and unchanged other parts. Physical wall stiffness, wire retention and actual assembly remain to be checked.\n')
 manifest=json.loads((OLD/'MANIFEST.json').read_text());manifest.pop('files',None);manifest.pop('validated',None)
 manifest.update({'enclosure_version':'2.15','packaged_date':'2026-09-18','bambu_projects':2,'changed_production_parts':['01'],'provenance':provenance})
 (OUT/'MANIFEST.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
 print(json.dumps({'release':str(OUT),'front_only':single,'all_plates':total},indent=2))
if __name__=='__main__':main()
