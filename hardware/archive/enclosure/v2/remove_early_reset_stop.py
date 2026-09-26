import importlib.util
from pathlib import Path
def run(_context:str):
 path=Path(__file__).resolve().with_name('build_v2.py')
 s=importlib.util.spec_from_file_location('v2',str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 c=m.b.comp('05 Rear electronics housing')
 m.b.cutbox(c,'Open reset insertion path - stop moved to yoke',114.19,50.59,15.64,2,2.62,5.37)
 m.finish('rear reset insertion revision')
