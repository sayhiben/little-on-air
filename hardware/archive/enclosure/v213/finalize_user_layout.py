"""Remove only the user-identified spare from the material-corrected copy."""
from pathlib import Path
import json,subprocess,zipfile,xml.etree.ElementTree as E
BASE=Path(__file__).resolve().parents[1]
WORK=BASE/'output/v213-complete/user-layout-release-check'
CORE='http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
PROD='http://schemas.microsoft.com/3dmanufacturing/production/2015/06'
def md(o):return {m.get('key'):m.get('value') for m in o.findall('metadata') if m.get('key')}
def main():
    with zipfile.ZipFile(WORK/'user-three-plates-materials-corrected.3mf') as z:e={n:z.read(n) for n in z.namelist()}
    config=E.fromstring(e['Metadata/model_settings.config']);plate=config.findall('plate')[1]
    names={o.get('id'):md(o)['name'] for o in config.findall('object')}
    remove=[i for i in plate.findall('model_instance') if names[md(i)['object_id']].startswith('11-')]
    assert len(remove)==1
    oid=md(remove[0])['object_id'];plate.remove(remove[0])
    for o in list(config.findall('object')):
        if o.get('id')==oid:config.remove(o)
    assemble=config.find('assemble')
    if assemble is not None:
        for o in list(assemble):
            if o.get('object_id')==oid:assemble.remove(o)
    labels=['Black PLA+ - all enclosure parts','PLA+ insert - black base and white letters','Clear PETG - 1 front guide and 2 rear guides']
    for plate,label in zip(config.findall('plate'),labels):
        next(m for m in plate.findall('metadata') if m.get('key')=='plater_name').set('value',label)
    root=E.fromstring(e['3D/3dmodel.model']);res=root.find('{'+CORE+'}resources');build=root.find('{'+CORE+'}build')
    for obj in list(res):
        if obj.get('id')==oid:res.remove(obj)
    for obj in list(build):
        if obj.get('objectid')==oid:build.remove(obj)
    used={c.get('{'+PROD+'}path').lstrip('/') for obj in res for cs in obj.findall('{'+CORE+'}components') for c in cs}
    for name in list(e):
        if name.startswith('3D/Objects/') and name.endswith('.model') and name not in used:del e[name]
    rels=E.fromstring(e['3D/_rels/3dmodel.model.rels'])
    for rel in list(rels):
        if rel.get('Target','').lstrip('/').startswith('3D/Objects/') and rel.get('Target').lstrip('/') not in used:rels.remove(rel)
    # Bambu's relationship reader expects unprefixed element names.
    for element in rels.iter():element.tag=element.tag.split('}')[-1]
    rels.set('xmlns','http://schemas.openxmlformats.org/package/2006/relationships')
    E.register_namespace('',CORE);E.register_namespace('p',PROD)
    for name,xml in [('3D/3dmodel.model',root),('Metadata/model_settings.config',config),('3D/_rels/3dmodel.model.rels',rels)]:e[name]=E.tostring(xml,encoding='utf-8',xml_declaration=True)
    cfg=json.loads(e['Metadata/project_settings.config'])
    cfg['flush_volumes_matrix']=['0','700','700','220','0','500','500','500','0']
    e['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
    target=WORK/'final-three-plates.3mf'
    with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
        for n,d in e.items():z.writestr(n,d)
    sliced=WORK/'final-sliced';sliced.mkdir(exist_ok=True)
    with (sliced/'slice.log').open('w') as log:r=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(sliced.resolve()),'--export-3mf','on-air-v213-X1C-all-plates.3mf',str(target.resolve())],cwd=sliced,stdout=log,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
    result=json.loads((sliced/'result.json').read_text());assert r.returncode==0 and result['return_code']==0
    print(json.dumps({'removed_spare_object':oid,'plates':[{'plate':p['id'],'objects':len(p['objects']),'seconds':p['total_predication'],'grams':sum(f['total_used_g'] for f in p['filaments']),'filament_changes':p['filament_change_times'],'warning':p['warning_message']} for p in result['sliced_plates']]},indent=2))
if __name__=='__main__':main()
