import importlib.util
from pathlib import Path

def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(Path(__file__).with_name('build_slim.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 b.cutbox(rear,'Both MODE terminal rows load without a comb',56.9,53.64,9.48,6.2,1.65,8.57)
 b.cutbox(rear,'POWER solder pins load from open front',35.9,48.25,9.48,10.2,5.1,11.02)
 b.cutbox(rear,'XIAO keeper upper rail pocket',83.25,57.35,9.48,23.5,.70,3.17)
 b.cutbox(yoke,'Keeper clears upper-left closure boss',9.9,49.55,9.63,.55,8.9,5)
 for c in (rear,yoke):b.paint(c)
 m.checkpoint('straight-loading-clearances')
