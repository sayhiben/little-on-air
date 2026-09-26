import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('cap23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing')
 b.cutbox(rear,'Reset cap to top-wall clearance',115.95,57.35,9.45,4.2,1.3,5.2)
 b.paint(rear);m.finish('Final reset cap shell clearance')
