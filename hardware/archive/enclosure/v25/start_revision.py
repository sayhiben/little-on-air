import adsk.core as C
import adsk.fusion as F
from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v25'
def run(_context:str):
 app=C.Application.get();doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(OUT.parent/'on-air-v24-fabrication/cad/little-on-air-v24.f3d')))
 d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
 shapes=[(o.component.name,o.component.description,[(b.name,tm.copy(b)) for b in o.component.bRepBodies]) for o in d.rootComponent.occurrences]
 params=[(p.name,p.expression,p.comment) for p in d.userParameters]
 result=app.documents.add(C.DocumentTypes.FusionDesignDocumentType);result.name='Little On Air - v2.5 third physical fit revision'
 new=F.Design.cast(app.activeProduct);new.designType=F.DesignTypes.ParametricDesignType;new.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
 for name,expr,comment in params:new.userParameters.add(name,C.ValueInput.createByString(expr),'mm',comment)
 for name,desc,bs in shapes:
  if name.startswith(('07 ','REF XIAO','REF DPDT','REF Harness')):continue
  o=new.rootComponent.occurrences.addNewComponent(C.Matrix3D.create());c=o.component;c.name=name;c.description=desc
  f=c.features.baseFeatures.add();f.name='Inherited tested v2.4 solid';f.startEdit()
  for bn,body in bs:c.bRepBodies.add(body,f)
  f.finishEdit()
  for body,(bn,_) in zip(c.bRepBodies,bs):body.name=bn
  o.isLightBulbOn=not name.startswith(('81','82'))
 doc.close(False);result.activate()
 assert new.exportManager.execute(new.exportManager.createFusionArchiveExportOptions(str(OUT/'revision-start.f3d')))
 print('Fresh native revision from the archived second fit plate')
