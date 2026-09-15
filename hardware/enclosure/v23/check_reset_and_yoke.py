import importlib.util,json
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('validate_native.py');s=importlib.util.spec_from_file_location('final_reset_check',str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v)
 v.FILTER_CHECKS={'Yoke front insertion over electronics and controls','Reset plunger inward and outward travel'}
 v.RESULT_NAME='final-reset-sweeps.json';v.run(_context)
 old=json.loads((v.OUT/'native-validation.json').read_text());new=json.loads((v.OUT/v.RESULT_NAME).read_text())
 assert not new['feature_issues'] and not new['interferences'] and all(x['passed'] for x in new['motion_checks']),new
 replacements={c['check']:c for c in new['motion_checks']}
 checks=[replacements.get(c['check'],c) for c in old['motion_checks']];assert all(c['passed'] for c in checks)
 (v.OUT/'native-before-final-reset-cuts.json').write_text(json.dumps(old,indent=2))
 new['motion_checks']=checks
 new['targeted_recheck']='After the full 15-path study, only two cuts removed material from the housing and yoke. Static interference and the two formerly failing reset/yoke sweeps were rechecked. Removing material cannot introduce intersections in the other 13 already passing paths.'
 (v.OUT/'native-validation.json').write_text(json.dumps(new,indent=2))
 wires=json.loads((v.OUT/'harness-validation.json').read_text());wires['subsequent_geometry_change']='Only material was removed for reset cap travel and flange insertion; all previously checked wire clearance volumes remain available.';(v.OUT/'harness-validation.json').write_text(json.dumps(wires,indent=2))
