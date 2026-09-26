"""Final feature health, top control access and manufacturing exports/views."""
import adsk.core as C,adsk.fusion as F,adsk,json,importlib.util
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v214'
s=importlib.util.spec_from_file_location('final214',BASE/'build_enclosure.py');b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
def run(_context:str):
 app=C.Application.get();assert 'v2.14' in app.activeDocument.name;d=b.design();tm=F.TemporaryBRepManager.get();front=b.comp('01 Front optical bezel').bRepBodies.item(0)
 report={'feature_health':[],'control_bounds':[],'socket_plug_reservations':[]}
 for i in range(d.timeline.count):
  f=d.timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:report['feature_health'].append({'name':f.name,'message':f.errorOrWarningMessage})
 for occurrence in b.root().occurrences:
  n=occurrence.component.name
  if not n.startswith(('REF Charger','REF XIAO','REF DPDT moving','REF SPDT moving')):continue
  for body in occurrence.component.bRepBodies:
   bb=body.boundingBox;lo=[v*10 for v in bb.minPoint.asArray()];hi=[v*10 for v in bb.maxPoint.asArray()]
   report['control_bounds'].append({'component':n,'body':body.name,'min':lo,'max':hi})
   if 'USB' not in body.name and 'socket' not in body.name.lower():continue
   x=(lo[0]+hi[0])/2;z=(lo[2]+hi[2])/2
   probe=tm.createBox(C.OrientedBoundingBox3D.create(b.p(x,68,z),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),1.2,1.6,.65))
   assert tm.booleanOperation(probe,tm.copy(front),F.BooleanTypes.IntersectionBooleanType)
   report['socket_plug_reservations'].append({'component':n,'body':body.name,'assumed_overmold_mm':[12,16,6.5],'min_y_mm':60,'front_intersection_mm3':probe.volume*1000,'passed':probe.volume*1000<.001})
 report['passed']=not report['feature_health'] and all(q['passed'] for q in report['socket_plug_reservations'])
 (OUT/'final-native-check.json').write_text(json.dumps(report,indent=2))
 assert report['passed'],report
 for o in b.root().occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82','REF'))
 vp=app.activeViewport
 def view(name,prefix,eye):
  for o in b.root().occurrences:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(60,30,-7);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(OUT/'views'/name),1700,1100)
 view('front.png',('01',),(145,100,160));view('inside.png',('01',),(135,105,-180));view('assembly.png',('01','02','03','04','05','06','07','08','09','10','11'),(145,100,160))
 for o in b.root().occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82','REF'))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v214.f3d')))
 print(json.dumps(report,indent=2))
