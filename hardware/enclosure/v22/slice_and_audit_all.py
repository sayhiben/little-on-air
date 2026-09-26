from pathlib import Path
import importlib.util,subprocess,json,zipfile
OUT=Path(__file__).resolve().parents[1]/'output/v22/bambu-studio'
s=importlib.util.spec_from_file_location('audit',str(Path(__file__).with_name('audit_bambu_v2.py')));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
def main():
 reports=[]
 for src in sorted(OUT.glob('on-air-v22-X1C-*.3mf')):
  if 'ready' in src.name:continue
  dest=OUT/('sliced-'+src.stem);dest.mkdir(exist_ok=True)
  with (dest/'slice.log').open('w') as log:
   p=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(dest.resolve()),'--export-3mf',src.name,str(src.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=dest,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
  result=json.loads((dest/'result.json').read_text());assert p.returncode==0 and result['return_code']==0,(src.name,result)
  assert all(not p['warning_message'] for p in result['sliced_plates']),(src.name,result)
  n=12 if 'fit-checks' in src.name else 7
  objects=a.audit_project(src,n);a.audit_project(dest/src.name,n)
  color=None if 'fit-checks' in src.name else a.code_check(dest/'plate_3.gcode','manual-swap' in src.name)
  with zipfile.ZipFile(src) as z:settings=json.loads(z.read('Metadata/project_settings.config'))
  report={'project':src.name,'object_count':len(objects),'mesh_matches_STL':True,'slicer':result,'color_change':color,'material':settings['filament_type'],'nozzle_C':settings['nozzle_temperature'],'bed_C':settings['textured_plate_temp']};reports.append(report)
  print(json.dumps({'project':src.name,'plates':len(result['sliced_plates']),'warnings':[],'verified':True}),flush=True)
 (OUT/'all-projects-validation.json').write_text(json.dumps(reports,indent=2))
if __name__=='__main__':main()
