"""Check light sight lines, pad exits and measured common-fastener stack."""
import adsk.core as C
import adsk.fusion as F
import json,math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v26'
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);tm=F.TemporaryBRepManager.get()
 fixed=[(o.component.name,b) for o in d.rootComponent.occurrences if o.component.name.startswith(('01','04','05','06','07')) for b in o.component.bRepBodies];items=[]
 def p(q):return C.Point3D.create(q[0]/10,q[1]/10,-q[2]/10)
 def probe(name,a,z,r):
  source=tm.createCylinderOrCone(p(a),r/10,p(z),r/10);collisions=[]
  for n,b in fixed:
   t=tm.copy(source);assert tm.booleanOperation(t,tm.copy(b),F.BooleanTypes.IntersectionBooleanType)
   if t.volume*1000>.001:collisions.append({'part':n,'volume_mm3':t.volume*1000})
  items.append({'name':name,'start_mm':a,'end_mm':z,'radius_mm':r,'passed':not collisions,'collisions':collisions})
 probe('RGB direct light line',(110.61,55.006,26.155),(120.2,55.006,26.155),.5)
 for y in (49.4,44.65):probe('Charger indicator direct rear sight',(14,y,25.01),(14,y,34.2),.5)
 for dep in (12.82,28.08):
  for i in range(7):
   y=39.7025+2.54*i
   probe('XIAO plated pad outward solder exit',(110.51,y,dep),(112.6,y,dep),.45)
 probe('XIAO BAT underside solder exit',(108.75,47.64,15.995),(104.5,47.64,15.995),.65)
 probe('XIAO GND underside solder exit',(108.75,49.545,15.995),(104.5,49.545,15.995),.65)
 hs=json.loads((OUT/'hardware-layout.json').read_text());hardware=[]
 for r in hs:
  lo,hi=sorted(r['shaft_depth']);a,z=r['nut_depth'];eng=max(0,min(hi,z)-max(lo,a));tip=(hi-z) if r['type']!='Optical screw' else (a-lo)
  hardware.append({**r,'nut_engagement_mm':round(eng,4),'tip_past_nut_mm':round(tip,4),'passed':eng>=2.399 and tip>=.49})
 assert len(hardware)==8
 report={'passed':all(i['passed'] for i in items+hardware),'items':items,'hardware':hardware,'source':'Seeed official KiCad XIAO nRF52840 v1.2; measured PCB placement. Outward pad exits reserve0.9mm insulated wires; solder board before fitting. Hole diameter3.2charger; XIAO printable sight aperture3.4wide.'}
 (OUT/'service-fit-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps({'passed':report['passed'],'failed':[i for i in items+hardware if not i['passed']]},indent=2))
