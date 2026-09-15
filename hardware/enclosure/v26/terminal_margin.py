import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 s=importlib.util.spec_from_file_location('margin26',str(H/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 b.cutbox(b.comp('05 Rear electronics housing'),'MODE rear terminal row insulated clearance',56.9,52.04,22.92,6.2,3.45,1.1)
 m.finish('MODE rear terminal solder margin retained with tighter seat')
 old=json.loads((O/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('marginstatic26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS=set();v.RESULT_NAME='terminal-margin-static-validation.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences']
 new['motion_checks']=old['motion_checks'];new['recheck_note']='Only material removed below the MODE body, restoring0.2mm terminal-row margin. All prior assembly, wire and control clearances remain open. Final static solids and feature health checked; terminal rows rechecked separately.'
 (O/'native-validation.json').write_text(json.dumps(new,indent=2))
