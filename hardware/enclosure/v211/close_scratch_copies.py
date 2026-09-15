"""Close only this revision's unexported intermediate archive imports."""
import adsk.core as C
import json
def run(_context:str):
 app=C.Application.get();keep=app.activeDocument
 assert keep.name=='Little ON AIR v2.11 - clean top seam'
 copies=[d for d in app.documents if d.name==keep.name and d!=keep]
 for d in copies:assert d.close(False)
 keep.activate()
 print(json.dumps({'closed_intermediate_imports':len(copies),'active':keep.name}))
