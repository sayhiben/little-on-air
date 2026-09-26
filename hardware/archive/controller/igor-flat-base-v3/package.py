"""Audit the deliverable and create a self-contained prototype ZIP."""
from pathlib import Path
import hashlib,json,zipfile,xml.etree.ElementTree as E
import numpy as np
import trimesh

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'output'
REPO=ROOT.parents[2]
NAME='little-on-air-igor-controller-v3'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    geometry=json.loads((OUT/'validation/geometry.json').read_text())
    fit=json.loads((OUT/'validation/fit.json').read_text())
    sliced=json.loads((OUT/'validation/slicing.json').read_text())
    assert geometry['passed'] and fit['passed']
    assert geometry['changes_outside_allowed_regions_mm3']<.001
    assert geometry['orientation']['encoder_axis_vertical'] and geometry['orientation']['rear_wall_vertical']
    assert geometry['raised_front_nose_unchanged']
    assert all(x<.001 for x in geometry['unchanged_original_parts_symmetric_difference_mm3'].values())
    assert len(geometry['parts'])==5 and len(sliced)==2
    stls={x['name']+'.stl':x for x in geometry['parts']}
    for filename,record in stls.items():assert sha(OUT/'stl'/filename)==record['sha256']
    all_files=[]
    ns={'m':'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'}
    for project in sliced:
        assert project['slicer']['return_code']==0
        assert all(not p['warning_message'] for p in project['slicer']['sliced_plates'])
        with zipfile.ZipFile(OUT/'bambu-studio'/project['project']) as z:
            for serial,ob in enumerate(project['objects'],1):
                path=OUT/'stl'/ob['file'];assert sha(path)==ob['sha256']
                mesh=trimesh.load_mesh(path);center=mesh.bounds.mean(axis=0)
                root=E.fromstring(z.read(f'3D/Objects/object_{serial}.model'))
                vs=np.array([[float(v.get(k)) for k in 'xyz'] for v in root.findall('.//m:vertex',ns)])
                fs=np.array([[int(v.get(k)) for k in ('v1','v2','v3')] for v in root.findall('.//m:triangle',ns)])
                assert np.allclose(vs[fs]+center,mesh.triangles,atol=2e-6),ob['file']
                all_files.append(ob['file'])
            config=json.loads(z.read('Metadata/project_settings.config'))
            assert config['scan_first_layer']=='0'
    assert sorted(all_files)==sorted(stls)
    report={'passed':True,'five_STLs_match_two_sliced_projects':True,
      'source_geometry':'UrbanCircles/igor@7543085fe11f102f121f08aabd8f6c25c38bdf60',
      'native_geometry':True,'original_hat_and_inlays_unchanged':True,'shell_and_faceplate_changes_bounded':True,'correct_desk_orientation_checked':True,'native_xiao_fit_and_insertion':True,'sliced_without_warnings':True,
      'physical_print_or_electronics_test':False,'esp32_firmware_port_complete':False,
      'total_estimated_minutes':sum(x['slicer']['sliced_plates'][0]['total_predication'] for x in sliced)/60,
      'total_estimated_filament_g':sum(f['total_used_g'] for x in sliced for f in x['slicer']['sliced_plates'][0]['filaments'])}
    (OUT/'validation/package-audit.json').write_text(json.dumps(report,indent=2))
    files=sorted(p for p in ROOT.rglob('*') if p.is_file()
      and 'build-slicing' not in p.parts and '__pycache__' not in p.parts
      and p.name!='MANIFEST.json')
    manifest={str(p.relative_to(ROOT)).replace('\\','/'):{'bytes':p.stat().st_size,'sha256':sha(p)} for p in files}
    (ROOT/'MANIFEST.json').write_text(json.dumps(manifest,indent=2))
    target=REPO/'release'/f'{NAME}.zip'
    with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED) as z:
        for p in files+[ROOT/'MANIFEST.json']:z.write(p,str(Path(NAME)/p.relative_to(ROOT)))
    with zipfile.ZipFile(target) as z:
        assert z.testzip() is None
        for rel,record in manifest.items():
            assert hashlib.sha256(z.read(NAME+'/'+rel)).hexdigest()==record['sha256']
    target.with_suffix('.zip.sha256').write_text(sha(target)+'  '+target.name+'\n')
    print(json.dumps({'zip':str(target),'bytes':target.stat().st_size,'files':len(files)+1,'audit':report},indent=2))

if __name__=='__main__':main()
