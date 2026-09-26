"""Package actual STL meshes and run Bambu Studio's slicer (no printer upload)."""
from pathlib import Path
import json,zipfile,xml.etree.ElementTree as E,uuid,subprocess,hashlib
import trimesh

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'output'
CORE='http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
PROD='http://schemas.microsoft.com/3dmanufacturing/production/2015/06'
REL='http://schemas.openxmlformats.org/package/2006/relationships'
E.register_namespace('',CORE);E.register_namespace('p',PROD)
def t(n):return '{'+CORE+'}'+n
def uid():return str(uuid.uuid4())
def md(e,k,v):E.SubElement(e,'metadata',key=k,value=str(v))
def xml(e):return E.tostring(e,encoding='utf-8',xml_declaration=True)

def project(name,settings,objects,color,optical=False):
    settings=dict(settings)
    updates={'print_settings_id':name,'scan_first_layer':'0','layer_height':'.12' if optical else '.2',
      'initial_layer_print_height':'.2','wall_loops':'3' if optical else '4',
      'sparse_infill_density':'100%' if optical else '25%',
      'sparse_infill_pattern':'zig-zag' if optical else 'gyroid',
      'top_shell_layers':'5','bottom_shell_layers':'5','enable_support':'1',
      'support_type':'normal(auto)','support_style':'snug','support_on_build_plate_only':'0',
      'support_threshold_angle':'30','support_top_z_distance':'.2',
      'support_object_xy_distance':'.35','support_interface_top_layers':'2',
      'brim_type':'outer_only','brim_width':'3','brim_object_gap':'.15',
      'enable_prime_tower':'0','outer_wall_speed':'35' if optical else '50',
      'inner_wall_speed':'40' if optical else '100','bridge_speed':'25',
      'initial_layer_speed':'25','initial_layer_infill_speed':'35'}
    settings.update(updates)
    settings['filament_colour']=[color];settings['filament_multi_colour']=[color]
    settings['different_settings_to_system'][0]=';'.join(sorted(set(settings['different_settings_to_system'][0].split(';'))|set(updates)))
    entries={
     '[Content_Types].xml':b'<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>',
     '_rels/.rels':b'<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>',
     'Metadata/project_settings.config':json.dumps(settings,indent=2).encode()}
    model=E.Element(t('model'),{'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'})
    E.SubElement(model,t('metadata'),name='Application').text='BambuStudio-02.08.02.61'
    E.SubElement(model,t('metadata'),name='BambuStudio:3mfVersion').text='1'
    resources=E.SubElement(model,t('resources'));build=E.SubElement(model,t('build'),{'{'+PROD+'}UUID':uid()})
    rels=E.Element('Relationships',xmlns=REL);config=E.Element('config');assemble=E.Element('assemble')
    plate=E.SubElement(config,'plate');md(plate,'plater_id',1);md(plate,'plater_name',name);md(plate,'locked','false')
    manifest=[]
    for serial,(filename,x,y,support) in enumerate(objects,1):
        mesh=trimesh.load_mesh(OUT/'stl'/filename)
        center=mesh.bounds.mean(axis=0);vs=mesh.vertices-center
        oid=serial*2;pid=oid-1;file=f'3D/Objects/object_{serial}.model'
        sub=E.Element(t('model'),unit='millimeter');sr=E.SubElement(sub,t('resources'))
        ob=E.SubElement(sr,t('object'),id=str(pid),type='model');me=E.SubElement(ob,t('mesh'))
        v=E.SubElement(me,t('vertices'));f=E.SubElement(me,t('triangles'))
        for p in vs:E.SubElement(v,t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',p)})
        for p in mesh.faces:E.SubElement(f,t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),p)})
        E.SubElement(sub,t('build'));entries[file]=xml(sub)
        ob=E.SubElement(resources,t('object'),{'id':str(oid),'type':'model','{'+PROD+'}UUID':uid()})
        cs=E.SubElement(ob,t('components'))
        E.SubElement(cs,t('component'),{'objectid':str(pid),'{'+PROD+'}path':'/'+file,'{'+PROD+'}UUID':uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
        E.SubElement(rels,'Relationship',Target='/'+file,Id=f'rel{serial}',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
        transform=f'1 0 0 0 1 0 0 0 1 {x} {y} {center[2]:.7f}'
        E.SubElement(build,t('item'),{'objectid':str(oid),'printable':'1','transform':transform,'{'+PROD+'}UUID':uid()})
        ob=E.SubElement(config,'object',id=str(oid));md(ob,'name',filename);md(ob,'extruder',1)
        md(ob,'enable_support',int(support));md(ob,'brim_type','outer_only');md(ob,'brim_width',3)
        E.SubElement(ob,'metadata',face_count=str(len(mesh.faces)))
        part=E.SubElement(ob,'part',id=str(pid),subtype='normal_part',uuid=uid())
        md(part,'name',filename);md(part,'matrix','1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1');md(part,'source_file',filename)
        E.SubElement(part,'mesh_stat',face_count=str(len(mesh.faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
        inst=E.SubElement(plate,'model_instance');md(inst,'object_id',oid);md(inst,'instance_id',0);md(inst,'identify_id',serial)
        E.SubElement(assemble,'assemble_item',object_id=str(oid),instance_id='0',transform=transform,offset='0 0 0')
        manifest.append({'file':filename,'sha256':hashlib.sha256((OUT/'stl'/filename).read_bytes()).hexdigest(),'support':support,'center_xy':[x,y]})
    config.append(assemble)
    entries['3D/3dmodel.model']=xml(model);entries['3D/_rels/3dmodel.model.rels']=xml(rels);entries['Metadata/model_settings.config']=xml(config)
    dest=OUT/'bambu-studio';dest.mkdir(exist_ok=True)
    target=dest/(name+'.3mf')
    with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
        for n,data in entries.items():z.writestr(n,data)
    work=ROOT/'build-slicing'/name;work.mkdir(parents=True,exist_ok=True)
    with (work/'slice.log').open('w') as log:
        p=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2',
          '--outputdir',str(work),'--export-3mf',target.name,str(target)],cwd=work,
          stdout=log,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
    result=json.loads((work/'result.json').read_text())
    assert p.returncode==0 and result['return_code']==0,result
    assert all(not x['warning_message'] for x in result['sliced_plates']),result
    if objects[0][0]=='01-weighted-shell.stl':
        with zipfile.ZipFile(work/target.name) as z:
            (OUT/'views/print-plate.png').write_bytes(z.read('Metadata/plate_1.png'))
    report={'project':target.name,'objects':manifest,'slicer':result,'profile_overrides':updates}
    print(json.dumps({'name':name,'slicer':result}),flush=True)
    return report

def main():
    profiles=json.loads((ROOT/'print-profiles.json').read_text())
    reports=[]
    reports.append(project('igor-desk-v1-X1C-PLA-body',profiles['pla'],
       [('01-weighted-shell.stl',105,103,True),('03-igor-hat.stl',175,103,False),('04-ballast-cover.stl',135,183,False)],'#34585A'))
    reports.append(project('igor-desk-v1-X1C-PLA-faceplate',profiles['pla'],
       [('02-igor-faceplate.stl',128,128,False)],'#D6D9CA'))
    reports.append(project('igor-desk-v1-X1C-clear-PETG-diffuser',profiles['petg'],
       [('05-led-diffuser.stl',128,128,False)],'#F4F0DF',True))
    (OUT/'validation/slicing.json').write_text(json.dumps(reports,indent=2))

if __name__=='__main__':main()
