"""Fresh native solid, insertion, control and clearance checks for v2.7."""
import adsk.core as C
import adsk.fusion as F
import json,math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v27'

def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 groups={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
 report={'document':C.Application.get().activeDocument.name,'feature_issues':[],'interferences':[],'motion_checks':[],'clearance_checks':[],'components':[]}
 def save():
  report['passed']=not(report['feature_issues'] or report['interferences']) and all(r['passed'] for r in report['motion_checks']+report['clearance_checks'])
  (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 def bounds(body):return [[round(v*10,5) for v in p.asArray()] for p in (body.boundingBox.minPoint,body.boundingBox.maxPoint)]
 def overlap(a,z):
  ab,zb=a.boundingBox,z.boundingBox
  return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(ab.maxPoint.asArray(),zb.maxPoint.asArray(),ab.minPoint.asArray(),zb.minPoint.asArray()))
 def intersection(a,z):
  if not overlap(a,z):return 0
  q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),F.BooleanTypes.IntersectionBooleanType)
  return q.volume*1000
 for i in range(d.timeline.count):
  f=d.timeline.item(i).entity
  if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:report['feature_issues'].append({'name':f.name,'message':f.errorOrWarningMessage})
 for name,bs in groups.items():
  report['components'].append({'name':name,'body_count':len(bs),'bodies':[{'solid':q.isSolid,'volume_mm3':q.volume*1000,'bounds':bounds(q)} for q in bs]})
  if name[:2].isdigit():assert len(bs)==1 and bs[0].isSolid,name
 selected=[(n,q) for n,bs in groups.items() if not n.startswith(('81','82')) for q in bs]
 for i,(n,a) in enumerate(selected):
  for zn,z in selected[:i]:
   if n==zn:continue
   vol=intersection(a,z)
   if vol>.001:report['interferences'].append({'one':n,'two':zn,'volume_mm3':round(vol,5)})
 save()
 def select(prefixes):return [(n,q) for n,bs in groups.items() if any(n.startswith(p) for p in prefixes) for q in bs]
 def motion(label,moving,fixed,offsets):
  fail=[];count=0
  for off in offsets:
   mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(*[v/10 for v in off])
   for n,a in select(moving):
    q=tm.copy(a);tm.transform(q,mat)
    for zn,z in select(fixed):
     vol=intersection(q,z);count+=1
     if vol>.001:fail.append({'offset':off,'one':n,'two':zn,'volume_mm3':round(vol,5)})
  report['motion_checks'].append({'name':label,'samples':len(offsets),'pair_checks':count,'passed':not fail,'failures':fail[:20]});save()
 front=[(0,0,i*.25) for i in range(81)]
 for n in ('REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery'):
  motion(n+' straight front insertion',[n],['05'],front)
 motion('Keeper drops over installed PCBs and switches',['06'],['05','REF Charger','REF XIAO','REF DPDT','REF SPDT'],front)
 motion('Complete front including reset closes',['01','02','03','04','07'],['05','06','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery','REF Capacitor'],front)
 motion('Reset loads into bezel from rear',['07'],['01'],[(0,0,-i*.25) for i in range(81)])
 motion('Reset supported travel, target surface deflects',['07'],['01','05','06'],[(0,0,-i*.025) for i in range(25)])
 motion('POWER full detent travel',['REF SPDT moving'],['05','06'],[(i*1.425/30,0,0) for i in range(-30,31)])
 motion('MODE full detent travel',['REF DPDT moving'],['05','06'],[(i*1.2/30,0,0) for i in range(-30,31)])
 for n,f in [('02',['01']),('03',['01','02']),('04',['01','02','03','REF Four LEDs'])]:motion(n+' rear optical insertion',[n],f,[(0,0,-i*.25) for i in range(65)])
 def p(v):return C.Point3D.create(v[0]/10,v[1]/10,-v[2]/10)
 def tube(label,a,z,r,fix=('01','04','05','06','07')):
  q=tm.createCylinderOrCone(p(a),r/10,p(z),r/10);fail=[]
  for n,body in select(fix):
   vol=intersection(q,body)
   if vol>.001:fail.append({'part':n,'volume_mm3':round(vol,5)})
  report['clearance_checks'].append({'name':label,'from':a,'to':z,'radius':r,'passed':not fail,'failures':fail})
 tube('RGB front sight',(103.605,55.006,17.89),(103.605,55.006,-.1),.5)
 for y in (49.4,44.65):tube('Charger rear sight',(14,y,17.11),(14,y,24.2),.5)
 for x,end in ((90.27,85),(105.53,108.9)):
  for i in range(7):
   y=39.7025+2.54*i;tube('XIAO edge-pad wire exit',(x,y,18.0),(end,y,18.0),.45)
 for y in (47.64,49.545):tube('XIAO underside power wire exit',(93.445,y,20.45),(85,y,20.45),.45)
 for x in (13.5,28.5):tube('Charger lower OUT pad clearance',(x,32.3,12.4),(x,32.3,17),.65)
 # Max compact solder envelopes moving straight down with the board.
 joints=[]
 for x in (90.27,105.53):
  for i in range(7):joints.append(((x-.55,39.7025+2.54*i-.55,17.25),(x+.55,39.7025+2.54*i+.55,19.65)))
 for y in (47.64,49.545):joints.append(((92.7,y-.7,19.7),(94.2,y+.7,20.95)))
 fail=[]
 for lo,hi in joints:
  mid=[(lo[i]+hi[i])/2 for i in range(3)]
  q=tm.createBox(C.OrientedBoundingBox3D.create(p(mid),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),*[(hi[i]-lo[i])/10 for i in range(3)]))
  for step in range(81):
   body=tm.copy(q);mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,step*.025);tm.transform(body,mat)
   for name,solid in select(['05']):
    vol=intersection(body,solid)
    if vol>.001:fail.append({'joint':lo,'offset_z':step*.25,'part':name,'volume_mm3':vol})
 report['clearance_checks'].append({'name':'Pre-soldered XIAO straight insertion','joint_envelopes':16,'sampled_poses':1296,'passed':not fail,'failures':fail[:25]})
 save();print(json.dumps({'passed':report['passed'],'features':report['feature_issues'],'static':report['interferences'],'failed_motion':[r for r in report['motion_checks'] if not r['passed']],'failed_clearance':[r for r in report['clearance_checks'] if not r['passed']]},indent=2))
