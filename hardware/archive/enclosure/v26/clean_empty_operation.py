import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct)
 def sig():return [(o.component.name,[round(b.volume,10) for b in o.component.bRepBodies]) for o in d.rootComponent.occurrences]
 before=sig();bad=[]
 for i in range(d.timeline.count):
  e=d.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:bad.append(e)
 for e in bad:
  assert e.name=='Right yoke full depth screw clearance' and 'No target body' in e.errorOrWarningMessage
  e.deleteMe()
 assert sig()==before,'Cleanup changed solids'
 old=json.loads((O/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('clean26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS=set();v.RESULT_NAME='cleanup-static-validation.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences']
 new['motion_checks']=old['motion_checks'];new['cleanup_note']='Removed one failed no-target cut after its clearance had already been opened by the previous cut. Component volume signatures unchanged; all static solids and feature health rechecked. All16 passing motion checks apply to the unchanged solids.'
 (O/'native-validation.json').write_text(json.dumps(new,indent=2))
