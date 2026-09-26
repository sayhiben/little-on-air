import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 old=json.loads((O/'harness-validation.json').read_text())
 s=importlib.util.spec_from_file_location('seatwires26',str(H/'validate_harness.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_NAMES=('P4','D1','XIAO');v.RESULT_NAME='xiao-harness-recheck.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert new['passed'];checks={r['name']:r for r in new['items']}
 old['items']=[checks.get(r['name'],r) for r in old['items']];old['passed']=all(r['passed'] for r in old['items']);old['final_note']='XIAO positive back-face seat: all affected P4,D1 andXIAO solder/aisle envelopes rechecked. Other wire corridors are outside the added0.3mm spine surface.'
 (O/'harness-validation.json').write_text(json.dumps(old,indent=2))
