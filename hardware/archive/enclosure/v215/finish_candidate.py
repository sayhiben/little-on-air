"""Set roof removals exactly to the original mating plane, then validate/export."""
import adsk.core as C,adsk.fusion as F,importlib.util
from pathlib import Path
BASE=Path(__file__).resolve().parents[1]
s=importlib.util.spec_from_file_location('finish215',BASE/'v215/open_channels.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
def run(_context:str):
 app=C.Application.get();current=app.activeDocument;assert 'v2.15' in current.name
 tm=F.TemporaryBRepManager.get()
 baseline=next(doc for doc in app.documents if 'v2.14' in doc.name)
 baseline.activate();old=tm.copy(m.b.comp('01 Front optical bezel').bRepBodies.item(0))
 before={o.component.name:[m.fingerprint(q) for q in o.component.bRepBodies] for o in m.b.root().occurrences if o.component.name!='01 Front optical bezel'}
 current.activate();c=m.b.comp('01 Front optical bezel')
 for f in c.features.extrudeFeatures:
  if not f.name.startswith(('Remove continuous cable channel roof','Open LED wiring access from rear','Open side cable access from rear')):continue
  extent=F.DistanceExtentDefinition.cast(f.extentOne);assert extent is not None
  extent.distance.expression='-1.4 mm' if extent.distance.value<0 else '1.4 mm'
 m.validate_export(current,old,before)
