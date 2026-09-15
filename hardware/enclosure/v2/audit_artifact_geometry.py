import importlib.util,json
from pathlib import Path
import numpy as np
import xml.etree.ElementTree as E
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output'/'v2'
s=importlib.util.spec_from_file_location('audit_helpers',str(BASE/'audit_print_projects.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
def run():
 tri=a.stl(OUT/'stl'/'03-registered-graphic-backing.stl');master=json.loads((OUT/'laser'/'shared-front-master.json').read_text());results={}
 for label,loops,z in [('letters',master['loops'],2.0),('outline',[master['outline']],0.0)]:
  contours=[np.array(p)-np.array([8,11]) for p in loops]
  wanted=np.concatenate([np.stack([p,np.roll(p,-1,axis=0)],axis=1) for p in contours]);actual=a.boundary_edges(tri,z)
  sample=lambda e:np.concatenate([e[:,0],e[:,1],e.mean(axis=1)])
  difference=max(float(a.point_segment_distance(sample(wanted),actual).max()),float(a.point_segment_distance(sample(actual),wanted).max()))
  assert difference<.0001,(label,difference)
  results[label]={'actual_STL_to_shared_laser_master_error_mm':difference,'passed':True}
 (OUT/'optical-registration-validation.json').write_text(json.dumps(results,indent=2));print(json.dumps(results,indent=2))
if __name__=='__main__':run()
