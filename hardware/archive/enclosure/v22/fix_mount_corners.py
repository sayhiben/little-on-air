import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('corner_build',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 c=b.comp('05 Rear electronics housing')
 for x in (34.05,46.55):b.box(c,'SPDT cheek-to-stop continuous corner',x,50.9,19.8,1.4,.6,11.9)
 b.union(c);m.finish('SPDT nonmanifold edge contacts replaced by continuous corners')
 for file in ['export_native.py','make_fit_sections.py']:
  p=Path(__file__).with_name(file);s=importlib.util.spec_from_file_location('final_'+p.stem,str(p));v=importlib.util.module_from_spec(s);s.loader.exec_module(v);v.run(_context)
