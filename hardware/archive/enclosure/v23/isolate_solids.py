"""Preserve completed native solids in a fresh, short timeline before refinements."""
import adsk.core as C
import adsk.fusion as F
import json
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v23'

def run(_context:str):
 app=C.Application.get();old=app.activeDocument;source=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 issues=[]
 for i in range(source.timeline.count):
  e=source.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:issues.append({'name':e.name,'message':e.errorOrWarningMessage})
 shapes=[(o.component.name,o.component.description,[(b.name,tm.copy(b)) for b in o.component.bRepBodies]) for o in source.rootComponent.occurrences]
 params=[(p.name,p.expression,p.comment) for p in source.userParameters]
 report={'source_document':old.name,'source_feature_issues':issues,'source_timeline_features':source.timeline.count,'components':{n:len(bs) for n,_,bs in shapes}}
 (OUT/'isolation-source-audit.json').write_text(json.dumps(report,indent=2))
 assert not issues,issues
 doc=app.documents.add(C.DocumentTypes.FusionDesignDocumentType);doc.name='Little On Air - v2.3 measured fit final'
 d=F.Design.cast(app.activeProduct);d.designType=F.DesignTypes.ParametricDesignType;d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
 for name,expr,comment in params:d.userParameters.add(name,C.ValueInput.createByString(expr),'mm',comment)
 for name,desc,bs in shapes:
  o=d.rootComponent.occurrences.addNewComponent(C.Matrix3D.create());c=o.component;c.name=name;c.description=desc
  f=c.features.baseFeatures.add();f.name='Verified v2.3 inherited solid';f.startEdit()
  for bn,body in bs:c.bRepBodies.add(body,f)
  f.finishEdit()
  for body,(bn,_) in zip(c.bRepBodies,bs):body.name=bn
  o.isLightBulbOn=not name.startswith(('81','82','REF Harness'))
 d.rootComponent.attributes.add('LittleOnAirV23','Revision','2.3 measured fits; inherited native solids plus explicit refinement features')
 assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'measured-fit-isolated.f3d')))
 print(json.dumps({'new_document':doc.name,'timeline_features':d.timeline.count,'component_count':d.rootComponent.occurrences.count}))
