"""Remove the v2.14 wire-channel roofs; retain every other part and interface."""
import adsk.core as C,adsk.fusion as F,adsk
import importlib.util,json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v215'
s=importlib.util.spec_from_file_location('open215',BASE/'build_enclosure.py');b=importlib.util.module_from_spec(s);s.loader.exec_module(b)
def fingerprint(q):
 return {'volume':q.volume,'area':q.area,'faces':q.faces.count,'edges':q.edges.count,'bounds':[q.boundingBox.minPoint.asArray(),q.boundingBox.maxPoint.asArray()]}
def run(_context:str):
 OUT.mkdir(parents=True,exist_ok=True);app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE.parents[1]/'release/little-on-air-enclosure-v2.14/cad/little-on-air-v214.f3d')))
 doc.name='Little ON AIR v2.15 - open rear cable channels'
 d=b.design();c=b.comp('01 Front optical bezel');tm=F.TemporaryBRepManager.get();old=tm.copy(c.bRepBodies.item(0))
 before={o.component.name:[fingerprint(q) for q in o.component.bRepBodies] for o in b.root().occurrences if o.component.name!=c.name}
 sk=b.sketch(c,'Open back of perimeter wire channel',8.1)
 b.rounded(sk,-2.9,-2.9,125.8,65.8,8.1);b.rounded(sk,1.3,1.3,117.4,57.4,3.9)
 profile=next(p for p in sk.profiles if p.profileLoops.count==2)
 b.extrude(c,sk,-1.4,'Remove continuous cable channel roof',F.FeatureOperations.CutFeatureOperation,profile)
 prior=json.loads((BASE/'output/v214/native-build.json').read_text())
 for q in prior['led_access_windows']:
  b.cutbox(c,'Open LED wiring access from rear',q['x'],q['y'],8.1,q['width'],q['height'],1.4)
 for x in (1.2,117):
  for y in (15,41):b.cutbox(c,'Open side cable access from rear',x,y,8.1,1.8,4,1.4)
 validate_export(doc,old,before)

def validate_export(doc,old,before):
 app=C.Application.get();d=b.design();c=b.comp("01 Front optical bezel");tm=F.TemporaryBRepManager.get()
 assert c.bRepBodies.count==1
 front=c.bRepBodies.item(0)
 def boolean(a,z,op):
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),op);return q
 removed=boolean(old,front,F.BooleanTypes.DifferenceBooleanType)
 added=boolean(front,old,F.BooleanTypes.DifferenceBooleanType)
 assert added.volume*1000<1e-5
 rb=removed.boundingBox;assert rb.maxPoint.z<=-.809999 and rb.minPoint.z>=-.950001
 unchanged=[]
 for o in b.root().occurrences:
  if o.component.name==c.name:continue
  after=[fingerprint(q) for q in o.component.bRepBodies]
  assert after==before[o.component.name],o.component.name
  unchanged.append(o.component.name)
 def box(x,y,w,h,lo=0,hi=11.01):
  return tm.createBox(C.OrientedBoundingBox3D.create(b.p(x+w/2,y+h/2,-(lo+hi)/2),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,h/10,(hi-lo)/10))
 guards=[('Reset bearing',89.4,52.6,5.6,5.6),('RGB bearing',100,51.4,7.21,7.21),('Optical stack',8,11,104,38)]
 for x in (6,114):
  for y in (6,54):guards.append((f'Closure screw seat {x},{y}',x-3.2,y-3.2,6.4,6.4))
 for y in (6,54):guards.append((f'Optical-retainer boss {y}',55.8,y-4.2,8.4,8.4))
 checks=[]
 for name,x,y,w,h in guards:
  v=boolean(removed,box(x,y,w,h),F.BooleanTypes.IntersectionBooleanType).volume*1000
  checks.append({'region':name,'removed_mm3':v,'passed':v<1e-5})
 features=[]
 for i in range(d.timeline.count):
  f=d.timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:features.append({'name':f.name,'message':f.errorOrWarningMessage})
 report={'passed':not features and all(q['passed'] for q in checks),'only_changed_component':c.name,'unchanged_component_native_fingerprints':unchanged,
         'added_mm3':added.volume*1000,'removed_mm3':removed.volume*1000,'removed_depth_range_mm':[-rb.maxPoint.z*10,-rb.minPoint.z*10],
         'all_geometry_in_front_of_depth_8_1_mm_unchanged':True,'interface_guards':checks,'feature_health_failures':features,
         'prior_collision_checks_remain_valid':'Only solid removal; all other geometry and positions unchanged. Therefore previous collision-free wire passages, front closing motion and reset travel cannot gain interference.',
         'channel_nominal_width_mm':4.2,'channel_open_depth_mm':7.7,'front_floor_mm':1.8,'minimum_outer_wall_mm':1.6,
         'front_bounds_mm':[129,69,11],'wires_retain_by':'Small hot-glue anchors; open toward wall outside the original rear housing.'}
 (OUT/'native-build.json').write_text(json.dumps(report,indent=2));assert report['passed'],report
 c.description='v2.15: open-backed perimeter and LED cable channels. Original floors, wall perimeter and screw/control/optical interfaces retained. No wire-channel roof bridges or additional printed covers.'
 (OUT/'meshes-assembly-coordinates').mkdir(exist_ok=True)
 opt=d.exportManager.createSTLExportOptions(c,str(OUT/'meshes-assembly-coordinates/01-front-optical-bezel.stl'));opt.unitType=F.DistanceUnits.MillimeterDistanceUnits;opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh;opt.sendToPrintUtility=False;assert d.exportManager.execute(opt)
 for o in b.root().occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82','REF'))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v215.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v215-assembly.step')))
 (OUT/'views').mkdir(exist_ok=True);vp=app.activeViewport
 for name,eye in [('inside',(120,100,-180)),('front',(145,100,160))]:
  for o in b.root().occurrences:o.isLightBulbOn=o.component.name==c.name
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(60,30,-5);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
  vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(OUT/'views'/(name+'.png')),1700,1100)
 print(json.dumps(report,indent=2))
