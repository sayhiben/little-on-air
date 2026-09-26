import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
def run(_context:str):
 app=C.Application.get();current=app.activeDocument
 source=next(doc for doc in app.documents if doc.name=='Little On Air - Enclosure v2.3 - measured fits')
 source.activate();old=F.Design.cast(app.activeProduct)
 names={o.component.name:[b.name for b in o.component.bRepBodies] for o in old.rootComponent.occurrences}
 current.activate();d=F.Design.cast(app.activeProduct)
 for o in d.rootComponent.occurrences:
  if o.component.name.startswith('REF'):
   for body,name in zip(o.component.bRepBodies,names[o.component.name]):body.name=name
 p=Path(__file__).with_name('refine_measured_ports.py');text=p.read_text()
 tail=text[text.index(' # Replace only the USB reference solids.'):]
 builder=Path(__file__).with_name('build_v2.py');s=importlib.util.spec_from_file_location('ref23',str(builder));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 rear=b.comp('05 Rear electronics housing');yoke=b.comp('06 Electronics retaining yoke')
 exec('def finish():\n'+tail,globals(),namespace:={'b':b,'m':m,'rear':rear,'yoke':yoke})
 namespace['finish'].__globals__.update(namespace);namespace['finish']()
 issues=[]
 for i in range(d.timeline.count):
  e=d.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append(e)
 for e in issues:
  assert 'No target body' in e.errorOrWarningMessage,(e.name,e.errorOrWarningMessage)
  e.deleteMe()
 print('Removed redundant empty cuts:',len(issues))
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(m.OUT/'measured-port-refinement.f3d')))
