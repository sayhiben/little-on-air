import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('refine26',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke');front=b.comp('01 Front optical bezel')
 for x,y in m.FAST:b.cutcyl(front,'M3x8 closure full nut engagement',x,y,-.02,6.8,5.62)
 screws=b.comp('REF M3 screws');bs=[bb for bb in screws.bRepBodies if bb.name.startswith('Closure screw')]
 mat=C.Matrix3D.create();mat.translation=C.Vector3D.create(0,0,-.04)
 inp=screws.features.moveFeatures.createInput2(b.oc(bs));inp.defineAsFreeMove(mat);screws.features.moveFeatures.add(inp)
 # Clear PCB through restored top wall, leaving upper axial stop atY58.65.
 b.cutbox(rear,'Flipped charger PCB top seating allowance',11.95,57.35,22.95,18.1,1.3,1.5)
 # The continuous outer yoke rail is gone; replace only the reset stop bridge.
 b.box(yoke,'Reset stop broad connection on empty side aisle',113.5,52.1,9.65,2.25,5.5,2.4)
 b.box(yoke,'Retained positive .40 reset travel stop',114.4,52.1,12.05,.6,2.2,3.45)
 b.union(yoke)
 for c in (rear,yoke):b.paint(c)
 m.finish('Full common-screw engagement and independent reset stop')
