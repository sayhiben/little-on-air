from pathlib import Path
import xml.etree.ElementTree as E,json
OUT=Path(__file__).resolve().parents[1]/'output/v21/laser';NS='http://www.w3.org/2000/svg'
E.register_namespace('',NS)
def tag(n):return '{'+NS+'}'+n
def root(w,h,title):
 r=E.Element(tag('svg'),width=f'{w}mm',height=f'{h}mm',viewBox=f'0 0 {w} {h}')
 E.SubElement(r,tag('title')).text=title;return r
def cut(r,d):E.SubElement(r,tag('path'),d=d,fill='none',stroke='#ff0000',**{'stroke-width':'.02'})
def save(r,name):E.indent(r);E.ElementTree(r).write(OUT/name,encoding='utf-8',xml_declaration=True)
def main():
 OUT.mkdir(exist_ok=True)
 r=root(40,30,'KERF TEST: 20 mm plug and opening. Cut at zero offset; measure both.')
 cut(r,'M 10,5 L 30,5 L 30,25 L 10,25 Z');cut(r,'M 0,0 L 40,0 L 40,30 L 0,30 Z');save(r,'91-kerf-plug-and-frame-CUT.svg')
 master=json.loads((OUT/'shared-front-master.json').read_text());loops=master['loops'];xs=[p[0] for l in loops for p in l];ys=[p[1] for l in loops for p in l]
 scale=18/(max(xs)-min(xs));r=root(84,48,'Rear-engrave interval/power test. Nine independently colored filled samples; no cutting.')
 colors=['#0000ff','#00ff00','#00ffff','#ff00ff','#ffff00','#000000','#808080','#800000','#008000']
 for n,color in enumerate(colors):
  x=4+(n%3)*27;y=4+(n//3)*15
  d=' '.join('M '+' L '.join(f'{x+18-(px-min(xs))*scale:.5f},{y+(max(ys)-py)*scale:.5f}' for px,py in loop)+' Z' for loop in loops)
  E.SubElement(r,tag('path'),d=d,fill=color,**{'fill-rule':'evenodd','stroke':'none'})
  for k,w in enumerate([.15,.2,.3,.4,.5]):E.SubElement(r,tag('rect'),x=str(x+k*3.5),y=str(y+7),width=str(w),height='3',fill=color)
 save(r,'92-engraving-quality-nine-samples-FILL.svg')
 # Verify operation count and physical scaling independently after serialization.
 results=[]
 for p in sorted(OUT.glob('*.svg')):
  x=E.parse(p).getroot();results.append({'file':p.name,'width':x.get('width'),'height':x.get('height'),'path_count':len(x.findall('.//'+tag('path'))),'text_elements':len(x.findall('.//'+tag('text')))})
 (OUT/'svg-inventory.json').write_text(json.dumps(results,indent=2));print(json.dumps(results))
if __name__=='__main__':main()
