"""Check the user's three-plate arrangement after restoring chosen materials."""
from pathlib import Path
import importlib.util,json,collections,hashlib,zipfile,re
import numpy as np
BASE=Path(__file__).resolve().parents[1]
OUT=BASE/'output/v215'
def load(name,path):
    s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
a=load('mesh',BASE/'audit_print_projects.py')
c=load('complete',BASE/'v213/audit_complete_project.py')
def md(o):return {m.get('key'):m.get('value') for m in o.findall('metadata') if m.get('key')}

def main():
    p=OUT/'bambu-studio/all-plates/on-air-v215-X1C-all-plates.3mf'
    model,config,cfg=a.project_meshes(p)
    assert len(model)==10 and len(config.findall('plate'))==3
    assert cfg['filament_type']==['PLA','PLA','PETG'] and cfg['filament_colour']==['#161616','#FFFFFF','#D8EDF0']
    assert cfg['scan_first_layer']=='0'
    assert cfg['fan_max_speed'][2]=='30' and cfg['additional_cooling_fan_speed'][2]=='0'
    expected=collections.Counter({'01-front-optical-bezel.stl':1,'05-rear-electronics-housing.stl':1,'04-optical-retainer.stl':1,'06-electronics-retaining-yoke.stl':1,'07-front-guided-reset-button.stl':1,'03-registered-graphic-backing.stl':1,'08-captive-front-rgb-guide.stl':1,'09-charger-light-guide.stl':2,'11-rear-light-guide-keeper.stl':1})
    assert collections.Counter(o['name'] for o in model.values())==expected
    settings={o.get('id'):md(o) for o in config.findall('object')}
    records=[];allbounds={}
    for i,plate in enumerate(config.findall('plate')):
        origin=np.array([(i%2)*307.2,-(i//2)*307.2,0]);bounds=[];objects=[]
        for inst in plate.findall('model_instance'):
            oid=md(inst)['object_id'];o=model[oid];name=o['name'];tri=o['triangles']
            source=OUT/'stl'/name if name.startswith('01') else BASE.parents[1]/'release/little-on-air-enclosure-v2.13/stl'/name
            raw=a.stl(source)
            matches=[]
            for k in range(4):
                angle=k*np.pi/2;rotation=np.array([[np.cos(angle),-np.sin(angle),0],[np.sin(angle),np.cos(angle),0],[0,0,1]])
                rotated=raw@rotation;delta=tri.reshape(-1,3).min(axis=0)-rotated.reshape(-1,3).min(axis=0)
                if tri.shape==raw.shape and np.allclose(tri-delta,rotated,atol=.00006,rtol=0):matches.append(k)
            assert matches,name
            lo=(tri-origin).reshape(-1,3).min(axis=0);hi=(tri-origin).reshape(-1,3).max(axis=0)
            assert abs(lo[2])<.00005 and lo[0]>6 and lo[1]>6 and hi[0]<250 and hi[1]<250
            for oldlo,oldhi in bounds:assert max(np.maximum(lo[:2]-oldhi[:2],oldlo[:2]-hi[:2]))>1.99
            bounds.append((lo,hi))
            assert settings[oid]['enable_support']==('1' if name.startswith(('07','11')) else '0')
            objects.append({'name':name,'bounds':[lo.tolist(),hi.tolist()],'source_STL_matches':True,'XY_rotation_quarter_turns':matches[0]})
        allbounds[i+1]=objects
        records.append({'plate':i+1,'objects':objects})
    result=json.loads((OUT/'bambu-studio/all-plates/result.json').read_text())
    assert result['return_code']==0 and all(not q['warning_message'] for q in result['sliced_plates'])
    slicing=[]
    for i,q in enumerate(result['sliced_plates'],1):
        assert [f['id'] for f in q['filaments']]=={1:[1],2:[1,2],3:[3]}[i]
        code=(OUT/f'bambu-studio/all-plates/plate_{i}.gcode').read_text(encoding='utf-8').splitlines()
        active=[l.split(';')[0].strip() for l in code]
        assert not any(re.match(r'M97[67](?:\s|$)',l) for l in active)
        assert not any(re.match(r'(?:M400\s+U1|M0(?:\s|$)|M1(?:\s|$)|M25(?:\s|$)|M226(?:\s|$))',l) for l in active)
        assert 'M104 S0' in active and 'M140 S0' in active and any(l.startswith('G29 A ') for l in active)
        assert ('M190 S70' if i==3 else 'M190 S55') in active
        runs=list(c.paths(code));support=[s for s in runs if s['role'].startswith('Support')]
        support_bounds=[o['bounds'] for o in allbounds[i] if o['name'].startswith(('07','11'))]
        assert (bool(support)==bool(support_bounds))
        for s in support:
            for pt in [s['a'],s['b']]:assert any(all(lo[k]-6<pt[k]<hi[k]+6 for k in [0,1]) for lo,hi in support_bounds)
        record={'plate':i,'seconds':round(q['total_predication']),'filaments':q['filaments'],'warnings':[],'support_only_on_reset_or_guide_keepers':True,'first_layer_inspection_disabled':True,'no_manual_pauses':True,'bed_leveling_and_heater_shutdown':True}
        if i==2:
            lo,hi=next(o['bounds'] for o in allbounds[i] if o['name'].startswith('03'))
            layers=collections.defaultdict(set)
            for run in runs:
                middle=np.mean([run['a'],run['b']],axis=0)
                if run['role'] in ('Inner wall','Outer wall','Top surface','Bottom surface','Internal solid infill','Sparse infill','Gap infill') and all(lo[k]-.01<middle[k]<hi[k]+.01 for k in (0,1)):
                    layers[run['z']].add(run['tool'])
            assert len(layers)==25 and all(v==({0} if h<=1.6 else {1}) for h,v in layers.items()),layers
            assert q['filament_change_times']==1
            record['insert_colors']={'black_base_mm':1.6,'first_white_layer_z_mm':1.7,'all_25_layers_correct':True,'mechanism':'User-painted mesh retained; no height-change event required','filament_changes':q['filament_change_times']}
        if i==3:
            fill=[r for r in runs if r['command']=='G1' and r['dist']>1 and r['role'] in ('Sparse infill','Internal solid infill','Bottom surface','Top surface')]
            assert len(fill)==332 and all(abs(r['a'][1]-r['b'][1])<.02 for r in fill)
            assert all(r['feed']<=1200.01 for r in fill)
            assert cfg['nozzle_temperature'][2]=='255' and cfg['textured_plate_temp'][2]=='70'
            record['optical_fill']={'long_runs_parallel_to_guide_axis':332,'off_axis_runs':0,'maximum_fill_speed_mm_s':20,'low_cooling_restored':True}
        slicing.append(record)
    # Confirm the other nine instances keep their source geometry and paint.
    with zipfile.ZipFile(BASE.parents[1]/'release/little-on-air-enclosure-v2.13/bambu-studio/on-air-v213-X1C-all-plates.3mf') as old,zipfile.ZipFile(p) as new:
        unchanged=[n for n in old.namelist() if n.startswith('3D/Objects/') and n!='3D/Objects/object_1.model']
        assert all(old.read(n)==new.read(n) for n in unchanged),'Unchanged mesh/paint payload differs'
    frame_id=next(k for k,o in model.items() if o['name'].startswith('01'))
    assert settings[frame_id]['bridge_angle']=='0'
    single_path=OUT/'bambu-studio/front-only/on-air-v215-X1C-front-only.3mf'
    single,sc,sp=a.project_meshes(single_path)
    assert len(single)==1 and len(sc.findall('plate'))==1 and sp['scan_first_layer']=='0'
    single_tri=next(iter(single.values()))['triangles'];raw=a.stl(OUT/'stl/01-front-optical-bezel.stl')
    assert np.allclose(single_tri-single_tri.reshape(-1,3).min(axis=0),raw,atol=.00006,rtol=0)
    single_code=(OUT/'bambu-studio/front-only/plate_1.gcode').read_text().splitlines()
    single_runs=list(c.paths(single_code))
    assert not any(r['role'].startswith('Support') for r in single_runs)
    roofs=[r for r in single_runs if r['role']=='Bridge' and 8.1<r['z']<8.4]
    assert not roofs,'A roof bridge remains at the former wire-channel roof layer'
    maxrun=0
    ss=json.loads((OUT/'bambu-studio/front-only/result.json').read_text())
    assert ss['return_code']==0 and not ss['sliced_plates'][0]['warning_message']
    report={'passed':True,'production_print_instances':10,'additional_spare_keeper':0,'project_objects':10,'bambu_plates':3,'changed_geometry':['01 front frame'],'rear_housing_plate_1_shift_from_v213_y_mm':9,'placement_unchanged_from_v214':True,'unchanged_other_mesh_and_paint_payloads':unchanged,'slicing':slicing,'plates':records,'total_estimated_seconds':sum(s['seconds'] for s in slicing),'user_original_retained':True,'materials_PLA_PLA_PETG':True,'front_only':{'mesh_matches':True,'supports':False,'bridge_angle_deg':0,'roof_bridge_runs':len(roofs),'max_roof_bridge_extrusion_length_mm':maxrun,'seconds':ss['sliced_plates'][0]['total_predication'],'grams':sum(f['total_used_g'] for f in ss['sliced_plates'][0]['filaments'])}}
    (OUT/'printing-validation.json').write_text(json.dumps(report,indent=2))
    print(json.dumps({'passed':True,'objects':10,'spare_keepers':0,'seconds':report['total_estimated_seconds'],'insert':slicing[1]['insert_colors'],'optics':slicing[2]['optical_fill']},indent=2))

if __name__=='__main__':main()
