from pathlib import Path
import adsk.core as C
import adsk.fusion as F
import json
def run(_context:str):
 app=C.Application.get();original=app.activeDocument;d=F.Design.cast(app.activeProduct);out=Path(__file__).resolve().parents[1]/'output/v27'
 def sig(d):return {o.component.name:[round(q.volume*1000,5) for q in o.component.bRepBodies] for o in d.rootComponent.occurrences}
 before=sig(d)
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(out/'little-on-air-v27.f3d')))
 try:
  clone=F.Design.cast(app.activeProduct);assert sig(clone)==before
  refs=C.ObjectCollection.create()
  for o in clone.rootComponent.occurrences:
   if o.component.name.startswith(('81','82')):continue
   for q in o.component.bRepBodies:refs.add(q.createForAssemblyContext(o))
  inp=clone.createInterferenceInput(refs);inp.areCoincidentFacesIncluded=False
  bad=[{'one':i.entityOne.parentComponent.name,'two':i.entityTwo.parentComponent.name,'volume_mm3':i.interferenceBody.volume*1000} for i in clone.analyzeInterference(inp) if i.interferenceBody and i.interferenceBody.volume*1000>.001]
  report={'passed':not bad,'volume_signatures_match':True,'interferences':bad,'archive':'little-on-air-v27.f3d'}
  (out/'archive-roundtrip-validation.json').write_text(json.dumps(report,indent=2));assert not bad,bad
 finally:doc.close(False);original.activate()
 print('Saved Fusion archive reopens with matching volumes and no static overlaps')
