"""Read-only native health, assembly overlaps and sampled insertion/travel checks."""
import adsk.core as C
import adsk.fusion as F
import json, math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output'/'v2'

def run(_context:str):
 app=C.Application.get();design=F.Design.cast(app.activeProduct);root=design.rootComponent
 report={'document':app.activeDocument.name,'units':'mm','components':[],'feature_issues':[],'interferences':[],'motion_checks':[]}
 groups={};bodies=C.ObjectCollection.create()
 for o in root.occurrences:
  c=o.component;entry={'name':c.name,'body_count':c.bRepBodies.count,'bodies':[]};groups[c.name]=list(c.bRepBodies)
  for body in c.bRepBodies:
   bb=body.boundingBox
   entry['bodies'].append({'name':body.name,'solid':body.isSolid,'volume_mm3':round(body.volume*1000,4),'min_mm':[round(v*10,5) for v in bb.minPoint.asArray()],'max_mm':[round(v*10,5) for v in bb.maxPoint.asArray()]})
   if not c.name.startswith(('81','82')):bodies.add(body.createForAssemblyContext(o))
  report['components'].append(entry)
 for i in range(design.timeline.count):
  obj=design.timeline.item(i).entity
  if hasattr(obj,'healthState') and obj.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:
   report['feature_issues'].append({'index':i,'name':getattr(obj,'name',obj.objectType),'message':getattr(obj,'errorOrWarningMessage','')})
 inp=design.createInterferenceInput(bodies);inp.areCoincidentFacesIncluded=False
 for inter in design.analyzeInterference(inp):
  vol=inter.interferenceBody.volume*1000 if inter.interferenceBody else 0
  if vol<.001:continue
  bb=inter.interferenceBody.boundingBox
  report['interferences'].append({'one':inter.entityOne.parentComponent.name+' / '+inter.entityOne.name,'two':inter.entityTwo.parentComponent.name+' / '+inter.entityTwo.name,'volume_mm3':round(vol,5),'min_mm':[round(v*10,4) for v in bb.minPoint.asArray()],'max_mm':[round(v*10,4) for v in bb.maxPoint.asArray()]})
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 tm=F.TemporaryBRepManager.get()
 def select(prefixes):return [(n,body) for n,bs in groups.items() if any(n.startswith(p) for p in prefixes) for body in bs]
 def overlap(a,b):
  aa=a.boundingBox;bb=b.boundingBox
  return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray()))
 def sweep(label,moving,fixed,offsets,skip=None):
  failures=[];count=0;mx=0
  for off in offsets:
   mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(*[v/10 for v in off])
   for mn,mb in select(moving):
    if skip and skip(mn,mb):continue
    transformed=tm.copy(mb);tm.transform(transformed,mat)
    for fn,fb in select(fixed):
     if not overlap(transformed,fb):continue
     x=tm.copy(transformed);other=tm.copy(fb)
     if not tm.booleanOperation(x,other,F.BooleanTypes.IntersectionBooleanType):raise RuntimeError('Temporary intersection failed')
     vol=x.volume*1000;mx=max(mx,vol);count+=1
     if vol>.001:failures.append({'offset_mm':off,'moving':mn+'/'+mb.name,'fixed':fn+'/'+fb.name,'volume_mm3':round(vol,5)})
  report['motion_checks'].append({'check':label,'samples':len(offsets),'boolean_checks':count,'max_overlap_mm3':round(mx,5),'passed':not failures,'failures':failures[:50]})
  (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 # Sampling every 0.25 mm is supplemented by the explicit analytical clearances in the assembly guide.
 sweep('Acrylic rear insertion into bezel',['02'],['01'],[(0,0,-i*.25) for i in range(0,65)])
 sweep('Graphic rear insertion into bezel',['03'],['01','02'],[(0,0,-i*.25) for i in range(0,65)])
 sweep('Optical retainer rear insertion',['04'],['01','02','03','REF Four LEDs'],[(0,0,-i*.25) for i in range(0,65)])
 sweep('Charger front insertion',['REF Charger'],['05'],[(0,0,i*.25) for i in range(0,97)])
 sweep('XIAO front insertion before reset plunger',['REF XIAO'],['05'],[(0,0,i*.25) for i in range(0,97)])
 sweep('Switch front insertion into installed slider',['REF DPDT'],['05','08'],[(0,0,i*.25) for i in range(0,97)])
 sweep('Yoke front insertion over electronics and controls',['06'],['05','07','08','REF Charger','REF XIAO','REF DPDT'],[(0,0,i*.25) for i in range(0,97)])
 sweep('Front display subassembly closure',['01','02','03','04'],['05','06','07','08','REF Battery','REF Charger','REF XIAO','REF DPDT'],[(0,0,i*.25) for i in range(0,49)])
 sweep('Optical screw heads during front closure',['REF M3 screws'],['05','06'],[(0,0,i*.25) for i in range(0,49)],skip=lambda n,b:not b.name.startswith('Optical screw'))
 sweep('Reset plunger inward and outward travel',['07'],['05','06'],[(i*.025,0,0) for i in range(-20,9)])
 sweep('Reset front insertion after XIAO',['07'],['05','REF XIAO'],[(0,0,i*.25) for i in range(0,65)])
 sweep('Slider lateral travel',['08'],['05','06'],[(i*1.29/20,0,0) for i in range(-20,21)])
 sweep('Slider front insertion before switch',['08'],['05'],[(0,0,i*.25) for i in range(0,97)])
 report['timeline_features']=design.timeline.count
 report['parameters']=[{'name':p.name,'expression':p.expression,'comment':p.comment} for p in design.userParameters]
 report['all_occurrences_at_assembly_origin']=all(all(abs(a-b)<1e-9 for a,b in zip(o.transform2.asArray(),C.Matrix3D.create().asArray())) for o in root.occurrences)
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
 print(json.dumps({'body_counts':{c['name']:c['body_count'] for c in report['components']},'feature_issues':report['feature_issues'],'interferences':report['interferences'],'motion_checks':[{k:v for k,v in r.items() if k!='failures'} for r in report['motion_checks']]},indent=2))
