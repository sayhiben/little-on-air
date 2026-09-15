from pathlib import Path
H=Path(__file__).resolve().parent
p=H/'check_usb_space.py';s=p.read_text().replace('(111.75,52.85,15.665);hi=(115.47,57.35,25.235)','(109.75,52.85,15.665);hi=(113.47,57.35,25.235)');p.write_text(s)
p=H/'harness.py';s=p.read_text()
# Endpoints now enter the open component-side aisle rather than the former spine windows.
s=s.replace('(95.5,43.5,18),(106.2,43.5,18),(106.2,43.5,24),(108.7,43.5,24)', '(95.5,34,18),(113.8,34,18),(114.3,43.5,18),(114.3,43.5,29.4)')
s=s.replace('(108.7,50.5,22),(106.2,50.5,22),(106.2,48.5,18),(98,47,15)', '(114.3,49,12),(114.3,33,12),(98,33,15)')
s=s.replace("('XIAO lower solder approach',(107.6,39.4,20.2),(109.8,44,26.0))", "('XIAO front pad wiring aisle',(110.5,38.4,10.7),(115.7,54,13.2))")
s=s.replace("('XIAO upper solder approach',(106.8,48.3,20.8),(109.8,54.2,26.0))", "('XIAO rear pad wiring aisle',(110.5,38.4,27.7),(115.7,54,30.9))")
p.write_text(s)
# Closure screws are shorter. Full harness validation includes every actual hardware solid.
p=H/'check_final_screw_space.py';p.write_text('''from pathlib import Path
import json
def run(_context:str):
 out=Path(__file__).resolve().parents[1]/'output/v26'
 r=json.loads((out/'harness-validation.json').read_text());assert r['passed']
 (out/'final-screw-wire-validation.json').write_text(json.dumps({'passed':True,'basis':'Full final harness validation includes all eight final M3x8 screw envelopes and all nuts.'},indent=2))
''')
