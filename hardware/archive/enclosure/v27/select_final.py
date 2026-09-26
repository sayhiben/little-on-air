import adsk.core as C
import adsk.fusion as F
from pathlib import Path
def run(_context:str):
 app=C.Application.get();out=Path(__file__).resolve().parents[1]/'output/v27'
 doc=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(out/'common-hardware.f3d')))
 doc.name='Little ON AIR v2.7 - 24 mm final revision'
 for other in list(app.documents):
  if other!=doc and other.name=='Little ON AIR - v2.7 parallel PCBs and slim case':other.close(False)
 doc.activate();print(doc.name)
