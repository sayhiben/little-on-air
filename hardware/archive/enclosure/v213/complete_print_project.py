"""One editable, four-plate X1C project using the latest released production meshes.

Do not rebuild CAD here. Two PLA+ colors share the same thermal baseline. The
PETG guides have object-level optical settings; settings Bambu stores only at
project level use the more conservative optical values across all four plates.
"""
from pathlib import Path
import copy, importlib.util, json, re, subprocess, zipfile
import xml.etree.ElementTree as E

BASE = Path(__file__).resolve().parents[1]
OUT = BASE / 'output/v213-complete'
NAME = 'on-air-v213-X1C-all-plates.3mf'
LATEST = BASE / 'output/on-air-v213-captive-light-guides'
UNCHANGED = BASE / 'output/on-air-v28-fabrication'

def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

def read_project(path):
    with zipfile.ZipFile(path) as z:
        return {n: z.read(n) for n in z.namelist()}

def metadata(element):
    return {m.get('key'): m.get('value') for m in element.findall('metadata') if m.get('key')}

def serialize(value):
    return ','.join(map(str, value)) if isinstance(value, list) else str(value)

def build():
    OUT.mkdir(exist_ok=True)
    a = module('mf_helpers', BASE / 'v28/make_bambu.py')
    black_entries = read_project(LATEST / 'bambu-studio/on-air-v213-X1C-eSUN-PLA-plus-retention-housings.3mf')
    optical_entries = read_project(LATEST / 'bambu-studio/on-air-v213-clear-PETG-three-light-guides.3mf')
    old_entries = read_project(UNCHANGED / 'bambu-studio/on-air-v28-X1C-eSUN-PLA-plus-AMS.3mf')
    black = json.loads(black_entries['Metadata/project_settings.config'])
    optical = json.loads(optical_entries['Metadata/project_settings.config'])
    cfg = copy.deepcopy(black)

    # Source-of-truth distinction between filament arrays and machine/variant arrays.
    preset_source = (OUT / 'reference/Preset.cpp').read_text(encoding='utf-8')
    filament_section = preset_source.split('s_Preset_filament_options {', 1)[1].split('\n};', 1)[0]
    filament_keys = set(re.findall(r'"([a-z][a-z0-9_]*)"', filament_section))
    filament_keys |= {'filament_colour', 'filament_multi_colour', 'filament_colour_type', 'filament_ids', 'filament_settings_id'}
    for key in filament_keys:
        if key not in cfg or key not in optical:
            continue
        if isinstance(black[key], list) and black[key]:
            assert isinstance(optical[key], list) and optical[key], key
            cfg[key] = [black[key][0], black[key][0], optical[key][0]]
    # Non-preset project filament indexing, always one physical X1C extruder.
    cfg.update({
        'filament_self_index': ['1', '2', '3'],
        'filament_map': ['1', '1', '1'],
        'filament_volume_map': ['0', '0', '0'],
        'filament_nozzle_map': ['0', '0', '0'],
        'filament_colour': ['#161616', '#FFFFFF', '#D8EDF0'],
        'filament_multi_colour': ['#161616', '#FFFFFF', '#D8EDF0'],
        'filament_settings_id': ['ON AIR black PLA+ - eSUN baseline', 'ON AIR white PLA+ - eSUN baseline', optical['filament_settings_id'][0]],
        'filament_notes': 'Black and white share the previous eSUN PLA+ baseline. Clear PETG retains the optical profile. Match actual spool temperatures and calibrated flow before printing.',
        'print_settings_id': 'ON AIR complete v2.13 - structural + two-color insert + clear guides',
        'scan_first_layer': '0',
        'enable_prime_tower': '1',
        'flush_volumes_matrix': ['0', '700', '700', '220', '0', '500', '500', '500', '0'],
        'flush_volumes_vector': ['140'] * 6,
        'flush_multiplier': '1',
        'flush_into_infill': '0', 'flush_into_objects': '0', 'flush_into_support': '0',
        'wipe_tower_x': ['22'] * 4, 'wipe_tower_y': ['185'] * 4,
    })
    # Bambu's initial layer, acceleration, and travel policies are project-wide.
    # Retain the optical requirements; structural layer heights remain 0.20 mm.
    common_keys = ['initial_layer_print_height', 'initial_layer_speed', 'initial_layer_infill_speed',
                   'default_acceleration', 'outer_wall_acceleration', 'reduce_crossing_wall']
    for key in common_keys:
        cfg[key] = copy.deepcopy(optical[key])
    proc_keys = set(black['different_settings_to_system'][0].split(';')) | set(common_keys) | {'enable_prime_tower'}
    fkeys = ';'.join(sorted(k for k in filament_keys if k in cfg and k not in {'inherits','compatible_printers','compatible_prints'}))
    cfg['different_settings_to_system'] = [';'.join(sorted(proc_keys)), fkeys, fkeys, fkeys, 'scan_first_layer']
    cfg['inherits_group'] = ['0.20mm Standard @BBL X1C', '', '', '', '']

    old_objects = {metadata(o)['name']: metadata(o) for o in E.fromstring(old_entries['Metadata/model_settings.config']).findall('object')}
    new_objects = {metadata(o)['name']: metadata(o) for o in E.fromstring(black_entries['Metadata/model_settings.config']).findall('object')}
    # Only recognized object/region settings can override the shared process.
    hpp = (OUT / 'reference/PrintConfig.hpp').read_text(encoding='utf-8')
    object_section = hpp.split('    PrintObjectConfig,', 1)[1].split('    MachineEnvelopeConfig,', 1)[0]
    override_keys = set(re.findall(r'\(\(\w+(?:<[^>]+>)?,\s*(\w+)\)\)', object_section))
    optical_overrides = {k: serialize(v) for k, v in optical.items() if k in override_keys and v != cfg.get(k)}
    optical_overrides.update({'enable_support':'0', 'brim_type':'no_brim'})
    plates = [
        ('Black PLA+ - frame, rear housing, guide keeper', [
            (LATEST, '01-front-optical-bezel.stl', 115, 84, 1),
            (LATEST, '05-rear-electronics-housing.stl', 115, 170, 1),
            (LATEST, '11-rear-light-guide-keeper.stl', 207, 128, 1)]),
        ('Black PLA+ - retainers and reset button', [
            (UNCHANGED, '04-optical-retainer.stl', 128, 164, 1),
            (UNCHANGED, '06-electronics-retaining-yoke.stl', 128, 103, 1),
            (UNCHANGED, '07-front-guided-reset-button.stl', 128, 63, 1)]),
        ('PLA+ insert - black base, white letters', [
            (UNCHANGED, '03-registered-graphic-backing.stl', 128, 128, 1)]),
        ('Clear PETG - 1 front guide and 2 rear guides', [
            (LATEST, '08-captive-front-rgb-guide.stl', 110, 128, 3),
            (LATEST, '09-charger-light-guide.stl', 133, 128, 3),
            (LATEST, '09-charger-light-guide.stl', 145, 128, 3)]),
    ]
    entries = {k: black_entries[k] for k in ['[Content_Types].xml', '_rels/.rels']}
    entries['Metadata/project_settings.config'] = json.dumps(cfg, indent=2).encode()
    model = E.Element(a.t('model'), {'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'})
    E.SubElement(model,a.t('metadata'),name='Application').text='BambuStudio-02.08.02.61'
    E.SubElement(model,a.t('metadata'),name='BambuStudio:3mfVersion').text='1'
    E.SubElement(model,a.t('metadata'),name='Title').text='Little ON AIR v2.13 - complete print set'
    resources=E.SubElement(model,a.t('resources'))
    build=E.SubElement(model,a.t('build'),{'{'+a.PROD+'}UUID':a.uid()})
    rels=E.Element('Relationships',xmlns=a.REL)
    config=E.Element('config');assemble=E.Element('assemble');serial=0;manifest=[]
    for pi,(label,parts) in enumerate(plates):
        plate=E.SubElement(config,'plate')
        for k,v in {'plater_id':pi+1,'plater_name':label,'locked':'false','filament_map_mode':'Auto For Flush','filament_maps':'1 1 1','filament_volume_maps':'0 0 0'}.items():a.md(plate,k,v)
        pm={'plate':pi+1,'name':label,'objects':[]};manifest.append(pm)
        for root,filename,x,y,extruder in parts:
            serial+=1;oid=serial*2;pid=oid-1;path=root/'stl'/filename
            verts,faces,center=a.mesh(path);file=f'3D/Objects/object_{serial}.model'
            sub=E.Element(a.t('model'),unit='millimeter');sr=E.SubElement(sub,a.t('resources'))
            ob=E.SubElement(sr,a.t('object'),id=str(pid),type='model');mesh=E.SubElement(ob,a.t('mesh'))
            vs=E.SubElement(mesh,a.t('vertices'));ts=E.SubElement(mesh,a.t('triangles'))
            for v in verts:E.SubElement(vs,a.t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
            for f in faces:E.SubElement(ts,a.t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
            E.SubElement(sub,a.t('build'));entries[file]=a.xml(sub)
            ob=E.SubElement(resources,a.t('object'),{'id':str(oid),'type':'model','{'+a.PROD+'}UUID':a.uid()})
            cs=E.SubElement(ob,a.t('components'))
            E.SubElement(cs,a.t('component'),{'objectid':str(pid),'{'+a.PROD+'}path':'/'+file,'{'+a.PROD+'}UUID':a.uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
            E.SubElement(rels,'Relationship',Target='/'+file,Id=f'rel{serial}',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
            transform=f'1 0 0 0 1 0 0 0 1 {x+(pi%2)*307.2} {y-(pi//2)*307.2} {center[2]:.7f}'
            E.SubElement(build,a.t('item'),{'objectid':str(oid),'printable':'1','transform':transform,'{'+a.PROD+'}UUID':a.uid()})
            ob=E.SubElement(config,'object',id=str(oid))
            om=copy.deepcopy((new_objects if root==LATEST else old_objects).get(filename,{}))
            om.update({'name':filename,'extruder':str(extruder)})
            if pi==3:om.update(optical_overrides)
            # Preserve the reset button's previously sliced support recipe.
            if filename.startswith('07-'):
                old_cfg=json.loads(old_entries['Metadata/project_settings.config'])
                om.update({k:serialize(v) for k,v in old_cfg.items() if k.startswith('support_') and k in override_keys})
            for k,v in om.items():a.md(ob,k,v)
            E.SubElement(ob,'metadata',face_count=str(len(faces)))
            p=E.SubElement(ob,'part',id=str(pid),subtype='normal_part',uuid=a.uid())
            for k,v in {'name':filename,'matrix':'1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1','source_file':filename,'source_object_id':0,'source_volume_id':0}.items():a.md(p,k,v)
            for axis,c in zip('xyz',center):a.md(p,'source_offset_'+axis,f'{c:.7f}')
            E.SubElement(p,'mesh_stat',face_count=str(len(faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
            inst=E.SubElement(plate,'model_instance')
            for k,v in {'object_id':oid,'instance_id':0,'identify_id':serial}.items():a.md(inst,k,v)
            E.SubElement(assemble,'assemble_item',object_id=str(oid),instance_id='0',transform=transform,offset='0 0 0')
            E.SubElement(assemble,'assemble_item',object_id=str(oid),volume_id='0',transform='1 0 0 0 1 0 0 0 1 0 0 0')
            pm['objects'].append({'id':oid,'source':str(path.relative_to(BASE)).replace('\\','/'),'filename':filename,'extruder':extruder,'center_xy':[x,y],'settings':om})
    config.append(assemble)
    entries['3D/3dmodel.model']=a.xml(model);entries['3D/_rels/3dmodel.model.rels']=a.xml(rels)
    entries['Metadata/model_settings.config']=a.xml(config)
    entries['Metadata/custom_gcode_per_layer.xml']=old_entries['Metadata/custom_gcode_per_layer.xml']
    target=OUT/NAME
    with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
        for n,data in entries.items():z.writestr(n,data)
    (OUT/'plate-manifest.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    (OUT/'shared-process-notes.json').write_text(json.dumps({'shared_optical_values':{k:cfg[k] for k in common_keys},'optical_object_overrides':optical_overrides},indent=2))
    print(target,flush=True)
    sliced=OUT/'sliced';sliced.mkdir(exist_ok=True)
    with (sliced/'slice.log').open('w',encoding='utf-8') as log:
        result=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(sliced.resolve()),'--export-3mf',NAME,str(target.resolve())],cwd=sliced,stdout=log,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
    print('Slicer exit',result.returncode,flush=True)
    print((sliced/'result.json').read_text(encoding='utf-8') if (sliced/'result.json').exists() else (sliced/'slice.log').read_text(encoding='utf-8')[-5000:])
    assert result.returncode==0

if __name__=='__main__':build()
