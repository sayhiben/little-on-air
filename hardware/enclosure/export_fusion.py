"""Native Fusion archive, STEP, meshes and shared laser artwork exports."""
import adsk.core as C
import adsk.fusion as F
import json
import math
import re
from pathlib import Path

OUT=Path(__file__).resolve().parent/"output"

def collection(items):
    result=C.ObjectCollection.create()
    for item in items: result.add(item)
    return result

def stitch(segments):
    remaining=list(segments); loops=[]
    def near(a,b): return math.hypot(a[0]-b[0],a[1]-b[1])<0.003
    while remaining:
        pts=remaining.pop(0)
        while not near(pts[-1],pts[0]):
            hit=None
            for i,part in enumerate(remaining):
                if near(pts[-1],part[0]): hit=(i,part); break
                if near(pts[-1],part[-1]): hit=(i,list(reversed(part))); break
            if hit is None: raise RuntimeError("Text contour is not closed")
            i,part=hit; remaining.pop(i); pts.extend(part[1:])
        loops.append(pts[:-1])
    return loops

def write_artwork(loops, outline, mirror=False):
    # Sheet-local coordinates: 104 x 38 mm. Mirroring includes the registration key.
    def xy(pt):
        x,y=pt[0]-8,pt[1]-11
        return (104-x if mirror else x,y)
    paths=[[(round(xy(pt)[0],5),round(xy(pt)[1],5)) for pt in loop] for loop in loops]
    cut=[xy(pt) for pt in outline]
    name="acrylic-rear-face" if mirror else "on-air-front-master"
    dxf=["0","SECTION","2","HEADER","9","$INSUNITS","70","4","0","ENDSEC",
         "0","SECTION","2","TABLES","0","TABLE","2","LAYER","70","2",
         "0","LAYER","2","CUT","70","0","62","1","6","CONTINUOUS",
         "0","LAYER","2","ENGRAVE","70","0","62","5","6","CONTINUOUS",
         "0","ENDTAB","0","ENDSEC","0","SECTION","2","ENTITIES"]
    for layer,contours in (("CUT",[cut]),("ENGRAVE",paths)):
        for contour in contours:
            dxf.extend(["0","POLYLINE","8",layer,"66","1","70","1"])
            for x,y in contour: dxf.extend(["0","VERTEX","8",layer,"10",f"{x:.5f}","20",f"{y:.5f}","30","0"])
            dxf.extend(["0","SEQEND"])
    dxf.extend(["0","ENDSEC","0","EOF"])
    (OUT/"laser"/(name+".dxf")).write_text("\n".join(dxf)+"\n")
    def svgpath(contours):
        return " ".join("M "+" L ".join(f"{x:.5f} {38-y:.5f}" for x,y in contour)+" Z" for contour in contours)
    svg=(f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" width="104mm" height="38mm" viewBox="0 0 104 38">'
         f'<title>{name}: millimetres; cut red outline and fill-engrave blue text</title>'
         f'<g id="CUT"><path d="{svgpath([cut])}" fill="none" stroke="#ff0000" stroke-width="0.02"/></g>'
         f'<g id="ENGRAVE"><path d="{svgpath(paths)}" fill="#0000ff" fill-rule="evenodd" stroke="none"/></g></svg>')
    (OUT/"laser"/(name+".svg")).write_text(svg)

def run(_context: str):
    app=C.Application.get(); d=F.Design.cast(app.activeProduct); root=d.rootComponent; ex=d.exportManager
    (OUT/"meshes-assembly-coordinates").mkdir(parents=True,exist_ok=True)
    (OUT/"laser").mkdir(parents=True,exist_ok=True)
    manifest=[]
    for occurrence in root.occurrences:
        c=occurrence.component
        if c.name.startswith("REF"): continue
        slug=re.sub(r"[^a-z0-9]+","-",c.name.lower()).strip("-")
        if not c.name.startswith("02"):
            stl=ex.createSTLExportOptions(c,str(OUT/"meshes-assembly-coordinates"/(slug+".stl")))
            stl.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh
            stl.unitType=F.DistanceUnits.MillimeterDistanceUnits
            stl.sendToPrintUtility=False
            if not ex.execute(stl): raise RuntimeError("STL failed: "+c.name)
            mf=ex.createC3MFExportOptions(c,str(OUT/"meshes-assembly-coordinates"/(slug+".3mf")))
            mf.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh
            mf.sendToPrintUtility=False
            if not ex.execute(mf): raise RuntimeError("3MF failed: "+c.name)
        manifest.append({"component":c.name,"slug":slug,"bodies":c.bRepBodies.count})
        if c.name.startswith("03"):
            sk=next(s for s in c.sketches if s.name=="ON AIR shared lettering")
            txt=sk.sketchTexts.item(0)
            segments=[]
            for curve in txt.asCurves():
                ev=curve.evaluator
                ok,lo,hi=ev.getParameterExtents()
                if not ok: raise RuntimeError("Cannot evaluate letter curve")
                ok,pts=ev.getStrokes(lo,hi,0.001)
                if not ok: raise RuntimeError("Cannot stroke letter curve")
                segments.append([[q.x*10,q.y*10] for q in pts])
            loops=stitch(segments)
            outline=[[8,11],[112,11],[112,49],[11,49],[8,46]]
            (OUT/"laser"/"master-contours.json").write_text(json.dumps({"units":"mm","chord_tolerance_mm":0.01,"loops":loops,"outline":outline},indent=2))
            write_artwork(loops,outline,False); write_artwork(loops,outline,True)
    if not ex.execute(ex.createSTEPExportOptions(str(OUT/"little-on-air-assembly.step"))): raise RuntimeError("STEP export failed")
    if not ex.execute(ex.createFusionArchiveExportOptions(str(OUT/"little-on-air-enclosure.f3d"))): raise RuntimeError("Fusion archive export failed")
    (OUT/"parts-manifest.json").write_text(json.dumps(manifest,indent=2))
    print(json.dumps({"exported_components":len(manifest),"output":str(OUT)},indent=2))
