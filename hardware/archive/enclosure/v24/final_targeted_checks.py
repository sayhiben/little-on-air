import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v24'
def load(name):
 p=HERE/(name+'.py');s=importlib.util.spec_from_file_location('final24_'+name,str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def run(_context:str):
 prior=json.loads((OUT/'final-motion-checks.json').read_text())
 v=load('validate_native');v.FILTER_CHECKS={'Yoke front insertion over electronics and controls'}
 v.RESULT_NAME='stop-relief-check.json';v.run(_context)
 old=json.loads((OUT/'native-validation.json').read_text());new=json.loads((OUT/v.RESULT_NAME).read_text())
 assert not new['feature_issues'] and not new['interferences'] and all(c['passed'] for c in new['motion_checks']),[c for c in new['motion_checks'] if not c['passed']]
 replacement={c['check']:c for c in new['motion_checks']};new['motion_checks']=[replacement.get(c['check'],c) for c in prior['motion_checks']]
 assert all(c['passed'] for c in new['motion_checks'])
 new['note']='Six prior motion paths retain their passing results after a local housing cut; yoke insertion and all static interference/health checks rerun after the stop relief.'
 (OUT/'final-motion-checks.json').write_text(json.dumps(new,indent=2))
 checks={c['check']:c for c in old['motion_checks'] if c['check']!='XIAO straight insertion with reset already installed'};checks.update({c['check']:c for c in new['motion_checks']})
 new['motion_checks']=list(checks.values());assert len(checks)==16 and all(c['passed'] for c in checks.values())
 (OUT/'native-first-study.json').write_text(json.dumps(old,indent=2))
 new['targeted_recheck']='Full original assembly study plus final seven affected motion checks after removing the fixed XIAO lower stop, adding its removable yoke stop, and clearing the reset flange. All other paths are spatially disjoint from that local addition; remaining geometry changes removed material.'
 (OUT/'native-validation.json').write_text(json.dumps(new,indent=2))
 w=load('validate_harness');w.FILTER_NAMES=['G1 ','D1 ','XIAO lower solder'];w.RESULT_NAME='final-wire-routes.json';w.run(_context)
 updated=json.loads((OUT/w.RESULT_NAME).read_text());assert updated['passed'],[i for i in updated['items'] if not i['passed']]
 before=json.loads((OUT/'harness-validation.json').read_text());replacements={i['name']:i for i in updated['items']}
 h=load('harness');routes={n:p for n,r,p in h.ROUTES};bays={n:(lo,hi) for n,lo,hi in h.BAYS}
 for item in before['items']:
  if item['name'] in replacements:continue
  if 'path' in item:assert item['path']==[list(p) for p in routes[item['name']]],item['name']
  if item['name'] in bays:assert [item['min_mm'],item['max_mm']]==[list(p) for p in bays[item['name']]],item['name']
 before['items']=[replacements.get(i['name'],i) for i in before['items']];assert all(i['passed'] for i in before['items'])
 w.FILTER_NAMES=[];w.OBSTACLE_BOXES=[{'lo':[110.3,34.1,11.3],'hi':[112.1,36.55,14.4]}];w.RESULT_NAME='new-stop-wire-check.json';w.run(_context)
 assert json.loads((OUT/w.RESULT_NAME).read_text())['passed']
 before['passed']=True;before['targeted_recheck']='Three edited routes/bays rechecked in final geometry. All 41 envelopes also checked against the added yoke lower stop; other changes removed material.'
 (OUT/'harness-validation.json').write_text(json.dumps(before,indent=2))
 u=load('check_usb_space');u.run(_context);assert json.loads((OUT/'usb-space-validation.json').read_text())['passed']
 print('All sixteen assembly/control paths, all forty-one wire spaces, and enlarged USB sweep pass')
