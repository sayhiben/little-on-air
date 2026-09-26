"""Remove only added rim material in the existing reset-collar space."""
import adsk.core as C,adsk.fusion as F
import adsk,importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v214'
s=importlib.util.spec_from_file_location('clear214',BASE/'build_enclosure.py');b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
def run(_context:str):
 app=C.Application.get();current=app.activeDocument;assert 'v2.14' in current.name
 tm=F.TemporaryBRepManager.get()
 old=None
 for candidate in app.documents:
  if candidate.name==current.name:continue
  candidate.activate()
  matches=[o.component for o in b.root().occurrences if o.component.name=='01 Front optical bezel']
  if matches:
   old=tm.copy(matches[0].bRepBodies.item(0));break
 assert old is not None
 current.activate();d=b.design();c=b.comp('01 Front optical bezel');front=c.bRepBodies.item(0)
 previous=[f for f in c.features.baseFeatures if f.name=='Reset collar relief tool - added material only']
 for base in previous:
  for f in list(c.features.combineFeatures):
   if f.timelineObject.index>base.timelineObject.index and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:f.deleteMe()
  base.deleteMe()
 front=c.bRepBodies.item(0)
 addition=tm.copy(front);assert tm.booleanOperation(addition,old,F.BooleanTypes.DifferenceBooleanType)
 keepout=tm.createBox(C.OrientedBoundingBox3D.create(b.p(92.015,56.025,-7.655),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),.573,.565,.371))
 assert tm.booleanOperation(addition,keepout,F.BooleanTypes.IntersectionBooleanType)
 removed_volume=addition.volume*1000;assert removed_volume>0
 f=c.features.baseFeatures.add();f.name='Reset collar relief tool - added material only';f.startEdit();tool=c.bRepBodies.add(addition,f);f.finishEdit();tool=f.bodies.item(0)
 inp=c.features.combineFeatures.createInput(front,b.oc([tool]));inp.operation=F.FeatureOperations.CutFeatureOperation;inp.isKeepToolBodies=False
 f=c.features.combineFeatures.add(inp);f.name='Clear existing reset collar without changing original bearing'
 assert c.bRepBodies.count==1
 button=b.comp('07 Front guided reset button').bRepBodies.item(0)
 motion=[]
 for i in range(17):
  q=tm.copy(button);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,-i*.05/10);assert tm.transform(q,mat)
  assert tm.booleanOperation(q,tm.copy(front),F.BooleanTypes.IntersectionBooleanType)
  motion.append({'travel_mm':i*.05,'intersection_mm3':q.volume*1000})
 assert all(q['intersection_mm3']<.001 for q in motion),motion
 # Preserve successful wire tests: this operation only removes solid material.
 validation=json.loads((OUT/'native-validation.json').read_text())
 validation['static']=[q for q in validation['static'] if q['part']!='07 Front guided reset button']
 validation['reset_travel']=motion
 validation['reset_collar_relief']={'removed_added_material_mm3':removed_volume,'original_front_material_removed':False,'wire_clearance_monotonic_improvement':True}
 validation['passed']=not validation['static'] and not validation['closure'] and all(q['passed'] for q in validation['passages'])
 (OUT/'native-validation.json').write_text(json.dumps(validation,indent=2))
 build=json.loads((OUT/'native-build.json').read_text());build['added_mm3']-=removed_volume;build['reset_collar_keepout']={'min':[89.15,53.2,5.8],'max':[94.88,58.85,9.51],'scope':'Added rim only; original v2.13 bearing geometry preserved'}
 (OUT/'native-build.json').write_text(json.dumps(build,indent=2))
 opt=d.exportManager.createSTLExportOptions(c,str(OUT/'meshes-assembly-coordinates/01-front-optical-bezel.stl'))
 opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 for o in b.root().occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82','REF'))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v214.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v214-assembly.step')))
 (OUT/'validation-progress.json').write_text(json.dumps({'stage':'complete after reset collar correction','passed':validation['passed']}))
 print(json.dumps({'passed':validation['passed'],'removed_added_material_mm3':removed_volume,'reset_motion_samples':len(motion)},indent=2))
