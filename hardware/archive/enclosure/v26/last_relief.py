import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('last26',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 b.cutbox(b.comp('06 Electronics retaining yoke'),'Reset insertion roof relief full connector depth',110.3,54.3,13.5,5,3.35,2.3)
 m.finish('Reset insertion no longer brushes USB roof')
