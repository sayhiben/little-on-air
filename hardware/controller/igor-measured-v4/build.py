"""Exact Igor remix fitted to measured hardware; actual desk orientation."""
import json,hashlib,math
import cadquery as cq
from OCP.BRepPrimAPI import BRepPrimAPI_MakePrism
from OCP.gp import gp_Vec
import trimesh
from components import *
OUT=ROOT/'output'
ORIGIN=(7.25603150203824,11.0316793496028,-5.516018234362889)
EXTENSION=9.5

def source_parts():
 p=ROOT/'upstream/igor-v1.step'
 assert hashlib.sha256(p.read_bytes()).hexdigest()=='9645738bee23f74ca35bc64abd22047e27ce61a9ba0c0e83864a13e755bd8c33'
 return [front(s.translate(ORIGIN)) for s in cq.importers.importStep(str(p)).solids().vals()]
def difference(a,b):return a.cut(b).Volume()+b.cut(a).Volume()
def outside_changes(a,b,regions):
 aa=a.cut(b);bb=b.cut(a)
 for r in regions:
  if aa.Volume()>1e-5:aa=aa.cut(r)
  if bb.Volume()>1e-5:bb=bb.cut(r)
 return aa.Volume()+bb.Volume()

def geometry():
 small,big,original_face,original_hat,original=source_parts()
 additions=[cq.Shape.cast(BRepPrimAPI_MakePrism(original.Faces()[i].wrapped,gp_Vec(0,0,-EXTENSION)).Shape()) for i in (11,12,13,63,65,67)]
 nose_mask=front(cq.Workplane(obj=box(-24.51,24.51,-20,120,-.01,100)).edges('|Y').fillet(7.01).val())
 body=original.fuse(*additions).clean().intersect(nose_mask).clean()
 well=box(-20.5,20.5,34.4,68.5,-6.4,3.4)
 ridge=box(-16.2,15.2,32,47,2.01,12)
 tray_pocket=box(-22.2,22.2,49.05,70.9,.8,5.2)
 rear_y=original.Faces()[16].Center().y
 port_fill=box(-5.3,5.3,71.0,rear_y,1.8,8.1)
 port=(cq.Workplane('XZ').center(0,5.46).rect(9.8,4.6).extrude(8).edges('|Y').fillet(1).val().translate((0,76,0)))
 body=body.cut(well).cut(ridge).cut(tray_pocket).fuse(port_fill).cut(port)
 # Close-fitting encoder-box locator attached to existing ceiling.
 enc_outer=box(-7.5,7.5,AXIS_Y-7.5,AXIS_Y+7.5,32.5,36.1)
 enc_inner=box(-6.2,6.2,AXIS_Y-6.2,AXIS_Y+6.2,32.4,35.75)
 tab_relief=box(-6.2,6.2,AXIS_Y+4.4,AXIS_Y+8.5,32.4,36.95)
 collar_relief=cylinder(3.6,6,(0,AXIS_Y,34))
 enc_ring=enc_outer.cut(enc_inner).cut(tab_relief).cut(collar_relief)
 body=body.fuse(enc_ring).cut(tab_relief).cut(collar_relief).clean()

 # Source closure and outer face are retained. Remove only old OLED pegs;
 # install snug edge guides matching measured glass, PCB and ribbon.
 peg_clear=front(box(-13,13,1.49,3.3,3.7,31.0))
 window=front(box(-13.4,12.8,-1,3.0,11.4,26.6))
 bevel=front(cq.Workplane('XZ',origin=(-.3,1.5,19)).rect(26.2,15.2)
             .workplane(offset=1.7).rect(29.6,18.6).loft().val())
 face=original_face.cut(peg_clear).cut(window).cut(bevel)
 supports=[]
 # Vertical edge guides and faceward stops; all PCB holes remain free.
 for x0,x1 in [(-14.8,-14.0),(14.0,14.6)]:supports.append(box(x0,x1,1.4,5.5,2.75,32.25))
 for x0,x1 in [(-14.0,-11.3),(11.3,14.0)]:
  supports.extend([box(x0,x1,1.4,OLED_FRONT,3.15,4.25),box(x0,x1,1.4,OLED_FRONT,30.25,31.45)])
 # End locators only on the corners, never on the glass or lower ribbon.
 for x0,x1 in [(-14,-8),(8,14)]:
  supports.extend([box(x0,x1,OLED_FRONT-.2,5.5,2.75,3.15),box(x0,x1,OLED_FRONT-.2,5.5,31.45,32.25)])
 supports=[front(s) for s in supports]
 face=face.fuse(*supports)
 ribbon_relief=front(box(-7.6,7.6,1.49,4.0,2.85,3.6))
 face=face.cut(ribbon_relief)

 # Diffuser stem and flange: front shoulder prevents push-through. The
 # removable strip cassette captures the flange from the rear.
 seat=front(cylinder(3.8,1.1,(PIXEL_X,1.5,PIXEL_Z),(0,1,0)))
 lens_hole=front(cylinder(2.65,5,(PIXEL_X,-1,PIXEL_Z),(0,1,0)))
 flange_pocket=front(cylinder(3.4,1.3,(PIXEL_X,1.5,PIXEL_Z),(0,1,0)))
 rails=[box(14.1,14.7,1.4,7.2,8.4,29.2),box(21.3,21.9,1.4,7.2,8.4,29.2),
        box(14.1,21.9,2.6,7.2,8.4,9.0)]
 for z0,z1 in [(12.5,14.0),(23.5,25.0)]:
  rails.extend([box(14.1,15.6,6.4,7.2,z0,z1),box(20.4,21.9,6.4,7.2,z0,z1)])
 rails=[front(s) for s in rails]
 face=face.fuse(seat,*rails).cut(lens_hole).cut(flange_pocket).clean()
 lens=front(cylinder(2.5,1.6,(PIXEL_X,-.1,PIXEL_Z),(0,1,0)).fuse(
            cylinder(3.2,.8,(PIXEL_X,1.5,PIXEL_Z),(0,1,0)))).clean()
 cassette=box(14.9,21.1,2.6,6.2,9.2,28.8)
 cassette=cassette.cut(box(15.3,20.7,3.4,5.4,10.0,29.0))
 cassette=cassette.cut(box(15.3,20.7,2.5,3.5,16.3,21.7))
 # Enter from behind with these notches aligned to the retaining tabs,
 # then slide downward 3 mm. No flexing past the original top rim is needed.
 for z0,z1 in [(9.3,11.1),(20.3,22.1)]:
  cassette=cassette.cut(box(14.8,15.8,2.5,6.3,z0,z1)).cut(box(20.2,21.2,2.5,6.3,z0,z1))
 cassette=front(cassette.clean())

 # A separate carrier allows both full-size weights to be loaded first.
 # Sides sit on broad shell ledges, clear of the two weight tops.
 tray=box(-22,22,49.25,70.65,.8,2.8)
 tray=tray.fuse(box(-10.3,-9.1,50,69.8,2.8,4.5),box(9.1,10.3,50,69.8,2.8,4.5),
                box(-9.1,9.1,49.4,49.7,2.8,4.5)).clean()

 # Preserve hat exterior, lift 1.2 mm for push travel and replace its bore.
 hat=original_hat.translate((0,0,HAT_LIFT))
 bore_fill=cylinder(3.5,11.0,(0,AXIS_Y,45.4))
 collar_bore=cylinder(7.2,7.3,(0,AXIS_Y,38.2))
 flat=-math.sqrt(3**2-(5.4/2)**2)
 shaft_bore=d_shape(3.1,flat-.15,45.4,ENC_PCB_TOP+27.25)
 hat=hat.fuse(bore_fill).cut(collar_bore).cut(shaft_bore).clean()
 parts={'01-igor-measured-shell':body,'02-igor-measured-faceplate':face,'03-igor-measured-hat':hat,
  '04-igor-small-inlay-original':small.translate((0,0,HAT_LIFT)),
  '05-igor-large-inlay-original':big.translate((0,0,HAT_LIFT)),
  '06-front-diffuser-PETG':lens,'07-strip-cassette':cassette,'08-xiao-carrier':tray}
 body_regions=additions+[well,ridge,tray_pocket,port_fill,port,enc_outer,tab_relief,collar_relief]
 face_regions=[peg_clear,window,bevel,ribbon_relief,seat,lens_hole,flange_pocket]+supports+rails
 return parts,original,original_face,original_hat,body_regions,face_regions,[bore_fill,collar_bore,shaft_bore]

def main():
 for d in ('cad','stl','assembly-meshes','validation','views','reference-components'):(OUT/d).mkdir(parents=True,exist_ok=True)
 parts,original,of,oh,br,fr,hr=geometry()
 shell_delta=outside_changes(parts['01-igor-measured-shell'],original,br)
 face_delta=outside_changes(parts['02-igor-measured-faceplate'],of,fr)
 hat_delta=outside_changes(parts['03-igor-measured-hat'],oh.translate((0,0,HAT_LIFT)),hr)
 assert max(shell_delta,face_delta,hat_delta)<.01,(shell_delta,face_delta,hat_delta)
 s=source_parts()
 assert abs(s[4].Faces()[12].normalAt().z+1)<1e-7
 assert abs(s[4].Faces()[9].normalAt().z-1)<1e-7
 assert abs(s[4].Faces()[16].normalAt().y-1)<1e-7
 report={'passed':True,'extension_down_mm':EXTENSION,'correct_desk_orientation':True,
  'hat_lift_for_push_mm':HAT_LIFT,'changes_outside_allowed_regions_mm3':shell_delta+face_delta+hat_delta,
  'original_shell_width_and_depth_preserved':True,'parts':[],'physical_fit_tested':False}
 assembly=cq.Assembly(name='IGOR-measured-components-v4')
 for name,shape in parts.items():
  assert shape.isValid() and len(shape.Solids())==1,name
  cq.exporters.export(shape,str(OUT/'cad'/f'{name}.step'))
  cq.exporters.export(shape,str(OUT/'assembly-meshes'/f'{name}.stl'),tolerance=.015,angularTolerance=.08)
  assembly.add(shape,name=name)
  if name.startswith(('01','02','06')):p=shape.rotate((0,0,0),(1,0,0),120)
  elif name.startswith('07'):p=shape.rotate((0,0,0),(1,0,0),-60)
  else:p=shape
  path=OUT/'stl'/f'{name}.stl';cq.exporters.export(p,str(path),tolerance=.015,angularTolerance=.08)
  mesh=trimesh.load_mesh(path);mesh.apply_translation(-mesh.bounds[0]);mesh.export(path)
  assert mesh.is_watertight and mesh.is_winding_consistent and len(mesh.split())==1 and mesh.volume>0,name
  assert max(mesh.extents)<256 and abs(mesh.bounds[0,2])<1e-5
  report['parts'].append({'name':name,'watertight':True,'single_connected_solid':True,'native_valid':True,
   'size_mm':mesh.extents.tolist(),'volume_mm3':shape.Volume(),'sha256':hashlib.sha256(path.read_bytes()).hexdigest()})
 assembly.save(str(OUT/'cad/igor-measured-v4.step'))
 collisions=[]
 for i,(n,a) in enumerate(parts.items()):
  for n2,b in list(parts.items())[i+1:]:
   v=a.intersect(b).Volume()
   if v>.001:collisions.append([n,n2,v])
 assert not collisions,collisions
 for n,shape in [('original-shell-reference',original),('original-faceplate-reference',of),('original-hat-reference',oh)]:
  cq.exporters.export(shape,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.02,angularTolerance=.08)
 (OUT/'validation/geometry.json').write_text(json.dumps(report,indent=2))
 (ROOT/'MEASUREMENTS.json').write_text(json.dumps(MEASUREMENTS,indent=2))
 print(json.dumps(report,indent=2),flush=True)
if __name__=='__main__':main()
