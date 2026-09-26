from pathlib import Path
import numpy as np,math,json
from harness import ROUTES,BAYS
OUT=Path(__file__).resolve().parents[1]/'output/v27'
def rounded(points,r=3):
 out=[points[0]]
 for i,q0 in enumerate(points[1:-1],1):
  q=np.array(q0);u=np.array(points[i-1])-q;v=np.array(points[i+1])-q;lu=np.linalg.norm(u);lv=np.linalg.norm(v);u=u/lu;v=v/lv
  angle=math.acos(np.clip(np.dot(u,v),-1,1));dist=min(r/math.tan(angle/2),lu*.45,lv*.45);a=q+u*dist;z=q+v*dist;out.append(a)
  for k in range(1,13):
   t=k/12;out.append((1-t)**2*a+2*(1-t)*t*q+t*t*z)
 out.append(points[-1]);result=[]
 for a,z in zip(out,out[1:]):
  a=np.array(a);z=np.array(z)
  for t in np.linspace(0,1,max(2,math.ceil(np.linalg.norm(z-a)/.2)+1)):result.append(a+(z-a)*t)
 return np.array(result)
def bay(a,z):
 for n,lo,hi in BAYS:
  if np.all(a>=np.array(lo)-1) and np.all(a<=np.array(hi)+1) and np.all(z>=np.array(lo)-1) and np.all(z<=np.array(hi)+1):return n
 return None
def main():
 shapes=[rounded(path) for _,_,path in ROUTES];records=[]
 def radius(r):return .97 if r==1.15 else .8 if r in (.9,.85) else .45
 for i,(n,r,p) in enumerate(ROUTES):
  for j in range(i):
   other,rr,_=ROUTES[j];a,z=shapes[i],shapes[j];dist=np.linalg.norm(a[:,None,:]-z[None,:,:],axis=2);needed=radius(r)+radius(rr)+.2
   near=np.argwhere(dist<needed);fails=[(int(u),int(v)) for u,v in near if not bay(a[u],z[v])]
   if len(near):
    ij=min(fails,key=lambda v:dist[v]) if fails else np.unravel_index(np.argmin(dist),dist.shape)
    records.append({'one':n,'two':other,'distance_mm':round(float(dist[ij]),3),'required_mm':round(needed,3),'at_one':np.round(a[ij[0]],3).tolist(),'at_two':np.round(z[ij[1]],3).tolist(),'shared_junction_bay':bay(a[ij[0]],z[ij[1]]),'passed':not fails})
 report={'passed':all(r['passed'] for r in records),'pairs_checked':len(ROUTES)*(len(ROUTES)-1)//2,'approaches':records,'basis':'Three OD0.9 wires fit inside radius0.97; pairs use OD0.8 radius0.8; singles OD0.9 radius0.45. Add0.2 placement allowance. Connections spread in the validated junction bays plus1mm terminal dressing margin.'}
 (OUT/'wire-packing-validation.json').write_text(json.dumps(report,indent=2));print(json.dumps([r for r in records if not r['passed']],indent=2))
if __name__=='__main__':main()
