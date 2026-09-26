from pathlib import Path
import json,xml.etree.ElementTree as E,hashlib
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output'/'v2'/'laser'
NS='http://www.w3.org/2000/svg';INK='http://www.inkscape.org/namespaces/inkscape'
E.register_namespace('',NS);E.register_namespace('inkscape',INK)
def tag(n):return '{'+NS+'}'+n
def main():
 master=json.loads((BASE/'output'/'laser'/'master-contours.json').read_text());OUT.mkdir(parents=True,exist_ok=True)
 report=[]
 for name,mirror in [('02-acrylic-REAR-engrave-and-cut',True),('03-optional-laminate-FRONT-engrave-and-cut',False)]:
  def xy(p):
   x,y=p[0]-8,p[1]-11
   return (104-x if mirror else x,38-y)
  def path(loops):return ' '.join('M '+' L '.join(f'{x:.5f},{y:.5f}' for x,y in map(xy,loop))+' Z' for loop in loops)
  r=E.Element(tag('svg'),width='104mm',height='38mm',viewBox='0 0 104 38')
  E.SubElement(r,tag('title')).text=name+' | 104 x 38 mm'
  E.SubElement(r,tag('desc')).text=('Already mirrored for rear engraving, including keyed corner. Do not mirror again. ' if mirror else 'Front engraving of laser-safe black-over-white laminate; not mirrored. ')+ 'Blue filled lettering: Fill engrave first. Red closed outline: Line cut last. No kerf offset. All text is paths.'
  for id,label,d,attrs in [('ENGRAVE','01 BLUE - FILL ENGRAVE FIRST',path(master['loops']),{'fill':'#0000ff','fill-rule':'evenodd','stroke':'none'}),('CUT','02 RED - LINE CUT LAST',path([master['outline']]),{'fill':'none','stroke':'#ff0000','stroke-width':'0.02'})]:
   g=E.SubElement(r,tag('g'),id=id);g.set('{'+INK+'}groupmode','layer');g.set('{'+INK+'}label',label)
   E.SubElement(g,tag('path'),d=d,**attrs)
  E.indent(r);p=OUT/(name+'.svg');E.ElementTree(r).write(p,encoding='utf-8',xml_declaration=True)
  rr=E.parse(p).getroot();assert rr.get('width')=='104mm' and rr.get('height')=='38mm';assert not rr.findall('.//'+tag('text'))
  loops=rr.findall('.//'+tag('path'));assert len(loops)==2 and loops[0].get('d').count('Z')==len(master['loops']) and loops[1].get('d').count('Z')==1
  # Invert the exported coordinate mapping and compare every formatted point.
  import re
  for element,source in zip(loops,[master['loops'],[master['outline']]]):
   points=[tuple(map(float,pair)) for pair in re.findall(r'(-?\d+\.\d+),(-?\d+\.\d+)',element.get('d'))]
   recovered=[(8+(104-x if mirror else x),49-y) for x,y in points]
   expected=[pt for loop in source for pt in loop]
   assert len(recovered)==len(expected) and max(abs(a-b) for a,b in zip(sum((list(p) for p in recovered),[]),sum((list(p) for p in expected),[])))<.000006
  report.append({'file':p.name,'mm':[104,38],'mirrored':mirror,'cut_contours':1,'engrave_contours':len(master['loops']),'text_is_paths':True,'kerf_offset_mm':0,'exact_shared_master_within_mm':.000006,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
 (OUT/'shared-front-master.json').write_text(json.dumps(master,indent=2));(OUT/'artwork-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
 strip=E.Element(tag('svg'),width='31mm',height='6mm',viewBox='0 0 31 6')
 E.SubElement(strip,tag('title')).text='FIT SAMPLE ONLY - 31 x 6 mm acrylic strip'
 E.SubElement(strip,tag('desc')).text='Red Line cut only. No engraving and no kerf compensation. Use the same sheet as the display.'
 E.SubElement(strip,tag('path'),d='M 0,0 L 31,0 L 31,6 L 0,6 Z',fill='none',stroke='#ff0000',**{'stroke-width':'0.02'})
 E.ElementTree(strip).write(OUT/'90-fit-strip-CUT-ONLY.svg',encoding='utf-8',xml_declaration=True)
if __name__=='__main__':main()
