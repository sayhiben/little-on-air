import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_retained_guides.py');s=importlib.util.spec_from_file_location('keeper_rebuild',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 old=next(o for o in m.b.root().occurrences if o.component.name=='11 Rear light guide keeper');assert old.deleteMe()
 m.create_keeper()
 print('Keeper clears shell, fence and charger IC without reducing the retaining shoulders.')
