"""Independently audit delivered meshes, plate layout, optics, and sliced output."""
from pathlib import Path
from collections import Counter, defaultdict
import hashlib
import json
import math
import re
import struct
import xml.etree.ElementTree as ET
import zipfile
import numpy as np

ROOT = Path(__file__).parent
OUT = ROOT / 'output'
PROJECTS = OUT / 'bambu-studio'
AUDIT = PROJECTS / 'audit'
NS = '{http://schemas.microsoft.com/3dmanufacturing/core/2015/02}'
PROD = '{http://schemas.microsoft.com/3dmanufacturing/production/2015/06}'


def stl(path):
    data = path.read_bytes()
    n = struct.unpack_from('<I', data, 80)[0]
    assert len(data) == 84 + 50*n
    return np.array([struct.unpack_from('<9f', data, 96+50*i) for i in range(n)]).reshape(-1,3,3)


def canonical(triangles):
    return Counter(tuple(sorted(tuple(int(round(c*1000)) for c in v) for v in t)) for t in triangles)


def topology(triangles):
    vertices, inv = np.unique(np.round(triangles.reshape(-1,3), 5), axis=0, return_inverse=True)
    faces = inv.reshape(-1,3)
    edges = defaultdict(list)
    for i, f in enumerate(faces):
        for a,b in zip(f, np.roll(f,-1)):
            edges[tuple(sorted((int(a),int(b))))].append((i,int(a),int(b)))
    assert all(len(v)==2 for v in edges.values()), 'Open/nonmanifold edge'
    assert all(v[0][1:]==v[1][1:][::-1] for v in edges.values()), 'Inconsistent winding'
    adjacency = defaultdict(list)
    for pair in edges.values():
        a,b = pair[0][0], pair[1][0]
        adjacency[a].append(b); adjacency[b].append(a)
    pending=set(range(len(faces))); shells=0
    while pending:
        queue=[pending.pop()]; shells+=1
        while queue:
            for neighbor in adjacency[queue.pop()]:
                if neighbor in pending:
                    pending.remove(neighbor); queue.append(neighbor)
    volume=float(np.einsum('ij,ij->i',triangles[:,0],np.cross(triangles[:,1],triangles[:,2])).sum()/6)
    area2=np.linalg.norm(np.cross(triangles[:,1]-triangles[:,0],triangles[:,2]-triangles[:,0]),axis=1)
    assert shells==1 and volume>0 and area2.min()>1e-10
    return {'closed_shells':shells,'consistent_winding':True,'triangles':len(faces),
            'volume_mm3':round(volume,4),'bounds_mm':np.round(np.ptp(triangles.reshape(-1,3),axis=0),5).tolist()}


def affine(points, transform):
    if not transform: return points
    a=np.array([float(x) for x in transform.split()]).reshape(4,3)
    return points @ a[:3] + a[3]


def project_meshes(path):
    with zipfile.ZipFile(path) as z:
        root=ET.fromstring(z.read('3D/3dmodel.model'))
        assert root.get('unit')=='millimeter'
        resources={o.get('id'):o for o in root.find(NS+'resources')}
        config=ET.fromstring(z.read('Metadata/model_settings.config'))
        names={o.get('id'):next(m.get('value') for m in o.findall('metadata') if m.get('key')=='name') for o in config.findall('object')}
        result={}
        for item in root.find(NS+'build'):
            assert item.get('printable')=='1'
            obj=resources[item.get('objectid')]
            parts=[]
            for component in obj.find(NS+'components'):
                sub=ET.fromstring(z.read(component.get(PROD+'path').lstrip('/')))
                mesh=next(o.find(NS+'mesh') for o in sub.find(NS+'resources') if o.get('id')==component.get('objectid'))
                verts=np.array([[float(v.get(k)) for k in ('x','y','z')] for v in mesh.find(NS+'vertices')])
                indices=np.array([[int(t.get(k)) for k in ('v1','v2','v3')] for t in mesh.find(NS+'triangles')])
                parts.append(affine(affine(verts[indices],component.get('transform')),item.get('transform')))
            result[item.get('objectid')]={'name':names[item.get('objectid')], 'triangles':np.concatenate(parts)}
        return result,config,json.loads(z.read('Metadata/project_settings.config'))


def audit_project(path):
    meshes,config,settings=project_meshes(path)
    assert len(meshes)==12
    assert settings['printer_settings_id']=='Bambu Lab X1 Carbon 0.4 nozzle'
    assert settings['nozzle_diameter']==['0.4']
    assert settings['wall_loops']=='4' and settings['wall_generator']=='arachne'
    assert settings['layer_height']=='0.2' and settings['initial_layer_print_height']=='0.2'
    assert settings['filament_type']==['PETG','PETG']
    assert 'wall_loops' in settings['different_settings_to_system'][0]
    results={}; instances=[]; min_spacing=float('inf')
    for index,plate in enumerate(config.findall('plate')):
        origin=np.array([(index%2)*307.2,-(index//2)*307.2,0])
        bounds=[]
        for inst in plate.findall('model_instance'):
            oid=next(m.get('value') for m in inst.findall('metadata') if m.get('key')=='object_id')
            instances.append(oid)
            obj=meshes[oid]; tri=obj['triangles']; raw=stl(OUT/'print'/obj['name'])
            delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
            assert np.allclose(np.ptp(tri.reshape(-1,3),axis=0),np.ptp(raw.reshape(-1,3),axis=0),atol=0.00005)
            assert canonical(tri-delta)==canonical(raw), 'Mesh changed: '+obj['name']
            local=tri-origin
            lo=local.reshape(-1,3).min(axis=0); hi=local.reshape(-1,3).max(axis=0)
            assert abs(lo[2])<0.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
            b=(lo[:2]-3.5,hi[:2]+3.5)
            for old in bounds:
                separation=np.maximum(b[0]-old[1],old[0]-b[1])
                assert separation.max()>0, 'Expanded part envelopes overlap'
                min_spacing=min(min_spacing,float(separation.max()))
            bounds.append(b)
            results[obj['name']]={'plate':index+1,'mesh_matches_export':True,
                'bed_min':np.round(lo,5).tolist(),'bed_max':np.round(hi,5).tolist(),**topology(raw)}
        if index==3:
            # Reserve a conservative 40 x 40 mm square around the tower.
            tower=(np.array([18,181]),np.array([58,221]))
            assert all(np.maximum(tower[0]-b[1],b[0]-tower[1]).max()>0 for b in bounds)
    assert len(instances)==len(set(instances))==12
    return {'sha256':hashlib.sha256(path.read_bytes()).hexdigest(), 'objects':results,
            'minimum_clearance_after_3_5_mm_expansion':round(min_spacing,3)}


def boundary_edges(triangles,z):
    flat=triangles[np.all(np.abs(triangles[:,:,2]-z)<1e-4,axis=1)]
    edges=Counter()
    for t in flat:
        points=[tuple(round(float(v),5) for v in p[:2]) for p in t]
        for a,b in zip(points,points[1:]+points[:1]): edges[tuple(sorted((a,b)))]+=1
    return np.array([edge for edge,n in edges.items() if n==1])


def boundary_vertices(triangles,z):
    return np.unique(boundary_edges(triangles,z).reshape(-1,2),axis=0)


def point_segment_distance(points,segments):
    start=segments[:,0]; direction=segments[:,1]-start
    t=np.clip(np.einsum('ijk,jk->ij',points[:,None]-start[None],direction)/
              np.einsum('ij,ij->i',direction,direction),0,1)
    return np.linalg.norm(points[:,None]-(start[None]+t[:,:,None]*direction[None]),axis=2).min(axis=1)


def audit_optics():
    tri=stl(OUT/'print/03-black-and-white-backing.stl')
    svg=ET.parse(OUT/'fdm-and-acrylic/acrylic/02-acrylic-rear-engrave-and-cut.svg').getroot()
    assert svg.get('width')=='104mm' and svg.get('height')=='38mm'
    assert not list(svg.iter('{http://www.w3.org/2000/svg}text'))
    groups={g.get('id'):g for g in svg}
    result={}
    for group,z in [('ENGRAVE',2.0),('CUT',0.0)]:
        path=list(groups[group])[0]
        d=path.get('d'); assert set(re.findall('[A-Za-z]',d)) <= set('MLZ')
        loops=[np.array([float(x) for x in re.findall(r'-?\d+(?:\.\d+)?',p)]).reshape(-1,2) for p in d.split('Z') if p.strip()]
        svg_edges=np.concatenate([np.stack((p,np.roll(p,-1,axis=0)),axis=1) for p in loops])
        mesh_edges=np.array([104,38])-boundary_edges(tri,z)
        # Compare contours, not vertex indices: the STL and laser export use
        # different curve tessellations and may remove collinear vertices.
        sample=lambda e: np.concatenate([e[:,0],e[:,1],e.mean(axis=1)])
        difference=max(float(point_segment_distance(sample(svg_edges),mesh_edges).max()),
                       float(point_segment_distance(sample(mesh_edges),svg_edges).max()))
        tolerance=0.1 if group=='ENGRAVE' else 0.0001
        assert difference<tolerance, (group,difference)
        result[group]={'closed_contours':d.count('Z'),'maximum_sampled_contour_difference_mm':round(difference,7),
                       'audit_tolerance_mm':tolerance}
    return {'stock_nominal_mm':3.175,'viewbox_mm':[104,38],'rear_mirror_matches_printed_geometry':True,**result}


def audit_gcode(directory,manual=False):
    result=json.loads((directory/'result.json').read_text())
    assert result['return_code']==0
    report=[]
    for plate in result['sliced_plates']:
        assert plate['warning_message']=='',plate['warning_message']
        report.append({'plate':plate['id'],'seconds':round(plate['total_predication']),
                       'filament_changes':plate['filament_change_times'],
                       'grams':round(sum(f['total_used_g'] for f in plate['filaments']),3),
                       'slicer_warnings':[]})
    code=(directory/'plate_4.gcode').read_text().splitlines()
    if manual:
        indices=[i for i,line in enumerate(code) if line.strip()=='M400 U1']
        assert len(indices)==1
        context='\n'.join(code[max(0,indices[0]-25):indices[0]])
        assert '; Z_HEIGHT: 1.8' in context and '9/10' in context
        assert not any(line.strip()=='T1' for line in code)
        color={'pause_before_layer':9,'black_height_mm':1.6,'automatic_changes':0}
    else:
        h=0;t=0;role=''; layer_tools=defaultdict(set)
        for line in code:
            if line.startswith('; Z_HEIGHT:'): h=float(line.split(':')[1])
            if re.fullmatch(r'T[01]',line.strip()): t=int(line.strip()[1:])
            if line.startswith('; FEATURE:'): role=line.split(':',1)[1].strip()
            if h and line.startswith(('G1 ','G2 ','G3 ')) and re.search(r' E(?:[0-9]|\.[0-9])',line) and re.search(r' [XY][-0-9.]',line) and role in ['Inner wall','Outer wall','Top surface','Bottom surface','Internal solid infill','Gap infill']:
                layer_tools[h].add(t)
        assert len(layer_tools)==10
        assert all(v=={0 if h<=1.6 else 1} for h,v in layer_tools.items())
        assert report[3]['filament_changes']==1
        color={'model_filament_by_layer_height':{str(h):next(iter(v))+1 for h,v in layer_tools.items()}}
    return {'plates':report,'backing_color':color}


if __name__=='__main__':
    report={'projects':{}}
    for kind in ('AMS','manual-swap'):
        p=PROJECTS/f'little-on-air-X1C-PETG-{kind}-ready.3mf'
        report['projects'][p.name]=audit_project(p)
    report['optics']=audit_optics()
    report['ams_toolpaths']=audit_gcode(AUDIT/'ams-slice')
    report['manual_toolpaths']=audit_gcode(PROJECTS/'manual-final',manual=True)
    native=json.loads((OUT/'fusion-verification.json').read_text())
    assert not native['feature_issues'] and not native['interferences']
    report['native_fusion']={'feature_issues':[],'interferences':[],'component_count':len(native['components'])}
    (AUDIT/'independent-audit.json').write_text(json.dumps(report,indent=2))
    print(json.dumps({'projects':'12 matching, closed, correctly oriented meshes in each',
                      'optics':report['optics'],'ams_toolpaths':report['ams_toolpaths'],
                      'manual_color':report['manual_toolpaths']['backing_color'],
                      'native_fusion':report['native_fusion']},indent=2))
