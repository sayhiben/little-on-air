import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).resolve().with_name('build_v2.py');s=importlib.util.spec_from_file_location('v21',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.comp('05 Rear electronics housing')
 b.cutbox(c,'XIAO underside battery and GPIO solder access',108.8,36.8,11.38,2.15,17.7,17.72)
 b.paint(c);m.finish('open XIAO solder access; no unsupported window roof')
