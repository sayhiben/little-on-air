from pathlib import Path
import struct,collections,json
OUT=Path(__file__).resolve().parents[1]/'output/v23/meshes-assembly-coordinates'
for src in sorted(OUT.glob('*.stl')):
 raw=src.read_bytes();verts=[];look={};faces=[];adj=collections.defaultdict(set)
 for i in range(struct.unpack_from('<I',raw,80)[0]):
  pts=struct.unpack_from('<9f',raw,96+50*i);ids=[]
  for k in (0,3,6):
   p=tuple(round(v,5) for v in pts[k:k+3])
   if p not in look:look[p]=len(verts);verts.append(p)
   ids.append(look[p])
  faces.append(ids)
  for a,b in zip(ids,ids[1:]+ids[:1]):adj[a].add(b);adj[b].add(a)
 remaining=set(range(len(verts)));groups=[]
 while remaining:
  stack=[remaining.pop()];group=set(stack)
  while stack:
   for v in adj[stack.pop()]:
    if v in remaining:remaining.remove(v);stack.append(v);group.add(v)
  groups.append(group)
 if len(groups)>1:
  out=[]
  for g in groups:
   vv=[verts[i] for i in g];ff=[f for f in faces if f[0] in g];vol=0
   for ids in ff:
    a,b,c=[verts[i] for i in ids]
    vol+=(a[0]*(b[1]*c[2]-b[2]*c[1])+a[1]*(b[2]*c[0]-b[0]*c[2])+a[2]*(b[0]*c[1]-b[1]*c[0]))/6
   out.append({'vertices':len(g),'faces':len(ff),'signed_volume_mm3':vol,'min':[min(p[i] for p in vv) for i in range(3)],'max':[max(p[i] for p in vv) for i in range(3)]})
  print(json.dumps({'file':src.name,'groups':out},indent=2))
