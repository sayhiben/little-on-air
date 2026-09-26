"""Measure unsupported portions of roof paths against the native mesh section."""
from pathlib import Path
import importlib.util,json,math
import numpy as np
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v214'
def load(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
s=load('sections_bridge',BASE/'v214/inspect_sections.py');c=load('gcode_bridge',BASE/'v213/audit_complete_project.py')
def main():
 edges=np.array(s.segments(s.a.stl(OUT/'meshes-assembly-coordinates/01-front-optical-bezel.stl'),8.0))
 # Front-only build is centered at (128,128); source front X=-4.5..124.5,
 # Y=-4.5..64.5. Bambu's X1C profile has extruder_offset 0x2, already
 # subtracted in the emitted G-code. Restore it before mapping to CAD XY.
 to_cad=lambda pt:np.array([pt[0]-68,156-pt[1]])
 runs=[q for q in c.paths((OUT/'bambu-studio/front-only/plate_1.gcode').read_text().splitlines()) if q['role']=='Bridge' and q['command']=='G1' and 8.1<q['z']<8.4]
 cross=lambda a,b:a[...,0]*b[...,1]-a[...,1]*b[...,0]
 def inside(p):
  a,z=edges[:,0],edges[:,1];active=(a[:,1]>p[1])!=(z[:,1]>p[1]);aa=a[active];zz=z[active]
  return np.count_nonzero(aa[:,0]+(zz[:,0]-aa[:,0])*(p[1]-aa[:,1])/(zz[:,1]-aa[:,1])>p[0])%2==1
 maxfree=0;items=[]
 for r in runs:
  a=to_cad(r['a']);z=to_cad(r['b']);v=z-a;ep=edges[:,0];ev=edges[:,1]-ep;den=cross(v,ev);ok=abs(den)>1e-8
  ts=cross(ep[ok]-a,ev[ok])/den[ok];us=cross(ep[ok]-a,v)/den[ok]
  cuts=sorted(set([0.,1.]+[round(float(t),8) for t,u in zip(ts,us) if 0<t<1 and 0<=u<=1]))
  spans=[]
  for p,q in zip(cuts,cuts[1:]):
   if not inside(a+v*(p+q)/2):spans.append((q-p)*r['dist'])
  free=max(spans,default=0);maxfree=max(maxfree,free)
  items.append({'a_cad':a.tolist(),'b_cad':z.tolist(),'extrusion_length_mm':r['dist'],'max_unsupported_centerline_mm':free})
 assert maxfree<14.5,maxfree
 report={'passed':True,'method':'Exact piecewise-linear path/mesh-section intersections; section depth 8.0 mm, roof bridge layer 8.3 mm. Restores X1C extruder Y offset. Unsupported centerline lengths do not subtract bead overlap. Arc connector paths excluded; longest such chord about 2 mm.','roof_G1_paths':len(runs),'max_extrusion_length_mm':max(q['dist'] for q in runs),'max_unsupported_centerline_mm':maxfree,'longest_unsupported_paths':sorted(items,key=lambda q:q['max_unsupported_centerline_mm'],reverse=True)[:10]}
 (OUT/'bridge-validation.json').write_text(json.dumps(report,indent=2))
 print(json.dumps(report,indent=2))
 # Show the actual bridge layer over the preceding layer's section.
 svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1400" height="900" viewBox="0 0 1400 900"><rect width="1400" height="900" fill="#f4f6f8"/><g font-family="Arial" fill="#17283b">',
 '<text x="35" y="46" font-size="28" font-weight="bold">Front channel roof — verified Bambu toolpaths</text>',
 f'<text x="35" y="81" font-size="19">45° bridge direction · no support · longest unsupported centerline span {maxfree:.2f} mm</text>',
 '<text x="35" y="112" font-size="17">Blue: roof bridge extrusions at print Z 8.3 mm. Gray: frame section immediately below the roof.</text>',
 '<g transform="translate(103,734) scale(9,-9)">']
 path=' '.join(f'M{p[0]},{p[1]} L{q[0]},{q[1]}' for p,q in edges)
 svg.append(f'<path d="{path}" fill="none" stroke="#69798a" stroke-width=".20"/>')
 for r in runs:
  a=to_cad(r['a']);z=to_cad(r['b']);svg.append(f'<path d="M{a[0]} {a[1]} L{z[0]} {z[1]}" stroke="#1784a3" stroke-width=".12"/>')
 svg.extend(['</g>','<text x="35" y="826" font-size="18">Inspect the first printed roof for sagging or strings before threading wires. Keep the frame’s bridge-angle override when re-slicing.</text>','<text x="35" y="859" font-size="18">View uses front coordinates; the actual part prints face-down. Actual bridge performance still depends on the PLA+ spool and cooling.</text>','</g></svg>'])
 (OUT/'roof-toolpaths.svg').write_text('\n'.join(svg),encoding='utf-8')
if __name__=='__main__':main()
