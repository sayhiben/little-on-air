import adsk.core as C,adsk.fusion as F,json
def run(_context:str):
 app=C.Application.get();d=F.Design.cast(app.activeProduct);c=next(o.component for o in d.rootComponent.occurrences if o.component.name=='01 Front optical bezel')
 def bb(q):return [list(p.asArray()) for p in [q.boundingBox.minPoint,q.boundingBox.maxPoint]]
 out={'document':app.activeDocument.name,'bodies':[{'name':q.name,'volume_mm3':q.volume*1000,'bounds_cm':bb(q)} for q in c.bRepBodies],'last_extrudes':[{'name':f.name,'health':int(f.healthState)} for f in list(c.features.extrudeFeatures)[-14:]]}
 print(json.dumps(out,indent=2))
