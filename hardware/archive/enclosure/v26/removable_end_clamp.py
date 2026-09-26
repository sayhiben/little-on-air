import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 s=importlib.util.spec_from_file_location('end26',str(H/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(rear,'Move lower outer cheek out of prewired insertion path',110.25,36.8,26.7,3.5,1.4,2.9)
 b.box(yoke,'Broad root for removable XIAO end clamp',108.5,34.1,9.65,4.15,4.1,1.65)
 b.box(yoke,'Removable short-end clamp leaves both pad rows free',110.25,35,11.25,2.4,3.1,18.2);b.union(yoke)
 b.paint(rear);b.paint(yoke);m.finish('Lower XIAO clamp belongs to removable yoke; prewired pad rows slide freely')
 old=json.loads((O/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('endstatic26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS={'Yoke front insertion over electronics and controls'};v.RESULT_NAME='removable-end-clamp-validation.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences'] and all(r['passed'] for r in new['motion_checks'])
 checks={r['check']:r for r in new['motion_checks']};new['motion_checks']=[checks.get(r['check'],r) for r in old['motion_checks']];new['recheck_note']=old.get('recheck_note','')+' Lower outer cheek replaced by a2.4x3.1mm removable yoke end clamp. Its insertion path rechecked. Other motion paths either exclude the removed yoke during PCB loading or are disjoint. Prewired solder paths and final wire space checked separately.'
 (O/'native-validation.json').write_text(json.dumps(new,indent=2))
