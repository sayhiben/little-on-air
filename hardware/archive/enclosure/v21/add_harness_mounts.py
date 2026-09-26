import adsk.core as C
import adsk.fusion as F
import importlib.util,json
from pathlib import Path
HERE=Path(__file__).resolve().parent
def run(_context:str):
 s=importlib.util.spec_from_file_location('v21',str(HERE/'build_v2.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b;c=b.comp('05 Rear electronics housing')
 # Insulating landing pads and low fences integrated into the rear floor.
 # The upper 12-13 mm stays free for wires, electrolytic and low profile boards.
 for name,x,y,w,h in [('BOOST',37,41.5,15.3,11),('SIGNAL',71,41,19.5,12.5)]:
  b.box(c,name+' insulating landing',x,y,29.5,w,h,2.2)
  for xx in (x-.9,x+w-.3):b.box(c,name+' lateral locating fence',xx,y,27.5,1.2,h,4.2)
 # Open-ended shelves accept direct-solder boards; adhesive strap crosses parts,
 # not battery or port mechanisms. Raised floor avoids a new loose carrier.
 for x,y in [(17,18),(99,20)]:
  b.box(c,'Harness strap anchor',x-3,y-3.5,22,6,7,9.7)
 b.union(c)
 for x,y in [(17,18),(99,20)]:
  m.yz(c,'Harness strap passage',x-3.1,[(y-1.5,28.5),(y+1.5,28.5),(y+1.5,25.8),(y,24.3),(y-1.5,25.8)],6.2,True)
 b.paint(c);m.finish('harness anchors and auxiliary electrical landings')
 print(json.dumps({'added':'two auxiliary lands and two integrated strap anchors'}))
