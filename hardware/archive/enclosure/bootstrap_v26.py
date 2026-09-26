from pathlib import Path
B=Path(__file__).resolve().parent
D=B/'v26';D.mkdir(exist_ok=True);(B/'output/v26').mkdir(exist_ok=True)
for source in (B/'v25').glob('*.py'):
    text=source.read_text(encoding='utf-8').replace('v25','v26').replace('v2.5','v2.6')
    (D/source.name).write_text(text,encoding='utf-8')
p=D/'start_revision.py'
s=p.read_text().replace('on-air-v24-fabrication/cad/little-on-air-v24.f3d','on-air-v25-fabrication/cad/little-on-air-v25.f3d').replace("('07 ','REF XIAO','REF DPDT','REF Harness')","('REF M3 screws','REF M3 nuts','REF Harness')").replace('third physical fit revision','service access and common fasteners').replace('Inherited tested v2.4 solid','Inherited tested v2.5 solid')
p.write_text(s)
