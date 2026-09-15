"""Orient native Fusion meshes, verify topology, and write portable millimetre 3MFs."""
import collections
import json
import math
from pathlib import Path
import struct
import xml.etree.ElementTree as ET
import zipfile

OUT=Path(__file__).resolve().parent/"output"
NS="http://schemas.microsoft.com/3dmanufacturing/core/2015/02"
ET.register_namespace("",NS)

def rotate(v,part):
    x,y,z=v
    if part in (1,4): return (x,-y,-z)
    if part in (6,7): return (z,y,-x)
    if part==8: return (x,z,-y)
    return (x,y,z)

def three_mf(path,vertices,faces,label,part):
    def tag(n): return "{"+NS+"}"+n
    model=ET.Element(tag("model"),{"unit":"millimeter","xml:lang":"en-US"})
    ET.SubElement(model,tag("metadata"),{"name":"Title"}).text=label
    ET.SubElement(model,tag("metadata"),{"name":"Description"}).text=(
        "First-fit prototype from native Fusion. Verify physical interfaces. " +
        ("Black base; manual filament change to white at Z=1.6 mm." if part==3 else ""))
    resources=ET.SubElement(model,tag("resources"))
    obj=ET.SubElement(resources,tag("object"),{"id":"1","type":"model","name":label})
    mesh=ET.SubElement(obj,tag("mesh")); verts=ET.SubElement(mesh,tag("vertices"))
    for x,y,z in vertices: ET.SubElement(verts,tag("vertex"),{"x":f"{x:.6f}","y":f"{y:.6f}","z":f"{z:.6f}"})
    tris=ET.SubElement(mesh,tag("triangles"))
    for a,b,c in faces: ET.SubElement(tris,tag("triangle"),{"v1":str(a),"v2":str(b),"v3":str(c)})
    build=ET.SubElement(model,tag("build")); ET.SubElement(build,tag("item"),{"objectid":"1"})
    content_types=('<?xml version="1.0" encoding="UTF-8"?>'
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
        '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
        '<Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>')
    relationships=('<?xml version="1.0" encoding="UTF-8"?>'
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
        '<Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>')
    with zipfile.ZipFile(path,"w",zipfile.ZIP_DEFLATED) as archive:
        archive.writestr("[Content_Types].xml",content_types)
        archive.writestr("_rels/.rels",relationships)
        archive.writestr("3D/3dmodel.model",ET.tostring(model,encoding="utf-8",xml_declaration=True))

def main():
    dest=OUT/"print"; dest.mkdir(exist_ok=True)
    reports=[]
    for source in sorted((OUT/"meshes-assembly-coordinates").glob("*.stl")):
        part=int(source.name[:2]); data=source.read_bytes(); count=struct.unpack_from("<I",data,80)[0]
        if len(data)!=84+50*count: raise ValueError("Unexpected STL format: "+source.name)
        tris=[]
        for i in range(count):
            values=struct.unpack_from("<12fH",data,84+i*50)
            tris.append((rotate(values[:3],part),[rotate(values[j:j+3],part) for j in (3,6,9)]))
        minimum=[min(pt[axis] for _,triangle in tris for pt in triangle) for axis in range(3)]
        maximum=[max(pt[axis] for _,triangle in tris for pt in triangle) for axis in range(3)]
        vertices=[]; faces=[]; lookup={}; records=[]; edges=collections.Counter(); volume=0.0
        for normal,triangle in tris:
            points=[tuple(v[k]-minimum[k] for k in range(3)) for v in triangle]
            ids=[]
            for v in points:
                if not all(math.isfinite(q) for q in v): raise ValueError("Invalid vertex")
                key=tuple(round(q,5) for q in v)
                if key not in lookup: lookup[key]=len(vertices); vertices.append(v)
                ids.append(lookup[key])
            if len(set(ids))!=3: raise ValueError("Degenerate triangle: "+source.name)
            faces.append(ids)
            for a,b in ((ids[0],ids[1]),(ids[1],ids[2]),(ids[2],ids[0])): edges[tuple(sorted((a,b)))]+=1
            a,b,c=points
            volume+=(a[0]*(b[1]*c[2]-b[2]*c[1])+a[1]*(b[2]*c[0]-b[0]*c[2])+a[2]*(b[0]*c[1]-b[1]*c[0]))/6
            records.append(struct.pack("<12fH",*normal,*points[0],*points[1],*points[2],0))
        bad=sum(n!=2 for n in edges.values())
        if bad or volume<=0: raise ValueError(f"Mesh failed: {source.name}: nonmanifold edges={bad}, volume={volume}")
        (dest/source.name).write_bytes(b"Little On Air Fusion mesh; millimetres".ljust(80,b" ")+struct.pack("<I",len(records))+b"".join(records))
        three_mf(dest/(source.stem+".3mf"),vertices,faces,source.stem,part)
        reports.append({"part":source.stem,"triangles":len(faces),"watertight_edges":bad==0,
            "volume_mm3":round(volume,3),"print_bounds_mm":[round(maximum[i]-minimum[i],4) for i in range(3)],
            "minimum_z_mm":0,"filament_change_mm":1.6 if part==3 else None,
            "support_note":"Support beneath the optical partition and carrier overhangs; inspect latch slots." if part==4 else "Inspect overhangs in slicer; do not support snug interfaces unnecessarily."})
    (OUT/"mesh-verification.json").write_text(json.dumps(reports,indent=2))
    print(json.dumps(reports,indent=2))

if __name__=="__main__": main()
