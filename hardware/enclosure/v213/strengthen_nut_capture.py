import importlib.util,adsk.core as C
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_retained_guides.py');s=importlib.util.spec_from_file_location('mount_rebuild',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing')
 b.cyl(rear,'Keeper nut structural roof extension',6.5,42.3,18.3,8.4,2.01);b.union(rear)
 b.cutbox(rear,'Guide nut lower loading bay and sliding entry',3.5,31.2,20.3,6,11.1,2.9)
 b.cutcyl(rear,'Guide keeper blind screw tip clearance',6.5,42.3,18.28,3.6,5.12)
 old=next(o for o in b.root().occurrences if o.component.name=='11 Rear light guide keeper');assert old.deleteMe();m.create_keeper()
 hw=b.comp('REF Guide keeper hardware');nut=next(q for q in hw.bRepBodies if q.name.startswith('M3 nut envelope'))
 mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,.05);inp=hw.features.moveFeatures.createInput2(b.oc([nut]));inp.defineAsFreeMove(mat);hw.features.moveFeatures.add(inp)
 b.paint(rear)
 print('Keeper nut has a 2 mm structural roof and a lower slide-in entry; keeper pad bears directly on its boss.')
