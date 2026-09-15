from pathlib import Path
import importlib.util,json
import numpy as np
HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('audit',str(HERE/'audit_bambu_v2.py'));a=importlib.util.module_from_spec(s);s.loader.exec_module(a)
p=a.BAMBU/'sliced-on-air-v24-X1C-eSUN-PLA-plus-AMS/on-air-v24-X1C-eSUN-PLA-plus-AMS.3mf'
for obj in a.a.project_meshes(p)[0].values():
 raw=a.a.stl(a.OUT/'stl'/obj['name']);tri=obj['triangles'];delta=tri.reshape(-1,3).min(0)-raw.reshape(-1,3).min(0);tri-=delta
 report={'name':obj['name'],'triangles':[len(raw),len(tri)],'canonical_equal':a.a.canonical(raw)==a.a.canonical(tri)}
 if raw.shape==tri.shape:
  report['ordered_max_difference_mm']=float(np.max(np.abs(raw-tri)))
  rv=np.unique(raw.reshape(-1,3),axis=0);tv=np.unique(tri.reshape(-1,3),axis=0)
  ds=[];ix=[]
  for off in range(0,len(tv),200):
   sq=((tv[off:off+200,None]-rv[None])**2).sum(2);inds=sq.argmin(1);ix.extend(inds);ds.extend(np.sqrt(sq[np.arange(len(inds)),inds]))
  dist=np.array(ds);idx=np.array(ix)
  report['vertex_max_difference_mm']=float(dist.max())
  report['unique_vertices']=[len(rv),len(tv)]
  report['vertex_correspondence_bijective']=len(set(idx))==len(rv)==len(tv)
 print(json.dumps(report))
