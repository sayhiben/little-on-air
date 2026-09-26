from pathlib import Path
H=Path(__file__).resolve().parent
p=H/'harness.py';s=p.read_text()
s=s.replace('(95.5,34,18),(113.8,34,18),(114.3,43.5,18),(114.3,43.5,29.4)', '(95.5,43.5,18),(101,48.6,16),(107.3,48.6,16)')
s=s.replace('(110.5,38.4,10.7),(115.7,55.3,13.2)', '(110.5,38.4,11.7),(113.2,55.6,13.4)')
s=s.replace('(115.7,55.3,30.9)', '(115.7,55.6,30.9)')
s=s.replace("BAYS=[", "BAYS=[\n ('XIAO BAT and GND underside solder bay',(104.8,46.5,14.5),(108.75,50.5,18.0)),")
p.write_text(s)
