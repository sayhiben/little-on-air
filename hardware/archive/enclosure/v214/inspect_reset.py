import adsk.core as C,adsk.fusion as F
import json
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v214'
def run(_context:str):
 app=C.Application.get();tm=F.TemporaryBRepManager.get();report=[]
 for doc in app.documents:
  if 'v2.14' not in doc.name and 'v213' not in doc.name:continue
  doc.activate();d=F.Design.cast(app.activeProduct)
  cs={o.component.name:o.component for o in d.rootComponent.occurrences}
  if '01 Front optical bezel' not in cs:continue
  front=cs['01 Front optical bezel'].bRepBodies.item(0);button=cs['07 Front guided reset button'].bRepBodies.item(0)
  q=tm.copy(front);assert tm.booleanOperation(q,tm.copy(button),F.BooleanTypes.IntersectionBooleanType)
  def bounds(z):return [[v*10 for v in p.asArray()] for p in [z.boundingBox.minPoint,z.boundingBox.maxPoint]]
  report.append({'doc':doc.name,'frame_bounds':bounds(front),'button_bounds':bounds(button),'collision_mm3':q.volume*1000,'collision_bounds':bounds(q) if q.volume>1e-8 else None})
  if 'v2.14' in doc.name:current=doc
 current.activate()
 (OUT/'reset-inspection.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
