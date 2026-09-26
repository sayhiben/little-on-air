"""Publish a separate internally consistent, checked two-switch fabrication package."""
from pathlib import Path
import json,zipfile,shutil,hashlib,xml.etree.ElementTree as E,importlib.util
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v22';DEST=BASE/'output/on-air-v22-fabrication'
def read(path):return json.loads(path.read_text())
def stats(plates):
 sec=sum(p['total_predication'] for p in plates);g=sum(f['total_used_g'] for p in plates for f in p['filaments']);return f'{int(sec//3600)} h {round(sec%3600/60):02d} min / {g:.1f} g'
def main():
 native=read(OUT/'native-validation.json');meshes=read(OUT/'mesh-validation.json');optics=read(OUT/'optical-registration-validation.json');harness=read(OUT/'harness-validation.json');packing=read(OUT/'wire-packing-validation.json');bambu=read(OUT/'bambu-studio/all-projects-validation.json');unchanged=read(OUT/'unchanged-optics-validation.json')
 assert not native['feature_issues'] and not native['interferences'] and native['all_occurrences_at_assembly_origin']
 assert len(native['motion_checks'])==15 and all(x['passed'] for x in native['motion_checks'])
 assert len(meshes)==18 and all(x['watertight'] and x['connected_solids']==1 for x in meshes)
 assert all(x['passed'] for x in optics.values()) and harness['passed'] and packing['passed'] and unchanged['passed']
 assert packing['route_pairs_checked']==78
 assert read(OUT/'archive-roundtrip-validation.json')['passed']
 assert len(bambu)==9 and sum(len(x['slicer']['sliced_plates']) for x in bambu)==21
 assert all(r['slicer']['return_code']==0 and not any(p['warning_message'] for p in r['slicer']['sliced_plates']) for r in bambu)
 s=importlib.util.spec_from_file_location('release_audit',str(Path(__file__).with_name('audit_bambu_v2.py')));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
 for r in bambu:
  p=OUT/'bambu-studio'/('sliced-'+Path(r['project']).stem)/r['project'];a.audit_project(p,r['object_count'])
  with zipfile.ZipFile(p) as z:
   assert z.testzip() is None
   for n in z.namelist():
    if n.endswith('.model'):
     for tri in E.fromstring(z.read(n)).iter('{http://schemas.microsoft.com/3dmanufacturing/core/2015/02}triangle'):assert all(k in tri.attrib for k in ('v1','v2','v3'))
 layers=E.parse(OUT/'laser/02-acrylic-REVIEW-ONLY.lbrn2').getroot().findall('CutSetting')
 assert [x.get('type') for x in layers]==['Scan','Cut']
 assert all(x.find(k).get('Value')=='0' for x in layers for k in ('minPower','maxPower','minPower2','maxPower2','doOutput'))
 pairs=[]
 for directory,pattern in [('stl','*.stl'),('optional-laminate','*.stl'),('fit-samples','*.stl'),('laser','*.svg'),('laser','*.lbrn2'),('views','*.png')]:
  pairs.extend((p,Path(directory)/p.name) for p in (OUT/directory).glob(pattern))
 assert len(list((OUT/'stl').glob('*.stl')))==7 and len(list((OUT/'fit-samples').glob('*.stl')))==9
 for n in ['little-on-air-v22.f3d','little-on-air-v22-assembly.step','v22-production-fit-sections.f3d']:pairs.append((OUT/n,Path('cad')/n))
 for r in bambu:
  n=r['project'];pairs.append((OUT/'bambu-studio'/('sliced-'+Path(n).stem)/n,Path('bambu-studio')/n))
 for n in ['native-validation.json','mesh-validation.json','optical-registration-validation.json','harness-validation.json','wire-packing-validation.json','unchanged-optics-validation.json','archive-roundtrip-validation.json']:pairs.append((OUT/n,Path('validation')/n))
 for n in ['artwork-validation.json','svg-inventory.json','shared-front-master.json']:pairs.append((OUT/'laser'/n,Path('validation')/n))
 pairs.append((OUT/'bambu-studio/all-projects-validation.json',Path('validation/bambu-projects.json')))
 for n in ['BOM.csv','COMMISSIONING.csv','wire-cut-list.csv','routing-map.svg','routing-map.png','BUILD-AND-ASSEMBLY.md']:pairs.append((OUT/n,Path(n)))
 for src,rel in pairs:
  assert src.is_file(),src;dst=DEST/rel;dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(src,dst)
 start='''# ON AIR v2.2 — two switches

The larger SPDT is POWER. The original tiny DPDT and captive slider are RUN/PROGRAM. Both are retained by integrated rear holders and one removable yoke. The case remains 120 × 60 × 34 mm with a flat adhesive-mounting back.

**Reprint parts 05 and 06 together if you already made v2.1.** Other main printed shapes and laser artwork are unchanged. Part08 has only been renamed RUN PROGRAM. This package replaces the earlier alternative-circuit wiring instructions.

1. Open [PETG fit checks](bambu-studio/on-air-v22-X1C-PETG-fit-checks.3mf), or the matching PLA / PLA-plus-starting project. Test the actual switches, PCBs, LEDs, fasteners and acrylic. New sample98 checks the POWER mount; its actual lever width and travel are still unmeasured. Nine production sections plus the full yoke and two printed controls make twelve test objects.
2. Open [PETG AMS main print](bambu-studio/on-air-v22-X1C-PETG-AMS.3mf), or its manual-swap/material alternative. Plate1: bezel and rear housing. Plate2: optical retainer, yoke, reset and mode slider. Plate3: registered black/white backing. X1C,0.4 mm nozzle,100% scale; retain supplied orientations. PLA+ is a Generic PLA starting profile requiring spool calibration.
3. Use [rear-engraved acrylic SVG](laser/02-acrylic-REAR-engrave-and-cut.svg) at104 ×38 mm. Already mirrored; blue Fill first, red Line last. Qualify kerf and engraving on the actual PMMA and Nova Plus24 60W RF machine using the supplied test SVGs. The optional LightBurn file is review-only, powers zero and outputs off.
4. Follow [Build and assembly](BUILD-AND-ASSEMBLY.md), the selected [BOM](BOM.csv), [routing map](routing-map.png) and [wire cut list](wire-cut-list.csv). Only the inline330 Ω resistor,680 µF capacitor and your pigtails supplement the existing boards and switches. Check the charger's existing current setting against the cell's rating before charging.
5. Complete [Commissioning](COMMISSIONING.csv) before wall mounting. The existing receiver firmware still needs an external four-NeoPixel output; this revision does not flash or change it.

**Before either USB: POWER OFF, MODE PROGRAM, then connect only the selected USB port.** PROGRAM electrically isolates XIAO BAT+ and DATA; it is not an automatic bootloader command. Disconnect USB before returning to RUN and turning POWER on. LED and capacitor current bypass the tiny DPDT.

Separate STLs are in `stl/`, editable Fusion and STEP in `cad/`. `fit-samples/` are test sections. `optional-laminate/` contains two rings used only for the optional laser-laminate graphic alternative; do not add them to the printed backing stack.

[Validation record](VALIDATION.md): 18 connected watertight STL solids,15 nominal assembly/control paths,40 wire/space checks and9 Bambu projects/21 sliced plates. These digital checks do not replace physical fit and electrical commissioning.

![Revised enclosure](views/assembled.png)
'''
 (DEST/'START-HERE.md').write_text(start,encoding='utf-8')
 tables=['| Project | Slicer estimate |','|---|---|']+[f'| {r["project"].removeprefix("on-air-v22-X1C-").removesuffix(".3mf")} | {stats(r["slicer"]["sliced_plates"])} |' for r in bambu]
 validation=f'''# ON AIR v2.2 — validation record

Digitally checked fabrication prototype; actual build results belong in `COMMISSIONING.csv`.

| Check | Result |
|---|---|
| Native Fusion solids | {len(native['components'])} assembly components at origin; no feature warnings/errors or positive-volume static interference |
| Insertion, closure and control travel | {len(native['motion_checks'])} paths, {sum(x['samples'] for x in native['motion_checks'])} poses; no overlap above0.001 mm³ |
| Exported STL topology | 7 main parts,2 optional rings,9 fit sections;18 connected,closed,positive-volume solids with bed contact atZ=0 |
| Wire and component space | {len(harness['items'])} routes,bays and individual LED exits clear modeled obstacles |
| Simultaneous wire packing | All78 route pairs checked; compact insulation radii plus0.2 placement allowance; fanning inside marked bays only |
| Optical registration | Letter STL vs shared laser master error {optics['letters']['actual_STL_to_shared_laser_master_error_mm']:.8f} mm; file agreement only |
| Previous optical parts | Unchanged main meshes verified against v2.1 by canonical geometry; laser files match byte for byte |
| Bambu Studio2.8.2.61 | 9 projects,21 plates sliced without warnings; source and saved meshes match final STLs |
| Graphic color change | Black ends at1.6 mm; first white layer ends at1.7; all24 extrusion layers checked; one manual pause or AMS change |
| LightBurn artwork | 104 ×38 mm, mirrored rear text and key; Fill before Cut; review file power zero and outputs disabled |

The new POWER mount was checked for front insertion with the lever already attached, nominal3 mm lever travel, yoke installation and front closure. A roof/tongue collision discovered during review was corrected with a45-degree printed ramp; the final report passes. No front optical geometry was changed to make room for the switch.

## Print estimates

'''+ '\n'.join(tables)+'''

These estimates include configured brims and color purge; cooling, manual handling and calibration take additional time.

## Practical limits

The SPDT drawing gives the flange, main body,5 mm lever and2.5 mm legs. Its actual other-axis knob width and travel remain unmeasured. CAD reserves a3.2 mm square lever and checks3.0 mm motion; its7.9 mm opening has additional lateral clearance. Qualify it with sample98 and the full yoke. FDM fits use calibrated surfaces within±0.10 mm as an acceptance target, not a published X1C accuracy guarantee.

Motion sampling is generally0.25 mm and validates the specified straight insertion paths. Reference electronics simplify populated boards and solder geometry. Optional laminate rings pass mesh tests; assembly and optics use the printed graphic. Laser power/speed, actual PMMA thickness, kerf, engraving appearance, shrinkage, switch force, USB overmolds and connector bodies require real samples.

The13 wire routes and6 reserved bays plus21 individual LED exits clear modeled obstacles. Wire pairs near one another are allowed to fan within named bays and a2 mm dressing margin; this is not a physical cable simulation. Some native reference sweeps are stored as separate tested primitives because the CAD kernel could not unite nearly coincident display geometry. This does not skip their collision tests or affect printable parts.

Electrical behavior is not certified by CAD. In particular, confirm S1 startup/capacitive inrush, S2 MCU current below100 mA, the cell's charge rating versus the actual TP4056 setting, protected-ground wiring and the manual USB mode procedure. Direct battery-powered pixels may dim or become unreliable as voltage falls. Test the intended operating range and brightness.

No printer, laser or firmware job was sent. The existing receiver firmware still drives its onboard RGB LED and needs a four-pixel external output to operate this display.
'''
 (DEST/'VALIDATION.md').write_text(validation,encoding='utf-8')
 manifest=[{'file':p.relative_to(DEST).as_posix(),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in sorted(DEST.rglob('*')) if p.is_file() and p.name!='manifest.json']
 (DEST/'manifest.json').write_text(json.dumps({'revision':'v2.2','main_stls':7,'optional_stls':2,'fit_section_stls':9,'laser_svgs':5,'bambu_projects':9,'files':manifest},indent=2))
 target=BASE/'output/on-air-v22-fabrication.zip'
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for p in sorted(DEST.rglob('*')):
   if p.is_file():z.write(p,p.relative_to(DEST))
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for x in manifest:assert hashlib.sha256(z.read(x['file'])).hexdigest()==x['sha256']
 print(json.dumps({'folder':str(DEST),'zip':str(target),'zip_bytes':target.stat().st_size,'files':len(manifest)+1},indent=2))
if __name__=='__main__':main()
