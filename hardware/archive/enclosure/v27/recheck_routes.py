import importlib.util,json
from pathlib import Path
def run(_context:str):
 out=Path(__file__).resolve().parents[1]/'output/v27';old=json.loads((out/'harness-validation.json').read_text())
 s=importlib.util.spec_from_file_location('vh',str(Path(__file__).with_name('validate_harness.py')));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
 h.FILTER_NAMES=['R1 inline'];h.RESULT_NAME='changed-routes-validation.json';h.run(_context)
 new=json.loads((out/h.RESULT_NAME).read_text());names={x['name'] for x in new['items']}
 old['items']=[x for x in old['items'] if x['name'] not in names]+new['items'];old['passed']=all(x['passed'] for x in old['items']);old['revision_note']='Updated route paths and junction reservation replace earlier results against unchanged native geometry. All other corridors retain their fresh v2.7 checks.'
 (out/'harness-validation.json').write_text(json.dumps(old,indent=2))
 print(json.dumps({'passed':old['passed'],'items':len(old['items']),'failed':[x['name'] for x in old['items'] if not x['passed']]}))
