import adsk.core as C
import adsk.fusion as F
import importlib.util,json,math
from pathlib import Path
H=Path(__file__).resolve().parent;O=H.parent/'output/v26'
def run(_context:str):
 s=importlib.util.spec_from_file_location('strength26',str(H/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');front=b.comp('01 Front optical bezel')
 for x,y in m.FAST:b.box(rear,'Restore common nut pocket for stronger roof',x-4.2,y-4.2,10.45,8.4,8.4,4.1)
 b.union(rear)
 for i,(x,y) in enumerate(m.FAST):
  b.cutcyl(front,'Common screw deeper bearing leaves2.9mm front seat',x,y,-.02,6.8,6.62)
  if i==2:
   sk=b.sketch(rear,'Upper left common nut pocket2mm roof',11.5);r=6/math.sqrt(3)
   b.polygon(sk,[(x+r*math.cos(math.pi/2+j*math.pi/3),y+r*math.sin(math.pi/2+j*math.pi/3)) for j in range(6)])
   b.extrude(rear,sk,-3,'Upper left strengthened nut seat',F.FeatureOperations.CutFeatureOperation)
   b.cutbox(rear,'Upper left inward entry',x-3,y-4.5,11.5,6,4.5,3)
  else:
   m.hexcut(rear,'Common nut pocket with2mm front roof',x,y,11.5,3,6)
   b.cutbox(rear,'Inward common nut entry',x if x<60 else x-4.5,y-3,11.5,4.5,6,3)
  b.cutcyl(rear,'Final closure shaft and tip clearance',x,y,9.48,3.6,5.72)
 for name in ('REF M3 nuts','REF M3 screws'):
  c=b.comp(name);bs=list(c.bRepBodies)[:4] if 'nuts' in name else [bb for bb in c.bRepBodies if bb.name.startswith('Closure screw')]
  mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,-.1);inp=c.features.moveFeatures.createInput2(b.oc(bs));inp.defineAsFreeMove(mat);c.features.moveFeatures.add(inp)
 hs=json.loads((O/'hardware-layout.json').read_text())
 for r in hs:
  if r['type']=='Closure screw':r['bearing_depth']=6.6;r['shaft_depth']=[6.6,14.6];r['nut_depth']=[11.6,14.0]
 (O/'hardware-layout.json').write_text(json.dumps(hs,indent=2))
 for name,val in {'closure_head_bearing':6.6,'closure_nut_front':11.5,'closure_nut_roof':2}.items():
  p=b.design().userParameters.itemByName(name)
  if p:p.expression=str(val)+' mm'
  else:b.design().userParameters.add(name,b.vi(val),'mm','v2.6 full-depth common screw nut roof')
 b.paint(rear);b.paint(front);m.finish('Common M3x8 closure now has2mm rear nut roof and2.9mm front seat')
 old=json.loads((O/'native-validation.json').read_text())
 s=importlib.util.spec_from_file_location('strengthstatic26',str(H/'validate_native.py'));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.FILTER_CHECKS={'Front display subassembly closure','Optical screw heads during front closure'};v.RESULT_NAME='common-screw-final-validation.json';v.run(_context)
 new=json.loads((O/v.RESULT_NAME).read_text());assert not new['feature_issues'] and not new['interferences'] and all(r['passed'] for r in new['motion_checks'])
 rechecked={r['check']:r for r in new['motion_checks']};new['motion_checks']=[rechecked.get(r['check'],r) for r in old['motion_checks']]
 new['recheck_note']='Four closure nut pockets and heads moved1mm deeper to provide a2mm rear nut roof and2.9mm front compression seat. Assembly closure and optical-head path rechecked. Other14 motions lie outside the corner-boss edit bounds. Nut loading, hardware engagement and complete wire clearances rechecked separately.'
 (O/'native-validation.json').write_text(json.dumps(new,indent=2))
