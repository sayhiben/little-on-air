from pathlib import Path
import importlib.util,subprocess,json,zipfile,sys
OUT=Path(__file__).resolve().parents[1]/'output/v23/bambu-studio'
s=importlib.util.spec_from_file_location('audit',str(Path(__file__).with_name('audit_bambu_v2.py')));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
def main():
 selected=sys.argv[1] if len(sys.argv)>1 else None
 reports=json.loads((OUT/'all-projects-validation.json').read_text()) if selected else []
 for src in sorted(OUT.glob('on-air-v23-X1C-*.3mf')):
  if 'ready' in src.name:continue
  if selected and selected not in src.name:continue
  dest=OUT/('sliced-'+src.stem);dest.mkdir(exist_ok=True)
  with (dest/'slice.log').open('w') as log:
   p=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(dest.resolve()),'--export-3mf',src.name,str(src.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=dest,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
  result=json.loads((dest/'result.json').read_text());assert p.returncode==0 and result['return_code']==0,(src.name,result)
  assert all(not p['warning_message'] for p in result['sliced_plates']),(src.name,result)
  n=6
  objects=a.audit_project(src,n);a.audit_project(dest/src.name,n)
  color=None if 'fit-checks' in src.name else a.code_check(dest/'plate_3.gcode','manual-swap' in src.name)
  with zipfile.ZipFile(src) as z:settings=json.loads(z.read('Metadata/project_settings.config'))
  with zipfile.ZipFile(dest/src.name) as z:
   import re
   for member in z.namelist():
    if member.endswith('.gcode'):
     active=[line.split(';',1)[0].strip() for line in z.read(member).decode().splitlines()]
     assert not any(re.match(r'M97[67](?:\s|$)',line) for line in active),(src.name,member)
     pauses=[line for line in active if re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',line)]
     expected_pause='manual-swap' in src.name and member.endswith('plate_3.gcode')
     assert pauses==(['M400 U1'] if expected_pause else []),(src.name,member,pauses)
     assert 'M104 S0' in active and 'M140 S0' in active,(src.name,member,'shutdown')
     assert any(line.startswith('G29 A ') for line in active),(src.name,member,'leveling')
  assert str(settings['scan_first_layer'])=='0'
  report={'project':src.name,'object_count':len(objects),'mesh_matches_STL':True,'slicer':result,'color_change':color,'material':settings['filament_type'],'nozzle_C':settings['nozzle_temperature'],'bed_C':settings['textured_plate_temp'],'first_layer_inspection_disabled':True,'expected_pauses_only':True,'bed_leveling_sequence_present':True,'normal_heater_shutdown_present':True};reports=[r for r in reports if r['project']!=src.name];reports.append(report)
  print(json.dumps({'project':src.name,'plates':len(result['sliced_plates']),'warnings':[],'verified':True}),flush=True)
 assert len(reports)==9,[(r['project']) for r in reports]
 (OUT/'all-projects-validation.json').write_text(json.dumps(reports,indent=2))
if __name__=='__main__':main()
