"""Exact segment-to-segment distances, including every sampled circular bend."""
import numpy as np,json,math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def separation(pa,pb):
 a=np.asarray(pa,float);b=np.asarray(pb,float)
 aa=a[:-1,None,:];bb=b[None,:-1,:];u=np.diff(a,axis=0)[:,None,:];v=np.diff(b,axis=0)[None,:,:];w=aa-bb
 au=np.sum(u*u,axis=2);bv=np.sum(v*v,axis=2);ab=np.sum(u*v,axis=2);d=np.sum(u*w,axis=2);e=np.sum(v*w,axis=2)
 # Remove duplicated fillet tangent vertices before calling this routine.
 denom=au*bv-ab*ab
 with np.errstate(divide='ignore',invalid='ignore'):
  s=(ab*e-bv*d)/denom;t=(au*e-ab*d)/denom
 valid=(denom>1e-12)&(s>=0)&(s<=1)&(t>=0)&(t<=1)
 s=np.where(valid,s,0);t=np.where(valid,t,0)
 candidates=[np.where(valid,np.sum((w+s[:,:,None]*u-t[:,:,None]*v)**2,axis=2),np.inf)]
 for sv in (0,1):
  tv=np.clip((e+sv*ab)/bv,0,1);candidates.append(np.sum((w+sv*u-tv[:,:,None]*v)**2,axis=2))
 for tv in (0,1):
  sv=np.clip((tv*ab-d)/au,0,1);candidates.append(np.sum((w+sv[:,:,None]*u-tv*v)**2,axis=2))
 all_dist=np.min(candidates,axis=0);idx=np.unravel_index(np.argmin(all_dist),all_dist.shape)
 return math.sqrt(max(0,float(all_dist[idx]))),{'a':a[idx[0]].tolist(),'b':b[idx[1]].tolist()}
def main():
 routes=json.loads((OUT/'candidate-routes.json').read_text());pairs=[]
 for r in routes:r['points']=[p for i,p in enumerate(r['points']) if i==0 or math.dist(p,r['points'][i-1])>1e-6]
 for i,a in enumerate(routes):
  for b in routes[i+1:]:
   sep,where=separation(a['points'],b['points']);pairs.append({'a':a['name'],'b':b['name'],'center_distance_mm':sep,'surface_gap_at_1_8_OD_mm':sep-1.8,'closest':where,'passed':sep>=1.999-1e-5})
 report={'passed':all(p['passed'] for p in pairs),'wire_OD_max_mm':1.8,'pairs':pairs}
 (OUT/'wire-separation.json').write_text(json.dumps(report,indent=2));print(json.dumps({'passed':report['passed'],'failed':[x for x in pairs if not x['passed']]},indent=2))
if __name__=='__main__':main()
