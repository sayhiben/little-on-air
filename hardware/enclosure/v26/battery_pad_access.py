import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('bat26',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 # BAT0 center from Seeed board:10.16mm fromUSB end,4.445fromnear long edge.
 # Open-front notch leaves the rearward13mm-deep structural spine intact.
 b.cutbox(b.comp('05 Rear electronics housing'),'Dedicated BAT plus underside solder exit',103.5,45.5,9.48,5.25,5.3,9.52)
 m.finish('XIAO BAT underside pad has its own open solder exit')
