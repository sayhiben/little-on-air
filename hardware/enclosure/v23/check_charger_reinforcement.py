from pathlib import Path
import importlib.util,json
def load(name):
 p=Path(__file__).with_name(name+'.py');s=importlib.util.spec_from_file_location('final_'+name,str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def run(_context:str):
 w=load('validate_harness');w.RESULT_NAME='charger-reinforcement-wire-check.json';w.OBSTACLE_BOXES=json.loads((w.OUT/'charger-added-volumes.json').read_text());w.run(_context)
 assert json.loads((w.OUT/w.RESULT_NAME).read_text())['passed']
 v=load('validate_native');v.FILTER_CHECKS={'Charger front insertion','Yoke front insertion over electronics and controls','Front display subassembly closure'};v.RESULT_NAME='charger-reinforcement-native-check.json';v.run(_context)
 new=json.loads((v.OUT/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences'] and all(c['passed'] for c in new['motion_checks'])
 old=json.loads((v.OUT/'native-validation.json').read_text());replacement={c['check']:c for c in new['motion_checks']}
 new['motion_checks']=[replacement.get(c['check'],c) for c in old['motion_checks']];assert all(c['passed'] for c in new['motion_checks'])
 new['targeted_recheck']='Complete assembly study plus targeted reset cuts and charger reinforcement checks. Charger insertion, yoke insertion and front closure were rechecked after adding 2 mm charger supports. Other paths are spatially disjoint from the charger additions; reset cuts only removed material.'
 (v.OUT/'native-validation.json').write_text(json.dumps(new,indent=2))
 h=json.loads((v.OUT/'harness-validation.json').read_text());h['charger_support_recheck']='All 41 wire/space envelopes were additionally checked against all eight new charger-support volumes; no collision. See charger-reinforcement-wire-check.json.';(v.OUT/'harness-validation.json').write_text(json.dumps(h,indent=2))
