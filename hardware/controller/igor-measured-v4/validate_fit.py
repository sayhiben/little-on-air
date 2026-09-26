"""Component-to-print and module-to-module checks for supplied measurements."""
import json,math,hashlib
import cadquery as cq
from build import OUT,EXTENSION
from components import *

def main():
 printed={p.stem:cq.importers.importStep(str(p)).val() for p in sorted((OUT/'cad').glob('0*.step'))}
 c=all_components()
 # Mesh references are strictly illustrative component envelopes, never STLs
 # offered as printable parts. Include a native reference assembly as well.
 asm=cq.Assembly(name='Measured-hardware-reference')
 for n,s in c.items():
  asm.add(s,name=n)
  cq.exporters.export(s,str(OUT/'reference-components'/f'{n}.step'))
  cq.exporters.export(s,str(OUT/'assembly-meshes'/f'{n}.stl'),tolerance=.02,angularTolerance=.08)
 asm.save(str(OUT/'reference-components/measured-hardware.step'))
 errors=[];contacts=[]
 for n,a in printed.items():
  for cn,b in c.items():
   v=a.intersect(b).Volume()
   if v>.001:errors.append({'printed':n,'component':cn,'overlap_mm3':v})
 groups={'encoder':[n for n in c if n.startswith('encoder-')],
         'oled':[n for n in c if n.startswith('oled-')],
         'pixel':[n for n in c if n.startswith('pixel-')],
         'xiao':['xiao'],'weight-left':['weight-left'],'weight-right':['weight-right'],
         'auxiliary':['auxiliary-envelope'],'capacitor':['capacitor-envelope']}
 for i,(g,names) in enumerate(groups.items()):
  for g2,names2 in list(groups.items())[i+1:]:
   for n in names:
    for n2 in names2:
     v=c[n].intersect(c[n2]).Volume()
     if v>.001:errors.append({'components':[n,n2],'overlap_mm3':v})
 report={'passed':False,'nominal_component_fit_passed':not errors,'component_collisions':errors,'physical_fit_verified':False,
  'component_source':'User-supplied measured envelopes plus Seeed XIAO reference STEP',
  'xiao_reference_sha256':hashlib.sha256((ROOT/'reference/xiao-esp32s3-seeed.step').read_bytes()).hexdigest()}
 (OUT/'validation/fit.json').write_text(json.dumps(report,indent=2))
 print(json.dumps(errors,indent=2),flush=True)
 assert not errors,'Resolve reported interferences before insertion checks.'

 body=printed['01-igor-measured-shell'];face=printed['02-igor-measured-faceplate']
 hat=printed['03-igor-measured-hat'];tray=printed['08-xiao-carrier']
 cassette=printed['07-strip-cassette'];lens=printed['06-front-diffuser-PETG']
 # A 1 mm press moves only the knob/shaft, leaving collar and encoder body fixed.
 push=[]
 for q in range(11):
  dz=-q*.1;p=hat.translate((0,0,dz))
  v=p.intersect(body).Volume()+p.intersect(c['encoder-collar']).Volume()
  v+=p.intersect(c['encoder-shaft'].translate((0,0,dz))).Volume()
  push.append({'press_mm':-dz,'overlap_mm3':v})
 assert max(x['overlap_mm3'] for x in push)<.001,push
 # Hat rotation sweeps the exterior independently of its matching D shaft.
 for degrees in range(0,360,15):
  assert hat.rotate((0,AXIS_Y,0),(0,AXIS_Y,1),degrees).intersect(body).Volume()<.001
 # Encoder goes in before weights/carrier. Feed it through the angled front,
 # turn it upright low in the empty base, then raise the shaft into its hole.
 enc_parts=[v for n,v in c.items() if n.startswith('encoder-') and n!='encoder-connector-envelope']
 enc_module=compound(enc_parts)
 def enc_pose(angle,y,z):
  return enc_module.rotate((0,AXIS_Y,ENC_PCB_TOP),(1,AXIS_Y,ENC_PCB_TOP),angle).translate((0,y-AXIS_Y,z-ENC_PCB_TOP))
 encoder_path=[]
 initial=enc_pose(-120,20,16.5)
 for d in range(80,-1,-2):
  p=initial.translate((0,-d*math.cos(math.pi/6),d*.5))
  encoder_path.append(body.intersect(p).Volume())
 way=[(-120,20,16.5),(-120,20,20.5),(-90,35,15),(-60,40,15),(-30,44,7),(-15,47,5),(0,AXIS_Y,5.5)]
 for a,b in zip(way,way[1:]):
  steps=max(8,int(abs(b[0]-a[0])/2.5))
  for q in range(steps+1):
   p=enc_pose(*[u+(v-u)*q/steps for u,v in zip(a,b)])
   encoder_path.append(body.intersect(p).Volume())
 for q in range(47):encoder_path.append(body.intersect(enc_module.translate((0,0,-23+q*.5))).Volume())
 assert max(encoder_path)<.001,('encoder insertion',max(encoder_path))
 # Weights first: enter through the front high in the empty shell, then lower.
 insert=[]
 for name in ('weight-left','weight-right'):
  w=c[name]
  for dy in range(-100,1,2):
   p=w.translate((0,dy,24));v=body.intersect(p).Volume()+enc_module.intersect(p).Volume()
   insert.append({'part':name,'front_offset':dy,'overlap_mm3':v})
  for q in range(49):
   p=w.translate((0,0,24-q*.5));v=body.intersect(p).Volume()+enc_module.intersect(p).Volume()
   insert.append({'part':name,'height_offset':24-q*.5,'overlap_mm3':v})
 assert max(x['overlap_mm3'] for x in insert)<.001,[x for x in insert if x['overlap_mm3']>.001]
 # The carrier can be inserted without forcing the weight envelopes.
 carrier_path=[]
 for dy in range(-100,1,2):
  p=tray.translate((0,dy,16));v=body.intersect(p).Volume()+enc_module.intersect(p).Volume()
  carrier_path.append(v)
 for q in range(33):
  p=tray.translate((0,0,16-q*.5));v=body.intersect(p).Volume()
  v+=p.intersect(c['weight-left']).Volume()+p.intersect(c['weight-right']).Volume()
  v+=enc_module.intersect(p).Volume()
  carrier_path.append(v)
 assert max(carrier_path)<.001,('carrier insertion',max(carrier_path))
 # Then insert the XIAO socket-first with its front tipped up 15 degrees.
 xiao=c['xiao'];tilted=xiao.rotate((0,71,5.46),(1,71,5.46),-15)
 xiao_path=[]
 obstacles=compound([body,tray,enc_module])
 for d in range(-100,-3,2):
  p=tilted.translate((0,d,8));xiao_path.append(obstacles.intersect(p).Volume())
 for q in range(17):
  p=tilted.translate((0,-4,8-q*.5))
  xiao_path.append(obstacles.intersect(p).Volume())
 for q in range(-16,1):xiao_path.append(obstacles.intersect(tilted.translate((0,q/4,0))).Volume())
 for q in range(-30,1):xiao_path.append(obstacles.intersect(xiao.rotate((0,71,5.46),(1,71,5.46),q/2)).Volume())
 assert max(xiao_path)<.001,('XIAO insertion',max(xiao_path))
 # Faceplate subassembly: fit the diffuser from behind, then slide the
 # cassette into its rails from above. Adhesive at its top prevents sliding.
 for d in range(17):
  delta=(0,d*.5*math.cos(math.pi/6),-d*.25)
  assert face.intersect(lens.translate(delta)).Volume()<.001,('lens insertion',d)
 for q in range(33):
  depth=8-q*.25
  delta=(0,depth*math.cos(math.pi/6)+1.5,-depth*.5+3*math.cos(math.pi/6))
  assert face.intersect(cassette.translate(delta)).Volume()<.001,('cassette rear entry',q)
 for q in range(13):
  dz=3-q*.25;delta=(0,dz*.5,dz*math.cos(math.pi/6))
  assert face.intersect(cassette.translate(delta)).Volume()<.001,('cassette latch slide',q)
 for d in range(19):
  delta=(0,d*.5,d*math.cos(math.pi/6))
  assert cassette.intersect(c['pixel-strip-envelope'].translate(delta)).Volume()<.001,('strip insertion',d)
 # Captured flange cannot escape through the opening or through its cassette.
 forward=lens.translate((0,-.5*math.cos(math.pi/6),.25))
 backward=lens.translate((0,.6*math.cos(math.pi/6),-.3))
 assert face.intersect(forward).Volume()>.1
 assert cassette.intersect(backward).Volume()>.1
 # Verify the fully populated front closes over the fixed internal modules.
 front_items=[face,lens,cassette]+[v for n,v in c.items() if n.startswith(('oled-','pixel-'))]
 front_module=compound(front_items)
 fixed=compound([body,hat,tray,c['xiao'],enc_module,c['encoder-connector-envelope'],c['weight-left'],c['weight-right']])
 closure=[]
 for q in range(41):
  d=20-q*.5;p=front_module.translate((0,-d*math.cos(math.pi/6),d*.5))
  closure.append(fixed.intersect(p).Volume())
 assert max(closure)<.001,('populated face closure',max(closure))
 # A face-normal ray slab spanning the measured active area remains open.
 sight=front(box(-13.05,12.45,-.3,OLED_FRONT-2,11.75,26.25))
 assert face.intersect(sight).Volume()<.001
 # The untrimmed solder envelopes were included above. Validate a continuous
 # floor below both weights, not just the center of the cavity.
 floor=box(-20.5,20.5,34.4,68.5,-8.8,-6.4)
 assert abs(body.intersect(floor).Volume()-floor.Volume())<.01
 report.update(passed=True,push_samples=push,encoder_insertion_max_overlap_mm3=max(encoder_path),xiao_insertion_max_overlap_mm3=max(xiao_path),weight_insertion_max_overlap_mm3=max(x['overlap_mm3'] for x in insert),
  carrier_insertion_max_overlap_mm3=max(carrier_path),populated_face_closure_max_overlap_mm3=max(closure),diffuser_captured_front_and_rear=True,
  measured_active_area_unobstructed=True,weight_floor_verified_mm=2.4,
  clearances_mm={'weight_side_per_outer_edge':.25,'weight_gap_between':.5,'weight_under_xiao_carrier':.7,
   'encoder_box_each_side':.2,'encoder_box_top_adhesive_gap':.25,'collar_radial':.2,
   'knob_rest_to_shell':1.2,'knob_after_1mm_press_to_shell':.2,'D_shaft_radial':.1,
   'D_flat':.15,'OLED_PCB_sides':.2,'OLED_PCB_ends':.2,'OLED_glass_to_faceplate_rear':.5,
   'strip_each_side':.2,'strip_each_end':.2,'strip_back_mount_tape':.2,
   'diffuser_stem_radial':.15,'diffuser_flange_radial':.2,'diffuser_back_to_LED_envelope':1.5,
   'cassette_side':.2,'cassette_back':.2,'xiao_carrier_sides':.2,'xiao_PCB_side':.21,'xiao_mount_tape':.3},
  assumed_connector_envelopes={'encoder_mm':[13.5,8.5,3],'oled_mm':[10.8,8,2.6]},
  limitations=MEASUREMENTS['assumptions'])
 (OUT/'validation/fit.json').write_text(json.dumps(report,indent=2))
 print('PASS: all measured components, motion, weight loading, cassette insertion, diffuser capture and active display aperture.',flush=True)
if __name__=='__main__':main()
