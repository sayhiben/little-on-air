"""Minimal Project IGOR remix: lower floor, XIAO recess, top pixel opening.

All distances are millimetres. Start from the creator's original STEP, never
from the superseded desk-v1 enclosure. X=width, Y=rearward, Z=up. Original
front bottom is Z=0. slope() uses Igor's existing 30-degree PCB plane.
"""
from pathlib import Path
import hashlib,json
import cadquery as cq
from OCP.BRepPrimAPI import BRepPrimAPI_MakePrism
from OCP.gp import gp_Vec
import trimesh
import numpy as np

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'output'
ORIGIN=(7.25603150203824,11.0316793496028,-5.516018234362889)
EXTENSION=6.0

def box(x0,x1,y0,y1,z0,z1):
    return cq.Solid.makeBox(x1-x0,y1-y0,z1-z0,(x0,y0,z0))
def slope(s):return s.rotate((0,0,0),(1,0,0),30)
def unslope(s):return s.rotate((0,0,0),(1,0,0),-30)
def cylinder(r,h,p,d=(0,0,1)):return cq.Solid.makeCylinder(r,h,p,d)
def source_parts():
    p=ROOT/'upstream/igor-v1.step'
    assert hashlib.sha256(p.read_bytes()).hexdigest()=='9645738bee23f74ca35bc64abd22047e27ce61a9ba0c0e83864a13e755bd8c33'
    return [s.translate(ORIGIN) for s in cq.importers.importStep(str(p)).solids().vals()]

def geometry():
    small,big,face,hat,original=source_parts()
    # A SIX-MILLIMETRE SWEEP of the original underside, not an extrusion to
    # a flat datum. The rear slope and the rounded lower outline remain.
    additions=[]
    for i in (4,5,8,11,12,13,71,73,75):
        f=original.Faces()[i]
        additions.append(cq.Shape.cast(BRepPrimAPI_MakePrism(f.wrapped,gp_Vec(0,0,-EXTENSION)).Shape()))
    body=original.fuse(*additions).clean()
    assert body.isValid() and len(body.Solids())==1
    # Two top-access recesses in the thicker floor. Load adhesive weights
    # through the existing front opening; no new cover or case fasteners.
    flat_well=box(-19.5,19.5,4,17,-3.5,2.05)
    sloped_well=slope(box(-18,18,24.5,44.5,-12.7,-7.95))
    body=body.cut(flat_well).cut(sloped_well)
    # Replace the D1-mini ridge with a close-fitting, lowered XIAO pocket.
    old_ridge=slope(box(-16.2,15.2,32,47,-7.99,2))
    body=body.cut(old_ridge)
    xiao_recess=slope(box(-9.2,9.2,49.7,71.15,-9.2,-7.0))
    body=body.cut(xiao_recess)
    pad=slope(box(-6.7,6.7,50.5,68.0,-9.21,-8.91))
    body=body.fuse(pad)
    # Center the XIAO socket at the ORIGINAL USB opening. Only enlarge that
    # opening by 0.6 mm in width and 1.1 mm in height (9.8 x 4.6 mm final).
    port=(cq.Workplane('XZ').center(0,-6.25).rect(9.8,4.6).extrude(8)
          .edges('|Y').fillet(1).val().translate((0,76,0)))
    port=slope(port)
    body=body.cut(port)
    # Small top window ahead of the hat. Three internal locating/glue lands
    # accept a 10 x 10 x 1.6 mm centered 5050-pixel PCB.
    led_lands=[box(6,7,4,9,32.5,36.2),box(17.4,18.4,4,9,32.5,36.2),
               box(7.2,17.2,12,13,32.5,38)]
    body=body.fuse(*led_lands)
    led_window=box(9.4,15,3.9,9.5,35.8,39)
    body=body.cut(led_window).clean()
    parts={'01-igor-shell-minimal':body,'02-igor-faceplate-original':face,
           '03-igor-hat-original':hat,'04-igor-small-inlay-original':small,
           '05-igor-large-inlay-original':big}
    # These exact regions are the complete authorized shell change budget.
    floor_region=cq.Compound.makeCompound(additions+[flat_well,sloped_well])
    board_region=cq.Compound.makeCompound([old_ridge,xiao_recess,pad,port])
    led_region=cq.Compound.makeCompound(led_lands+[led_window])
    return original,parts,(floor_region,board_region,led_region)

def main():
    for d in ('cad','stl','assembly-meshes','validation','views'):(OUT/d).mkdir(parents=True,exist_ok=True)
    original,parts,regions=geometry()
    body=parts['01-igor-shell-minimal']
    # Check the actual solid difference against the bounded edit regions.
    additions=body.cut(original);removals=original.cut(body)
    for group in regions:
        for region in group.Solids():
            if additions.Volume()>.00001:additions=additions.cut(region)
            if removals.Volume()>.00001:removals=removals.cut(region)
    unexplained=additions.Volume()+removals.Volume()
    assert unexplained<.001,unexplained
    originals=source_parts()
    unchanged={name:parts[name].cut(s).Volume()+s.cut(parts[name]).Volume()
      for name,s in zip(list(parts)[1:],[originals[2],originals[3],originals[0],originals[1]])}
    assert all(v<.001 for v in unchanged.values())
    report={'passed':True,'extension_down_mm':EXTENSION,
      'original_source_sha256':hashlib.sha256((ROOT/'upstream/igor-v1.step').read_bytes()).hexdigest(),
      'changes_outside_three_allowed_regions_mm3':unexplained,
      'unchanged_original_parts_symmetric_difference_mm3':unchanged,
      'original_rear_slope_deg':30,'new_parts_or_case_fasteners':0,'parts':[]}
    assembly=cq.Assembly(name='IGOR-minimal-XIAO-S3')
    for name,s in parts.items():
        assert s.isValid() and len(s.Solids())==1,name
        cq.exporters.export(s,str(OUT/'cad'/f'{name}.step'))
        cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{name}.stl'),tolerance=.015,angularTolerance=.08)
        assembly.add(s,name=name,color=cq.Color(*((.45,.56,.54) if name.startswith('01') else (.8,.81,.77) if name.startswith('02') else (.16,.18,.18))))
        p=s.rotate((0,0,0),(1,0,0),90) if name.startswith(('01','02')) else unslope(s)
        target=OUT/'stl'/f'{name}.stl'
        cq.exporters.export(p,str(target),tolerance=.015,angularTolerance=.08)
        m=trimesh.load_mesh(target);m.apply_translation(-m.bounds[0]);m.export(target)
        assert m.is_watertight and m.is_winding_consistent and len(m.split())==1 and m.volume>0,name
        assert max(m.extents)<256 and abs(m.bounds[0,2])<1e-5
        report['parts'].append({'name':name,'watertight':True,'single_connected_solid':True,
          'valid_native_solid':True,'volume_mm3':s.Volume(),'print_size_mm':m.extents.tolist(),
          'sha256':hashlib.sha256(target.read_bytes()).hexdigest()})
    assembly.save(str(OUT/'cad/igor-minimal-v2.step'))
    cq.exporters.export(original,str(OUT/'assembly-meshes/original-shell-reference.stl'),tolerance=.015,angularTolerance=.08)
    collisions=[]
    for i,(n,a) in enumerate(parts.items()):
        for m,b in list(parts.items())[i+1:]:
            v=a.intersect(b).Volume()
            if v>.001:collisions.append({'parts':[n,m],'intersection_mm3':v})
    assert not collisions,collisions
    report['part_interferences']=collisions
    report['physical_fit_tested']=False
    (OUT/'validation/geometry.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2),flush=True)

if __name__=='__main__':main()
