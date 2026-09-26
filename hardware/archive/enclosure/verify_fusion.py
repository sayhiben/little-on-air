"""Read-only native solid, feature-health and interference inspection."""
import adsk.core as C
import adsk.fusion as F
import json
from pathlib import Path

OUT=Path(__file__).resolve().parent/"output"

def run(_context: str):
    app=C.Application.get(); design=F.Design.cast(app.activeProduct); root=design.rootComponent
    report={"document":app.activeDocument.name,"units":"mm","components":[],"feature_issues":[],"interferences":[]}
    bodies=C.ObjectCollection.create()
    for occurrence in root.occurrences:
        c=occurrence.component
        entry={"name":c.name,"reference":c.name.startswith("REF"),"body_count":c.bRepBodies.count,"bodies":[]}
        for body in c.bRepBodies:
            bb=body.boundingBox
            entry["bodies"].append({"name":body.name,"solid":body.isSolid,"volume_mm3":round(body.volume*1000,4),
                "min_mm":[round(v*10,5) for v in bb.minPoint.asArray()],"max_mm":[round(v*10,5) for v in bb.maxPoint.asArray()]})
            bodies.add(body.createForAssemblyContext(occurrence))
        report["components"].append(entry)
    for i in range(design.timeline.count):
        obj=design.timeline.item(i).entity
        if hasattr(obj,"healthState") and obj.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:
            report["feature_issues"].append({"index":i,"name":getattr(obj,"name",obj.objectType),"state":obj.healthState,"message":getattr(obj,"errorOrWarningMessage","")})
    inp=design.createInterferenceInput(bodies); inp.areCoincidentFacesIncluded=False
    result=design.analyzeInterference(inp)
    for inter in result:
        one=inter.entityOne; two=inter.entityTwo
        vol=inter.interferenceBody.volume*1000 if inter.interferenceBody else None
        if vol is not None and vol<0.001: continue
        bb=inter.interferenceBody.boundingBox if inter.interferenceBody else None
        report["interferences"].append({"one":one.parentComponent.name+" / "+one.name,
            "two":two.parentComponent.name+" / "+two.name,"volume_mm3":round(vol,5) if vol else vol,
            "min_mm":[round(v*10,4) for v in bb.minPoint.asArray()] if bb else None,
            "max_mm":[round(v*10,4) for v in bb.maxPoint.asArray()] if bb else None})
    report["timeline_features"]=design.timeline.count
    identity=C.Matrix3D.create().asArray()
    report["all_occurrences_at_assembly_origin"]=all(
        all(abs(a-b)<1e-9 for a,b in zip(o.transform2.asArray(),identity)) for o in root.occurrences)
    report["visual_style"]=app.activeViewport.visualStyle
    report["parameters"]=[{"name":v.name,"expression":v.expression,"comment":v.comment} for v in design.userParameters]
    OUT.mkdir(parents=True,exist_ok=True)
    (OUT/"fusion-verification.json").write_text(json.dumps(report,indent=2))
    print(json.dumps({"component_count":len(report["components"]),"body_counts":{c["name"]:c["body_count"] for c in report["components"]},
                      "feature_issues":report["feature_issues"],"interferences":report["interferences"]},indent=2))
