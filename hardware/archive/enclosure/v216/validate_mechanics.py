"""Assembly solids, insertion, service bays and final native exports."""
import adsk.core as C,adsk.fusion as F,adsk,json,math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get();groups={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 obstacles=[(n,q) for n,bs in groups.items() if not n.startswith(('81','82','REF Harness')) for q in bs]
 bounds={id(q):q.boundingBox for n,q in obstacles}
 def hit(a,z):
  aa=a.boundingBox;bb=bounds[id(z)] if id(z) in bounds else z.boundingBox
  if not all(min(h,k)>max(l,m)+1e-7 for h,k,l,m in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray())):return 0
  r=tm.copy(a);assert tm.booleanOperation(r,tm.copy(z),F.BooleanTypes.IntersectionBooleanType);return r.volume*1000
 def moved(q,z):
  a=tm.copy(q);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,z/10);assert tm.transform(a,m);return a
 def box(lo,hi):
  p=C.Point3D.create((lo[0]+hi[0])/20,(lo[1]+hi[1])/20,-(lo[2]+hi[2])/20)
  return tm.createBox(C.OrientedBoundingBox3D.create(p,C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*( (hi[i]-lo[i])/10 for i in range(3))))
 report={'passed':False,'static':[],'yoke_insertion':[],'closure':[],'bays':[]}
 yoke=groups['06 Electronics retaining yoke'][0];rear=groups['05 Rear electronics housing'][0]
 for part,a in [('05',rear),('06',yoke)]:
  for name,q in obstacles:
   if name.startswith(part):continue
   volume=hit(a,q)
   if volume>.001:report['static'].append({'part':part,'other':name,'mm3':volume})
 for i in range(31):
  offset=i*.5;a=moved(yoke,offset)
  for n,q in obstacles:
   if not n.startswith(('05','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery','REF Capacitor','09','10','11','REF Guide')):continue
   v=hit(a,q)
   if v>.001:report['yoke_insertion'].append({'offset_mm':offset,'other':n,'mm3':v})
 for i in range(31):
  for name in ('01 Front optical bezel','02 Clear acrylic','03 Registered graphic backing','04 Optical retainer','07 Front guided reset button','08 Front RGB light guide'):
   for q in groups[name]:
    v=hit(moved(q,i*.5),yoke)
    if v>.001:report['closure'].append({'offset_mm':i*.5,'part':name,'mm3':v})
 bays=[('Pigtail connector',(4,14,12),(17,24,19.5)),('R1 DATA inline resistor',(70,5.2,18),(82,8.4,21.2)),('Lower service slack',(18,15,10.3),(30,27,12.4))]
 for name,lo,hi in bays:
  a=box(lo,hi);hits=[]
  for n,q in obstacles:
   v=hit(a,q)
   if v>.001:hits.append({'part':n,'mm3':v})
  report['bays'].append({'name':name,'lo':lo,'hi':hi,'collisions':hits,'passed':not hits})
 report['passed']=not any(report[k] for k in ('static','yoke_insertion','closure')) and all(q['passed'] for q in report['bays'])
 report['poses_per_motion']=31;report['physical_limits']='Nominal geometry and hand-dressed path reservations; actual LED pad positions, solder fillets, insulation OD and print fit require dry fitting. No structural FEA or physical print claim.'
 (OUT/'mechanical-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2));assert report['passed']
 assert json.loads((OUT/'route-check.json').read_text())['passed'] and json.loads((OUT/'wire-separation.json').read_text())['passed']
 for o in d.rootComponent.occurrences:o.isLightBulbOn=not o.component.name.startswith(('81','82','REF'))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v216.f3d')))
 assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v216-assembly.step')))
 (OUT/'views').mkdir(exist_ok=True);vp=app.activeViewport
 def p(x,y,z):return C.Point3D.create(x/10,y/10,z/10)
 for name,prefix,eye in [('yoke-rear','06',(95,75,-160)),('housing-inside','05',(145,100,155)),('frame-unchanged','01',(120,100,-180))]:
  for o in d.rootComponent.occurrences:o.isLightBulbOn=o.component.name.startswith(prefix)
  cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=p(*eye);cam.target=p(60,30,-12);cam.upVector=C.Vector3D.create(0,1,0);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam;vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle
  adsk.doEvents();vp.refresh();adsk.doEvents();assert vp.saveAsImageFile(str(OUT/'views'/(name+'.png')),1600,1050)
