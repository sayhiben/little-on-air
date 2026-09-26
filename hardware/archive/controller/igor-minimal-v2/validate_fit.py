"""Nominal solid-fit checks against the exact Seeed XIAO model."""
import json,hashlib,math
import cadquery as cq
from build import ROOT,OUT,box,slope,cylinder

def main():
 body=cq.importers.importStep(str(OUT/'cad/01-igor-shell-minimal.step')).val()
 face=cq.importers.importStep(str(OUT/'cad/02-igor-faceplate-original.step')).val()
 original=cq.importers.importStep(str(ROOT/'reference/xiao-esp32s3-seeed.step')).val()
 local=original.rotate((0,0,0),(1,1,1),120).translate((6.11,58.62,-8.36))
 xiao=slope(local)
 pcb=box(7.2,17.2,1.7,11.7,32.7,34.3)
 emitter=box(9.7,14.7,4.2,9.2,34.3,35.9)
 pixel=pcb.fuse(emitter)
 auxiliary=box(-22.2,-18.2,16,34,19,31)
 capacitor=cylinder(3.15,8.5,(15,9,4))
 weights=[box(x,x+19,4.75,16.25,-3.5,.5) for x in (-19.25,.25)]
 weights += [slope(box(x,x+11.5,25,44,-12.7,-8.7)) for x in (-17.5,-5.75,6)]
 parts={'xiao':xiao,'pixel':pixel,'auxiliary':auxiliary,'capacitor':capacitor}
 parts.update({f'weight-{i+1}':s for i,s in enumerate(weights)})
 collisions={}
 for n,s in parts.items():
  for cn,c in [('shell',body),('faceplate',face)]:
   v=c.intersect(s).Volume();assert v<.001,(n,cn,v);collisions[n+' / '+cn]=v
 for i,(n,s) in enumerate(parts.items()):
  for n2,s2 in list(parts.items())[i+1:]:
   v=s.intersect(s2).Volume();assert v<.001,(n,n2,v)
 # Tip the board's front UP 15 degrees about the USB end. Slide from the
 # existing front opening, then lower the front onto its insulating tape.
 tilted=slope(local.rotate((0,71,-6.25),(1,71,-6.25),-15))
 insertion=[]
 for dy in range(-80,-3):
  v=body.intersect(tilted.translate((0,dy,0))).Volume()
  insertion.append({'front_offset_mm':dy,'collision_mm3':v})
 for q in range(9):
  delta=(0,-4+q/8*(4-4*math.cos(math.pi/6)),-q/8*2)
  v=body.intersect(tilted.translate(delta)).Volume()
  insertion.append({'align_socket_fraction':q/8,'collision_mm3':v})
 for q in range(-16,1):
  v=body.intersect(slope(local.rotate((0,71,-6.25),(1,71,-6.25),-15).translate((0,q/4,0)))).Volume()
  insertion.append({'slope_advance_offset_mm':q/4,'collision_mm3':v})
 for q in range(-30,1):
  deg=q/2
  v=body.intersect(slope(local.rotate((0,71,-6.25),(1,71,-6.25),deg))).Volume()
  insertion.append({'tip_deg':deg,'collision_mm3':v})
 assert max(x['collision_mm3'] for x in insertion)<.001
 for dy in range(-40,1):
  v=body.intersect(pixel.translate((0,dy,0))).Volume()
  assert v<.001,('pixel insertion',dy,v)
 # USB socket's end stands 0.21 mm beyond the exterior wall. A cable shell
 # begins there, so its plastic body need not fit through the smaller hole.
 plug=slope(box(-6,6,72.45,94,-9.75,-2.75))
 assert body.intersect(plug).Volume()<.001
 for n,s in [('xiao-reference',xiao),('pixel-reference',pixel),('weight-reference',cq.Compound.makeCompound(weights))]:
  cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.02,angularTolerance=.08)
 report={'passed':True,'xiao_native_collision_mm3':collisions['xiao / shell'],
  'xiao_model_sha256':hashlib.sha256((ROOT/'reference/xiao-esp32s3-seeed.step').read_bytes()).hexdigest(),
  'nominal_part_collisions_mm3':collisions,'xiao_front_insertion':insertion,
  'insertion_sampling':'1 mm front translation, lower 2 mm to align socket, 0.25 mm slide along slope, then 0.5 degree lowering increments; bare board without wires',
  'usb_aperture_mm':[9.8,4.6],'usb_socket_proud_of_rear_wall_mm':.21,
  'external_cable_body_envelope_mm':[12,7],'pcb_insulating_tape_thickness_mm':.3,
  'pixel_pcb_mm':[10,10,1.6],'pixel_emitter_mm':[5,5,1.6],
  'weight_segment_max_mm':[19,11.5,4],'weight_count':5,'weight_total_g_if_5g_segments':25,
  'weight_recess_min_floor_mm':2.2,'auxiliary_envelope_mm':[18,12,4],
  'physical_fit_verified':False,
  'oled_encoder':'Exact original Igor mounting geometry retained. Check purchased module and solder clearances before printing.'}
 (OUT/'validation/fit.json').write_text(json.dumps(report,indent=2))
 print('PASS: nominal component fit, board and LED insertion, five weights and external USB cable clearance.',flush=True)

if __name__=='__main__':main()
