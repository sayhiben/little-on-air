import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('restore_build',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.comp('06 Electronics retaining yoke')
 b.box(c,'SPDT roof ramp reinforcing web',37.4,53,11.3,7.2,4.4,3.5);b.union(c)
 m.yz(c,'SPDT 45-degree printable roof and tongue clearance',37.2,[(53.95,0),(60.1,0),(60.1,12.75),(57.3,12.75),(53.95,9.4)],7.6,True)
 m.finish('Final printable roof restored; production previews isolated')
 for name in ['export_native.py','make_fit_sections.py']:
  p=Path(__file__).with_name(name);s=importlib.util.spec_from_file_location('restore_'+p.stem,str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.run(_context)
