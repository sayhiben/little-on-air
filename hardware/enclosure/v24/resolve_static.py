import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('static24',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 # Keep original screw bearing planes and nut engagement while thickening the frame elsewhere.
 for x in (35,103):b.cutbox(yoke,'Original standoff underside seat',x-4.45,33.55,11.4,8.9,8.9,1.05)
 b.cutbox(rear,'XIAO frame allows thicker yoke rail',108.05,34.95,11.6,2.5,23.05,1.5)
 b.cutbox(rear,'Exact captive flange corner clearance',115.98,53.65,9.45,.02,4.7,7.55)
 b.cutbox(yoke,'Reset crossbar PCB clearance',110.5,51.65,11.3,1.55,2.7,.8)
 b.cutbox(yoke,'Reset stop clear of adjacent components',113.6,51.7,12.05,1.35,.4,4.5)
 for c in (rear,yoke):b.paint(c)
 m.finish('Clear original bearing seats and measured XIAO envelope')
