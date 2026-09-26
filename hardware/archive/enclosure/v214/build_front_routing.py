"""v2.14: change only the front bezel; create enclosed peripheral cable passages."""
import adsk.core as C
import adsk.fusion as F
import adsk, importlib.util, json
from pathlib import Path

BASE = Path(__file__).resolve().parents[1]
OUT = BASE / 'output/v214'
SPEC = importlib.util.spec_from_file_location('front_routing_helpers', BASE/'build_enclosure.py')
b = importlib.util.module_from_spec(SPEC); SPEC.loader.exec_module(b)

def run(_context: str):
    OUT.mkdir(parents=True, exist_ok=True)
    app = C.Application.get()
    doc = app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(
        str(BASE.parents[1]/'release/little-on-air-enclosure-v2.13/cad/little-on-air-v213.f3d')))
    doc.name = 'Little ON AIR v2.14 - front perimeter wire routing'
    d=b.design(); c=b.comp('01 Front optical bezel'); tm=F.TemporaryBRepManager.get()
    old=tm.copy(c.bRepBodies.item(0))
    before={o.component.name:[tm.copy(q) for q in o.component.bRepBodies] for o in b.root().occurrences}

    def ring(name,depth,amount,outer,inner,operation):
        sk=b.sketch(c,name+' profile',depth)
        b.rounded(sk,*outer); b.rounded(sk,*inner)
        rings=[p for p in sk.profiles if p.profileLoops.count==2]
        assert len(rings)==1,(name,sk.profiles.count,len(rings))
        return b.extrude(c,sk,-amount,name,operation,rings[0])

    addition=ring('Wider enclosed front rim - 4.5 mm per side',0,9.5,
         (-4.5,-4.5,129,69,7.5),(1.8,1.8,116.4,56.4,1.2),F.FeatureOperations.NewBodyFeatureOperation).bodies.item(0)
    sk=b.sketch(c,'Reset collar keepout in added rim only',5.8);b.rect(sk,89.15,53.2,5.73,5.65)
    inp=c.features.extrudeFeatures.createInput(sk.profiles.item(0),F.FeatureOperations.CutFeatureOperation)
    inp.setDistanceExtent(False,b.vi(-3.71));inp.participantBodies=[addition]
    feature=c.features.extrudeFeatures.add(inp);feature.name='Preserve reset collar space in wider rim';sk.isVisible=False
    b.union(c,'Join relieved wider rim to original front')
    ring('Continuous 4.2 x 6.3 mm wire tunnel',1.8,6.3,
         (-2.9,-2.9,125.8,65.8,8.1),(1.3,1.3,117.4,57.4,3.9),F.FeatureOperations.CutFeatureOperation)

    openings=[]
    for x in (40,80):
        for upper,y in ((False,6.8),(True,53.2)):
            for xx in (x-5.55,x+4.2):
                b.cutbox(c,'Remove LED side lip above alignment floor',xx,49.25 if upper else 2.35,2.1875,1.35,8.4,5.9125)
            for side in ('left','right'):
                xx=x-11.8 if side=='left' else x+4.5
                # Reset bearing starts immediately beyond the upper-right LED.
                width=4.0 if upper and x==80 and side=='right' else 7.3
                yy=50.6 if upper else 1.2
                b.cutbox(c,'Inward LED solder and cable access',xx,yy,1.8,width,8.2,6.3)
                openings.append({'led_center':[x,y],'side':side,'x':xx,'y':yy,'width':width,'height':8.2,'depth_range':[1.8,8.1]})
    for x in (1.2,117):
        for y in (15,41):
            b.cutbox(c,'Inside access to corner cable bypass',x,y,1.8,1.8,4,6.3)

    front=max((f for f in c.bRepBodies.item(0).faces
               if abs(f.boundingBox.minPoint.z)<1e-7 and abs(f.boundingBox.maxPoint.z)<1e-7),key=lambda f:f.area)
    edges=list(next(q for q in front.loops if q.isOuter).edges)
    inp=c.features.chamferFeatures.createInput2()
    inp.chamferEdgeSets.addEqualDistanceChamferEdgeSet(b.oc(edges),b.vi(1.4),False)
    f=c.features.chamferFeatures.add(inp); f.name='Restore 1.4 mm modern outer front bevel'
    assert c.bRepBodies.count==1
    c.description='v2.14 front-only update: 129 x 69 mm rim; enclosed 4.2 x 6.3 mm cable loop; hot-glue LED mounting with original optical floor height. Existing acrylic, hardware, controls and all other printed components retained.'
    b.paint(c)

    def boolean(a,z,op):
        q=tm.copy(a); assert tm.booleanOperation(q,tm.copy(z),op); return q
    new=c.bRepBodies.item(0)
    removed=boolean(old,new,F.BooleanTypes.DifferenceBooleanType)
    added=boolean(new,old,F.BooleanTypes.DifferenceBooleanType)
    unchanged=[]
    for o in b.root().occurrences:
        n=o.component.name
        if n==c.name:continue
        bs=list(o.component.bRepBodies); assert len(bs)==len(before[n])
        for index,(a,z) in enumerate(zip(before[n],bs)):
            diff=boolean(a,z,F.BooleanTypes.DifferenceBooleanType).volume*1000+boolean(z,a,F.BooleanTypes.DifferenceBooleanType).volume*1000
            assert diff<1e-5,(n,index,diff)
        unchanged.append(n)

    def box(x,y,w,h,lo=0,hi=11.01):
        return tm.createBox(C.OrientedBoundingBox3D.create(b.p(x+w/2,y+h/2,-(lo+hi)/2),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,h/10,(hi-lo)/10))
    guards=[('Reset guide',89.4,52.6,5.6,5.6),('RGB guide bearing',100,51.4,7.21,7.21),('RGB front aperture',101.2,52.6,4.8,4.8),
            ('Optical stack and aperture',8,11,104,38)]
    for x in (6,114):
        for y in (6,54):guards.append((f'Closure screw and compression post {x},{y}',x-3.2,y-3.2,6.4,6.4))
    for y in (6,54):guards.append((f'Optical retainer boss and nut {y}',55.8,y-4.2,8.4,8.4))
    checks=[]
    for n,x,y,w,h in guards:
        q=box(x,y,w,h,lo=1.5 if n=='RGB guide bearing' else 0)
        delta=sum(boolean(a,q,F.BooleanTypes.IntersectionBooleanType).volume*1000 for a in (removed,added))
        checks.append({'region':n,'changed_mm3':delta,'passed':delta<1e-5})
    health=[]
    for i in range(d.timeline.count):
        f=d.timeline.item(i).entity
        if hasattr(f,'healthState') and f.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:health.append({'name':f.name,'message':f.errorOrWarningMessage})
    report={'passed':not health and all(q['passed'] for q in checks),'changed_components':[c.name],
            'unchanged_components_native_symmetric_difference':unchanged,'critical_unchanged_regions':checks,
            'feature_health_failures':health,'front_bounds_mm':[129,69,11],
            'tunnel_width_mm':4.2,'tunnel_depth_range_mm':[1.8,8.1],'roof_mm':1.4,'outer_wall_min_mm':1.6,
            'outer_bevel_mm':1.4,'led_floor_depth_mm':2.1875,'led_access_windows':openings,
            'added_mm3':added.volume*1000,'removed_mm3':removed.volume*1000}
    (OUT/'native-build.json').write_text(json.dumps(report,indent=2))

    dst=OUT/'meshes-assembly-coordinates';dst.mkdir(exist_ok=True)
    opt=d.exportManager.createSTLExportOptions(c,str(dst/'01-front-optical-bezel.stl'))
    opt.unitType=F.DistanceUnits.MillimeterDistanceUnits; opt.meshRefinement=F.MeshRefinementSettings.MeshRefinementHigh; opt.sendToPrintUtility=False
    assert d.exportManager.execute(opt)
    assert d.exportManager.execute(d.exportManager.createFusionArchiveExportOptions(str(OUT/'little-on-air-v214.f3d')))
    assert d.exportManager.execute(d.exportManager.createSTEPExportOptions(str(OUT/'little-on-air-v214-assembly.step')))
    views=OUT/'views';views.mkdir(exist_ok=True);vp=app.activeViewport
    for name,eye,up in [('front',(145,100,160),(0,1,0)),('inside',(135,105,-180),(0,1,0))]:
        for o in b.root().occurrences:o.isLightBulbOn=o.component.name==c.name
        cam=vp.camera;cam.cameraType=C.CameraTypes.OrthographicCameraType;cam.eye=b.p(*eye);cam.target=b.p(60,30,-5)
        cam.upVector=C.Vector3D.create(*up);cam.isSmoothTransition=False;cam.isFitView=True;vp.camera=cam
        vp.visualStyle=C.VisualStyles.ShadedWithVisibleEdgesOnlyVisualStyle;adsk.doEvents();vp.refresh();adsk.doEvents()
        assert vp.saveAsImageFile(str(views/(name+'.png')),1700,1100)
    print(json.dumps(report,indent=2))
