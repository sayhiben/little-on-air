"""Reproducible native Fusion enclosure. All input lengths are millimetres.

Run stages through fusion_client.py. Front is XY at Z=0; depth goes toward -Z.
Manufacturing allowances and unmeasured component dimensions are explicit below.
"""
import adsk.core as C
import adsk.fusion as F
import json
import math
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "output"
TITLE = "Little On Air - Enclosure v1"
PARAMS = {
    "case_w": (120, "Overall width"), "case_h": (60, "Overall height"),
    "case_d": (30, "Overall depth; excludes adhesive strips"),
    "wall": (2.4, "PETG wall thickness"), "front_lip": (1.6, "Front retaining lip"),
    "window_w": (100, "Visible opening width"), "window_h": (34, "Visible opening height"),
    "panel_w": (104, "Keyed optical panel width"), "panel_h": (38, "Keyed optical panel height"),
    "acrylic_t": (3.175, "MEASURE: actual sheet thickness"),
    "air_gap": (0.5, "Clearance from engraving to raised white letters"),
    "backing_base": (1.6, "Black backing base thickness"), "letter_relief": (0.4, "White final two 0.2 mm layers"),
    "tray_t": (1.6, "Optical support and electronics tray base"),
    "fit": (0.25, "Sliding fit allowance per side; verify with coupon"),
    "led_w": (8, "MEASURE: individual LED PCB width"), "led_h": (8, "MEASURE: individual LED PCB length"),
    "led_t": (2, "MEASURE: LED assembly depth"), "led_face_gap": (0.2, "Emitter to acrylic edge gap"),
    "led_optical_offset": (1, "MEASURE: emitter centre from frontmost module surface"),
    "battery_w": (52, "Supplied battery width"), "battery_h": (21, "Supplied battery height"), "battery_t": (10, "Supplied battery thickness"),
    "charger_w": (16.5, "Listed board width; confirm physical board"), "charger_h": (25, "Listed board length; confirm physical board"),
    "charger_pcb_t": (1, "MEASURE: charging PCB thickness"), "charger_component_t": (4.5, "RESERVED: component-side envelope"),
    "xiao_length": (21, "Seeed PCB length along case height"), "xiao_width": (17.8, "Seeed PCB width along case depth"),
    "xiao_pcb_t": (1, "MEASURE: XIAO PCB thickness"),
    "reset_y": (54.7, "MEASURE: reset centre height in installed orientation"),
    "reset_depth": (12.3, "MEASURE: reset centre depth in installed orientation"),
    "reset_tip_x": (114.1, "MEASURE: resting contact tip; tune using coupon"),
    "reset_stroke": (0.5, "PROVISIONAL: total plunger travel including free play"),
    "switch_w": (8.6, "DPDT body length"), "switch_h": (3.1, "DPDT body width"), "switch_t": (2.7, "DPDT body depth"),
    "switch_throw": (2, "MEASURE: lateral DPDT throw; 1.4 mm is actuator height"),
    "m3_hole": (3.4, "M3 clearance diameter"), "head_d": (6.4, "Socket head pocket diameter"),
    "head_depth": (3.2, "Screw head pocket depth"), "nut_af": (5.8, "M3 hex pocket across flats"),
    "text_h": (18, "Native Fusion text height; same master for both optical layers"),
}

def app(): return C.Application.get()
def design(): return F.Design.cast(app().activeProduct)
def root(): return design().rootComponent
def mm(v):
    if isinstance(v, str): return design().unitsManager.evaluateExpression(v, "mm") * 10
    return float(v)
def vi(v): return C.ValueInput.createByString(v if isinstance(v, str) else f"{v:.7f} mm")
def p(x=0,y=0,z=0): return C.Point3D.create(mm(x)/10,mm(y)/10,mm(z)/10)
def oc(items):
    result=C.ObjectCollection.create()
    for item in items: result.add(item)
    return result
def param(name): return design().userParameters.itemByName(name).value*10
def depths():
    a=param("front_lip"); b=a+param("acrylic_t"); c=b+param("air_gap")
    d=c+param("letter_relief")+param("backing_base")
    return a,b,c,d,d+param("tray_t")
def component(name, desc=""):
    occurrence=root().occurrences.addNewComponent(C.Matrix3D.create())
    occurrence.component.name=name
    occurrence.component.description=desc
    return occurrence.component
def comp(name):
    for occurrence in root().occurrences:
        if occurrence.component.name==name: return occurrence.component
    raise ValueError("Component not found: "+name)
def appearance(name, color=None):
    existing=design().appearances.itemByName(name)
    if existing: return existing
    lib=app().materialLibraries.itemByName("Fusion Appearance Library")
    source=lib.appearances.itemByName("Acrylic (Clear)" if name=="Clear acrylic" else "ABS (White)")
    result=design().appearances.addByCopy(source,name)
    if color:
        prop=result.appearanceProperties.itemById("opaque_albedo")
        if prop and prop.objectType==C.ColorProperty.classType(): prop.value=C.Color.create(*color,255)
    return result
def paint(c,name="Black PETG",color=(24,27,31)):
    a=appearance(name,color)
    for body in c.bRepBodies: body.appearance=a
def plane(c,depth,axis="z"):
    base={"z":c.xYConstructionPlane,"x":c.yZConstructionPlane,"y":c.xZConstructionPlane}[axis]
    if abs(mm(depth))<1e-8: return base
    inp=c.constructionPlanes.createInput()
    inp.setByOffset(base,vi(depth))
    result=c.constructionPlanes.add(inp)
    result.isLightBulbOn=False
    return result
def sketch(c,name,depth=0,axis="z"):
    sk=c.sketches.add(plane(c,-mm(depth) if axis=="z" else depth,axis))
    sk.name=name
    return sk
def rect(sk,x,y,w,h):
    x,y=mm(x),mm(y)
    lines=sk.sketchCurves.sketchLines.addTwoPointRectangle(p(x,y),p(x+mm(w),y+mm(h)))
    # One fixed corner and driving width/height; offsets remain directly editable.
    if x or y: lines.item(0).startSketchPoint.isFixed=True
    hd=sk.sketchDimensions.addDistanceDimension(lines.item(0).startSketchPoint,lines.item(0).endSketchPoint,
        F.DimensionOrientations.HorizontalDimensionOrientation,p(x+mm(w)/2,y-1))
    hd.parameter.expression=w if isinstance(w,str) else f"{mm(w)} mm"
    vd=sk.sketchDimensions.addDistanceDimension(lines.item(1).startSketchPoint,lines.item(1).endSketchPoint,
        F.DimensionOrientations.VerticalDimensionOrientation,p(x+mm(w)+1,y+mm(h)/2))
    vd.parameter.expression=h if isinstance(h,str) else f"{mm(h)} mm"
    return lines
def polygon(sk,points):
    for i,a in enumerate(points):
        line=sk.sketchCurves.sketchLines.addByTwoPoints(p(*a),p(*points[(i+1)%len(points)]))
        line.isFixed=True
def rounded(sk,x,y,w,h,r):
    x,y,w,h,r=map(mm,(x,y,w,h,r))
    lines=[((x+r,y),(x+w-r,y)),((x+w,y+r),(x+w,y+h-r)),((x+w-r,y+h),(x+r,y+h)),((x,y+h-r),(x,y+r))]
    for a,b in lines: sk.sketchCurves.sketchLines.addByTwoPoints(p(*a),p(*b))
    for center,start in [((x+w-r,y+r),(x+w-r,y)),((x+w-r,y+h-r),(x+w,y+h-r)),((x+r,y+h-r),(x+r,y+h)),((x+r,y+r),(x,y+r))]:
        sk.sketchCurves.sketchArcs.addByCenterStartSweep(p(*center),p(*start),math.pi/2)
def extrude(c,sk,amount,name,operation=F.FeatureOperations.NewBodyFeatureOperation,profile=None):
    profile=profile or (sk.profiles.item(0) if sk.profiles.count==1 else oc(list(sk.profiles)))
    inp=c.features.extrudeFeatures.createInput(profile,operation)
    inp.setDistanceExtent(False,vi(amount))
    if operation in (F.FeatureOperations.CutFeatureOperation,F.FeatureOperations.IntersectFeatureOperation):
        inp.participantBodies=list(c.bRepBodies)
    result=c.features.extrudeFeatures.add(inp)
    result.name=name
    if operation==F.FeatureOperations.NewBodyFeatureOperation:
        for body in result.bodies: body.name=name
    sk.isVisible=False
    return result
def box(c,name,x,y,d,w,h,t,op=F.FeatureOperations.NewBodyFeatureOperation):
    sk=sketch(c,name+" profile",d); rect(sk,x,y,w,h)
    return extrude(c,sk,-mm(t),name,op)
def rbox(c,name,x,y,d,w,h,t,r,op=F.FeatureOperations.NewBodyFeatureOperation):
    sk=sketch(c,name+" profile",d); rounded(sk,x,y,w,h,r)
    return extrude(c,sk,-mm(t),name,op)
def cyl(c,name,x,y,d,diam,t,op=F.FeatureOperations.NewBodyFeatureOperation):
    sk=sketch(c,name+" profile",d)
    circle=sk.sketchCurves.sketchCircles.addByCenterRadius(p(x,y),mm(diam)/20)
    sk.sketchDimensions.addDiameterDimension(circle,p(x+mm(diam),y)).parameter.expression=diam if isinstance(diam,str) else f"{diam} mm"
    return extrude(c,sk,-mm(t),name,op)
def union(c,name="Union manufactured solid"):
    bodies=list(c.bRepBodies)
    if len(bodies)<2: return
    inp=c.features.combineFeatures.createInput(bodies[0],oc(bodies[1:]))
    inp.operation=F.FeatureOperations.JoinFeatureOperation
    result=c.features.combineFeatures.add(inp); result.name=name
def cutbox(c,name,x,y,d,w,h,t): return box(c,name,x,y,d,w,h,t,F.FeatureOperations.CutFeatureOperation)
def cutcyl(c,name,x,y,d,diam,t): return cyl(c,name,x,y,d,diam,t,F.FeatureOperations.CutFeatureOperation)
def keyed(sk,inset=0):
    x=(param("case_w")-param("panel_w"))/2-inset
    y=(param("case_h")-param("panel_h"))/2-inset
    w=param("panel_w")+2*inset; h=param("panel_h")+2*inset
    polygon(sk,[(x,y),(x+w,y),(x+w,y+h),(x+3,y+h),(x,y+h-3)])
def text_sketch(c,name,depth,mirror=False):
    sk=sketch(c,name,depth)
    ti=sk.sketchTexts.createInput3("'ON AIR'",vi("text_h"))
    ti.fontName="Arial"; ti.textStyle=F.TextStyles.TextStyleBold
    ti.isHorizontalFlip=mirror
    ti.setAsMultiLine(p(10,13),p(110,47),C.HorizontalAlignments.CenterHorizontalAlignment,C.VerticalAlignments.MiddleVerticalAlignment,0)
    txt=sk.sketchTexts.add(ti)
    return sk,txt
def finish(stage):
    for occurrence in root().allOccurrences:
        for sk in occurrence.component.sketches: sk.isVisible=False
        occurrence.component.isConstructionFolderLightBulbOn=False
    root().isOriginFolderLightBulbOn=False
    app().activeViewport.fit()
    OUT.mkdir(parents=True,exist_ok=True)
    (OUT/"progress.json").write_text(json.dumps({"stage":stage,"components":root().occurrences.count,"timeline":design().timeline.count},indent=2))
    print(json.dumps({"stage":stage,"components":root().occurrences.count,"timeline":design().timeline.count}))

def setup():
    if design() and root().attributes.itemByName("LittleOnAir","Status"):
        app().activeDocument.name=TITLE+" - superseded fit study"
    doc=app().activeDocument if app().activeDocument.name==TITLE and root().occurrences.count==0 else app().documents.add(C.DocumentTypes.FusionDesignDocumentType)
    doc.name=TITLE
    d=design(); d.designType=F.DesignTypes.ParametricDesignType
    d.unitsManager.distanceDisplayUnits=F.DistanceUnits.MillimeterDistanceUnits
    for name,(value,comment) in PARAMS.items(): d.userParameters.add(name,vi(value),"mm",comment)
    root().attributes.add("LittleOnAir","Status","Prototype: verify physical component envelopes before manufacture")
    finish("setup")

def shell():
    c=component("01 Body and front frame","Front-facing XY plane; rear assembly access; PETG")
    rbox(c,"Rounded outer shell",0,0,0,120,60,"case_d",4)
    rbox(c,"Open rear cavity",2.4,2.4,"front_lip",115.2,55.2,30,1.6,F.FeatureOperations.CutFeatureOperation)
    rbox(c,"Viewing aperture",10,13,0,"window_w","window_h",3,2,F.FeatureOperations.CutFeatureOperation)
    for x0 in (6,114):
        for y in (6,54):
            x=96 if x0==114 and y==54 else x0
            cyl(c,f"Corner compression post {x} {y}",x,y,1.5,8.4,22.1)
    # Side fences locate the acrylic; LEDs and their solder bays occupy top/bottom.
    for x in (6.55,112.25): box(c,"Acrylic side fence",x,11,1.5,1.2,38,3.7)
    for y in (9.55,49.25):
        for x in (17,94): box(c,"Acrylic end datum",x,y,1.5,9,1.2,3.7)
    lead=param("front_lip")+param("acrylic_t")/2-param("led_optical_offset")
    for x in (40,80):
        for y in (6.8,53.2):
            box(c,"LED cradle floor",x-4.4,y-4.4,1.5,8.8,8.8,lead-1.5)
            for xx in (x-5.4,x+4.2): box(c,"LED pocket side rail",xx,y-4.4,1.5,1.2,8.8,3.7)
    union(c)
    for x0 in (6,114):
        for y in (6,54):
            x=96 if x0==114 and y==54 else x0
            cutcyl(c,"M3 through post",x,y,0,"m3_hole",24)
            cutcyl(c,"Recessed M3 head",x,y,0,"head_d","head_depth")
            cutbox(c,"Rear boss clearance",x-4.45,y-4.45,23.6,8.9,8.9,4.0)
    # Optical tray ledges and serviceable side snap sockets.
    for x in (2.3,113.0):
        for y in (18,38): box(c,"Tray socket shelf",x,y,9.15,4.7,5,1.4)
    union(c)
    for x in (2.3,112.8):
        for y in (18.3,38.3): cutbox(c,"Tray snap relief",x,y,9.0,4.9,4.4,0.9)
    # Actual cable-overmould clearance is intentionally larger than the metal receptacle.
    cutbox(c,"Charger USB access",14.8,57.4,11.0,12.4,4,7.0)
    cutbox(c,"XIAO USB access",109.2,57.4,13.0,8.1,4,13.0)
    cutbox(c,"Power slider guide slot",56.6,57.4,18.0,7.6,4,2.6)
    # Right-side plunger, axis X. YZ sketch uses its local x as Y, y as Z.
    sk=sketch(c,"Reset stem side bore",117.4,"x")
    center=sk.modelToSketchSpace(p(117.4,"reset_y",-param("reset_depth")))
    sk.sketchCurves.sketchCircles.addByCenterRadius(center,0.215)
    extrude(c,sk,4,"Reset stem side bore",F.FeatureOperations.CutFeatureOperation)
    paint(c)
    finish("shell")

def optics():
    a,b,front,back,trayback=depths()
    c=component("02 Engraved acrylic","CO2 cut and reverse engrave; keyed upper-left corner in front view")
    sk=sketch(c,"Acrylic cut outline",a); keyed(sk)
    extrude(c,sk,-param("acrylic_t"),"Clear acrylic blank")
    ts,txt=text_sketch(c,"ON AIR rear engraving",b)
    extrude(c,ts,0.15,"Rear engraved letters",F.FeatureOperations.CutFeatureOperation,txt)
    paint(c,"Clear acrylic",None)
    c=component("03 Black and white backing","Print back down; black base 1.6 mm then white 0.4 mm")
    sk=sketch(c,"Backing keyed outline",front+param("letter_relief")); keyed(sk)
    extrude(c,sk,-param("backing_base"),"Black substrate")
    paint(c)
    ts,txt=text_sketch(c,"ON AIR shared lettering",front+param("letter_relief"))
    feature=extrude(c,ts,param("letter_relief"),"White lettering",F.FeatureOperations.NewBodyFeatureOperation,txt)
    for body in feature.bodies: body.appearance=appearance("White PETG",(244,245,240))
    c.attributes.add("LittleOnAir","Print","Back down, filament change at 1.6 mm; white letters are 0.4 mm tall")
    finish("optics")

def backplate():
    c=component("10 Wall back plate","Flat rear surface, removable adhesive strips; front-access M3 closure")
    rbox(c,"Flat adhesive back",2.65,2.65,27.6,114.7,54.7,2.4,2)
    for x0 in (6,114):
        for y in (6,54):
            x=96 if x0==114 and y==54 else x0
            box(c,"Captive nut compression boss",x-4.2,y-4.2,23.6,8.4,8.4,4.1)
    union(c)
    for x0 in (6,114):
        for y in (6,54):
            x=96 if x0==114 and y==54 else x0
            sk=sketch(c,"M3 hex trap profile",24.8)
            radius=param("nut_af")/math.sqrt(3)
            polygon(sk,[(x+radius*math.cos(math.radians(60*i)),y+radius*math.sin(math.radians(60*i))) for i in range(6)])
            extrude(c,sk,-2.6,"Captive hex nut pocket",F.FeatureOperations.CutFeatureOperation)
            cutbox(c,"Nut loading slot",x if x<60 else x-4.4,y-2.9,24.8,4.4,5.8,2.6)
            cutcyl(c,"Blind screw tip clearance",x,y,23.6,"m3_hole",5.1)
    paint(c)
    finish("backplate")

def tray():
    a,b,front,back,tb=depths()
    c=component("04 Optical and electronics tray","Rear removable carrier; four side spring latches; wire and battery strap channels")
    box(c,"Optical support partition",11,12,back,98,36,"tray_t")
    box(c,"Battery support extension",32,5,back,58,10,"tray_t")
    box(c,"Charger support extension",10.75,32,back,21,25.2,"tray_t")
    box(c,"XIAO support extension",108,33,back,3.5,23.8,"tray_t")
    # Four cantilevers flex horizontally into the free space beside the tray.
    for side in (0,1):
        xx=7.3 if side==0 else 111.9
        box(c,"Snap root bridge",7.3 if side==0 else 108,29,8.0,4.7,2.0,1.8)
        for y,h in ((19.0,11),(30,11.7)):
            box(c,"Tray spring leaf",xx,y,8.0,0.8,h,1.8)
        for yy in (18.6,38.6):
            box(c,"Tray latch tongue",4.5 if side==0 else 111.9,yy,9.3,3.6,3.8,0.5)
    # Retaining fingers bear behind LED PCBs; pads occupy the remaining 0.16 mm.
    for x in (40,80):
        box(c,"Lower LED retaining finger",x-1.5,5.2,4.35,3,8.8,tb-4.35)
        box(c,"Upper LED retaining finger",x-1.5,46,4.35,3,8.8,tb-4.35)
    # Battery cradle: 53 x 22 inside with a lead exit at its upper-right corner.
    box(c,"Battery bed",34,6.5,tb,53,22,0.5)
    box(c,"Battery left fence",33,6.5,tb,1,22,3.5)
    box(c,"Battery right fence",87,6.5,tb,1,15,3.5)
    box(c,"Battery lower stop",33,5.5,tb,55,1,3.5)
    box(c,"Battery upper stop",33,28.5,tb,45,1,3.5)
    # Charger cradle: four pads beneath clear PCB areas, side rails and axial stops.
    for x,y in ((14,36),(26,36),(14,51),(26,51)):
        box(c,"Charger underside support",x,y,tb,2,2,13.2-tb)
    for x in (10.75,29.75): box(c,"Charger side rail",x,33,tb,2,22,16.2-tb)
    box(c,"Charger lower insertion stop",12.75,31,tb,17,1.25,15.5-tb)
    for x in (12.0,27.75): box(c,"Charger upper extraction stop",x,57.75,tb,3.5,0.9,15.5-tb)
    # XIAO sits edge-on, with all USB/reset forces supported by the carrier spine.
    box(c,"XIAO rigid support spine",109.7,33,tb,1.6,23.8,27.25-tb)
    for yy in (39,49): box(c,"XIAO front edge seat",109.7,yy,tb,2.8,2,9.3-tb)
    for dd in (11.0,24.4):
        box(c,"XIAO lower axial stop",111.2,34.1,dd,1.6,1.15,1.8)
        box(c,"XIAO upper axial stop",111.2,56.75,dd,1.6,0.6,1.8)
    # DPDT cheeks leave a clear channel beneath the six through-hole terminals.
    for x in (54.2,64.6):
        box(c,"Switch cradle support",x,45,tb,1.2,10.8,21.5-tb)
    box(c,"Switch front retaining lip",54.2,53,16.55,11.6,2.8,1)
    union(c)
    for x in (31.0,88.0): cutbox(c,"Battery strap slot",x,15,back,2.1,8,"tray_t")
    for x in (11.1,30.1): cutbox(c,"Charger keeper peg socket",x,42,11.3,1.3,3.4,5.0)
    for dd in (10.0,25.3): cutbox(c,"XIAO keeper peg socket",109.6,33.4,dd,2.0,1.6,1.6)
    for x in (54.3,64.7): cutbox(c,"Switch keeper socket",x,50.6,17.0,1.0,1.8,5.0)
    paint(c)
    finish("tray")

def keepers():
    c=component("05 Charger keeper","Rear-inserted U clip; press-fit legs and bare-edge retaining tabs")
    for x in (11.05,29.7): box(c,"Keeper side arm",x,30,14.4,1.7,24,1.0)
    box(c,"Keeper crossbar",11.05,30,14.4,20.35,1.2,1.0)
    for x in (12.5,27.5):
        for y in (38,49): box(c,"PCB retaining tab",x,y,14.4,2.2,2,1)
    for x in (11.25,30.25): box(c,"Keeper press-fit leg",x,42.2,11.45,1.0,3.0,3.95)
    union(c); paint(c,"Keeper PETG",(58,63,70))
    c=component("06 XIAO keeper","Side-inserted U fork; USB and reset remain clear")
    box(c,"XIAO keeper bridge",112.8,33.6,10.2,1.4,1.2,16.5)
    for dd in (10.2,25.5): box(c,"XIAO keeper side finger",112.8,33.6,dd,1.4,22.7,1.2)
    for dd in (10.2,25.5): box(c,"XIAO keeper peg",109.9,33.6,dd,4.3,1.2,1.2)
    union(c); paint(c,"Keeper PETG",(58,63,70))
    c=component("09 Switch keeper","Rear removable keeper; terminal bay is open toward case interior")
    box(c,"Switch rear retaining bridge",54.2,53,21.15,11.6,2.8,1.0)
    for x in (54.2,64.6):
        box(c,"Switch keeper leg link",x,50.8,21.15,1.2,4.8,1.0)
        box(c,"Switch keeper press-fit leg",x+0.2,50.8,17.15,0.7,1.4,4.2)
    union(c); paint(c,"Keeper PETG",(58,63,70))
    finish("keepers")

def controls():
    c=component("07 Captive reset plunger","Right-side golf-tee plunger; tune contact length and hard stop after measuring reset stroke")
    y=param("reset_y"); dd=param("reset_depth")
    def along_x(name,x,length,diam):
        sk=sketch(c,name+" profile",x,"x")
        center=sk.modelToSketchSpace(p(x,y,-dd))
        sk.sketchCurves.sketchCircles.addByCenterRadius(center,diam/20)
        extrude(c,sk,length,name)
    along_x("Finger stem",116.9,3.6,3.8)
    along_x("Internal captive flange",116.5,0.4,6.4)
    along_x("Reset contact tip",param("reset_tip_x"),116.5-param("reset_tip_x"),1.6)
    union(c); paint(c,"Control PETG",(115,121,128))
    # A separate case stop behind the flange limits inward movement to 0.5 mm.
    sh=comp("01 Body and front frame")
    for yy in (y-4.4,y+3.5):
        box(sh,"Reset stop support",115.4,yy,dd-3.2,2.3,0.9,6.4)
    for yy in (y-3.5,y+2.5):
        box(sh,"Reset travel stop lug",115.4,yy,dd-2,0.6,1.0,4.0)
    union(sh); paint(sh)
    c=component("08 Captive power slider","Top finger pad; actuator cup clears 3.2 x 1.1 mm tongue")
    box(c,"Outside finger pad",55.5,60.2,16.7,9,1.2,5.2)
    box(c,"Sliding neck",57.6,56.5,18.3,4.8,3.9,2.0)
    box(c,"Internal captive flange",55.9,56.8,16.7,8.2,0.55,5.2)
    # Bottom-open socket couples the slider to the actual switch tongue.
    box(c,"Actuator socket block",57.65,55.8,18.1,4.7,1.0,2.4)
    union(c)
    cutbox(c,"Actuator tongue socket",58.2,55.7,18.55,3.6,1.6,1.5)
    paint(c,"Control PETG",(115,121,128))
    finish("controls")

def references():
    a,b,front,back,tb=depths()
    c=component("REF Battery 52x21x10","Reference envelope only; do not print")
    box(c,"Battery pouch envelope",34.5,7,tb+0.5,52,21,10)
    paint(c,"Battery foil",(170,177,187))
    c=component("REF TP4056 charger","PCB footprint from listing; heights and USB geometry provisional")
    box(c,"Charger PCB",13,32.5,13.2,16.5,25,1)
    paint(c,"PCB green",(24,100,63))
    box(c,"Charger USB C envelope",17,53,14.2,9,6.4,3.6)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Connector steel",(164,173,184))
    box(c,"Charger IC envelope",18,36,14.2,7,11,2.3)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Black PETG",(24,27,31))
    c=component("REF XIAO nRF52840","Official footprint, provisional socket/button placement; soldered wires, no headers")
    box(c,"XIAO PCB",111.5,35.5,9.3,1,21,17.8)
    paint(c,"PCB green",(24,100,63))
    box(c,"XIAO USB C envelope",112.5,52,15.5,3.3,6.4,9)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Connector steel",(164,173,184))
    box(c,"XIAO component envelope",112.5,41.5,13.8,3,9,9)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Black PETG",(24,27,31))
    box(c,"XIAO reset target",112.5,param("reset_y")-1,param("reset_depth")-0.9,1.5,2,1.8)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Control PETG",(115,121,128))
    c=component("REF DPDT switch and leads","8.6x3.1x2.7 case; six trimmed 3 mm leads; lateral throw provisional")
    box(c,"DPDT switch body",55.7,53,17.8,8.6,2.7,3.1)
    paint(c,"Connector steel",(164,173,184))
    box(c,"DPDT actuator tongue",58.4,55.7,18.7,3.2,1.4,1.1)
    c.bRepBodies.item(c.bRepBodies.count-1).appearance=appearance("Black PETG",(24,27,31))
    for x in (57,60,63):
        for d in (18.25,20.05): box(c,"DPDT clipped solder leg",x-0.2,50, d,0.4,3,0.35)
    c=component("REF Four side emitting LEDs","8x8x2 envelopes; optical centres must be measured")
    lead=param("front_lip")+param("acrylic_t")/2-param("led_optical_offset")
    for x in (40,80):
        for y in (6.8,53.2): box(c,"Side-emitting LED module",x-4,y-4,lead,8,8,2)
    paint(c,"LED module",(185,167,72))
    finish("references")

def refine():
    a,b,front,back,tb=depths()
    c=comp("04 Optical and electronics tray")
    for x in (40,80):
        cutbox(c,"Lower finger optical clearance",x-1.6,10.75,4.35,3.2,3.4,back-4.35)
        cutbox(c,"Upper finger optical clearance",x-1.6,45.9,4.35,3.2,3.35,back-4.35)
    c=comp("01 Body and front frame")
    for x in (11.7,27.5): cutbox(c,"Internal charger end stop relief",x,57.5,8.8,4.1,1.4,7.0)
    c=comp("03 Black and white backing")
    for body in c.bRepBodies:
        if body.name.startswith("White"):
            for face in body.faces: face.appearance=appearance("White PETG",(244,245,240))
    union(c,"Fused two color printable backing")
    # Native assembled view: +Z is the front, +Y is upward.
    vp=app().activeViewport
    vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle
    camera=vp.camera
    camera.cameraType=C.CameraTypes.OrthographicCameraType
    camera.target=p(60,30,-10)
    camera.eye=p(160,120,150)
    camera.upVector=C.Vector3D.create(0,1,0)
    camera.isSmoothTransition=False; camera.isFitView=True
    vp.camera=camera
    finish("refine")

def checkpoint():
    OUT.mkdir(parents=True,exist_ok=True)
    ex=design().exportManager
    opt=ex.createFusionArchiveExportOptions(str(OUT/"little-on-air-enclosure.f3d"))
    print(json.dumps({"archive":ex.execute(opt),"components":root().occurrences.count}))

def run_stage(stage):
    if stage!="setup" and not root().attributes.itemByName("LittleOnAir","Status"): raise RuntimeError("Activate the Little On Air design before continuing")
    stages={"setup":setup,"shell":shell,"optics":optics,"backplate":backplate,"tray":tray,"keepers":keepers,"controls":controls,"references":references,"refine":refine,"checkpoint":checkpoint}
    stages[stage]()
