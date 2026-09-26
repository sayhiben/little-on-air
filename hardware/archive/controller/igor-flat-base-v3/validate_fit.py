"""Verify actual board, front LED, display envelope, weights and insertion."""
import json,hashlib,math
import cadquery as cq
from build import ROOT,OUT,box,cylinder,front

def main():
 body=cq.importers.importStep(str(OUT/'cad/01-igor-flat-base-shell.step')).val()
 face=cq.importers.importStep(str(OUT/'cad/02-igor-front-led-faceplate.step')).val()
 original=cq.importers.importStep(str(ROOT/'reference/xiao-esp32s3-seeed.step')).val()
 xiao=original.rotate((0,0,0),(1,1,1),120).translate((6.11,58.62,1.64))
 # Conservative circular envelope for a 5 mm through-hole NeoPixel:
 # 7 mm body, 6 mm flange, and space behind for trimmed insulated leads.
 pixel=front(cylinder(2.5,7,(18.2,-4.5,19),(0,1,0)).fuse(
  cylinder(3,1,(18.2,2.5,19),(0,1,0))))
 leads=front(cylinder(1.8,7,(18.2,3.5,19),(0,1,0)))
 oled=front(box(-13.5,13.5,3.6,5,3.9,30.9))
 auxiliary=front(box(-22.2,-18.2,16,34,19,31))
 capacitor=front(cylinder(3.15,8.5,(15,9,4)))
 weights=[box(x,x+11.5,28.5,47.5,-3.8,.2) for x in (-17.5,-5.75,6)]
 parts={'xiao':xiao,'pixel':pixel,'pixel-leads':leads,'oled-envelope':oled,
        'auxiliary':auxiliary,'capacitor':capacitor}
 parts.update({f'weight-{i+1}':s for i,s in enumerate(weights)})
 collisions={}
 for n,s in parts.items():
  for cn,c in [('shell',body),('faceplate',face)]:
   v=c.intersect(s).Volume();assert v<.001,(n,cn,v);collisions[n+' / '+cn]=v
 for i,(n,s) in enumerate(parts.items()):
  for n2,s2 in list(parts.items())[i+1:]:assert s.intersect(s2).Volume()<.001,(n,n2)
 # Retain the verified USB-first board path, expressed in the correct desk
 # frame. Translate through the angled front opening; then align and lower.
 tilt=xiao.rotate((0,71,3.75),(1,71,3.75),-15)
 insertion=[]
 for dy in range(-80,-3):
  p=tilt.translate((0,dy*math.cos(math.pi/6),-dy*.5))
  insertion.append({'front_offset_mm':dy,'collision_mm3':body.intersect(p).Volume()})
 for q in range(9):
  # Connect (-3.464, +2) to (-4, 0) in this correct desk frame.
  p=tilt.translate((0,-4*math.cos(math.pi/6)+q/8*(-4+4*math.cos(math.pi/6)),2-q/8*2))
  insertion.append({'align_socket_fraction':q/8,'collision_mm3':body.intersect(p).Volume()})
 for q in range(-16,1):
  insertion.append({'rearward_offset_mm':q/4,'collision_mm3':body.intersect(tilt.translate((0,q/4,0))).Volume()})
 for q in range(-30,1):
  p=xiao.rotate((0,71,3.75),(1,71,3.75),q/2)
  insertion.append({'tip_deg':q/2,'collision_mm3':body.intersect(p).Volume()})
 assert max(x['collision_mm3'] for x in insertion)<.001,[x for x in insertion if x['collision_mm3']>.001]
 # LED installs into the removed faceplate from its rear, normal to the face.
 for q in range(17):
  p=pixel.translate((0,q*.5*math.cos(math.pi/6),-q*.25))
  assert face.intersect(p).Volume()<.001,('LED insertion',q)
 plug=box(-6,6,72.45,94,.25,7.25)
 assert body.intersect(plug).Volume()<.001
 # Weight well entirely behind the raised nose, no front weight compartment.
 assert all(w.BoundingBox().ymin>=28.49 for w in weights)
 # A whole material slab beneath the well establishes a minimum floor.
 floor=box(-18,18,28,48,-5.9,-3.8)
 assert abs(body.intersect(floor).Volume()-floor.Volume())<.001
 for n,s in [('xiao-reference',xiao),('pixel-reference',pixel),('weight-reference',cq.Compound.makeCompound(weights))]:
  cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.02,angularTolerance=.08)
 report={'passed':True,'xiao_native_collision_mm3':collisions['xiao / shell'],
  'xiao_model_sha256':hashlib.sha256((ROOT/'reference/xiao-esp32s3-seeed.step').read_bytes()).hexdigest(),
  'nominal_collisions_mm3':collisions,'xiao_insertion_samples':insertion,
  'pixel':'5 mm through-hole NeoPixel, 6 mm maximum flange, 7 mm body envelope',
  'pixel_bore_mm':5.4,'led_flange_pocket_mm':6.4,'pixel_insulated_lead_envelope_mm':[3.6,7],
  'weight_segment_max_mm':[19,11.5,4],'weight_count':3,'weight_total_g_if_5g_segments':15,
  'weight_location':'One 36 x 20 mm recess in the true horizontal base; no front nose weights',
  'weight_floor_min_verified_mm':2.1,'usb_aperture_mm':[9.8,4.6],
  'external_cable_body_envelope_mm':[12,7],'pcb_tape_mm':.3,
  'physical_fit_verified':False,'oled_and_encoder':'Original mounts retained; purchased-module solder and wire fit still require prototype check.'}
 (OUT/'validation/fit.json').write_text(json.dumps(report,indent=2))
 print('PASS: nominal fit, board insertion, front LED insertion, OLED clearance, base weights and USB cable.',flush=True)
if __name__=='__main__':main()
