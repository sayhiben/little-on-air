"""Assign fabrication appearances and label the external USB openings."""
import adsk.core as C
import adsk.fusion as F
import importlib.util
from pathlib import Path
import json

def run(_context: str):
    spec=importlib.util.spec_from_file_location("loa_builder",str(Path(__file__).with_name("build_enclosure.py")))
    b=importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
    d=b.design(); d.activateRootComponent()
    backing=b.comp("03 Black and white backing")
    front=b.depths()[2]; white=b.appearance("White PETG",(244,245,240)); black=b.appearance("Black PETG",(24,27,31))
    count=0
    for body in backing.bRepBodies:
        body.appearance=black
        for face in body.faces:
            if face.boundingBox.maxPoint.z*10 > -(front+b.param("letter_relief"))+0.001:
                face.appearance=white; count+=1
    # An explicit display opacity makes the clear part easy to inspect in Design.
    b.comp("02 Engraved acrylic").opacity=0.22
    for occurrence in b.root().occurrences:
        c=occurrence.component
        c.isOriginFolderLightBulbOn=False
        c.isConstructionFolderLightBulbOn=False
    shell=b.comp("01 Body and front frame")
    topfaces=[f for f in shell.bRepBodies.item(0).faces if abs(f.boundingBox.minPoint.y-6)<1e-6 and abs(f.boundingBox.maxPoint.y-6)<1e-6]
    face=max(topfaces,key=lambda f:f.area)
    for label,x,w in (("CHARGE",31,19),("USB",100,7)):
        sk=shell.sketches.add(face); sk.name=label+" top label"
        one=sk.modelToSketchSpace(b.p(x,60,-16.5)); two=sk.modelToSketchSpace(b.p(x+w,60,-12.5))
        lo=C.Point3D.create(min(one.x,two.x),min(one.y,two.y),0)
        hi=C.Point3D.create(max(one.x,two.x),max(one.y,two.y),0)
        inp=sk.sketchTexts.createInput3(repr(label),b.vi(2.2)); inp.fontName="Arial"; inp.textStyle=F.TextStyles.TextStyleBold
        inp.setAsMultiLine(lo,hi,C.HorizontalAlignments.CenterHorizontalAlignment,C.VerticalAlignments.MiddleVerticalAlignment,0)
        text=sk.sketchTexts.add(inp)
        normal=sk.transform.getAsCoordinateSystem()[3]
        amount=-0.25 if normal.y>0 else 0.25
        b.extrude(shell,sk,amount,label+" engraved legend",F.FeatureOperations.CutFeatureOperation,text)
    d.userParameters.add("upper_right_screw_x",b.vi(96),"mm","Layout datum: upper-right fastener moved inward to clear XIAO; regenerate to relocate")
    for prm in d.userParameters:
        if prm.name not in ("m3_hole","head_d","text_h") and "regenerate" not in prm.comment.lower():
            prm.comment=prm.comment+"; update builder and regenerate coordinated layout"
    b.finish("finished-design")
    print(json.dumps({"white_letter_faces":count,"labels":["CHARGE","USB"],"acrylic_display_opacity":0.22}))
