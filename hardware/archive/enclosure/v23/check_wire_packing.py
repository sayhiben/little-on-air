"""Check simultaneous compacted-wire radii, excluding defined termination spaces."""
import numpy as np,math,json
from pathlib import Path
from harness import ROUTES,BAYS
OUT=Path(__file__).resolve().parents[1]/'output/v23'
def rounded(points,r=3):
 result=[points[0]]
 for i,q0 in enumerate(points[1:-1],1):
  q=np.array(q0);u=np.array(points[i-1])-q;v=np.array(points[i+1])-q;lu=np.linalg.norm(u);lv=np.linalg.norm(v);u=u/lu;v=v/lv
  angle=math.acos(np.clip(np.dot(u,v),-1,1));dist=min(r/math.tan(angle/2),lu*.45,lv*.45);a=q+u*dist;z=q+v*dist;result.append(a)
  for k in range(1,13):
   t=k/12;result.append((1-t)**2*a+2*(1-t)*t*q+t*t*z)
 result.append(points[-1]);pts=[]
 for a,z in zip(result,result[1:]):
  a=np.array(a);z=np.array(z)
  for t in np.linspace(0,1,max(2,math.ceil(np.linalg.norm(z-a)/.15)+1)):pts.append(a+(z-a)*t)
 return np.array(pts)
def in_bay(a,b):
 for name,lo,hi in BAYS:
  if np.all(a>=np.array(lo)-2) and np.all(a<=np.array(hi)+2) and np.all(b>=np.array(lo)-2) and np.all(b<=np.array(hi)+2):return name
 return None
report=[];shapes=[rounded(p) for _,_,p in ROUTES]
for i,(name,r,path) in enumerate(ROUTES):
 for j in range(i):
  other=ROUTES[j][0];a=shapes[i];b=shapes[j]
  dist=np.linalg.norm(a[:,None,:]-b[None,:,:],axis=2);ix=np.unravel_index(np.argmin(dist),dist.shape);pa,pb=a[ix[0]],b[ix[1]];m=float(dist[ix])
  compact={.8:.45,1.2:.8,1.6:.97}
  ri=.9 if name.startswith('P3') else compact[r]
  rj=.9 if other.startswith('P3') else compact[ROUTES[j][1]]
  if m<ri+rj+.2:
   close=np.argwhere(dist<ri+rj+.2)
   outside=[(int(u),int(v)) for u,v in close if not in_bay(a[u],b[v])]
   if outside:
    ix=min(outside,key=lambda ij:dist[ij]);pa,pb=a[ix[0]],b[ix[1]];m=float(dist[ix])
   accepted=in_bay(pa,pb)
   report.append({'one':name,'two':other,'distance_mm':round(m,3),'required_compact_diameter_sum_mm':round(ri+rj,3),'at_one':np.round(pa,3).tolist(),'at_two':np.round(pb,3).tolist(),'shared_termination_or_trunk':accepted,'passed':bool(accepted) or m>=ri+rj+.2})
(OUT/'wire-packing-validation.json').write_text(json.dumps({'passed':all(x['passed'] for x in report),'route_pairs_checked':len(ROUTES)*(len(ROUTES)-1)//2,'approaches':report,'note':'Compact wire cross sections with 0.2 placement allowance: single OD0.9 radius0.45, pair OD0.8 radius0.8, P3 pair OD0.9 radius0.9, three OD0.9 radius0.97. Connections spread within marked termination bays plus2mm dressing margin. Dress actual wires to these routes.'},indent=2));print(json.dumps({'passed':all(x['passed'] for x in report),'failed':[r for r in report if not r['passed']]},indent=2))
