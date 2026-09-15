import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v26'
def run(_context:str):
 old=json.loads((OUT/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('native25',str(HERE/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v)
 v.FILTER_CHECKS={'XIAO final 8 mm upward slide','Direct DPDT front insertion','Yoke front insertion over electronics and controls','Front display subassembly closure'};v.RESULT_NAME='final-motion-checks.json';v.run(_context)
 fresh=json.loads((OUT/v.RESULT_NAME).read_text());assert not fresh['feature_issues'] and not fresh['interferences']
 assert all(c['passed'] for c in fresh['motion_checks']),[c for c in fresh['motion_checks'] if not c['passed']]
 replacement={c['check']:c for c in fresh['motion_checks']};fresh['motion_checks']=[replacement.get(c['check'],c) for c in old['motion_checks']]
 assert len(fresh['motion_checks'])==16 and all(c['passed'] for c in fresh['motion_checks'])
 fresh['targeted_recheck']='Full v2.6 study followed by corrected DPDT end shoulders and local USB PCB relief. All paths involving the added shoulders rechecked; other changes only remove material.'
 (OUT/'native-first-study.json').write_text(json.dumps(old,indent=2));(OUT/'native-validation.json').write_text(json.dumps(fresh,indent=2))
 print('Sixteen motion checks pass; static assembly and timeline healthy')
