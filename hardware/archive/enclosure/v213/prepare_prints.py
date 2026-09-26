"""Exactly three optical pieces; structural replacements on a separate plate."""
from pathlib import Path
import importlib.util,json,zipfile,xml.etree.ElementTree as E,subprocess
BASE=Path(__file__).resolve().parents[1];OUT=BASE/'output/v213'
def module(name,path):
 s=importlib.util.spec_from_file_location(name,str(path));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m

def project(template,name,objects,optical=False):
 a=module('mf_helpers',BASE/'v28/make_bambu.py')
 with zipfile.ZipFile(template) as z:entries={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels','Metadata/project_settings.config']}
 cfg=json.loads(entries['Metadata/project_settings.config']);cfg['print_settings_id']='ON AIR v2.13 - '+('three captive light guides' if optical else 'structural guide retention parts')
 cfg['scan_first_layer']='0';cfg['enable_support']='0' if optical else '1'
 if not optical:
  support={'enable_support':'1','support_type':'normal(auto)','support_style':'snug','support_threshold_angle':'30','support_on_build_plate_only':'1','support_top_z_distance':'0.3' if 'PETG' in name else '0.2','support_object_xy_distance':'0.35','support_interface_top_layers':'2'}
  cfg.update(support);cfg['different_settings_to_system'][0]=';'.join(sorted(set(cfg['different_settings_to_system'][0].split(';'))|set(support)))
 entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
 model=E.Element(a.t('model'),{'unit':'millimeter','xml:lang':'en-US','requiredextensions':'p'});E.SubElement(model,a.t('metadata'),name='Application').text='BambuStudio-02.08.02.61';E.SubElement(model,a.t('metadata'),name='BambuStudio:3mfVersion').text='1'
 resources=E.SubElement(model,a.t('resources'));build=E.SubElement(model,a.t('build'),{'{'+a.PROD+'}UUID':a.uid()});rels=E.Element('Relationships',xmlns=a.REL);config=E.Element('config');assemble=E.Element('assemble')
 plate=E.SubElement(config,'plate');a.md(plate,'plater_id',1);a.md(plate,'plater_name','Install all 3 pieces: 1 front + 2 rear' if optical else '01 frame + 05 rear housing + 11 rear guide keeper');a.md(plate,'locked','false')
 manifest=[]
 for serial,(filename,x,y) in enumerate(objects,1):
  oid=serial*2;pid=oid-1;path=OUT/'stl'/filename;verts,faces,center=a.mesh(path)
  file=f'3D/Objects/object_{serial}.model';sub=E.Element(a.t('model'),unit='millimeter');sr=E.SubElement(sub,a.t('resources'));ob=E.SubElement(sr,a.t('object'),id=str(pid),type='model');mesh=E.SubElement(ob,a.t('mesh'));vs=E.SubElement(mesh,a.t('vertices'));ts=E.SubElement(mesh,a.t('triangles'))
  for v in verts:E.SubElement(vs,a.t('vertex'),**{k:f'{q:.7f}' for k,q in zip('xyz',v)})
  for f in faces:E.SubElement(ts,a.t('triangle'),**{k:str(q) for k,q in zip(('v1','v2','v3'),f)})
  E.SubElement(sub,a.t('build'));entries[file]=a.xml(sub)
  ob=E.SubElement(resources,a.t('object'),{'id':str(oid),'type':'model','{'+a.PROD+'}UUID':a.uid()});cs=E.SubElement(ob,a.t('components'));E.SubElement(cs,a.t('component'),{'objectid':str(pid),'{'+a.PROD+'}path':'/'+file,'{'+a.PROD+'}UUID':a.uid(),'transform':'1 0 0 0 1 0 0 0 1 0 0 0'})
  E.SubElement(rels,'Relationship',Target='/'+file,Id=f'rel{serial}',Type='http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel')
  transform=f'1 0 0 0 1 0 0 0 1 {x} {y} {center[2]:.7f}';E.SubElement(build,a.t('item'),{'objectid':str(oid),'printable':'1','transform':transform,'{'+a.PROD+'}UUID':a.uid()})
  ob=E.SubElement(config,'object',id=str(oid));a.md(ob,'name',filename);a.md(ob,'extruder',1);a.md(ob,'enable_support',int(filename.startswith('11-')));a.md(ob,'brim_type','no_brim' if optical else 'outer_only')
  if not optical:a.md(ob,'brim_width',3);a.md(ob,'brim_object_gap',.15)
  E.SubElement(ob,'metadata',face_count=str(len(faces)));p=E.SubElement(ob,'part',id=str(pid),subtype='normal_part',uuid=a.uid());a.md(p,'name',filename);a.md(p,'matrix','1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1');a.md(p,'source_file',filename);a.md(p,'source_object_id',0);a.md(p,'source_volume_id',0)
  for axis,c in zip('xyz',center):a.md(p,'source_offset_'+axis,f'{c:.7f}')
  E.SubElement(p,'mesh_stat',face_count=str(len(faces)),edges_fixed='0',degenerate_facets='0',facets_removed='0',facets_reversed='0',backwards_edges='0')
  inst=E.SubElement(plate,'model_instance');a.md(inst,'object_id',oid);a.md(inst,'instance_id',0);a.md(inst,'identify_id',serial)
  E.SubElement(assemble,'assemble_item',object_id=str(oid),instance_id='0',transform=transform,offset='0 0 0');E.SubElement(assemble,'assemble_item',object_id=str(oid),volume_id='0',transform='1 0 0 0 1 0 0 0 1 0 0 0')
  manifest.append({'object_id':oid,'file':filename,'center_xy':[x,y]})
 config.append(assemble);entries['3D/3dmodel.model']=a.xml(model);entries['3D/_rels/3dmodel.model.rels']=a.xml(rels);entries['Metadata/model_settings.config']=a.xml(config)
 dest=OUT/'bambu-studio';dest.mkdir(exist_ok=True);target=dest/name
 with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
  for n,data in entries.items():z.writestr(n,data)
 sliced=dest/('sliced-'+name.removesuffix('.3mf'));sliced.mkdir(exist_ok=True)
 with (sliced/'slice.log').open('w') as log:
  r=subprocess.run(['C:/Program Files/Bambu Studio/bambu-studio.exe','--slice','0','--debug','2','--outputdir',str(sliced.resolve()),'--export-3mf',name,str(target.resolve())],stdout=log,stderr=subprocess.STDOUT,cwd=sliced,creationflags=subprocess.CREATE_NO_WINDOW,timeout=300)
 result=json.loads((sliced/'result.json').read_text());assert r.returncode==0 and result['return_code']==0 and all(not x['warning_message'] for x in result['sliced_plates'])
 print(json.dumps({'project':name,'objects':len(objects),'seconds':result['sliced_plates'][0]['total_predication'],'filaments':result['sliced_plates'][0]['filaments']}),flush=True)
 return {'name':name,'optical':optical,'objects':manifest,'sliced':str(sliced.relative_to(OUT)).replace('\\','/')}

def main():
 m=module('orient_guides',BASE/'v28/prepare_meshes.py');m.OUT=OUT;old=m.rotate
 m.rotate=lambda v,p:(-v[2],-v[0],v[1]) if p in (8,9,10) else (v[0],-v[1],-v[2]) if p==11 else old(v,p)
 m.main()
 projects=[]
 for material in ('eSUN-PLA-plus','PETG'):
  template=BASE/'output/on-air-v212-clean-perimeter-front/bambu-studio'/f'on-air-v212-X1C-{material}-clean-perimeter-front.3mf'
  projects.append(project(template,f'on-air-v213-X1C-{material}-retention-housings.3mf',[('01-front-optical-bezel.stl',115,84),('05-rear-electronics-housing.stl',115,170),('11-rear-light-guide-keeper.stl',207,128)]))
 projects.append(project(BASE/'output/on-air-v28-light-pipes/bambu-studio/on-air-v28-clear-PETG-light-pipes.3mf','on-air-v213-clear-PETG-three-light-guides.3mf',[('08-captive-front-rgb-guide.stl',110,128),('09-charger-light-guide.stl',133,128),('09-charger-light-guide.stl',145,128)],True))
 (OUT/'plate-manifest.json').write_text(json.dumps(projects,indent=2))
if __name__=='__main__':main()
