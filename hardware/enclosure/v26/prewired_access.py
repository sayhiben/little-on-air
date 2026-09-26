import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 s=importlib.util.spec_from_file_location('prewired26',str(H/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 if not globals().get('CHECK_ONLY',False):
  rear=b.comp('05 Rear electronics housing')
  # Solder stubs move8mm inY before seating; leave the adjacent M3 boss untouched.
  b.cutbox(rear,'XIAO solder-joint runway for8mm assembly slide',107.2,38.7,14.5,1.61,12.1,4.5)
  m.finish('Pre-soldered XIAO power joints can travel to their final wire notch')
  old=json.loads((O/'native-validation.json').read_text())
  s=importlib.util.spec_from_file_location('prewiredstatic26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS=set();v.RESULT_NAME='prewired-static-validation.json';v.run(_context)
  new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences'];new['motion_checks']=old['motion_checks'];new['recheck_note']=old.get('recheck_note','')+' Final solder-joint runway removes material only; prior clearances remain open. Final static assembly and feature health rechecked.';(O/'native-validation.json').write_text(json.dumps(new,indent=2))
 d=b.design();tm=F.TemporaryBRepManager.get();obstacles=[bb for o in d.rootComponent.occurrences if o.component.name.startswith(('05','07')) for bb in o.component.bRepBodies]
 refs=[]
 def box(lo,hi):
  return tm.createBox(C.OrientedBoundingBox3D.create(C.Point3D.create((lo[0]+hi[0])/20,(lo[1]+hi[1])/20,-(lo[2]+hi[2])/20),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
 for yy in (47.64,49.545):refs.append(('Underside power solder',box((107.55,yy-.7,14.8),(108.79,yy+.7,17.2))))
 for dep in (12.82,28.08):
  for i in range(7):
   yy=39.7025+2.54*i;refs.append(('Edge-pad solder and outward wire stub',box((110.01,yy-.5,dep-.5),(112.8,yy+.5,dep+.5))))
 # Bare board and USB already checked through these exact paths. Here test added solder only.
 failures=[];samples=0
 for name,source in refs:
  for dy,dz in [(-8,i*.5) for i in range(49)]+[(-i*.25,0) for i in range(33)]:
   a=tm.copy(source);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,dy/10,dz/10);tm.transform(a,mat);samples+=1
   for ob in obstacles:
    aa=a.boundingBox;bb=ob.boundingBox
    if not all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray())):continue
    z=tm.copy(a);assert tm.booleanOperation(z,tm.copy(ob),F.BooleanTypes.IntersectionBooleanType)
    if z.volume*1000>.001:failures.append({'name':name,'offset':[0,dy,dz],'volume_mm3':z.volume*1000,'min':[v*10 for v in z.boundingBox.minPoint.asArray()],'max':[v*10 for v in z.boundingBox.maxPoint.asArray()]})
 report={'passed':not failures,'solder_envelopes':len(refs),'sampled_poses':samples,'failures':failures[:40],'note':'Power solder projection<=1.25mm fromPCB back; local joint envelope1.4mm alongY x2.4mm depth. Edge joints exit component side with1mm square wire margin. Free flexible leads must be kept forward of the yoke boss during insertion, then dressed into the final routes.'}
 (O/'prewired-insertion-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
