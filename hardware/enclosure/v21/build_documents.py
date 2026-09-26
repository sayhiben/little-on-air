from pathlib import Path
import csv,json,math,html,importlib.util,shutil
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v21'
def csvout(name,fields,rows):
 with (OUT/name).open('w',newline='',encoding='utf-8-sig') as f:
  w=csv.writer(f);w.writerow(fields);w.writerows(rows)
def main():
 shutil.copy2(HERE/'MANUFACTURING-AND-WIRING.md',OUT/'BUILD-AND-ASSEMBLY.md')
 bom=[
 ['P01-P08',7,'Printed parts 01 03 04 05 06 07 08','PLA / calibrated PLA+ / PETG','Supplied STL and 3MF','Make'],
 ['AC1',1,'Clear PMMA panel','104 x 38 nominal; measured 3.00-3.45 thick','Rear-engrave shared SVG','Owned stock'],
 ['BT1',1,'Single-cell LiPo','1000 mAh; 52 x 21 x 10; verify protection and cell charge rating','Battery cradle','Owned'],
 ['MCU1',1,'Seeed XIAO nRF52840','Original footprint 21 x 17.8; no pin headers','Edge-on nest and solder access','Owned'],
 ['CH1',1,'HiLetgo TP4056 USB-C with protection','ASIN B07PKND8KG; 25 x 16.5 advertised; populated height check','Fixed charger nest','Owned'],
 ['SW1',1,'DPDT slide switch','8.6 x 3.1 x 2.7 case; 1.42 square actuator; verify DC contact rating','Integrated switch nest','Owned'],
 ['LED1-4',4,'Adafruit side-light RGB NeoPixel segments','Measured nominal 8 x 8 x 2; verify cut outline; keep SMD capacitors','Front seats','Owned; fit check first'],
 ['U2',1,'Pololu U3V16F5 boost #4941','5 V; 13.2 x 8.1 x 3 maximum; direct solder','Left auxiliary landing','Additional'],
 ['U3',1,'TI SN74AHCT1G125DBVR','Single-gate buffer; SOT-23-5; 5 V supply','Right signal carrier','Additional'],
 ['Q1',1,'Diodes DMP1045U-7','P-channel MOSFET SOT-23; verify pinout','Right signal carrier','Additional'],
 ['C1',1,'680 uF aluminium electrolytic','>=6.3 V; body <=8 diameter x11.5 long; polarity marked','Right signal carrier','Additional; select to dimensions'],
 ['C2',1,'100 nF ceramic bypass','>=10 V; 0603/0805 or compact equivalent','Directly at U3 VCC/GND','Additional'],
 ['R1',1,'330 ohm data series resistor','1/8 W compact axial or SMD; insulated assembly <=3.2 diameter','H1 near LED1','Additional'],
 ['R2',1,'100 kilohm input pulldown','1%; compact','U3 A to ground','Additional'],
 ['R3',1,'12 kilohm TP4056 charge-set replacement','1%; match existing SMD package; replace not parallel; bench verify100mA','On charger existing resistor pads','Additional'],
 ['R4',1,'100 kilohm gate-to-source resistor','1%; compact','Q1 gate to source','Additional'],
 ['PCB2',1,'Insulated signal carrier','17 x 10 x 1 maximum; SOT adapters must stay inside overall envelope','Right landing','Additional; fabricate/wire'],
 ['J1',1,'Polarized 3-position inline connector pair','Assembled <=13 x10 x7.5; GND +5V DATA labelled','Front service space','Additional'],
 ['W1','3 m total','Flexible stranded 28 AWG wire','Insulated OD <=0.9; three colors; cut from routing list','LEDs and power','Additional'],
 ['W2','1 m total','Flexible stranded 30 AWG wire','Insulated OD <=0.8; signal/XIAO low-current branch','XIAO access corridor','Additional'],
 ['H1',4,'M3 x25 socket-head screws','Head <=5.5 diameter x3.0 high','Front closure','Hardware'],
 ['H2',2,'M3 x6 button-head screws','Standard low button head','Optical retainer','Hardware'],
 ['H3',2,'M3 x8 button-head screws','Standard low button head','Electronics yoke','Hardware'],
 ['H4',8,'M3 nuts','Standard 5.5 across flats x2.4 thick','Captive side-entry pockets','Hardware'],
 ['I1','As needed','Insulating adhesive and compressible shims','Measured stack; no conductive foam; do not cover ICs','PCBs optical retainer battery','Assembly'],
 ['I2','As needed','Heat shrink / insulating sleeves','DPDT finished OD <=1.2; no bare joints','Terminations','Assembly'],
 ['T1',3,'Narrow nonconductive straps','2.5 wide; battery loose; anchors clear','Battery and two harness anchors','Assembly'],
 ['A1','As needed','Removable wall strips','Sized for actual assembled mass','Flat rear','Assembly'],
 ]
 csvout('BOM.csv',['Ref','Quantity','Item','Specification','Location','Status'],bom)
 checks=[['Printer/nozzle/material/spool','Record actual X1C 0.4 and spool'],['Flow and pressure advance','Calibrated for this spool'],['Nut / bolt samples','Nuts enter freely; screws pass; heads inset'],['Printed surface tolerance','Critical mating faces within +/-0.10 of CAD after cleanup'],['Case seam','Closes by hand; no wire pinch; about <=0.2 warp'],['Acrylic thickness','Measure5points;3.00-3.45; calculate cushion'],['Acrylic material','Confirmed PMMA; cast/extruded noted'],['Laser lens/focus/air','Record actual RF setup'],['Laser cut speed/power/passes','Record successful scrap setting'],['Laser engraving speed/power/interval','Record clean frosted fill'],['Kerf X/Y top and bottom','Record plug/opening;offset half kerf outward'],['Acrylic/graphic registration','Shared datums; text mismatch <=0.15 aim'],['LED segment actual outline','All pads/ICs fit without clipping'],['Charger populated height/USB overmold','Seats fully; port cable latches'],['XIAO solder access and antenna','Pads accessible; keep leads off antenna end'],['Reset and slider','20 repeats each; return and both detents'],['Cell charge specification','Verify cell datasheet and protection'],['Charging current','100mA initial; measure; not default1A'],['RUN/OFF/USB isolation','Mode table passes; no unexpected port voltage'],['5V rail','Measure before pixels; within regulator/pixel ratings'],['External NeoPixel firmware','Required: current repository driver is onboard-only'],['Four pixels and colors','DIN order and color order verified; 12.5% ceiling'],['Battery current','Measure at intended brightness and full test load'],['Closed-case temperature','Test intended use and charge; aim <=40C cell/case at20-25C ambient'],['Final retention / wall strips','No board movement; connector serviceable; rear flat']]
 csvout('COMMISSIONING.csv',['Check','Acceptance or instruction','Measured result','Pass/date'],[r+['',''] for r in checks])
 report=json.loads((OUT/'harness-validation.json').read_text());rows=[]
 for r in report['items']:
  if 'route_length_mm' in r:
   allowance=20+(8 if r['name'].startswith('H') else 0);length=math.ceil((r['route_length_mm']+allowance)/5)*5
   conductors={'H0':3,'H1':3,'H2':3,'H3':3,'H4':3,'P1':2,'P2':2,'P3':3,'P4':2,'P5':3,'D1':2}[r['name'][:2]]
   rows.append([r['name'],r['route_length_mm'],length,'per conductor; trim after dry fitting',conductors,'28 AWG OD<=0.9' if r['radius_mm']==1.6 else '30 AWG OD<=0.8'])
 csvout('wire-cut-list.csv',['Route','Centreline mm','Initial cut mm','Allowance note','Conductors','Wire'],rows)
 # Dimensioned route map, front view; red/blue groups separated by panel for clarity.
 s=importlib.util.spec_from_file_location('h',str(HERE/'harness.py'));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
 svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1100" height="730" viewBox="0 0 1100 730"><rect width="1100" height="730" fill="#f5f4f0"/><style>text{font-family:Arial,sans-serif;fill:#172b32}.label{font-size:13px}.small{font-size:11px}</style><text x="35" y="35" font-size="25">ON AIR v2.1 — harness and reserved components</text><text x="35" y="58" font-size="13">Front view. Dimensions in mm. Depth measured rearward from front face. Diagram is a routing guide, not laser artwork.</text>']
 def point(v,off):return off[0]+v[0]*4,off[1]+(60-v[1])*4
 def rect(x,y,w,h,off,fill,stroke='#617078'):
  a,b=point((x,y+h),off);svg.append(f'<rect x="{a}" y="{b}" width="{w*4}" height="{h*4}" rx="3" fill="{fill}" stroke="{stroke}"/>')
 for front,off in [(True,(35,110)),(False,(575,110))]:
  svg.append(f'<text x="{off[0]}" y="94" font-size="18">'+('Front LED chain' if front else 'Rear electronics / power')+'</text>')
  rect(0,0,120,60,off,'#e3e7e7');rect(2.4,2.4,115.2,55.2,off,'#fff')
  rect(35,11,52,21,off,'#d9dadd');rect(12.75,32,16.5,25,off,'#c7e2d1');rect(108.9,35.5,3,21,off,'#c7e2d1');rect(55.7,49.5,8.6,2.7,off,'#dcc9b1')
  for name,lo,hi in h.BAYS[:3]:rect(lo[0],lo[1],hi[0]-lo[0],hi[1]-lo[1],off,'#e4d6f0')
  for x,y in [(6,6),(114,6),(6,54),(96,54),(35,38),(103,38)]:
   a,b=point((x,y),off);svg.append(f'<circle cx="{a}" cy="{b}" r="13" fill="#9da7aa"/>')
  for x,y in [(40,6.8),(80,6.8),(80,53.2),(40,53.2)]:rect(x-4,y-4,8,8,off,'#eace70')
  selected=[r for r in h.ROUTES if (r[0].startswith(('H1','H2','H3','H4')))==front]
  colors=['#db572b','#0087a2','#8b4eaf','#427c35','#2354ac','#bf3863','#786429']
  for i,(name,r,path) in enumerate(selected):
   pts=' '.join(f'{x},{y}' for x,y in [point(v,off) for v in path]);svg.append(f'<polyline points="{pts}" fill="none" stroke="{colors[i%len(colors)]}" stroke-width="4" stroke-linejoin="round" opacity=".85"/>')
   svg.append(f'<text x="{off[0]}" y="{385+i*25}" class="label" style="fill:{colors[i%len(colors)]}">{html.escape(name)}</text>')
  labels=[('BAT 52×21×10',(47,19)),('J1',(63,24))]
  labels+= [('LED1',(37,6)),('LED2',(77,6)),('LED3',(77,52)),('LED4',(37,52))] if front else [('Charger',(15,45)),('XIAO',(96,32)),('5V boost',(38,46)),('Signal + C1',(73,49)),('DPDT',(57,56))]
  for label,v in labels:
   a,b=point(v,off);svg.append(f'<text x="{a}" y="{b}" class="small">{label}</text>')
 svg+=['<text x="35" y="610" font-size="16">Depth zones</text><text x="35" y="636" class="label">LED exits: d2.5–6.5 · Front harness: mainly d13.7 · Lower crossing H2: d18</text><text x="35" y="658" class="label">Rear power: mainly d18 / d24 · Battery front: d20.6 · Auxiliary landings: d29.5</text><text x="35" y="685" class="label">Route wires away from grey screw bosses. Purple service space above battery holds the unplugging connector.</text></svg>']
 (OUT/'routing-map.svg').write_text(''.join(svg),encoding='utf-8')
 print('BOM, commissioning form, wire cut list and route map written')
if __name__=='__main__':main()
