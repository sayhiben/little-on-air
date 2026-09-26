"""Release only after mesh, plate, material, support and optical toolpath audits."""
from pathlib import Path
import collections, hashlib, importlib.util, json, math, re, shutil, zipfile
import numpy as np

BASE=Path(__file__).resolve().parents[1]
OUT=BASE/'output/v213-complete'
DST=BASE/'output/on-air-v213-complete-print'
NAME='on-air-v213-X1C-all-plates.3mf'
spec=importlib.util.spec_from_file_location('print_audit',BASE/'audit_print_projects.py')
a=importlib.util.module_from_spec(spec);spec.loader.exec_module(a)
manifest=json.loads((OUT/'plate-manifest.json').read_text())

def md(node):
    return {m.get('key'):m.get('value') for m in node.findall('metadata') if m.get('key')}

def audit_meshes(path):
    meshes,config,cfg=a.project_meshes(path)
    assert len(meshes)==10 and len(config.findall('plate'))==4
    assert cfg['filament_type']==['PLA','PLA','PETG']
    assert cfg['filament_colour']==['#161616','#FFFFFF','#D8EDF0']
    assert cfg['filament_self_index']==['1','2','3']
    assert cfg['filament_vendor']==['eSUN','eSUN','Generic']
    assert cfg['nozzle_diameter']==['0.4']
    assert cfg['scan_first_layer']=='0' and cfg['initial_layer_print_height']=='0.1'
    assert cfg['textured_plate_temp']==['55','55','70']
    assert cfg['nozzle_temperature']==['220','220','255']
    assert cfg['wall_loops']=='4' and cfg['layer_height']=='0.2'
    assert cfg['enable_prime_tower']=='1'
    assert cfg['flush_volumes_matrix'][1]=='700'
    assert cfg['fan_max_speed']==['100','100','30'] and cfg['additional_cooling_fan_speed'][2]=='0'
    objects={o.get('id'):md(o) for o in config.findall('object')}
    reports=[];seen=[]
    for pi,plate in enumerate(config.findall('plate')):
        origin=np.array([(pi%2)*307.2,-(pi//2)*307.2,0])
        expected=manifest[pi]['objects'];instances=plate.findall('model_instance')
        assert len(instances)==len(expected)
        bounds=[];items=[]
        for inst,src in zip(instances,expected):
            oid=md(inst)['object_id'];seen.append(oid)
            obj=meshes[oid];raw=a.stl(BASE/src['source']);tri=obj['triangles'];setting=objects[oid]
            assert obj['name']==src['filename'] and setting['extruder']==str(src['extruder'])
            delta=tri.reshape(-1,3).min(axis=0)-raw.reshape(-1,3).min(axis=0)
            assert raw.shape==tri.shape and np.allclose(raw,tri-delta,atol=.00005,rtol=0),obj['name']
            topology=a.topology(raw)
            lo=(tri-origin).reshape(-1,3).min(axis=0);hi=(tri-origin).reshape(-1,3).max(axis=0)
            assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
            for oldlo,oldhi in bounds:
                assert max(np.maximum(lo[:2]-oldhi[:2],oldlo[:2]-hi[:2]))>(2 if pi==3 else 6)
            bounds.append((lo,hi))
            support=obj['name'].startswith(('07-','11-'))
            assert setting['enable_support']==str(int(support))
            if pi==3:
                for key,value in {'layer_height':'0.1','wall_loops':'1','sparse_infill_density':'100%','infill_direction':'0','sparse_infill_pattern':'alignedrectilinear','internal_solid_infill_pattern':'alignedrectilinear','bottom_surface_pattern':'alignedrectilinear','top_surface_pattern':'alignedrectilinear','brim_type':'no_brim'}.items():assert setting[key]==value,(key,setting)
            elif pi==2:assert setting['layer_height']=='0.1'
            items.append({'file':obj['name'],'source':src['source'],'source_sha256':hashlib.sha256((BASE/src['source']).read_bytes()).hexdigest(),'filament_slot':src['extruder'],'exact_mesh_match':True,'bed_min':lo.tolist(),'bed_max':hi.tolist(),**topology})
        reports.append({'plate':pi+1,'name':md(plate)['plater_name'],'objects':items})
    assert len(seen)==len(set(seen))==10
    with zipfile.ZipFile(path) as z:
        custom=z.read('Metadata/custom_gcode_per_layer.xml').decode()
        assert 'plate_info id="3"' in custom and 'top_z="1.7" type="2" extruder="2"' in custom
        assert z.testzip() is None
    return reports

def paths(lines):
    role='';z=0;x=y=0;feed=0;tool=0
    for line in lines:
        if line.startswith('; FEATURE:'):role=line.split(':',1)[1].strip()
        if line.startswith('; Z_HEIGHT:'):z=float(line.split(':')[1])
        bare=line.split(';')[0].strip()
        m=re.fullmatch(r'M620 S([012])A',bare)
        if m:tool=int(m[1])
        if re.fullmatch('T[012]',bare):tool=int(bare[1:])
        if bare.startswith(('G0 ','G1 ','G2 ','G3 ')):
            v={k:float(q) for k,q in re.findall(r'([XYEF])([-0-9.]+)',bare)}
            nx=v.get('X',x);ny=v.get('Y',y);feed=v.get('F',feed)
            dist=math.hypot(nx-x,ny-y)
            if v.get('E',0)>0 and dist>.02 and z>0:
                yield {'role':role,'z':z,'a':(x,y),'b':(nx,ny),'dist':dist,'tool':tool,'feed':feed,'command':bare.split()[0]}
            x,y=nx,ny

def audit_code():
    result=json.loads((OUT/'sliced/result.json').read_text())
    assert result['return_code']==0 and len(result['sliced_plates'])==4
    reports=[]
    for pi,plate in enumerate(result['sliced_plates'],1):
        assert not plate['warning_message']
        filament_ids=[f['id'] for f in plate['filaments']]
        assert filament_ids=={1:[1],2:[1],3:[1,2],4:[3]}[pi]
        assert plate['filament_change_times']==(1 if pi==3 else 0)
        code=(OUT/f'sliced/plate_{pi}.gcode').read_text(encoding='utf-8').splitlines()
        active=[l.split(';')[0].strip() for l in code]
        assert not any(re.match(r'M97[67](?:\s|$)',l) for l in active)
        assert not any(re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
        assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
        assert ('M190 S70' if pi==4 else 'M190 S55') in active
        runs=list(paths(code));support=[p for p in runs if p['role'].startswith('Support')]
        report={'plate':pi,'seconds':round(plate['total_predication']),'filaments':plate['filaments'],'first_layer_inspection_disabled':True,'no_manual_pause':True,'bed_leveling_and_heater_shutdown_present':True,'warnings':[]}
        if pi in (1,2):
            box=(193,221,114,142) if pi==1 else (115,141,50,76)
            assert support and all(box[0]<q[0]<box[1] and box[2]<q[1]<box[3] for p in support for q in [p['a'],p['b']]),pi
            report['support_only_on']='11 rear guide keeper' if pi==1 else '07 reset button'
        else:assert not support
        if pi==3:
            layer_tools=collections.defaultdict(set)
            for p in runs:
                if p['role'] in ('Inner wall','Outer wall','Top surface','Bottom surface','Internal solid infill','Sparse infill','Gap infill'):
                    layer_tools[p['z']].add(p['tool'])
            assert len(layer_tools)==25 and all(v==({0} if h<=1.6 else {1}) for h,v in layer_tools.items()),layer_tools
            assert 'Prime tower' in plate['feature_type_times']
            report['insert_colors']={'black_base_mm':1.6,'first_white_layer_z_mm':1.7,'automatic_color_changes':1,'all_25_layers_correct':True,'purge_tower_generated':True}
        if pi==4:
            fill=[p for p in runs if p['command']=='G1' and p['dist']>1 and p['role'] in ('Sparse infill','Internal solid infill','Bottom surface','Top surface')]
            assert len(fill)>=300 and all(abs(p['b'][1]-p['a'][1])<.02 for p in fill)
            assert all(p['tool']==2 for p in runs if p['role']!='Custom')
            assert not any(p['role'] in ('Brim','Support','Support interface','Prime tower') for p in runs)
            assert all(p['feed']<=1200.01 for p in runs if p['role'] not in ('Custom','Flush','Travel','Undefined'))
            assert sorted(set(p['z'] for p in fill))[0]==.1
            report['optical_fill']={'long_runs_parallel_to_guide_axis':len(fill),'off_axis_runs':0,'first_layer_mm':.1,'maximum_extrusion_speed_mm_s':20,'walls':1,'infill_percent':100,'support_and_brim':False}
        reports.append(report)
    return reports

def main():
    audit_meshes(OUT/NAME)
    mesh_report=audit_meshes(OUT/'sliced'/NAME)
    code_report=audit_code()
    report={'passed':True,'project':NAME,'physical_objects':10,'unique_parts':9,'plates':mesh_report,'slicing':code_report,'total_estimated_seconds':sum(r['seconds'] for r in code_report),'source_meshes_unchanged':True,'printer_job_sent':False}
    (OUT/'validation.json').write_text(json.dumps(report,indent=2))
    DST.mkdir(exist_ok=True)
    shutil.copy2(OUT/'sliced'/NAME,DST/NAME)
    shutil.copy2(OUT/'validation.json',DST/'validation.json')
    shutil.copy2(OUT/'plate-manifest.json',DST/'plate-manifest.json')
    (DST/'SHA256.json').write_text(json.dumps({NAME:hashlib.sha256((DST/NAME).read_bytes()).hexdigest()},indent=2))
    print(json.dumps({'passed':True,'path':str(DST/NAME),'plates':[{'plate':r['plate'],'seconds':r['seconds'],'grams':round(sum(f['total_used_g'] for f in r['filaments']),2)} for r in code_report]},indent=2))

if __name__=='__main__':main()
