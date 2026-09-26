"""Direct, reproducible STEP remix of UrbanCircles' Project IGOR v1.

Run with Python 3.12 and requirements.txt. All geometry is in millimetres.
Assembly coordinates: X left/right, Y front/rear, Z up; original front floor Z=0.
The source is deliberately retained; no resizing of the screen or encoder fit.
"""
from pathlib import Path
import hashlib
import json
import math

import cadquery as cq
from OCP.BRepPrimAPI import BRepPrimAPI_MakePrism
from OCP.gp import gp_Vec
import numpy as np
import trimesh

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'output'
EXTENSION = 14.0
POCKET = (40.0, 48.0, 10.0)  # width, depth, usable height above cover
ORIGIN = (7.25603150203824, 11.0316793496028, -5.516018234362889)

def box(x0, x1, y0, y1, z0, z1):
    return cq.Solid.makeBox(x1-x0, y1-y0, z1-z0, (x0, y0, z0))

def rounded_rect(w, d, h, r, y, z):
    return (cq.Workplane('XY').box(w,d,h,centered=(True,True,False))
            .edges('|Z').fillet(r).val().translate((0,y,z)))

def slope(shape):
    return shape.rotate((0,0,0),(1,0,0),30)

def unslope(shape):
    return shape.rotate((0,0,0),(1,0,0),-30)

def cyl(radius, length, xyz, direction=(0,0,1)):
    return cq.Solid.makeCylinder(radius,length,xyz,direction)

def bounds(s):
    b=s.BoundingBox()
    return [round(v,5) for v in (b.xmin,b.ymin,b.zmin,b.xmax,b.ymax,b.zmax)]

def main():
    for sub in ['cad','stl','assembly-meshes','validation','views']:
        (OUT/sub).mkdir(parents=True,exist_ok=True)
    upstream = ROOT/'upstream/igor-v1.step'
    original = cq.importers.importStep(str(upstream)).solids().vals()
    assert len(original)==5
    rings = [p.translate(ORIGIN) for p in original[:2]]
    face, hat, shell = [p.translate(ORIGIN) for p in original[2:]]
    assert abs(shell.Volume()-22763.7111993963)<.01
    source_shell=shell
    # 0.6 mm working gap under the rotating/pushing hat; shape is unchanged.
    hat=hat.translate((0,-.3,.6*math.cos(math.radians(30))))

    # Downward extrusion of the ORIGINAL exterior bottom surfaces preserves
    # their exact footprint and avoids approximating Igor with a new outer box.
    clip=box(-60,60,-20,120,-EXTENSION,80)
    additions=[]
    for i in (4,5,8,11,12,13,71,73,75):
        f=source_shell.Faces()[i]
        p=cq.Shape.cast(BRepPrimAPI_MakePrism(f.wrapped,gp_Vec(0,0,-100)).Shape())
        additions.append(p.intersect(clip))
    shell=shell.fuse(*additions).clean()
    assert shell.isValid() and len(shell.Solids())==1

    # Separate bottom-access ballast cavity. 2 mm minimum roof below original
    # exterior floor, plus Igor's original 2 mm floor above that.
    cavity=box(-20,20,9,57,-15,-2)
    # Cover is flush at Z=-14 and seats against this ledge at Z=-11.6.
    cover_recess=rounded_rect(46.2,64.0,2.4,2.3,33,-14)
    shell=shell.cut(cavity).cut(cover_recess)
    cover=rounded_rect(45.6,63.4,2.4,2.0,33,-14)
    # Center is relieved 0.4 mm: gives exactly 10 mm from -12 to -2.
    cover=cover.cut(box(-20,20,9,57,-12,-11.5))
    screw_xy=[(x,y) for x in (-18.5,18.5) for y in (5.5,60.5)]
    for x,y in screw_xy:
        # M3 heat-set insert, nominal OD4.2 x L4; 4.0 mm pilot is a starting fit.
        shell=shell.cut(cyl(2.0,4.4,(x,y,-11.6)))
        shell=shell.cut(cyl(1.65,7,(x,y,-11.6)))
        cover=cover.cut(cyl(1.65,3,(x,y,-14.2)))
        cover=cover.cut(cq.Solid.makeCone(3.1,1.65,1.45,(x,y,-14),(0,0,1)))

    # A separate front LED bay, isolated from the weight pocket by >=1.7 mm.
    # 10 x 10 x 1.6 PCB slides up from below; the cover captures its bottom edge.
    pcb_slot=box(-5.2,5.2,3.8,5.6,-14,-1)
    wire_bay=box(-6,6,5.6,7.3,-14,0.9)
    optical_bay=box(-3.7,3.7,1.2,3.8,-14,-2.3)
    shell=shell.cut(pcb_slot).cut(wire_bay).cut(optical_bay)
    shell=shell.cut(cyl(2.65,3,(0,-.5,-6),(0,1,0)))
    shell=shell.cut(cyl(3.6,1,(0,1.2,-6),(0,1,0)))
    shell=shell.cut(cyl(1.6,5,(0,5.5,-.1)))
    # Cover tongue leaves 0.2 mm below the nominal board lower edge at Z=-11.
    cover=cover.fuse(box(-4.8,4.8,3.85,5.55,-11.65,-11.2)).clean()
    lens=cyl(2.45,1.2,(0,0,-6),(0,1,0)).fuse(cyl(3.4,.8,(0,1.2,-6),(0,1,0))).clean()

    # Remove only Igor's D1-mini retaining ridge, above its sloping floor.
    old_clip=slope(box(-16.2,15.2,32,47,-7.99,2))
    shell=shell.cut(old_clip)
    # XIAO ESP32-S3 has a flat underside. 0.3 mm insulating mounting tape on
    # this central pedestal puts PCB underside at slope-coordinate W=-6.25.
    platform=slope(box(-6.7,6.7,49.0,66.5,-8.15,-6.55))
    shell=shell.fuse(platform)
    # Positive forward stop supports USB insertion load at the board edge.
    stop=slope(box(-5.5,5.5,47.0,48.05,-8.15,-4.7))
    shell=shell.fuse(stop)
    # Direct rear USB access; socket tip Y'=70.63, recessed 1.6 mm for insertion.
    usb_cut=slope(box(-6.75,6.75,69.5,76,-8.0,.6))
    shell=shell.cut(usb_cut).clean()
    # The full underside remains closed except the two service bays.
    parts={'01-weighted-shell':shell,'02-igor-faceplate':face,
           '03-igor-hat':hat,'04-ballast-cover':cover,'05-led-diffuser':lens}
    # Original 3MF supplies decorative inlay rings as separate solids. The
    # functional hat is used without them; its annular grooves remain visible.

    report={'source_sha256':hashlib.sha256(upstream.read_bytes()).hexdigest(),
            'base_extension_mm':EXTENSION,'weight_pocket_mm':list(POCKET),
            'weight_pocket_bounds':[-20,9,-12,20,57,-2],
            'original_shell_bounds':bounds(source_shell),'parts':[],
            'physical_fit_verified':False}
    assy=cq.Assembly(name='Little-On-Air-IGOR-desk-v1')
    colors={'01-weighted-shell':(.20,.34,.35),'02-igor-faceplate':(.84,.85,.79),
            '03-igor-hat':(.10,.14,.16),'04-ballast-cover':(.20,.34,.35),
            '05-led-diffuser':(.9,.7,.3)}
    for name,s in parts.items():
        assert s.isValid() and len(s.Solids())==1,(name,'invalid solid')
        cq.exporters.export(s,str(OUT/'cad'/f'{name}.step'))
        cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{name}.stl'),tolerance=.015,angularTolerance=.08)
        assy.add(s,name=name,color=cq.Color(*colors[name]))
        if name.startswith(('01','02')):
            oriented=s.rotate((0,0,0),(1,0,0),90) # front against print bed
        elif name.startswith('03'):
            oriented=unslope(s) # hat base flat, shaft socket downward
        elif name.startswith('05'):
            oriented=s.rotate((0,0,0),(1,0,0),90) # lens front face on bed
        else: oriented=s
        b=oriented.BoundingBox()
        oriented=oriented.translate((-b.xmin,-b.ymin,-b.zmin))
        target=OUT/'stl'/f'{name}.stl'
        cq.exporters.export(oriented,str(target),tolerance=.015,angularTolerance=.08)
        mesh=trimesh.load_mesh(target,process=True)
        # OpenCascade's cached bounding box includes the tessellation deflection.
        # Put the exported vertices, rather than that conservative box, on Z=0.
        mesh.apply_translation(-mesh.bounds[0])
        mesh.export(target)
        assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume>0,name
        assert len(mesh.split())==1,name
        assert mesh.bounds[0,2]>-1e-4 and np.max(mesh.extents)<256,name
        report['parts'].append({'name':name,'valid_native_solid':True,'watertight':True,
          'consistent_winding':True,'connected_components':1,'triangles':len(mesh.faces),
          'assembly_bounds':bounds(s),'print_size_mm':mesh.extents.tolist(),
          'volume_mm3':s.Volume(),'print_min_z':float(mesh.bounds[0,2]),
          'sha256':hashlib.sha256(target.read_bytes()).hexdigest()})
    assy.export(str(OUT/'cad/igor-desk-v1.step'))
    # Actual native intersections of the parts, not bounding-box overlap tests.
    collisions=[]
    for i,(n,a) in enumerate(parts.items()):
        for m,b in list(parts.items())[i+1:]:
            v=a.intersect(b).Volume()
            if v>0.001:collisions.append({'a':n,'b':m,'volume_mm3':v})
    report['part_collisions']=collisions
    assert not collisions,collisions
    # No changes in the upper shell outside the specifically reserved USB and
    # old-board mount edits. The OLED face and encoder hat are exact source solids.
    report['faceplate_source_volume_delta_mm3']=face.Volume()-original[2].Volume()
    report['hat_source_volume_delta_mm3']=hat.Volume()-original[3].Volume()
    report['printable_geometry_passed']=True
    (OUT/'validation/geometry.json').write_text(json.dumps(report,indent=2))
    print(json.dumps(report,indent=2),flush=True)

if __name__=='__main__':main()
