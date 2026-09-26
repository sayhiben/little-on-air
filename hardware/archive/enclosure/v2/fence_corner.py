import importlib.util
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('v2',str(Path(__file__).with_name('build_v2.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 c=m.b.comp('05 Rear electronics housing');m.b.box(c,'Battery fence corner union',32.4,32.9,27.1,1.7,1.7,4.6);m.b.union(c);m.b.paint(c);m.finish('watertight battery fence corner')
