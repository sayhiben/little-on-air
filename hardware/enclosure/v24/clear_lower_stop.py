import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('stop24',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.comp('05 Rear electronics housing');b.cutbox(c,'Yoke lower stop relief with 0.25 to 0.30 mm allowance',110,34,12.75,.55,2.8,1.95);b.paint(c);m.finish('Lower stop clearance complete')
