"""Orient meshes with proper rotations; check edges, connectedness and first layer."""
from pathlib import Path
import struct,collections,math,json,hashlib
OUT=Path(__file__).resolve().parents[1]/'output'/'v24'
def rotate(v,part):
 x,y,z=v
 if part==7:return y,-z,-x
 if part in (1,6,91,95):return x,-y,-z
 if part==8:return x,-z,y
 return x,y,z
def read_mesh(path):
 raw=path.read_bytes();n=struct.unpack_from('<I',raw,80)[0];assert len(raw)==84+50*n
 return [struct.unpack_from('<12fH',raw,84+50*i) for i in range(n)]
def main():
 reports=[]
 for src in sorted((OUT/'meshes-assembly-coordinates').glob('*.stl')):
  part=int(src.name[:2]);records=read_mesh(src)
  triangles=[[rotate(r[k:k+3],part) for k in (3,6,9)] for r in records]
  lo=[min(p[i] for tri in triangles for p in tri) for i in range(3)];hi=[max(p[i] for tri in triangles for p in tri) for i in range(3)]
  verts=[];faces=[];index={};edges=collections.Counter();directed=collections.Counter();adj=collections.defaultdict(set);out=[];volume=0;bed=0;horizontal=[]
  for tri in triangles:
   pts=[tuple(v[i]-lo[i] for i in range(3)) for v in tri];ids=[]
   for pt in pts:
    assert all(math.isfinite(v) for v in pt);key=tuple(round(v,5) for v in pt)
    if key not in index:index[key]=len(verts);verts.append(pt)
    ids.append(index[key])
   assert len(set(ids))==3,src.name
   a,b,c=pts;ab=[b[i]-a[i] for i in range(3)];ac=[c[i]-a[i] for i in range(3)]
   cross=[ab[1]*ac[2]-ab[2]*ac[1],ab[2]*ac[0]-ab[0]*ac[2],ab[0]*ac[1]-ab[1]*ac[0]];mag=math.sqrt(sum(v*v for v in cross));assert mag>1e-10
   normal=[v/mag for v in cross];volume+=sum(a[i]*cross[i] for i in range(3))/6
   if normal[2]<-.9999:
    if max(p[2] for p in pts)<.0001:bed+=mag/2
    else:horizontal.append((round(a[2],4),mag/2))
   faces.append(ids)
   for x,y in zip(ids,ids[1:]+ids[:1]):
    edges[tuple(sorted((x,y)))]+=1;directed[(x,y)]+=1;adj[x].add(y);adj[y].add(x)
   out.append(struct.pack('<12fH',*normal,*a,*b,*c,0))
  bad=sum(n!=2 for n in edges.values());assert not bad,(src.name,bad)
  assert all(directed[(a,b)]==directed[(b,a)] for a,b in edges)
  remaining=set(range(len(verts)));components=0
  while remaining:
   stack=[remaining.pop()];components+=1
   while stack:
    for v in adj[stack.pop()]:
     if v in remaining:remaining.remove(v);stack.append(v)
  assert components==1 and volume>0 and bed>0,(src.name,components,volume,bed)
  dst=OUT/('optional-laminate' if part>=80 and part<90 else 'fit-samples' if part>=90 else 'stl');dst.mkdir(exist_ok=True)
  path=dst/src.name;path.write_bytes(b'Little ON AIR v2; Fusion solid; millimetres; oriented for FDM'.ljust(80,b' ')+struct.pack('<I',len(out))+b''.join(out))
  byheight=collections.defaultdict(float)
  for z,area in horizontal:byheight[z]+=area
  reports.append({'file':str(path.relative_to(OUT)).replace('\\','/'),'bounds_mm':[round(hi[i]-lo[i],4) for i in range(3)],'volume_mm3':round(volume,4),'triangles':len(faces),'watertight':not bad,'connected_solids':components,'min_z':0,'bed_contact_mm2':round(bed,3),'horizontal_undersides_by_height_mm2':{k:round(v,3) for k,v in byheight.items()},'sha256':hashlib.sha256(path.read_bytes()).hexdigest()})
 (OUT/'mesh-validation.json').write_text(json.dumps(reports,indent=2));print(json.dumps(reports,indent=2))
if __name__=='__main__':main()
