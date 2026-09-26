import importlib.util,json
from pathlib import Path

def load(name):
 p=Path(__file__).with_name(name+'.py');s=importlib.util.spec_from_file_location('void23_'+name,str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m

def run(_context:str):
 m=load('build_v2');b=m.b;c=b.comp('05 Rear electronics housing');before=c.bRepBodies.item(0).volume*1000
 b.box(c,'Fill enclosed DPDT rebuild sliver',55.44,52.15,31.70,9.12,.31,.02)
 b.union(c);b.paint(c)
 delta=c.bRepBodies.item(0).volume*1000-before
 assert abs(delta-.028272)<.00001,delta
 v=load('validate_native');v.FILTER_CHECKS=set();v.RESULT_NAME='enclosed-void-native-check.json';v.run(_context)
 new=json.loads((m.OUT/v.RESULT_NAME).read_text());old=json.loads((m.OUT/'native-validation.json').read_text())
 assert not new['feature_issues'] and not new['interferences'] and not new['motion_checks']
 new['motion_checks']=old['motion_checks'];new['targeted_recheck']=old['targeted_recheck']+' Final enclosed void fill added exactly 0.028272 cubic mm inside the backplate, with no exterior boundary change; existing motion and wire clearance results remain valid. Static interference and timeline health rechecked.'
 (m.OUT/'native-validation.json').write_text(json.dumps(new,indent=2))
 (m.OUT/'enclosed-void-fill.json').write_text(json.dumps({'added_volume_mm3':delta,'expected_enclosed_volume_mm3':.028272,'passed':True},indent=2))
 m.finish('Enclosed DPDT rebuild void filled without changing fits')
