from pathlib import Path
H=Path(__file__).resolve().parent
p=H/'make_fit_sections.py';s=p.read_text().replace("('91 front screw recess section','01',(0,0,-11),(12,12,0))","('91 upper front fastener fit section','01',(0,48,-11),(120,60,0))").replace("('93 XIAO and reset fit section','05',(105.5,33,-34)","('93 XIAO and reset fit section','05',(102,33,-34)");p.write_text(s)
p=H/'make_bambu.py';s=p.read_text().replace("3 parts',[(99,128,104),(6,128,164),(7,128,198)]","4 parts',[(91,128,60),(99,128,104),(6,128,164),(7,128,198)]");p.write_text(s)
for name in ('slice_and_audit_all.py','check_gui_roundtrip.py'):
 p=H/name;s=p.read_text().replace("n=3 if 'fit-checks'","n=4 if 'fit-checks'").replace('audit_project(gui,3)','audit_project(gui,4)');p.write_text(s)
p=H/'validate_terminal_rows.py';s=p.read_text().replace('(19.8,22.82)','(19.9,22.92)');p.write_text(s)
p=H/'harness.py';s=p.read_text().replace('(115.7,54,13.2)','(115.7,55.3,13.2)').replace('(115.7,54,30.9)','(115.7,55.3,30.9)');p.write_text(s)
p=H/'routing_map.py';s=p.read_text().replace("('XIAO',110.8,36.8,4.37,21)","('XIAO',108.8,36.8,4.37,21)");p.write_text(s)
