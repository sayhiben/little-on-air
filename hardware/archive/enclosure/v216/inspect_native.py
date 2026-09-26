import adsk.core as C, adsk.fusion as F
import json
from pathlib import Path
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v216'
def run(_context:str):
 app=C.Application.get()
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(BASE.parents[1]/'release/little-on-air-enclosure-v2.15/cad/little-on-air-v215.f3d')))
 doc.name='Little ON AIR v2.16 - deeper wire route study'
 d=F.Design.cast(app.activeProduct); data=[]
 for o in d.rootComponent.occurrences:
  for i,q in enumerate(o.component.bRepBodies):
   bb=q.boundingBox
   data.append({'component':o.component.name,'body':q.name,'index':i,'min':[v*10 for v in bb.minPoint.asArray()],'max':[v*10 for v in bb.maxPoint.asArray()],'volume':q.volume*1000})
 (OUT/'assembly-bodies.json').write_text(json.dumps(data,indent=2))
 print(json.dumps(data,indent=2))
