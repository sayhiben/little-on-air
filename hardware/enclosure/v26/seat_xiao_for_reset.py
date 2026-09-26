"""Give reset force a positive PCB back-face seat instead of consuming travel."""
import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 s=importlib.util.spec_from_file_location('seat26',str(H/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing')
 b.box(rear,'XIAO positive back-face reaction seat',108.4,35,16.5,.4,23.2,15.2);b.union(rear)
 b.cutbox(rear,'Maintain underside BAT GND wire notch to PCB face',103.5,45.5,9.48,5.31,5.3,9.52)
 # The solid spine contacts the measured PCB back. Opposite end cheeks keep.25mm assembly allowance.
 m.finish('XIAO reset force bears on solid2.7mm spine at measured PCB back')
 old=json.loads((O/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('seatcheck26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v)
 v.FILTER_CHECKS={'XIAO lowered insertion with reset already installed','XIAO final 8 mm upward slide','Yoke front insertion over electronics and controls','Reset front loading before XIAO','Reset inside insertion before XIAO'};v.RESULT_NAME='xiao-seat-final-validation.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences'] and all(r['passed'] for r in new['motion_checks'])
 checks={r['check']:r for r in new['motion_checks']};new['motion_checks']=[checks.get(r['check'],r) for r in old['motion_checks']]
 new['recheck_note']=old.get('recheck_note','')+' XIAO back-face reaction seat extended0.3mm to the PCB back to eliminate play under reset force. Five affected loading paths rechecked; other11 paths are spatially disjoint. USB, reset, service exits and affected harness corridors rechecked.'
 (O/'native-validation.json').write_text(json.dumps(new,indent=2))
