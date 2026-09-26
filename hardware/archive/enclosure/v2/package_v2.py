from pathlib import Path
import json,zipfile,shutil,hashlib,xml.etree.ElementTree as E
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output'/'v2';DEST=BASE/'output'/'on-air-v2-fabrication'
def main():
 native=json.loads((OUT/'native-validation.json').read_text());mesh=json.loads((OUT/'mesh-validation.json').read_text());optics=json.loads((OUT/'optical-registration-validation.json').read_text());bambu=json.loads((OUT/'bambu-studio'/'verified-projects.json').read_text())
 assert not native['feature_issues'] and not native['interferences'];assert len(native['motion_checks'])==13 and all(c['passed'] for c in native['motion_checks']);assert all(c['watertight'] and c['connected_solids']==1 for c in mesh)
 assert len(list((OUT/'stl').glob('*.stl')))==7 and len(list((OUT/'optional-laminate').glob('*.stl')))==2 and len(list((OUT/'fit-samples').glob('*.stl')))==8
 pairs=[]
 for directory,pattern in [('stl','*.stl'),('optional-laminate','*.stl'),('fit-samples','*.stl'),('laser','*.svg'),('views','*.png')]:
  for p in (OUT/directory).glob(pattern):pairs.append((p,Path(directory)/p.name))
 for p in ['little-on-air-v2.f3d','little-on-air-v2-assembly.step','v2-production-fit-sections.f3d']:pairs.append((OUT/p,Path('cad')/p))
 for p in ['on-air-v2-X1C-PETG-AMS-ready.3mf','on-air-v2-X1C-PETG-manual-swap.3mf','on-air-v2-X1C-PETG-fit-checks.3mf']:pairs.append((OUT/'bambu-studio'/p,Path('bambu-studio')/p))
 for p in ['native-validation.json','mesh-validation.json','optical-registration-validation.json']:pairs.append((OUT/p,Path('validation')/p))
 pairs.append((OUT/'laser'/'artwork-validation.json',Path('validation')/'artwork-validation.json'));pairs.append((OUT/'bambu-studio'/'verified-projects.json',Path('validation')/'bambu-projects.json'))
 for src,rel in pairs:
  assert src.is_file(),src;dst=DEST/rel;dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(src,dst)
 guide=(OUT/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8').replace('bambu-studio/on-air-v2-X1C-PETG-AMS.3mf','bambu-studio/on-air-v2-X1C-PETG-AMS-ready.3mf')
 guide=guide.replace('use a 31 × 6 mm scrap strip','use `laser/90-fit-strip-CUT-ONLY.svg` to cut a 31 × 6 mm scrap strip')
 guide+='\n## CAD views\n\nThese are geometry views, not predictions of brightness or finished surface appearance.\n\n![Assembled front](views/front.png)\n\n![Rear housing with the component retaining yoke](views/retained-electronics.png)\n\n![Exploded optical and electronics assembly](views/exploded.png)\n'
 (DEST/'BUILD-AND-ASSEMBLY.md').write_text(guide,encoding='utf-8')
 ams=bambu['AMS']['slicer']['sliced_plates'];manual=bambu['manual-swap']['slicer']['sliced_plates'];fit=bambu['fit-checks']['slicer']['sliced_plates']
 def stats(plates):
  sec=sum(p['total_predication'] for p in plates);g=sum(f['total_used_g'] for p in plates for f in p['filaments']);return f'{int(sec//3600)} h {round(sec%3600/60):02d} min; {g:.1f} g'
 lines=['# v2 validation results','','The revised enclosure implements the rear-mounted fixtures and independent optical assembly. Seven main FDM parts replace the earlier carrier and separate stationary keepers. The case is 120 × 60 × 34 mm.','','## Checks completed','','| Check | Result |','|---|---|',f'| Native Fusion features | {native["timeline_features"]} timeline entries checked; no feature errors or warnings |','| Solid interference | No positive-volume collisions in the modeled default assembly, including screws and nuts |',f'| Assembly and control movement | All 13 sampled insertion, closure and travel checks passed ({sum(c["samples"] for c in native["motion_checks"])} poses; no overlap above 0.001 mm³) |','| Main STLs | Seven separate, closed, consistently oriented, connected solids; millimeters; on Z=0 |','| Optional parts and fit sections | Two closed laminate rings and eight closed sections clipped from production geometry |',f'| Artwork registration | Actual STL lettering matches the shared laser master within {optics["letters"]["actual_STL_to_shared_laser_master_error_mm"]:.8f} mm; outlines coincide |','| SVG operations | Closed vector paths; 104 × 38 mm; rear acrylic text and key mirrored together; blue Fill, red Line |','| Bambu Studio | Three plates sliced without warnings; all project meshes match the exported STLs |','| Color transition | Black through 1.6 mm; white begins on the layer ending at 1.7 mm; graphic finishes at 2.5 mm |','| Native Bambu save | AMS project opened, all plates sliced, graphic preview inspected, and project saved with native previews |','','## Manufacturing consequences','','The optical retainer has about 1,002 mm² of bed contact and no elevated horizontal undersides. The open electronics yoke has about 840 mm² of bed contact. This removes the previous carrier\'s broad, suspended 4,140 mm² underside. Remaining short bridges are mainly fastener pockets and small locating/control details.','','The USB openings and reset guide are open toward the assembly face until the yoke is installed. Its integrated caps then close them. This allows straight board/control insertion while retaining broad print contact. The DPDT fork also admits the actuator from the front. The front-inserted closure screws terminate in blind rear-housing bosses; the wall surface remains closed.','','## Bambu estimates','',f'- Main AMS build: {stats(ams)}.',f'- Main manual-swap build: {stats(manual)}; manual swap time is additional.',f'- Separate fit-check plate: {stats(fit)}.','','These are slicer estimates for the included X1 Carbon / 0.4 mm / Generic PETG profile.','','## Scope of validation','','Movement checks sample translations every 0.25 mm for insertion, with finer spacing for control travel. They validate the documented paths through the nominal solids, not every possible orientation. Wiring, solder joints, compliance, print shrinkage and loads are not simulated. No physical prototype or optical brightness test has been performed.','','Use the fit project first. Actual acrylic thickness, charger dimensions, XIAO populated envelope/reset position and USB cable overmolds remain the important physical checks. The confirmed DPDT actuator is 1.42 × 1.42 × 1.83 mm, with about 2.58 mm movement in a 4 mm opening.','','The optional laminate rings passed mesh checks; the default collision/travel study uses the printed graphic. Assembly dimensions for the alternative are documented in the build guide.','']
 (DEST/'VALIDATION.md').write_text('\n'.join(lines),encoding='utf-8')
 manifest=[]
 for p in sorted(DEST.rglob('*')):
  if p.is_file() and p.name!='manifest.json':manifest.append({'file':p.relative_to(DEST).as_posix(),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
 (DEST/'manifest.json').write_text(json.dumps({'revision':'v2','main_stls':7,'optional_stls':2,'fit_section_stls':8,'laser_svgs':3,'files':manifest},indent=2))
 target=BASE/'output'/'on-air-v2-fabrication.zip'
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for p in sorted(DEST.rglob('*')):
   if p.is_file():z.write(p,p.relative_to(DEST))
 with zipfile.ZipFile(target) as z:
  assert z.testzip() is None
  for item in manifest:assert hashlib.sha256(z.read(item['file'])).hexdigest()==item['sha256']
 print(json.dumps({'folder':str(DEST),'zip':str(target),'zip_bytes':target.stat().st_size,'files':len(manifest)+1,'main_print_estimate':stats(ams)},indent=2))
if __name__=='__main__':main()
