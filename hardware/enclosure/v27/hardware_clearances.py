import importlib.util
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(Path(__file__).with_name('build_slim.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 yoke=b.comp('06 Electronics retaining yoke');rear=b.comp('05 Rear electronics housing')
 b.cutcyl(yoke,'Optical head running pocket with thick roof',60,54,9.63,6.4,1.5)
 m.m.hexcut(rear,'Keeper nut clears later charger fence',35,38,13.8,3,6)
 for c in (rear,yoke):b.paint(c)
 m.checkpoint('final-hardware-clearances')
