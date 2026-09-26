import importlib.util,math,json
from pathlib import Path
def run(_context:str):
 s=importlib.util.spec_from_file_location('slim',str(Path(__file__).with_name('build_slim.py')));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);b=m.b
 screws=b.component('REF M3 screws','Eight identical M3x8 button heads, maximum 5.7 diameter x1.65 height')
 nuts=b.component('REF M3 nuts','Ordinary M3 nuts, 5.5 across flats x2.4 thick')
 records=[]
 for i,(x,y) in enumerate(m.FAST+[(60,6),(60,54)]+m.YFAST):
  optical=i in (4,5);keeper=i>=6
  bearing=9.075 if optical else 9.65 if keeper else 6.6
  shaft=(bearing-8,bearing) if optical else (bearing,bearing+8)
  head=(bearing,bearing+1.65) if optical else (bearing-1.65,bearing)
  nut=(3.3,5.7) if optical else (13.9,16.3) if keeper else (11.6,14.0)
  name='Optical screw' if optical else 'Keeper screw' if keeper else 'Closure screw'
  b.cyl(screws,name+' shaft',x,y,shaft[0],3,8);b.cyl(screws,name+' head',x,y,head[0],5.7,1.65)
  sk=b.sketch(nuts,'Nut profile',nut[0]);r=5.5/math.sqrt(3);a=math.pi/2 if i==2 else 0
  b.polygon(sk,[(x+r*math.cos(a+j*math.pi/3),y+r*math.sin(a+j*math.pi/3)) for j in range(6)])
  b.extrude(nuts,sk,-2.4,'M3 nut')
  # Real nuts contain the screw; cut their centre clearance for native overlap QA.
  b.cutcyl(nuts,'M3 threaded bore envelope',x,y,nut[0]-.01,3.01,2.42)
  records.append({'type':name,'xy':[x,y],'head_depth':head,'shaft_depth':shaft,'nut_depth':nut,'engagement_mm':round(min(shaft[1],nut[1])-max(shaft[0],nut[0]),4),'tip_clearance_mm':.425 if optical else .55 if keeper else .6})
 for c in (screws,nuts):b.paint(c,'Connector steel',(150,160,171))
 (m.OUT/'hardware-layout.json').write_text(json.dumps(records,indent=2));m.checkpoint('common-hardware')
