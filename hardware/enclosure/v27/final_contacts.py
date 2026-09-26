import importlib.util
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(Path(__file__).with_name('build_slim.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.comp('05 Rear electronics housing')
 for x,w in ((85.15,2.9),(101.05,3.0)):b.cutbox(c,'Wide upper keeper landing clearance',x,57.35,9.48,w,1.1,9.02)
 # Let the metal bracket ends remain open instead of creating fragile 0.035 mm
 # plastic fins. The 11 mm body pocket locates the switch laterally.
 b.cutbox(c,'Open POWER bracket ends without thin fins',30.89,57.65,9.48,20.22,.95,10.77)
 b.paint(c);m.checkpoint('final-mechanical-contacts')
