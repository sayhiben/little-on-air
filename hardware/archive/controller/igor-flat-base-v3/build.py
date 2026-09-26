"""Project IGOR in its actual desk orientation; millimetres throughout.

X=left/right, Y=front/rear, Z=up. Original broad base Z=0, encoder
mounting plane Z=38, vertical rear wall Y=72.3205. The source assembly
is rotated -30 degrees about X before any edits. Never use v1/v2 geometry.
"""
from pathlib import Path
import hashlib,json
import cadquery as cq
from OCP.BRepPrimAPI import BRepPrimAPI_MakePrism
from OCP.gp import gp_Vec
import trimesh

ROOT=Path(__file__).resolve().parent;OUT=ROOT/'output'
ORIGIN=(7.25603150203824,11.0316793496028,-5.516018234362889)
EXTENSION=6.0
def box(x0,x1,y0,y1,z0,z1):return cq.Solid.makeBox(x1-x0,y1-y0,z1-z0,(x0,y0,z0))
def cylinder(r,h,p,d=(0,0,1)):return cq.Solid.makeCylinder(r,h,p,d)
def front(s):return s.rotate((0,0,0),(1,0,0),-30).translate((0,0,10))
def source_parts():
 p=ROOT/'upstream/igor-v1.step'
 assert hashlib.sha256(p.read_bytes()).hexdigest()=='9645738bee23f74ca35bc64abd22047e27ce61a9ba0c0e83864a13e755bd8c33'
 return [front(s.translate(ORIGIN)) for s in cq.importers.importStep(str(p)).solids().vals()]
def difference(a,b):return a.cut(b).Volume()+b.cut(a).Volume()
def outside_changes(a,b,regions):
 additions=a.cut(b);removals=b.cut(a)
 for r in regions:
  if additions.Volume()>1e-5:additions=additions.cut(r)
  if removals.Volume()>1e-5:removals=removals.cut(r)
 return additions.Volume()+removals.Volume()

def geometry():
 small,big,face,hat,original=source_parts()
 # Only the broad horizontal base and its side/rear rounds move downward.
 # Source front nose faces 4,5,8,71,73,75 are deliberately not extruded.
 additions=[cq.Shape.cast(BRepPrimAPI_MakePrism(original.Faces()[i].wrapped,gp_Vec(0,0,-EXTENSION)).Shape())
            for i in (11,12,13,63,65,67)]
 # Continue the existing rounded front underside into the added depth.
 # This avoids a projecting step where the flat foot meets the raised nose.
 nose_mask=front(cq.Workplane(obj=box(-24.51,24.51,-20,120,-.01,100)).edges('|Y').fillet(7.01).val())
 body=original.fuse(*additions).clean().intersect(nose_mask).clean()
 # One well in the actual flat base, behind the raised display nose.
 # Three 19 x 11.5 x 4 mm adhesive 5 g segments in a single layer.
 well=box(-18,18,28,48,-3.8,2.05)
 old_ridge=box(-16.2,15.2,32,47,2.01,12)
 recess=box(-9.2,9.2,49.7,71.15,.8,3)
 pad=box(-6.7,6.7,50.5,68,.79,1.09)
 port=(cq.Workplane('XZ').center(0,3.75).rect(9.8,4.6).extrude(8)
       .edges('|Y').fillet(1).val().translate((0,76,0)))
 body=body.cut(well).cut(old_ridge).cut(recess).fuse(pad).cut(port).clean()
 # 5 mm through-hole NeoPixel beside the display. A simple circular hole
 # and rear shoulder in the faceplate retain the LED with an adhesive dot.
 collar=front(cylinder(4,2.8,(18.2,1.2,19),(0,1,0)))
 hole=front(cylinder(2.7,8,(18.2,-3,19),(0,1,0)))
 shoulder=front(cylinder(3.2,2,(18.2,2.5,19),(0,1,0)))
 led_face=face.fuse(collar).cut(hole).cut(shoulder).clean()
 parts={'01-igor-flat-base-shell':body,'02-igor-front-led-faceplate':led_face,
        '03-igor-hat-original':hat,'04-igor-small-inlay-original':small,'05-igor-large-inlay-original':big}
 return original,face,parts,additions+[well,old_ridge,recess,pad,port],[collar,hole,shoulder]

def main():
 for d in ('cad','stl','assembly-meshes','validation','views'):(OUT/d).mkdir(parents=True,exist_ok=True)
 original,original_face,parts,body_regions,face_regions=geometry()
 source=source_parts();body=parts['01-igor-flat-base-shell']
 # Direct orientation assertions: the intended bottom is horizontal, the
 # encoder mounting face is horizontal, and the rear face is vertical.
 base=source[4].Faces()[12];top=source[4].Faces()[9];rear=source[4].Faces()[16]
 assert abs(base.normalAt().z+1)<1e-7 and abs(base.Center().z)<1e-6
 assert abs(top.normalAt().z-1)<1e-7 and abs(top.Center().z-38)<1e-6
 assert abs(rear.normalAt().y-1)<1e-7 and abs(rear.normalAt().z)<1e-7
 assert abs(source[2].Faces()[0].normalAt().z)>.01
 shell_delta=outside_changes(body,original,body_regions)
 face_delta=outside_changes(parts['02-igor-front-led-faceplate'],original_face,face_regions)
 assert shell_delta<.001 and face_delta<.001
 # An entire slab of the raised front nose remains bit-for-bit geometrically
 # equal; no weight recess or extension is allowed forward of Y=17 mm.
 nose=box(-26,26,-2,17,-7,17)
 assert difference(body.intersect(nose),original.intersect(nose))<.001
 unchanged={n:difference(parts[n],s) for n,s in zip(list(parts)[2:],[source[3],source[0],source[1]])}
 assert all(v<.001 for v in unchanged.values())
 report={'passed':True,'extension_down_mm':EXTENSION,'orientation':{'base_z_mm':0,'revised_base_z_mm':-6,
  'encoder_plane_z_mm':38,'encoder_axis_vertical':True,'rear_wall_vertical':True,'display_plane_deg_above_horizontal':60},
  'changes_outside_allowed_regions_mm3':shell_delta+face_delta,'raised_front_nose_unchanged':True,
  'unchanged_original_parts_symmetric_difference_mm3':unchanged,'new_case_parts_or_fasteners':0,'parts':[]}
 assembly=cq.Assembly(name='IGOR-flat-base-front-pixel')
 for name,s in parts.items():
  assert s.isValid() and len(s.Solids())==1,name
  cq.exporters.export(s,str(OUT/'cad'/f'{name}.step'))
  cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{name}.stl'),tolerance=.015,angularTolerance=.08)
  assembly.add(s,name=name)
  # Front-down printing for shell/faceplate; base-down for hat/inlays.
  p=s.rotate((0,0,0),(1,0,0),120) if name.startswith(('01','02')) else s
  target=OUT/'stl'/f'{name}.stl';cq.exporters.export(p,str(target),tolerance=.015,angularTolerance=.08)
  m=trimesh.load_mesh(target);m.apply_translation(-m.bounds[0]);m.export(target)
  assert m.is_watertight and m.is_winding_consistent and len(m.split())==1 and m.volume>0,name
  assert max(m.extents)<256 and abs(m.bounds[0,2])<1e-5
  report['parts'].append({'name':name,'watertight':True,'single_connected_solid':True,'valid_native_solid':True,
   'volume_mm3':s.Volume(),'print_size_mm':m.extents.tolist(),'sha256':hashlib.sha256(target.read_bytes()).hexdigest()})
 assembly.save(str(OUT/'cad/igor-flat-base-v3.step'))
 for n,s in [('original-shell-reference',original),('original-faceplate-reference',original_face)]:
  cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.015,angularTolerance=.08)
 for i,(n,a) in enumerate(parts.items()):
  for n2,b in list(parts.items())[i+1:]:assert a.intersect(b).Volume()<.001,(n,n2)
 report['physical_fit_tested']=False
 (OUT/'validation/geometry.json').write_text(json.dumps(report,indent=2))
 print(json.dumps(report,indent=2),flush=True)
if __name__=='__main__':main()
