from pathlib import Path
import re,json
p=next(Path('hardware/enclosure/references/xiao').rglob('*.kicad_pcb'))
s=p.read_text();parts=[]
for block in s.split('\n  (footprint ')[1:]:
 ref=re.search(r'\(property "Reference" "([^"]+)"',block)
 if ref and ref[1] in ('RGB6','K1','USB1','U4'):
  print(ref[1],re.search(r'\(at ([^)]+)\)',block)[1])
  if ref[1]=='U4':print(block[:4200])
for block in s.split('\n  (gr_')[1:]:
 if '"Edge.Cuts"' in block:print(block[:320])
