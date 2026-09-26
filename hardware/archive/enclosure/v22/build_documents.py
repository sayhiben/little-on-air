"""Write the selected two-switch build, without superseded circuit alternatives."""
from pathlib import Path
import csv,json,math,html,shutil
from harness import ROUTES,BAYS
HERE=Path(__file__).resolve().parent;BASE=HERE.parent;OUT=BASE/'output/v22';OLD=BASE/'output/on-air-v21-fabrication'

def csvout(name,fields,rows):
 with (OUT/name).open('w',newline='',encoding='utf-8-sig') as f:
  w=csv.writer(f);w.writerow(fields);w.writerows(rows)

def main():
 old=(OLD/'BUILD-AND-ASSEMBLY.md').read_text(encoding='utf-8')
 mechanical=old[old.index('## Parts and retained joints'):old.index('## Electrical design and additional parts')]
 mechanical=mechanical.replace('v2.1','v2.2').replace('battery, charger, XIAO, DPDT and auxiliary board locations','battery, charger, XIAO, DPDT RUN/PROGRAM and SPDT POWER locations')
 mechanical=mechanical.replace('Check real nuts, screws, both PCBs, switch, reset action','Check real nuts, screws, both PCBs, both switches, reset action')
 mechanical=mechanical.replace('The new retainer contact','The retainer contact')
 mechanical=mechanical.replace('| LED seats |','| SPDT POWER body pocket | 11.1 × 6.1 for 10.5 × 5.5 nominal body | 0.30 per side; 0.35 front keeper gap, use thin insulating cushion |\n| SPDT POWER lever opening | 7.9 × 3.9 for a conservative 3.2 square lever envelope | Nominal 3.0 travel; opening permits up to 4.7 geometric travel before side contact, without added end clearance |\n| SPDT flange and terminals | 19.5 wide flange; 2.5 long terminals | No flange screw required; actual part held between integrated seat and removable yoke |\n| LED seats |')
 lead='''# ON AIR v2.2 — two-switch enclosure and assembly

The 120 × 60 × 34 mm housing now holds both switches you already own. S1 is the larger SPDT POWER switch; S2 is the tiny DPDT RUN/PROGRAM switch, operated by the existing captive printed slider. The revised rear housing (05) and yoke (06) capture S1 without another bracket, printed button or screw. The front optics, graphic, fasteners and flat wall-mounting back retain their previous dimensions.

Use this revision's wiring table and routing map together. It contains only the selected direct-battery circuit, inline 330 Ω data resistor, 680 µF capacitor and your pigtails. The unused booster landing has been cleared for the POWER mount. The right landing remains useful for securing the insulated capacitor and wire junctions.

The mechanical release is a digitally checked prototype. Print the fit plate first, especially sample 98 for the larger switch. The existing receiver firmware still controls the onboard RGB LED; a four-NeoPixel output remains an operational task. No board was flashed and no printer or laser job was started.

## What to reprint

If you already printed v2.1, replace **05 Rear electronics housing** and **06 Electronics retaining yoke** together. Part 08 has only been renamed RUN PROGRAM; its shape is unchanged. The bezel, graphic backing, optical retainer, reset plunger and laser artwork retain their geometry. The fit plate has nine clipped production samples plus the full yoke and both printed controls, twelve objects total. They are test pieces, not twelve additional assembly parts.

## Switch mounting and placement

Viewed from the front, POWER is on the top at X=41 mm, immediately left of RUN/PROGRAM at X=60 mm. The POWER switch's own 5 mm lever projects about 2 mm above the case. Its main body is located at X35.75–46.25, Y51.5–57.0, depth20.0–25.7. Solder terminals point inward, toward the empty routing area. Its flange slides in from the open front before the yoke is installed.

The [Tnuocke SS12F15-G5 listing](https://www.amazon.com/dp/B099N3HFPG?th=1) has a [dimension drawing](https://m.media-amazon.com/images/I/61bomash9uL._SL1500_.jpg) showing a 19.5 mm flange, 10.5 mm body length, 5.7 mm body depth, 5.5 mm body height, 5 mm lever and 2.5 mm legs. The side-view lever is 2.9 mm; CAD reserves a conservative 3.2 mm square. Its actual other-axis knob width and travel remain unmeasured. The nominal travel study uses 3.0 mm end-to-end. The wider aperture is deliberate; sample 98 must confirm both detents with clearance and no flange interference. Do not force a different switch revision into this seat.

The original [WMYCONGCONG DPDT](https://www.amazon.com/dp/B07F7PNDGM) retains the measured 8.6 × 3.1 × 2.7 mm case, 1.42 mm square actuator and 2.58 mm travel inferred from the confirmed 4 mm total opening. Use sample 94 with part 08 and the full yoke to check its travel. The POWER roof has a 45-degree underside ramp to clear the existing bezel tongue and build from the yoke's print bed surface.

Label S1 OFF / ON and S2 PROGRAM / RUN after checking continuity. Choose the connected throws so rightward motion, viewed from the front, selects ON and RUN. Identify the actual contacts with a meter; lever direction need not correspond to the nearest physical terminal. The controls remain accessible with the flat back against a wall.

'''
 electrical=(HERE/'TWO-SWITCH-WIRING.md').read_text(encoding='utf-8')
 tail='''
## Routing and physical assembly

The coordinates in `routing-map.svg` and `validation/harness-validation.json` are viewed from the front; depth increases rearward from the front face. H1–H4 follow LED1 lower-left → LED2 lower-right → LED3 upper-right → LED4 upper-left. Follow actual DIN/DOUT markings even if the wires exit opposite sides on a particular segment. The emitting faces point into the acrylic edges. Keep each pixel's original small SMD component and all solder pads. The measured cut-segment outline, rather than a similar strip photograph, determines fit.

Main LED and battery-pair reservations are Ø3.2. Two-wire MCU/distribution corridors are Ø2.4; individual wires have Ø1.6 clearance corridors. Use flexible insulated wire with OD ≤0.9 mm for 28 AWG LED/power wiring, and OD ≤0.8 mm for 30 AWG low-current MCU/signal wiring. Gauge alone does not determine fit. LED side exits carry three wires flat, with 1 mm lane spacing; the native check uses a 1.1 mm envelope per wire. Insulate solder fillets and keep them out of the optical edge.

Rear routes change depth at crossings: P4 crosses the battery region at depth18, D1 at depth16, and the front harness mainly at depth13.7. Near the XIAO, D1 moves to depth15 before crossing P4. P2/P3 carry the switched supply past the DPDT solder bay to the LED junction; this is a wire splice, **not a feed through the DPDT contact**. Protected ground fans out from G1 to P3/P4 inside the distribution bay. The route paths reserve space; their endpoints are dressing locations, not an assumed switch pinout.

All 78 route pairs are checked using compact insulation radii and 0.2 mm placement allowance. Close paths are allowed only inside the marked termination/service bays with 2 mm dressing margin, where individual insulated wires must fan out. Do not stack junctions directly on top of each other just because their diagram lines meet. Actual solder and connector bodies still require a dry fit.

The capacitor body allowance is Ø8 × 11.5, centred at X84/Y47.5, depth16.2–27.7. Secure it on an insulating pad in the right landing area; its positive and negative leads connect across the switched LED rail. The 330 Ω resistor is insulated inline near LED1, in H1. Keep its finished sleeve diameter within 3.2 mm. Your mated pigtail disconnect should fit the reserved 13 × 10 × 7.5 mm box above the battery, with room for bent wires. Split existing pigtails between smaller bays if necessary and check polarity independently; no connector brand or color code is assumed.

The SPDT solder bay is X36.8–45.2, Y44.0–48.8, depth20.5–25.3. The DPDT bay is X56.2–63.8, Y42.5–46.4, depth18.5–25.3. Clip leads only after identifying contacts. Keep individual DPDT sleeves around 1.2 mm OD or less so the two terminal rows cannot short. No wire goes beneath the cell or through a screw pocket. Keep the antenna end of the XIAO clear of loose conductors.

1. Print and cool the fit-check plate. Clean brim, strings and first-layer bulges. Fit real fasteners, LEDs, boards, acrylic sample, both switches and both controls. Check sample 98 with the complete new yoke; hold it at the same seated depth as the full housing. Both S1 detents must be accessible without forcing the roof or lever.
2. Make a continuity map of both switches before soldering. Mark S1 common/ON/unused and the two independent S2 poles with their common/RUN/PROGRAM contacts. Test the connection table on the bench with the battery disconnected.
3. Laser-test the actual PMMA, then cut and rear-engrave the panel. Solder the LED chain, resistor and pigtails; retain every original SMD part. Tape the wires into their reliefs, away from emitting faces. Assemble acrylic, graphic, edge preload and measured rear cushions, then install the optical retainer with two M3 × 6 button-head screws.
4. Side-load the rear closure and yoke nuts. Solder the switch/board harness while it is accessible. Keep XIAO underside joints within its open window and away from its end supports. Insulate and secure the capacitor and junctions separately on the right landing.
5. Seat the cell on its insulating pad and secure with a loose nonconductive strap. Fit the charger and edge-on XIAO. Insert the reset plunger after the XIAO. Insert the printed RUN/PROGRAM slider, then load the tiny DPDT into its fork from the front.
6. Load the SPDT into the new rear seat from the front, passing its own lever through the open-front top notch. The wide metal flange rests in the surrounding clearance, not underneath a clamp screw. Its three terminals face inward. Add a thin nonconductive cushion at the 0.35 mm keeper allowance if needed; do not pad over the moving lever.
7. Dress the rear wires along the depth-separated routes. Use the existing strap anchors and local service slack. `wire-cut-list.csv` gives initial lengths with allowance; trim after a dry closure. Complete and insulate the S1 rail splice before connecting the DPDT branch and LED branch. Keep the bulk capacitor current path out of S2.
8. Fit the revised yoke last, using its two M3 × 8 button-head screws. Its new arms restrain S1; its removable roof closes the lever notch. Check all USB cable shells insert fully and board movement is imperceptible. Operate reset and both switches twenty times each, checking return/detents and no wire movement into the mechanism.
9. With POWER off and PROGRAM selected, connect the internal pigtail and inspect the final few millimetres of closure. The case must close by hand. Install four M3 × 25 socket-head screws from the front into the rear captive nuts. Never tighten the screws to crush a trapped wire or bowed sheet.
10. Complete the electrical mode, lighting, fit and temperature checks in `COMMISSIONING.csv`. Confirm the current firmware supports the external four-pixel harness before judging lighting. Apply removable adhesive wall strips to the flat rear after the assembled unit passes.

## Validation limits

The native CAD checks nominal solids, sampled insertion paths, control travel and reserved wire volumes. The mesh and Bambu checks verify the exported files and color change. These do not certify actual FDM accuracy, switch force/current capability, cell behavior, solder fillets, plug overmolds, laser finish or illuminated appearance. The fit coupons and commissioning record close those gaps. Blender was not needed because native solid checks and independent STL topology and slicing checks cover this revision's geometry.

The current `status_output_pwm.c` and overlay use the onboard RGB LED. The proposed external pin is D2/P0.28, and a four-pixel 800 kHz NeoPixel driver with the correct color order and brightness limit must be implemented/selected before this sign operates. This enclosure revision does not modify or flash firmware.

![Two-switch enclosure](views/assembled.png)

![Retained electronics](views/retained-electronics.png)

![Wire routes](routing-map.png)
'''
 (OUT/'BUILD-AND-ASSEMBLY.md').write_text(lead+mechanical+electrical+tail,encoding='utf-8')
 with (OLD/'BOM.csv').open(encoding='utf-8-sig',newline='') as f:
  reader=csv.DictReader(f);fields=reader.fieldnames;rows=[]
  for row in reader:
   if row['Ref'] in ('U2','U3','Q1','C2','R2','R3','R4','PCB2'):continue
   if row['Ref']=='SW1':
    row.update(Ref='S2',Item='WMYCONGCONG DPDT B07F7PNDGM',Specification='100 mA listing; 8.6 x3.1 x2.7 case; 1.42 square actuator; RUN/PROGRAM isolation',Location='Existing tiny-switch nest and printed slider',Status='Owned; confirm MCU branch current')
   if row['Ref']=='C1':row.update(Location='Insulated right landing; across VBAT_SW and protected ground',Status='Selected addition; body fit check')
   if row['Ref']=='J1':row.update(Item='User pigtail disconnects',Specification='Mated envelope <=13 x10 x7.5 reserved; verify pinout and actual bends',Status='User supplied')
   rows.append(row)
  rows.insert(6,dict(zip(fields,['S1',1,'Tnuocke SPDT SS12F15-G5 B099N3HFPG','0.5 A listing; body 10.5 x5.5 x5.7; flange19.5; lever5; travel verify','New integrated POWER nest; retained by yoke','Owned; sample98 first'])))
 csvout('BOM.csv',fields,[[r.get(k,'') for k in fields] for r in rows])
 checks=[
 ('Printer / spool','X1C 0.4; calibrated flow/pressure advance; actual PLA/PLA+/PETG spool'),
 ('Surface tolerance / seam','Critical surfaces within +/-0.10 mm; seam closes by hand; no wire pinch'),
 ('All eight nuts and screws','Nuts enter freely; heads and screw tips inset; correct lengths'),
 ('S1 drawing vs actual','Body10.5x5.5x5.7; flange19.5; lever envelope <=3.2; measure travel'),
 ('S1 sample98 and yoke','Both detents clear aperture and roof; captive; no flange/terminal clash'),
 ('S2 sample94 and slider','Both detents; 1.42 square fork fit; nominal2.58 movement'),
 ('Reset and both switches','20 operations each; no sticking or moving wires'),
 ('Both USBs','Real cable overmolds fit and latch; PCBs stay seated'),
 ('LED segments','Entire cut outline and SMD components fit; emitting edges face acrylic'),
 ('Pigtails / cap / resistor','Actual bodies and insulated bends fit reserved space without load on pouch'),
 ('Acrylic material and thickness','Confirmed PMMA; measure5points;3.00-3.45; calculate rear cushion'),
 ('Laser RF setup','Record lens/focus/air; verified Nova Plus24 60W RF device'),
 ('Kerf','Record plug/opening X/Y at top/bottom; compensate outline only'),
 ('Engraving','Record RF speed/min-max power/interval/passes; frosted shallow fill'),
 ('Acrylic registration','Already mirrored SVG; common datums; practical text mismatch <=0.15 mm aim'),
 ('Switch continuity before battery','S1 common and throws; both independent S2 poles; NC throws insulated'),
 ('POWER off','Charger stays on cell; main load rail disconnected from charger OUT+'),
 ('PROGRAM isolation','XIAO BAT+ and DATA each isolated from switched LED rail/harness'),
 ('USB modes','POWER off + PROGRAM before either USB; only selected port plugged'),
 ('Cell rating / protection','Obtain cell max charge current; verify charger setting and protection'),
 ('Charge test','Load disconnected; measured charge current <=cell rating; termination and temperature pass'),
 ('Switch currents','S1 steady load below0.5A and startup checked; S2 MCU branch including startup below100mA'),
 ('External firmware','Four external pixels supported; correct order and brightness ceiling'),
 ('Lighting across battery range','Start at12.5% ceiling; verify colors, no flicker/reset as battery discharges'),
 ('Closed case','Intended run and charge tests; target <=40C cell/case at20-25C ambient or cell-maker lower limit'),
 ('Final mounting','No internal movement; connector service slack; flat rear and adequate wall strips')]
 csvout('COMMISSIONING.csv',['Check','Acceptance or instruction','Measured result','Pass/date'],[list(r)+['',''] for r in checks])
 report=json.loads((OUT/'harness-validation.json').read_text());cuts=[]
 conductors={'H0':3,'H1':3,'H2':3,'H3':3,'H4':3,'B1':2,'P1':1,'P2':1,'P3':2,'P4':2,'G1':1,'D1':1,'D2':1}
 for r in report['items']:
  if 'route_length_mm' not in r:continue
  length=math.ceil((r['route_length_mm']+20+(8 if r['name'].startswith('H') else 0))/5)*5
  wire='28 AWG OD<=0.9' if r['name'].startswith(('H','B','P1','P2','P3','G1')) else '30 AWG OD<=0.8'
  cuts.append([r['name'],r['route_length_mm'],length,conductors[r['name'][:2]],wire,'Per conductor; includes dressing slack; endpoints are bays, identify actual pads'])
 csvout('wire-cut-list.csv',['Route','Centreline mm','Initial cut mm','Conductors','Wire','Note'],cuts)
 svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1100" height="850" viewBox="0 0 1100 850"><rect width="1100" height="850" fill="#f5f4f0"/><style>text{font-family:Arial,sans-serif;fill:#172b32}.label{font-size:13px}.small{font-size:11px}</style><text x="35" y="35" font-size="25">ON AIR v2.2 — two switches and wire routes</text><text x="35" y="58" font-size="13">Front view. Dimensions in mm; depth increases rearward. Routing guide only, not laser artwork.</text>']
 def point(v,off):return off[0]+v[0]*4,off[1]+(60-v[1])*4
 def rect(x,y,w,h,off,fill,stroke='#617078'):
  a,b=point((x,y+h),off);svg.append(f'<rect x="{a}" y="{b}" width="{w*4}" height="{h*4}" rx="3" fill="{fill}" stroke="{stroke}"/>')
 for front,off in [(True,(35,110)),(False,(575,110))]:
  svg.append(f'<text x="{off[0]}" y="86" font-size="18">'+('Front LED chain' if front else 'Rear electronics and controls')+'</text>')
  rect(0,0,120,60,off,'#e3e7e7');rect(2.4,2.4,115.2,55.2,off,'#fff')
  rect(35,11,52,21,off,'#d9dadd');rect(12.75,32,16.5,25,off,'#c7e2d1');rect(108.9,35.5,3,21,off,'#c7e2d1')
  for name,lo,hi in BAYS:rect(lo[0],lo[1],hi[0]-lo[0],hi[1]-lo[1],off,'#e4d6f0')
  rect(55.7,49.5,8.6,2.7,off,'#dcc9b1');rect(35.75,51.5,10.5,5.5,off,'#dcc9b1');rect(31.25,56.5,19.5,.5,off,'#aaa')
  for x,y in [(6,6),(114,6),(6,54),(96,54),(35,38),(103,38)]:
   a,b=point((x,y),off);svg.append(f'<circle cx="{a}" cy="{b}" r="13" fill="#9da7aa"/>')
  for x,y in [(40,6.8),(80,6.8),(80,53.2),(40,53.2)]:rect(x-4,y-4,8,8,off,'#eace70')
  selected=[r for r in ROUTES if r[0].startswith(('H1','H2','H3','H4'))==front]
  colors=['#db572b','#0087a2','#8b4eaf','#427c35','#2354ac','#bf3863','#786429','#376268','#822b32']
  for i,(name,r,path) in enumerate(selected):
   pts=' '.join(f'{x},{y}' for x,y in [point(v,off) for v in path]);svg.append(f'<polyline points="{pts}" fill="none" stroke="{colors[i]}" stroke-width="3" stroke-linejoin="round" opacity=".85"/>')
   svg.append(f'<text x="{off[0]}" y="{385+i*25}" class="label" style="fill:{colors[i]}">{html.escape(name)}</text>')
  labels=[('BAT 52 x 21 x 10',(47,19)),('Pigtail',(63,24))]
  labels += [('LED1',(37,6)),('LED2',(77,6)),('LED3',(77,52)),('LED4',(37,52))] if front else [('CHARGER',(14,44)),('XIAO',(98,32)),('POWER',(35,62)),('MODE',(55,62)),('C1',(82,48))]
  for label,v in labels:
   a,b=point(v,off);svg.append(f'<text x="{a}" y="{b}" class="small">{label}</text>')
 svg += ['<text x="35" y="658" font-size="18">Keep the LED current out of the tiny DPDT</text><text x="35" y="685" class="label">S1 switched rail branches to LED+ and C1+ directly. S2 switches only XIAO BAT+ and the data signal.</text><text x="35" y="711" class="label">Front harness mainly d13.7; lower H2 at d18; P4 at d18; D1 crossing at d16, then d15 near XIAO.</text><text x="35" y="737" class="label">Purple bays allow insulated fan-out and service slack. Follow the 3D depths in the route list; avoid grey screw bosses.</text><text x="35" y="781" font-size="18">Before either USB: POWER OFF + PROGRAM. Use one USB port at a time.</text></svg>']
 (OUT/'routing-map.svg').write_text(''.join(svg),encoding='utf-8')
 print('Selected two-switch guide, BOM, route map, cut list and commissioning form written')

if __name__=='__main__':main()
