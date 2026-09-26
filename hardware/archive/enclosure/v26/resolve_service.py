import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('resolve26',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(yoke,'Remove obsolete charger roof over restored wall',25.225,57.35,9.63,1.4,2.4,10.2)
 b.cutbox(yoke,'Charger PCB clear of flipped socket roof',11.95,57.35,22.95,18.1,1.3,1.5)
 b.cutbox(yoke,'Remove obsolete XIAO outer socket roof',113.47,58.35,9.63,2.3,1.4,6.04)
 b.box(yoke,'Full-strength inboard XIAO retaining backbone',103.2,38,9.65,3.4,18,2.75)
 b.box(yoke,'Upper end crossbar connecting reset stop',103.5,55.4,9.65,12.25,1.7,1.65)
 b.union(yoke)
 b.cutcyl(yoke,'Reopen right yoke screw through broad crossbar',103,38,9.63,3.6,2)
 b.cutbox(yoke,'XIAO upper PCB front-edge running fit',108.5,36.55,11.3,1.75,21.55,18.3)
 b.cutbox(yoke,'Reset contact clearance below USB roof',110.3,54.3,13.5,5.0,3.35,2.15)
 b.cutbox(rear,'Reset flange clearance at restored corner',115.99,53.65,12.2,.11,4.7,3.55)
 b.union(yoke)
 m.finish('Service interfaces cleared and end clamps joined by broad backbone')
