import importlib.util,math
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_retained_guides.py');s=importlib.util.spec_from_file_location('last_clearance',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');sk=b.sketch(rear,'Restore exact nut roof underside',20.3);r=6/math.sqrt(3)
 b.polygon(sk,[(6.5+r*math.cos(math.pi/2+i*math.pi/3),42.3+r*math.sin(math.pi/2+i*math.pi/3)) for i in range(6)]);b.extrude(rear,sk,-2.9,'Exact nut roof underside',m.F.FeatureOperations.CutFeatureOperation)
 keeper=b.comp('11 Rear light guide keeper')
 for yy in (49.4,44.65):
  b.cutcyl(keeper,'Full depth pickup clearance through thick bridge',14,yy,16.48,3.3,3.84)
  b.cutbox(keeper,'Open pickup passage through thick bridge',11.95,yy-1.65,16.48,2.05,3.3,3.84)
 b.paint(rear);b.paint(keeper)
 print('Nut roof datum and keeper pickup passages corrected.')
