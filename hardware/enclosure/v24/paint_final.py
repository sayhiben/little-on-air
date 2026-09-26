import importlib.util
from pathlib import Path
def run(_context:str):
 p=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('paint23',str(p));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 for o in b.root().occurrences:
  c=o.component
  if c.name.startswith('REF'):
   if c.name.startswith(('REF XIAO','REF Charger')):b.paint(c,'PCB green',(24,100,63))
   elif not c.name.startswith('REF Harness'):b.paint(c,'Connector steel',(155,165,175))
  elif c.name.startswith('02'):b.paint(c,'Clear acrylic',None);c.opacity=.24
  elif c.name.startswith('07'):b.paint(c,'Control PETG',(105,110,117))
  else:b.paint(c)
  if c.name.startswith('03'):
   white=b.appearance('White PETG',(244,245,240))
   for face in c.bRepBodies.item(0).faces:
    if face.boundingBox.maxPoint.z*10 > -5.674:face.appearance=white
 m.finish('Final v2.4 appearance and hidden construction geometry')
