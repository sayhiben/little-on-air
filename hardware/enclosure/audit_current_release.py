"""Validate the standalone curated release and write its manifest/archive."""
from pathlib import Path
import base64, collections, csv, hashlib, importlib.util, json, re, struct, subprocess, zipfile
from urllib.parse import unquote, urlparse
import xml.etree.ElementTree as E
import numpy as np

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
OUT=ROOT/'release/little-on-air-enclosure-v2.13'
spec=importlib.util.spec_from_file_location('a',BASE/'audit_print_projects.py')
a=importlib.util.module_from_spec(spec);spec.loader.exec_module(a)

def md(node):return {m.get('key'):m.get('value') for m in node.findall('metadata') if m.get('key')}
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()

def check_cad_archive(path):
    """Fusion exports use ZIP method 93 (Zstandard), absent in this Python."""
    frames=[]
    with zipfile.ZipFile(path) as archive, path.open('rb') as stream:
        for info in archive.infolist():
            if info.compress_type!=93:
                archive.read(info)
                continue
            stream.seek(info.header_offset)
            header=stream.read(30)
            assert header[:4]==b'PK\x03\x04'
            name_len,extra_len=struct.unpack_from('<HH',header,26)
            stream.seek(name_len+extra_len,1)
            frames.append({'name':info.filename,'data':base64.b64encode(stream.read(info.compress_size)).decode(),'bytes':info.file_size,'crc':info.CRC})
    node=Path.home()/'.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node.exe'
    script="const fs=require('node:fs'),z=require('node:zlib'); const r=JSON.parse(fs.readFileSync(0,'utf8')); process.stdout.write(JSON.stringify(r.map(x=>{const b=z.zstdDecompressSync(Buffer.from(x.data,'base64')); return {name:x.name,bytes:b.length,crc:z.crc32(b)};})));"
    decoded=json.loads(subprocess.check_output([str(node),'-e',script],input=json.dumps(frames),text=True))
    assert len(decoded)==len(frames)
    for source,actual in zip(frames,decoded):
        assert all(source[k]==actual[k] for k in ['name','bytes','crc']),source['name']
    return {'all_member_lengths_and_CRCs_valid':True,'zstandard_members':len(frames)}

def main():
    manifest=json.loads((OUT/'MANIFEST.json').read_text(encoding='utf-8'))
    for rel,record in manifest['provenance'].items():
        if 'source_sha256' in record:
            source=ROOT/record['source'];assert sha(source)==record['source_sha256'],rel
            if record['exact_copy']:assert sha(OUT/rel)==record['source_sha256'],rel
    parts=list(csv.DictReader((OUT/'PARTS.csv').open(encoding='utf-8',newline='')))
    prints=[p for p in parts if p['Release file'].endswith('.stl')]
    assert len(prints)==9 and sum(int(p['Quantity']) for p in prints)==10
    assert len(list((OUT/'stl').glob('*.stl')))==9
    assert len(list((OUT/'alternatives/laminate').glob('*.stl')))==2
    for p in parts:assert (OUT/p['Release file']).is_file()
    meshes={str(p.relative_to(OUT)).replace('\\','/'):a.topology(a.stl(p)) for p in OUT.rglob('*.stl')}
    assert all(abs(a.stl(p).reshape(-1,3).min(axis=0)[2])<.00005 for p in OUT.rglob('*.stl'))
    bom={row['Ref']:row for row in csv.DictReader((OUT/'BOM.csv').open(encoding='utf-8',newline=''))}
    assert bom['H1']['Quantity']==bom['H4']['Quantity']=='9'
    assert bom['P09']['Quantity']=='2' and bom['P08']['Quantity']=='1'
    assert all(p not in bom for p in ['U2','U3','Q1','PCB2'])
    assert len(json.loads((OUT/'reference/fastener-layout.json').read_text())['fasteners'])==9

    project=OUT/'bambu-studio/on-air-v213-X1C-all-plates.3mf'
    assert sha(project)==sha(BASE/'output/v213-complete/user-layout-release-check/final-sliced'/project.name)
    model,config,cfg=a.project_meshes(project)
    assert len(model)==10 and len(config.findall('plate'))==3
    assert cfg['filament_type']==['PLA','PLA','PETG'] and cfg['scan_first_layer']=='0'
    expected=collections.Counter({Path(p['Release file']).name:int(p['Quantity']) for p in prints})
    actual=collections.Counter(o['name'] for o in model.values());assert expected==actual
    om={o.get('id'):md(o) for o in config.findall('object')}
    for oid,obj in model.items():
        raw=a.stl(OUT/'stl'/obj['name']);tri=obj['triangles']
        matches=[]
        for k in range(4):
            angle=k*np.pi/2
            rotation=np.array([[np.cos(angle),-np.sin(angle),0],[np.sin(angle),np.cos(angle),0],[0,0,1]])
            rotated=raw@rotation
            delta=tri.reshape(-1,3).min(axis=0)-rotated.reshape(-1,3).min(axis=0)
            if raw.shape==tri.shape and np.allclose(rotated,tri-delta,atol=.00006,rtol=0):matches.append(k)
        assert matches,obj['name']
        # The insert is assigned white and its base is painted black. The
        # separate toolpath audit verifies every printed layer's actual color.
        extruder='3' if obj['name'].startswith(('08','09')) else ('2' if obj['name'].startswith('03') else '1')
        assert om[oid]['extruder']==extruder
    with zipfile.ZipFile(project) as z:
        assert z.testzip() is None
        for i in range(1,4):assert len(z.read(f'Metadata/plate_{i}.gcode'))>1000
    pr=json.loads((OUT/'validation/printing.json').read_text())
    assert pr['passed'] and pr['bambu_plates']==3
    assert len(pr['slicing'])==3 and not any(p['warnings'] for p in pr['slicing'])
    assert pr['additional_spare_keeper']==0
    assert pr['slicing'][1]['insert_colors']['all_25_layers_correct']

    # SVG is expressed from the rear with downward Y; STL from the front with
    # upward Y. Reflect both XY axes before comparing physical contours.
    ns='{http://www.w3.org/2000/svg}'
    svg=E.parse(OUT/'laser/02-acrylic-REAR-engrave-and-cut.svg').getroot()
    assert svg.get('width')=='104mm' and svg.get('height')=='38mm'
    assert not list(svg.iter(ns+'text'))
    backing=a.stl(OUT/'stl/03-registered-graphic-backing.stl');optics={}
    for name,zheight in [('ENGRAVE',2.0),('CUT',0.0)]:
        group=next(g for g in svg if g.get('id')==name);path=list(group)[0];d=path.get('d')
        assert set(re.findall('[A-Za-z]',d))<=set('MLZ')
        loops=[np.array([float(v) for v in re.findall(r'-?\d+(?:\.\d+)?',s)]).reshape(-1,2) for s in d.split('Z') if s.strip()]
        se=np.concatenate([np.stack((v,np.roll(v,-1,axis=0)),axis=1) for v in loops]);me=np.array([104,38])-a.boundary_edges(backing,zheight)
        sample=lambda e:np.concatenate([e[:,0],e[:,1],e.mean(axis=1)])
        error=float(max(a.point_segment_distance(sample(se),me).max(),a.point_segment_distance(sample(me),se).max()))
        assert error<.0001
        optics[name]={'maximum_contour_error_mm':error,'closed_contours':len(loops)}
    for p in list((OUT/'laser').rglob('*.svg'))+list((OUT/'alternatives').rglob('*.svg')):
        r=E.parse(p).getroot();assert r.get('width').endswith('mm') and r.get('height').endswith('mm')
        assert not list(r.iter(ns+'image')) and not list(r.iter(ns+'text'))
    review=E.parse(OUT/'laser/02-acrylic-REVIEW-ONLY.lbrn2').getroot()
    for setting in review.findall('CutSetting'):
        assert setting.find('doOutput').get('Value')=='0'
        assert all(float(n.get('Value'))==0 for n in setting if n.tag.lower().startswith(('minpower','maxpower')))

    links=[]
    for p in OUT.rglob('*.md'):
        text=p.read_text(encoding='utf-8');assert not any(x in text for x in ['\u00c3\u2014','\u00e2\u20ac','\ufffd']),p
        for link in re.findall(r'\]\(([^)]+)\)',text):
            if urlparse(link).scheme or link.startswith('#'):continue
            target=(p.parent/unquote(link.split('#')[0])).resolve()
            assert target.is_relative_to(OUT.resolve()) and target.exists(),(p,link,target)
            links.append({'file':str(p.relative_to(OUT)),'target':link})
    cad_checks={}
    for p in (OUT/'cad').iterdir():
        assert p.stat().st_size>10000
        if zipfile.is_zipfile(p):
            cad_checks[p.name]=check_cad_archive(p)
    firmware=next((OUT/'firmware').glob('*.zip'))
    with zipfile.ZipFile(firmware) as z:
        assert z.testzip() is None
        assert next(n for n in z.namelist() if n.endswith('/VERSION'))
        version=z.read(next(n for n in z.namelist() if n.endswith('/VERSION'))).decode().strip()
        assert version==manifest['firmware_version']=='0.1.2'
        pwm=z.read(next(n for n in z.namelist() if n.endswith('/src/status_output_pwm.c'))).decode()
        assert 'DT_ALIAS(pwm_red)' in pwm and 'pwm_set_pulse_dt' in pwm
    report={'passed':True,'production_unique_stls':9,'production_print_instances':10,'optional_laminate_stls':2,'bambu_plates':3,'bambu_project_matches_validated_three_plate_source':True,'production_STLs_match_embedded_meshes':True,'all_STLs':meshes,'acrylic_to_printed_backing':optics,'laser_review_outputs_disabled':True,'guide_links_checked':len(links),'firmware_version':version,'firmware_onboard_RGB_only':True,'no_geometry_or_machine_jobs_performed':True,'zip_integrity_checked':True}
    report['native_CAD_archive_integrity']=cad_checks
    (OUT/'validation/release-audit.json').write_text(json.dumps(report,indent=2))
    entries=[]
    for p in sorted(OUT.rglob('*')):
        if not p.is_file() or p.name in ['MANIFEST.json','SHA256SUMS.txt']:continue
        rel=str(p.relative_to(OUT)).replace('\\','/')
        origin=manifest['provenance'].get(rel,{'source':'Generated validation or preview in this release','exact_copy':False})
        entries.append({'path':rel,'bytes':p.stat().st_size,'sha256':sha(p),**origin})
    manifest['files']=entries;manifest['validated']=True;manifest['files_excluded_from_self_hash']=['MANIFEST.json','SHA256SUMS.txt']
    (OUT/'MANIFEST.json').write_text(json.dumps(manifest,indent=2),encoding='utf-8')
    checks={str(p.relative_to(OUT)).replace('\\','/'):sha(p) for p in sorted(OUT.rglob('*')) if p.is_file() and p.name!='SHA256SUMS.txt'}
    (OUT/'SHA256SUMS.txt').write_text(''.join(f'{h}  {n}\n' for n,h in checks.items()),encoding='utf-8')
    archive=OUT.parent/(OUT.name+'.zip')
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=6) as z:
        for p in sorted(OUT.rglob('*')):
            if p.is_file():z.write(p,str(p.relative_to(OUT.parent)).replace('\\','/'))
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        assert len(z.namelist())==len(checks)+1
        assert all(hashlib.sha256(z.read(OUT.name+'/'+n)).hexdigest()==h for n,h in checks.items())
    archive.with_suffix('.zip.sha256').write_text(f'{sha(archive)}  {archive.name}\n')
    print(json.dumps({'passed':True,'release':str(OUT),'archive':str(archive),'files':len(checks)+1,'zip_bytes':archive.stat().st_size,'links_checked':len(links),'optical_error_mm':optics},indent=2))

if __name__=='__main__':main()
