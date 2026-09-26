"""Curate one internally checked fabrication release; preserve earlier releases."""
from pathlib import Path
import json,zipfile,shutil,hashlib,xml.etree.ElementTree as E,importlib.util,csv
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v21';DEST=BASE/'output/on-air-v21-fabrication'

def read(path):return json.loads(path.read_text())
def main():
 native=read(OUT/'native-validation.json');mesh=read(OUT/'mesh-validation.json');optics=read(OUT/'optical-registration-validation.json')
 harness=read(OUT/'harness-validation.json');packing=read(OUT/'wire-packing-validation.json');bambu=read(OUT/'bambu-studio/all-projects-validation.json')
 assert not native['feature_issues'] and not native['interferences'] and native['all_occurrences_at_assembly_origin']
 assert len(native['motion_checks'])==13 and all(c['passed'] for c in native['motion_checks'])
 assert len(mesh)==17 and all(c['watertight'] and c['connected_solids']==1 for c in mesh)
 assert all(c['passed'] for c in optics.values()) and harness['passed'] and packing['passed']
 assert len(bambu)==9 and all(p['slicer']['return_code']==0 and all(not t['warning_message'] for t in p['slicer']['sliced_plates']) for p in bambu)
 # Recheck meshes after the native Bambu save and final native STL export.
 spec=importlib.util.spec_from_file_location('audit',str(Path(__file__).with_name('audit_bambu_v2.py')));audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
 for report in bambu:
  file=OUT/'bambu-studio'/('sliced-'+Path(report['project']).stem)/report['project'];audit.audit_project(file,report['object_count'])
  with zipfile.ZipFile(file) as z:
   for name in z.namelist():
    if name.endswith('.model'):
     root=E.fromstring(z.read(name))
     for tri in root.iter('{http://schemas.microsoft.com/3dmanufacturing/core/2015/02}triangle'):
      assert all(k in tri.attrib for k in ('v1','v2','v3')), (file,name)
 lbrn=E.parse(OUT/'laser/02-acrylic-REVIEW-ONLY.lbrn2').getroot();layers=lbrn.findall('CutSetting')
 assert [s.get('type') for s in layers]==['Scan','Cut']
 assert all(s.find(k).get('Value')=='0' for s in layers for k in ('minPower','maxPower','minPower2','maxPower2','doOutput'))
 pairs=[]
 for directory,pattern in [('stl','*.stl'),('optional-laminate','*.stl'),('fit-samples','*.stl'),('laser','*.svg'),('laser','*.lbrn2'),('views','*.png')]:
  pairs += [(p,Path(directory)/p.name) for p in (OUT/directory).glob(pattern)]
 assert len(list((OUT/'stl').glob('*.stl')))==7 and len(list((OUT/'fit-samples').glob('*.stl')))==8
 for name in ['little-on-air-v21.f3d','little-on-air-v21-assembly.step','v21-production-fit-sections.f3d']:pairs.append((OUT/name,Path('cad')/name))
 for report in bambu:
  name=report['project'];pairs.append((OUT/'bambu-studio'/('sliced-'+Path(name).stem)/name,Path('bambu-studio')/name))
 for name in ['native-validation.json','mesh-validation.json','optical-registration-validation.json','harness-validation.json','wire-packing-validation.json']:
  pairs.append((OUT/name,Path('validation')/name))
 for name in ['artwork-validation.json','svg-inventory.json','shared-front-master.json']:pairs.append((OUT/'laser'/name,Path('validation')/name))
 pairs.append((OUT/'bambu-studio/all-projects-validation.json',Path('validation/bambu-projects.json')))
 for name in ['BOM.csv','COMMISSIONING.csv','wire-cut-list.csv','routing-map.svg','routing-map.png']:pairs.append((OUT/name,Path(name)))
 for src,rel in pairs:
  assert src.is_file(),src;dst=DEST/rel;dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(src,dst)
 shutil.copyfile(Path(__file__).with_name('SIMPLIFIED-BATTERY-WIRING.md'),DEST/'SIMPLIFIED-BATTERY-WIRING.md')
 with (OUT/'BOM.csv').open(encoding='utf-8-sig',newline='') as f:
  reader=csv.DictReader(f);fields=reader.fieldnames;simple=[]
  for row in reader:
   if row['Ref'] in ('U2','U3','Q1','C2','R2','R3','R4','PCB2'):continue
   if row['Ref']=='SW1':row.update(Item='WMYCONGCONG DPDT B07F7PNDGM',Specification='Listing: 100 mA at 12 V DC; not qualified for direct pixel/capacitor load',Status='Owned; use as control or choose suitably rated replacement')
   if row['Ref']=='C1':row.update(Location='Insulated harness; secured in unused right auxiliary space',Status='Selected addition; actual body fit check')
   if row['Ref']=='J1':row.update(Quantity='As needed',Item='User pigtail disconnects',Specification='Verify pinout; actual mated bodies and wire bends must dry-fit',Status='User supplied')
   if row['Ref']=='W1':row.update(Specification='Insulated OD <=0.9; shorten for simplified wiring; dry-fit before final cuts')
  simple.append(row)
  simple.append({'Ref':'POWER-SWITCH-CHOICE','Quantity':'TBD','Item':'Rated replacement switch OR electronic power-switch stage','Specification':'Resolve 100 mA switch limit and startup load; preserve USB/data isolation','Location':'Existing switch nest or unused auxiliary space; actual replacement fit to check','Status':'Unresolved; direct-load wiring not approved with identified switch'})
 with (DEST/'BOM-SIMPLIFIED.csv').open('w',encoding='utf-8-sig',newline='') as f:
  writer=csv.DictWriter(f,fieldnames=fields);writer.writeheader();writer.writerows(simple)
 guide=(OUT/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8')
 guide=guide.replace('# ON AIR v2.1 — manufacturing and wiring','# ON AIR v2.1 — manufacturing and wiring\n\n**Selected electrical build:** read the switch-rating update in [Simplified battery wiring](SIMPLIFIED-BATTERY-WIRING.md) and [its provisional BOM](BOM-SIMPLIFIED.csv). The identified switch is listed at 100 mA; direct-load wiring requires a suitably rated replacement or a revised electronic switching stage. The printed geometry and optical assembly remain unchanged. The regulated 5 V circuit below is retained as an alternative.',1)
 guide+='\n## Assembly illustrations\n\nCAD geometry views do not predict lighting brightness or printed finish.\n\n![Front assembly](views/front.png)\n\n![Rear housing, retained electronics and auxiliary parts](views/retained-electronics.png)\n\n![Exploded assembly](views/exploded.png)\n\n![Harness routes](routing-map.png)\n'
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text(guide,encoding='utf-8')
 def stats(plates):
  sec=sum(p['total_predication'] for p in plates);g=sum(f['total_used_g'] for p in plates for f in p['filaments']);return f'{int(sec//3600)} h {round(sec%3600/60):02d} min / {g:.1f} g'
 tables=['| Project | Slicer estimate |','|---|---|']+[f'| {r["project"].removeprefix("on-air-v21-X1C-").removesuffix(".3mf")} | {stats(r["slicer"]["sliced_plates"])} |' for r in bambu]
 lines=['# ON AIR v2.1 — validation record','','This is a digitally checked fabrication prototype. The commissioning form records the physical tests still required.','','| Check | Result |','|---|---|',f'| Native Fusion | {len(native["components"])} components; no feature warnings/errors or positive-volume assembly interference |',f'| Insertion, closure and controls | 13 paths, {sum(x["samples"] for x in native["motion_checks"])} sampled positions; no overlap above 0.001 mm³ |','| FDM meshes | 7 main solids, 2 optional laminate rings, 8 fit sections; closed, connected, consistently wound, positive volume and Z=0 |',f'| Reserved harness | {len(harness["items"])} routes, bays and individual LED exit checks passed against the native obstacles |','| Simultaneous wires | All 55 route pairs checked with compact insulation radii and 0.2 allowance; shared XIAO trunk and termination spaces documented |',f'| Optical registration | Exported letter outlines agree with the laser master within {optics["letters"]["actual_STL_to_shared_laser_master_error_mm"]:.8f} mm; this is file agreement, not manufacturing accuracy |','| Bambu Studio 2.8.2.61 | 9 projects / 21 plates sliced without warnings; source and saved project meshes match final STL geometry |','| Graphic color | Black ends at 1.6 mm; white starts at 1.7 mm layer top; all 24 extrusion layers checked; one manual pause or AMS change |','| LightBurn 2.0.03 | Acrylic imported at 104 × 38 mm; mirrored text and key; blue Fill before red Line; review project power zero and both outputs off |','','## What changed from v2','','Fixed holders remain integral to the rear housing. Fastener pockets, moving controls and keeper gaps have more clearance. LED pigtails have side exits, the XIAO has open solder access, and the housing includes two auxiliary electrical landings and two strap anchors. Rounded harness reservations include depth-separated crossings and space above the battery for a detachable connector.','','The first v2.1 Bambu export had an invalid triangle-field name. Bambu slicing caught it; the corrected schema and all nine rebuilt projects passed. No defective project is included here.','','## Print estimates','']+tables+['','Estimates include the configured brims and, where applicable, color purge. Manual intervention and material calibration are additional. PLA+ uses a clearly labeled Generic PLA starting profile.','','## Limits of this validation','','Insertion paths are sampled, usually at 0.25 mm. They check the nominal solids, not arbitrary assembly angles. Optional laminate rings passed mesh checks; the full assembly study uses the printed graphic. Reference electronics and harness envelopes are excluded from printable exports.','','Wire envelopes clear the modeled parts and auxiliary components. Close route pairs are permitted only in termination spaces with a 2 mm dressing margin, or the shared four-wire XIAO trunk. Actual pad locations, solder fillets, plug shells and wire packing still need a dry assembly. Wires are not physically simulated.','','The actual acrylic sheet thickness, LED cut outline/emitter position, charger revision/populated height, XIAO reset location, cell specification and switch rating are unconfirmed dimensions/specifications. Use fit samples and the commissioning record. FDM distortion, screw strength, adhesive retention, battery protection, charging behavior, RF cut/engrave settings and illuminated appearance have not been physically tested.','','The existing receiver firmware drives its onboard RGB LED. A four-pixel NeoPixel output remains necessary before the sign can operate. No firmware was changed or flashed, and no print or laser job was sent.','']
 (DEST/'VALIDATION.md').write_text('\n'.join(lines),encoding='utf-8')
 with (DEST/'VALIDATION.md').open('a',encoding='utf-8') as f:f.write('\n## Selected simplified wiring\n\nThe later direct-battery wiring choice is documented in `SIMPLIFIED-BATTERY-WIRING.md`. Printed parts and slicing are unchanged. The harness results above apply to the modeled original 5 V circuit; the simplified wiring and actual pigtail bodies have not received a new native routing study or physical fit test.\n')
 start='''# ON AIR v2.1 — start here

120 × 60 × 34 mm enclosure, with fixed electronics holders integrated into the flat rear housing. Use this entire revision together; previous plate layouts are superseded.

1. Read [Build and assembly](BUILD-AND-ASSEMBLY.md) and [BOM](BOM.csv). The NeoPixel circuit adds a 5 V boost board, logic buffer, MOSFET and passives; their space is reserved in this housing.
2. Open [PETG fit checks](bambu-studio/on-air-v21-X1C-PETG-fit-checks.3mf) first, or the PLA / PLA-plus-starting equivalent. Use the real LEDs, boards, switch, fasteners and measured acrylic scrap to qualify fit.
3. Open [PETG AMS main project](bambu-studio/on-air-v21-X1C-PETG-AMS.3mf), or the matching manual-swap / material alternative. All projects target the X1 Carbon with a 0.4 mm nozzle. Plate 1: bezel and rear housing. Plate 2: optical retainer, retaining yoke, reset and slider. Plate 3: black-and-white graphic. Keep 100% scale and the supplied orientations.
4. Use [rear-engraved acrylic SVG](laser/02-acrylic-REAR-engrave-and-cut.svg) in LightBurn, exactly 104 × 38 mm. It is already mirrored. Engrave blue Fill first; cut red Line last. Qualify the supplied kerf and engraving samples on your Nova Plus 24 / 60 W RF machine. The optional native LightBurn file is review-only, with outputs off and powers zero.
5. Assemble using the [routing map](routing-map.png), [wire cut list](wire-cut-list.csv) and exact connection table in the guide. Complete [the commissioning record](COMMISSIONING.csv) before wall mounting.

Separate meshes are in `stl/`; editable Fusion and STEP are in `cad/`. The two rings in `optional-laminate/` belong only to the optional laser laminate backing. The eight `fit-samples/` are clipped production sections, not extra assembly parts. Their Bambu plate also includes the complete yoke and both controls.

[Validation record](VALIDATION.md): all 17 meshes passed topology checks, 13 assembly/control paths passed, and all 9 Bambu projects sliced without warnings. These are digital results. Physical fit, wiring, thermal behavior and RF material settings still require the supplied tests. Existing receiver firmware is onboard-LED-only; external NeoPixel firmware is a remaining operational step.

![Assembly](views/assembled.png)
'''
 (DEST/'START-HERE.md').write_text(start,encoding='utf-8')
 start=start.replace('1. Read [Build and assembly](BUILD-AND-ASSEMBLY.md) and [BOM](BOM.csv). The NeoPixel circuit adds a 5 V boost board, logic buffer, MOSFET and passives; their space is reserved in this housing.','1. Read [Build and assembly](BUILD-AND-ASSEMBLY.md), [the selected simplified wiring](SIMPLIFIED-BATTERY-WIRING.md) and [its BOM](BOM-SIMPLIFIED.csv). This build uses battery-powered pixels, an inline data resistor, a bulk capacitor and your pigtail disconnects. The original regulated 5 V circuit is retained as an alternative.')
 start=start.replace('5. Assemble using the [routing map](routing-map.png), [wire cut list](wire-cut-list.csv) and exact connection table in the guide. Complete [the commissioning record](COMMISSIONING.csv) before wall mounting.','5. Assemble using the exact connection table and electrical checks in [Simplified battery wiring](SIMPLIFIED-BATTERY-WIRING.md). The old [routing map](routing-map.png) shows available corridors, but its endpoints and cut list describe the alternative 5 V circuit. Use the mechanical checks in [the commissioning record](COMMISSIONING.csv) and the simplified note’s electrical checks before wall mounting.')
 (DEST/'START-HERE.md').write_text(start,encoding='utf-8')
 start=start.replace('# ON AIR v2.1 — start here','# ON AIR v2.1 — start here\n\n**Electrical update:** the identified DPDT is listed at 100 mA. Read the [switch-rating finding](SIMPLIFIED-BATTERY-WIRING.md) before wiring; the simplified direct-load circuit needs a suitably rated replacement switch or an electronic switching stage. The fabrication geometry is unchanged.',1)
 (DEST/'START-HERE.md').write_text(start,encoding='utf-8')
 manifest=[{'file':p.relative_to(DEST).as_posix(),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in sorted(DEST.rglob('*')) if p.is_file() and p.name!='manifest.json']
 (DEST/'manifest.json').write_text(json.dumps({'revision':'v2.1','main_stls':7,'optional_stls':2,'fit_section_stls':8,'laser_svgs':5,'bambu_projects':9,'files':manifest},indent=2))
 target=BASE/'output/on-air-v21-fabrication.zip'
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for p in sorted(DEST.rglob('*')):
   if p.is_file():z.write(p,p.relative_to(DEST))
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for item in manifest:assert hashlib.sha256(z.read(item['file'])).hexdigest()==item['sha256']
 print(json.dumps({'folder':str(DEST),'zip':str(target),'zip_bytes':target.stat().st_size,'files':len(manifest)+1,'main_PETG_estimate':stats(bambu[0]['slicer']['sliced_plates'])},indent=2))
if __name__=='__main__':main()
