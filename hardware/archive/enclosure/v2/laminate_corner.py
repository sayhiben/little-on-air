import importlib.util
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('v2',str(Path(__file__).with_name('build_v2.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 a,ar,bf,br,rf,rb=m.dims()
 for prefix,d,t in [('81',ar,.5),('82',br-.4,.4)]:
  c=next(o.component for o in m.b.root().occurrences if o.component.name.startswith(prefix));sk=m.b.sketch(c,'Inset keyed corner',d)
  m.b.polygon(sk,[(9.5,47.5),(11.62132,47.5),(9.5,45.37868)]);m.b.extrude(c,sk,-t,'Full-width keyed corner');m.b.union(c);m.b.paint(c)
 m.finish('optional laminate keyed corner')
