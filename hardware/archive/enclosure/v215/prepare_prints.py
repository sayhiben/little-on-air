"""Replace only part 01 in the approved three-plate project and slice copies."""
from pathlib import Path
import copy,importlib.util,json,zipfile,xml.etree.ElementTree as E,subprocess
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v215'
CORE='http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
PROD='http://schemas.microsoft.com/3dmanufacturing/production/2015/06'
E.register_namespace('',CORE);E.register_namespace('p',PROD)
t=lambda n:'{'+CORE+'}'+n
def load(name,path):
    s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def md(o):return {q.get('key'):q.get('value') for q in o.findall('metadata') if q.get('key')}
def setmd(o,k,v):
    q=next((q for q in o.findall('metadata') if q.get('key')==k),None)
    if q is None:q=E.SubElement(o,'metadata',key=k)
    q.set('value',str(v))
def xml(o):return E.tostring(o,encoding='utf-8',xml_declaration=True)

def main():
    orient=load('orient214',BASE/'v215/prepare_meshes.py');orient.OUT=OUT;orient.main()
    a=load('bambu214',BASE/'v28/make_bambu.py')
    src=BASE.parents[1]/'release/little-on-air-enclosure-v2.13/bambu-studio/on-air-v213-X1C-all-plates.3mf'
    with zipfile.ZipFile(src) as z:entries={n:z.read(n) for n in z.namelist()}
    config=E.fromstring(entries['Metadata/model_settings.config']);root=E.fromstring(entries['3D/3dmodel.model'])
    obs={md(o)['name']:o for o in config.findall('object')}
    bezel=obs['01-front-optical-bezel.stl'];bid=bezel.get('id');rearid=obs['05-rear-electronics-housing.stl'].get('id')
    # Open channels have no roof. Remove the previous special bridge direction.
    setmd(bezel,'bridge_angle',0)
    resource=next(o for o in root.find(t('resources')) if o.get('id')==bid)
    component=resource.find(t('components')).find(t('component'))
    target=component.get('{'+PROD+'}path').lstrip('/')
    meshfile=E.fromstring(entries[target]);ob=next(o for o in meshfile.find(t('resources')) if o.get('id')==component.get('objectid'))
    mesh=ob.find(t('mesh'));mesh.clear()
    verts,faces,center=a.mesh(OUT/'stl/01-front-optical-bezel.stl')
    vs=E.SubElement(mesh,t('vertices'));ts=E.SubElement(mesh,t('triangles'))
    for v in verts:E.SubElement(vs,t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
    for f in faces:E.SubElement(ts,t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
    entries[target]=xml(meshfile)
    next(q for q in bezel.findall('metadata') if q.get('face_count')).set('face_count',str(len(faces)))
    part=bezel.find('part');part.find('mesh_stat').set('face_count',str(len(faces)))
    for k,v in zip('xyz',center):setmd(part,'source_offset_'+k,f'{v:.7f}')
    for item in root.find(t('build')):
        v=list(map(float,item.get('transform').split()))
        if item.get('objectid')==bid:v[9]+=4.5;v[10]+=4.5
        if item.get('objectid')==rearid:v[10]+=9
        item.set('transform',' '.join(f'{x:.7f}' for x in v))
    # The stored assemble positions are stale in the supplied user-layout file.
    # Match them to the actual, preserved build placement in the replacement.
    positions={q.get('objectid'):q.get('transform') for q in root.find(t('build'))}
    for q in config.find('assemble'):
        if q.get('instance_id') is not None:q.set('transform',positions[q.get('object_id')])
    setmd(config.findall('plate')[0],'plater_name','Black PLA+ - v2.15 wider wired front and enclosure')
    cfg=json.loads(entries['Metadata/project_settings.config'])
    assert cfg['scan_first_layer']=='0'
    cfg['print_settings_id']='ON AIR v2.15 - front cable channels - approved three-plate materials'
    entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
    for name in list(entries):
        if name.startswith('Metadata/plate_') or name=='Metadata/slice_info.config':del entries[name]
    dest=OUT/'bambu-studio';dest.mkdir(exist_ok=True)
    for single in (False,True):
        e=dict(entries);r=copy.deepcopy(root);c=copy.deepcopy(config)
        label='front-only' if single else 'all-plates'
        if single:
            for q in list(c.findall('object')):
                if q.get('id')!=bid:c.remove(q)
            for q in list(r.find(t('resources'))):
                if q.get('id')!=bid:r.find(t('resources')).remove(q)
            for q in list(r.find(t('build'))):
                if q.get('objectid')!=bid:r.find(t('build')).remove(q)
                else:q.set('transform',f'1 0 0 0 1 0 0 0 1 128 128 {center[2]:.7f}')
            for plate in list(c.findall('plate'))[1:]:c.remove(plate)
            plate=c.find('plate');setmd(plate,'plater_name','Black PLA+ - replace front frame only')
            for q in list(plate.findall('model_instance')):
                if md(q)['object_id']!=bid:plate.remove(q)
            for q in list(c.find('assemble')):
                if q.get('object_id')!=bid:c.find('assemble').remove(q)
                elif q.get('instance_id') is not None:q.set('transform',f'1 0 0 0 1 0 0 0 1 128 128 {center[2]:.7f}')
            rels=E.fromstring(e['3D/_rels/3dmodel.model.rels'])
            for q in list(rels):
                if q.get('Target','').lstrip('/')!=target:rels.remove(q)
            for q in rels.iter():q.tag=q.tag.split('}')[-1]
            rels.set('xmlns','http://schemas.openxmlformats.org/package/2006/relationships')
            e['3D/_rels/3dmodel.model.rels']=xml(rels)
            for name in list(e):
                if name.startswith('3D/Objects/') and name!=target:del e[name]
            singlecfg=copy.deepcopy(cfg);singlecfg['enable_support']='0';singlecfg['enable_prime_tower']='0'
            e['Metadata/project_settings.config']=json.dumps(singlecfg,indent=2).encode()
        e['3D/3dmodel.model']=xml(r);e['Metadata/model_settings.config']=xml(c)
        path=dest/f'input-{label}.3mf'
        with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED) as z:
            for n,data in e.items():z.writestr(n,data)
        sliced=dest/label;sliced.mkdir(exist_ok=True)
        with (sliced/'slice.log').open('w') as log:
            result=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(sliced.resolve()),'--export-3mf',f'on-air-v215-X1C-{label}.3mf',str(path.resolve())],cwd=sliced,stdout=log,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
        stats=json.loads((sliced/'result.json').read_text())
        assert result.returncode==0 and stats['return_code']==0,(label,stats)
        print(json.dumps({'project':label,'plates':[{'plate':p['id'],'seconds':p['total_predication'],'grams':sum(f['total_used_g'] for f in p['filaments']),'warning':p['warning_message']} for p in stats['sliced_plates']]}),flush=True)

if __name__=='__main__':main()
