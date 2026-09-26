"""Assembly-open ports, closed by the retaining yoke; all caps print from its bed face."""
import importlib.util
from pathlib import Path
def apply(m):
 b=m.b
 rear=b.comp('05 Rear electronics housing');front=b.comp('01 Front optical bezel');yoke=b.comp('06 Electronics retaining yoke')
 for name,x,w,depth in [('Charger',14.8,13.4,20.51),('XIAO',110.4,7.1,18.01),('Slider',55.25,9.5,21.11)]:
  b.cutbox(rear,name+' straight assembly notch',x,57.0 if name=='XIAO' else 57.4,9.48,w,3.2 if name=='XIAO' else 2.8,depth-9.48)
  b.cutbox(front,name+' yoke cap seam clearance',x,57.4,9.15,w,2.8,.5)
 b.cutbox(rear,'Reset front insertion notch',116.1,52.55,9.48,4.1,4.3,4.53)
 b.cutbox(front,'Reset cap seam clearance',116.1,52.55,9.15,4.1,4.3,.5)
 b.cutbox(rear,'DPDT seat to slider clearance',55.44,52.15,23.09,9.12,.31,8.62)
 # Arms terminate inside the open housing; cap edges have .25 mm clearance.
 for x in (13.1,26.9):b.box(yoke,'Charger port cap arm',x,52,9.4,2,5.4,2)
 b.box(yoke,'Charger port roof',15.05,57.15,9.4,12.9,2.6,8.85)
 b.box(yoke,'XIAO port cap arm',108.5,49,9.4,2.3,8.4,2)
 b.box(yoke,'XIAO port roof',110.65,57.15,9.4,6.6,2.6,6.85)
 for x in (55.5,63.1):b.box(yoke,'Slider cap arm',x,51,9.4,1.4,6.4,2)
 b.box(yoke,'Slider guide roof',55.5,57.15,9.4,9,2.6,8.85)
 b.box(yoke,'Reset cap arm',114.7,50.8,9.4,1.7,6.1,2)
 b.box(yoke,'Reset guide roof',116.2,52.8,9.4,3.55,3.8,4.3)
 reinforce(m)
 b.union(yoke);final_clearances(m);b.paint(yoke);m.finish('assembly-open ports and yoke caps')
def reinforce(m):
 b=m.b;c=b.comp('06 Electronics retaining yoke')
 for name,x,w in [('Charger',13.1,15.8),('XIAO',108.5,8.75),('Slider',55.5,9)]:b.box(c,name+' broad port cap root',x,55.5,9.4,w,1.9,2)
 b.box(c,'Reset broad cap root',114.7,52.8,9.4,2.3,3.8,2)
def final_clearances(m):
 b=m.b;yoke=b.comp('06 Electronics retaining yoke');rear=b.comp('05 Rear electronics housing')
 b.cutcyl(yoke,'Upper optical screw service clearance',60,54,9.38,6.4,2.04)
 b.cutbox(yoke,'Charger cable overmold clearance',15.04,57.14,17.75,12.92,2.62,.51)
 b.cutbox(yoke,'XIAO cable overmold clearance',110.64,57.14,15.2,6.62,2.62,1.06)
 b.cutbox(rear,'XIAO cable overmold rear clearance',110.4,57.4,27.99,7.1,2.8,1.51)
def run(_context:str):
 path=Path(__file__).resolve().with_name('build_v2.py');s=importlib.util.spec_from_file_location('v2',str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);apply(m)
