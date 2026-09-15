from pathlib import Path
import json,hashlib,zipfile,xml.etree.ElementTree as ET
BASE=Path(__file__).resolve().parents[1]
D=BASE/'output/on-air-v24-fabrication'
manifest=json.loads((D/'manifest.json').read_text())
actual={str(p.relative_to(D)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in D.rglob('*') if p.is_file() and p.name!='manifest.json'}
assert actual==manifest
with zipfile.ZipFile(D.with_suffix('.zip')) as z:
 assert z.testzip() is None
 assert len(z.namelist())==len(actual)+1
 for name,digest in actual.items():assert hashlib.sha256(z.read(D.name+'/'+name)).hexdigest()==digest,name
assert len(list((D/'stl').glob('*.stl')))==6
assert len(list((D/'fit-samples').glob('*.stl')))==10
assert len(list((D/'optional-laminate').glob('*.stl')))==2
assert not list(D.rglob('08*.stl'))
assert len(list((D/'bambu-studio').glob('*.3mf')))==9
assert len(list((D/'cad').glob('*')))==3
for p in D.rglob('*.svg'):ET.parse(p)
for p in D.rglob('*.md'):
 data=p.read_bytes();assert b'\r\r\n' not in data
 assert '\ufffd' not in data.decode('utf-8')
for name in ('bambu-gui-validation.json','archive-roundtrip-validation.json','harness-validation.json','usb-space-validation.json','wire-packing-validation.json'):
 assert json.loads((D/'validation'/name).read_text())['passed'],name
print(json.dumps({'passed':True,'files':len(actual)+1,'stls':18,'bambu_projects':9,'native_archives':3,'zip_size_bytes':D.with_suffix('.zip').stat().st_size,'manifest_and_zip_match':True}))
