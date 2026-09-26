"""Original annotated projection of the checked rearward wire paths."""
from pathlib import Path
from html import escape
import json,math,csv
OUT=Path(__file__).resolve().parents[1]/'output/v216'
routes=json.loads((OUT/'candidate-routes.json').read_text())
colors={'H1':'#ad4a12','H2':'#16827c','H3':'#7151ac','H4':'#2874b7'}
s=['<svg xmlns="http://www.w3.org/2000/svg" width="1400" height="1100" viewBox="0 0 1400 1100"><rect width="1400" height="1100" fill="#f5f7fa"/><style>text{font-family:Arial,sans-serif;fill:#172b40}.small{font-size:15px}.body{font-size:18px}.title{font-size:30px;font-weight:bold}.heading{font-size:22px;font-weight:bold}</style>']
def txt(x,y,t,cls='body',fill=None):s.append(f'<text x="{x}" y="{y}" class="{cls}"'+(f' style="fill:{fill}"' if fill else '')+f'>{escape(t)}</text>')
def line(x1,y1,x2,y2,c='#7c8da0',w=1.5):s.append(f'<path d="M{x1},{y1} L{x2},{y2}" stroke="{c}" stroke-width="{w}" fill="none"/>')
def rect(x,y,w,h,c,stroke='none',r=0):s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" fill="{c}" stroke="{stroke}"/>')
def lines(x,y,text,cls='body',step=25):
 for i,t in enumerate(text):txt(x,y+i*step,t,cls)
txt(40,48,'LED wiring that turns rearward', 'title')
txt(40,78,'v2.16 · Reprint 05 housing + 06 yoke · Reuse the front, optics and guides')
rect(25,99,884,584,'white','#dae2eb',12);rect(930,99,445,956,'white','#dae2eb',12)
txt(48,132,'FRONT VIEW · Top ports upward','heading')
txt(48,157,'Looking inside from the rear reverses left and right. Colors identify runs, not pins.','small')
scale=6.1;ox=83;oy=602
def xy(x,y):return ox+x*scale,oy-y*scale
def box(x,y,w,h,fill,stroke='#a8b6c6'):
 a,b=xy(x,y+h);rect(a,b,w*scale,h*scale,fill,stroke,3)
box(-4.5,-4.5,129,69,'#edf1f5');box(0,0,120,60,'#fff')
box(8,11,104,38,'#eff8fc','#bed7e5')
box(36,13,52,21,'#f1f1f1');a,b=xy(42,24);txt(a,b,'BATTERY 52 × 21','small')
box(12,27.2,17.5,28.1,'#ece8f3');a,b=xy(13,34);txt(a,b,'CH1','small')
box(86.5,34,17.8,21,'#ecf0f5');a,b=xy(89,43);txt(a,b,'XIAO','small')
box(33.7,53,12.6,5.05,'#e7eaee');box(55.45,54.1,9.1,3.72,'#e7eaee')
for x,y in ((4.2,4.2),(115.8,4.2),(4.2,55.8),(115.8,55.8),(60,6.8),(60,52.05)):
 a,b=xy(x,y);s.append(f'<circle cx="{a}" cy="{b}" r="{4.2*scale}" fill="#dce2e9" stroke="#a9b6c5"/>')
box(4,14,13,10,'#ffe9dc','#cc9b7c');box(70,5.2,12,3.2,'#ffe9dc','#cc9b7c');box(99,15,8,11.5,'#e9edf3')
for r in routes:
 pts=' '.join(f'{xy(p[0],p[1])[0]:.2f},{xy(p[0],p[1])[1]:.2f}' for p in r['points'])
 s.append(f'<polyline points="{pts}" fill="none" stroke="{colors[r["name"][:2]]}" stroke-width="4.1" stroke-linecap="round" stroke-linejoin="round"/>')
for number,x,y,label in [(1,76,2.8,'1 · IN'),(2,36,2.8,'2'),(3,36,48.05,'3'),(4,76,48.05,'4 · END')]:
 box(x,y,8,8,'#293c4f','#fff');a,b=xy(x+4,y+4)
 s.append(f'<text x="{a}" y="{b+6}" text-anchor="middle" class="body" style="fill:white;font-weight:bold">{number}</text>')
 ey=y+8 if number<3 else y;a,b=xy(x,ey);line(a,b,a+8*scale,b,'#e9b743',4)
for x,y,t in [(6,18,'J1'),(70,12,'R1'),(99,29,'C1'),(57,47,'H4'),(53,14,'H2'),(14,42,'H3'),(77,-3,'H1 → 1')]:
 a,b=xy(x,y);txt(a,b,t,'small')
txt(48,659,'Pixel order: 1 lower-right → 2 lower-left → 3 upper-left → 4 upper-right','body')
txt(953,137,'LAY WIRES IN BEFORE CLAMPING','heading')
lines(953,173,['Three separate flexible wires per run.','Insulation OD ≤1.8 mm; not a thick bundle.','Keep every emitter aimed into the acrylic.','Verify actual DIN / DOUT pad markings.'],'body',27)
y=300
for code,title,desc in [
 ('H1','Input feed along bottom',['Deep lanes D19.6 / D16.8 mm.','Broad right return toward pixel 1.','R1 sits in the DATA lead near that pixel.']),
 ('H2','Lower connection',['D12.8 mm behind optical screw head.','Gentle turns back from the inner pads.']),
 ('H3','Left-side connection',['D13.85 mm over the charger’s bare face.','Three columns; reversed order at top.','Moved charger contact clears the wires.']),
 ('H4','Upper connection',['D12.85 mm in the rear-open yoke groove.','Ahead of MODE terminals.','Seat the wires before tightening yoke 06.'])]:
 line(953,y-6,980,y-6,colors[code],5);txt(994,y,code+' · '+title,'body',colors[code]);lines(953,y+30,desc,'small',23);y+=35+23*len(desc)+24
lines(953,879,['D = depth from the visible front surface.','Larger D means farther into the enclosure.','','No new wire-tunnel roofs or extra clips.','Small glue anchors on insulation retain runs.','Keep glue off pads, seats and mating faces.'],'small',25)
rect(25,704,884,351,'white','#dae2eb',12)
txt(48,741,'SECTION THROUGH LOWER INNER-PAD LINK H2','heading')
txt(48,768,'One of three parallel wires shown · 3 mm centerline bend radii · dimensions in mm','small')
sx=60;sy=804;scx=10;scd=9
def section(x,d):return sx+(x-30)*scx,sy+d*scd
def sb(x,d,w,h,fill):
 a,b=section(x,d);rect(a,b,w*scx,h*scd,fill)
sb(30,0,64,1.8,'#dce2e9');sb(36,2.1875,8,2,'#293c4f');sb(76,2.1875,8,2,'#293c4f')
sb(55.8,1.5,8.4,5.975,'#dce2e9');sb(55.8,7.475,8.4,1.6,'#a8b6c6');sb(57.15,9.075,5.7,1.65,'#7b8c9e')
r=next(r for r in routes if r['name'].startswith('H2') and r['name'].endswith('lane1'))
pts=' '.join(f'{section(p[0],p[2])[0]:.2f},{section(p[0],p[2])[1]:.2f}' for p in r['points'])
s.append(f'<polyline points="{pts}" stroke="{colors["H2"]}" stroke-width="12" fill="none" stroke-linecap="round"/>')
txt(710,821,'Front surface','small');txt(710,866,'Optical screw boss','small');txt(710,902,'Screw head','small');txt(710,940,'H2 at D12.8','small',colors['H2'])
txt(48,999,'Wire drops behind the mount; the existing front frame and screw stay unchanged.','body')
txt(48,1030,'Schematic outlines · complete solids checked in CAD · physically dry-fit actual pads and solder','small')
txt(40,1083,'12 wire routes checked at Ø2.0 mm envelope · ≥3 mm modeled bend radius · This revision has not yet been physically printed.','small')
s.append('</svg>');(OUT/'front-wiring.svg').write_text('\n'.join(s),encoding='utf-8')
with (OUT/'harness-length-guide.csv').open('w',newline='',encoding='utf-8') as f:
 w=csv.writer(f);w.writerow(['Run','Nominal modeled centerline mm','Cutting / fitting instruction'])
 for r in sorted(routes,key=lambda r:r['name']):
  length=sum(math.dist(a,b) for a,b in zip(r['points'],r['points'][1:]))
  w.writerow([r['name'],round(length,1),'Not a cut length: excludes pad fanout/end joints; start overlong, dry-fit, trim; lane is not a pin number'])
