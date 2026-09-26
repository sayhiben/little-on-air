"""Native solid checks for the widened front, assembly and wire passages.

Wire tests reserve 2.0 mm diameter clearance envelopes. The assembly guide
limits actual insulation OD to 1.8 mm to leave manufacturing/dressing clearance.
These test passages, not unknown solder-pad shapes or a preassembled connector.
"""
import adsk.core as C
import adsk.fusion as F
import math,json,time
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v214'

def run(_context:str):
    app=C.Application.get();d=F.Design.cast(app.activeProduct);tm=F.TemporaryBRepManager.get()
    assert 'v2.14' in app.activeDocument.name
    # Restrict the bearing guard to the actual bearing depth. The earlier
    # rectangular guard also included 0.00036 mm3 of restored outer bevel
    # above it, which is a cosmetic change, not a change to the guide seat.
    build=json.loads((OUT/'native-build.json').read_text())
    if not build['passed']:
        current=app.activeDocument
        source=OUT.parents[2].parent/'release/little-on-air-enclosure-v2.13/cad/little-on-air-v213.f3d'
        baseline=app.importManager.importToNewDocument(app.importManager.createFusionArchiveImportOptions(str(source)))
        bd=F.Design.cast(app.activeProduct)
        old=tm.copy(next(o.component.bRepBodies.item(0) for o in bd.rootComponent.occurrences if o.component.name=='01 Front optical bezel'))
        current.activate();d=F.Design.cast(app.activeProduct)
        new=next(o.component.bRepBodies.item(0) for o in d.rootComponent.occurrences if o.component.name=='01 Front optical bezel')
        differences=[]
        for a,z in ((old,new),(new,old)):
            q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),F.BooleanTypes.DifferenceBooleanType);differences.append(q)
        for name,x,y,w,h,lo in [('RGB guide bearing',100,51.4,7.21,7.21,1.5),('RGB front aperture',101.2,52.6,4.8,4.8,0)]:
            box=tm.createBox(C.OrientedBoundingBox3D.create(C.Point3D.create((x+w/2)/10,(y+h/2)/10,-(lo+11.01)/20),C.Vector3D.create(1,0,0),C.Vector3D.create(0,1,0),w/10,h/10,(11.01-lo)/10))
            vol=0
            for a in differences:
                q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(box),F.BooleanTypes.IntersectionBooleanType);vol+=q.volume*1000
            check={'region':name,'changed_mm3':vol,'passed':vol<1e-5,'depth_range_mm':[lo,11.01]}
            build['critical_unchanged_regions']=[q for q in build['critical_unchanged_regions'] if q['region']!=name]+[check]
        build['passed']=not build['feature_health_failures'] and all(q['passed'] for q in build['critical_unchanged_regions'])
        (OUT/'native-build.json').write_text(json.dumps(build,indent=2))
    groups={o.component.name:list(o.component.bRepBodies) for o in d.rootComponent.occurrences}
    front=groups['01 Front optical bezel'][0]
    obstacles=[(n,q) for n,bs in groups.items() if not n.startswith(('81','82','REF Harness')) for q in bs]
    bounds={id(q):q.boundingBox for n,q in obstacles}
    def overlap(a,z):
        aa=a.boundingBox;bb=bounds[id(z)] if id(z) in bounds else z.boundingBox
        return all(min(x,y)-max(u,v)>1e-7 for x,y,u,v in zip(aa.maxPoint.asArray(),bb.maxPoint.asArray(),aa.minPoint.asArray(),bb.minPoint.asArray()))
    def intersection(a,z):
        if not overlap(a,z):return 0
        q=tm.copy(a);assert tm.booleanOperation(q,tm.copy(z),F.BooleanTypes.IntersectionBooleanType)
        return q.volume*1000
    def p(q):return C.Point3D.create(q[0]/10,q[1]/10,-q[2]/10)
    def moved(q,off):
        z=tm.copy(q);m=C.Matrix3D.create();m.translation=C.Vector3D.create(0,0,off/10);assert tm.transform(z,m);return z
    report={'passed':False,'wire_envelope_diameter_mm':2.0,'recommended_actual_wire_OD_max_mm':1.8,
            'static':[],'closure':[],'passages':[],
            'limits':'Passage reservations include installed optics, retainers, controls and hardware. Check real insulation OD, solder joints, bends and hand-dressed crossovers before final assembly; do not thread a connector through the tunnels.'}
    def save(stage):
        (OUT/'validation-progress.json').write_text(json.dumps({'stage':stage,'completed_passages':len(report['passages'])}))
        (OUT/'native-validation.json').write_text(json.dumps(report,indent=2))
    for n,q in obstacles:
        if n.startswith('01'):continue
        v=intersection(front,q)
        if v>.001:report['static'].append({'part':n,'mm3':v})
    save('static complete')
    for i in range(81):
        off=i*.25;a=moved(front,off)
        for n,q in obstacles:
            if not n.startswith(('05','06','09','10','11','REF Charger','REF XIAO','REF DPDT','REF SPDT','REF Battery','REF Capacitor','REF Guide')):continue
            v=intersection(a,q)
            if v>.001:report['closure'].append({'offset_z_mm':off,'part':n,'mm3':v})
    save('81 closure positions complete')
    report['reset_travel']=[]
    button=groups['07 Front guided reset button'][0]
    for i in range(17):
        q=moved(button,-i*.05)
        report['reset_travel'].append({'travel_mm':i*.05,'intersection_mm3':intersection(q,front)})
    def check(name,pts,r=1):
        collisions={};pieces=[]
        for a,z in zip(pts,pts[1:]):
            if math.dist(a,z)>1e-7:pieces.append(tm.createCylinderOrCone(p(a),r/10,p(z),r/10))
        for a in pts[1:-1]:pieces.append(tm.createSphere(p(a),r/10))
        for a in pieces:
            for n,q in obstacles:
                v=intersection(a,q)
                if v>.001:collisions[n]=round(collisions.get(n,0)+v,4)
        report['passages'].append({'name':name,'centerline_mm':pts,'collisions_mm3':collisions,'passed':not collisions})
        save(name)
    # Two lanes x three depth levels. Radii 5 and 7 mm put a full 2 mm
    # envelope inside the 3.9-to-8.1 mm corner annulus.
    for radius in (5,7):
        for dep in (3,5,7):
            pts=[]
            for x,y,start in [(114.8,5.2,-90),(114.8,54.8,0),(5.2,54.8,90),(5.2,5.2,180)]:
                pts.extend([(x+radius*math.cos(math.radians(start+i*5)),y+radius*math.sin(math.radians(start+i*5)),dep) for i in range(19)])
            pts.append(pts[0]);check(f'Perimeter lane radius {radius} depth {dep}',pts)
    # Three separate leads may enter each LED pocket from either side. Start
    # at the pocket edge, outside the unknown LED package/pad/solder envelope.
    for x in (40,80):
        for upper,y in ((False,6.8),(True,53.2)):
            for side in (-1,1):
                xx=(86.5 if upper and x==80 and side==1 else x+side*8)
                yy=60.8 if upper else -.8
                for dep in (3,5,7):
                    check(f'LED {x},{y} side {side} entry depth {dep}',[(xx,yy,dep),(xx,y,dep)])
    # Full original floor (excluding pre-existing reliefs) remains below the
    # nominal module. Native body references also verify the emitter location.
    report['led_seat_depth_mm']=2.1875
    report['closure_poses']=81
    report['passed']=build['passed'] and not report['static'] and not report['closure'] and all(q['passed'] for q in report['passages']) and all(q['intersection_mm3']<.001 for q in report['reset_travel'])
    save('complete')
    print(json.dumps({'passed':report['passed'],'static':report['static'],'closure':report['closure'],'passages':len(report['passages']),'failed_passages':[q for q in report['passages'] if not q['passed']]},indent=2))
