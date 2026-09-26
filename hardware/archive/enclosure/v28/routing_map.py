from pathlib import Path
from html import escape
import json,math,csv
from harness import ROUTES,BAYS
OUT=Path(__file__).resolve().parents[1]/'output/v28'
def main():
 s=['<svg xmlns="http://www.w3.org/2000/svg" width="1240" height="820" viewBox="0 0 1240 820">',
 '<rect width="1240" height="820" fill="#f4f6f8"/>','<g font-family="Arial, sans-serif" fill="#152536">',
 '<text x="64" y="40" font-size="25" font-weight="bold">ON AIR v2.8 · parallel PCBs · 120 × 60 × 24 mm</text>',
 '<text x="64" y="65" font-size="15">Open housing, viewed from the front. Depth is measured behind the display face.</text>']
 def rect(x,y,w,h,color,stroke='#526777',dash=False):
  s.append(f'<rect x="{64+x*8}" y="{96+(60-y-h)*8}" width="{w*8}" height="{h*8}" rx="5" fill="{color}" stroke="{stroke}" stroke-width="2" '+('stroke-dasharray="5 4"' if dash else '')+'/>')
 def label(x,y,text,size=15):s.append(f'<text x="{64+x*8}" y="{96+(60-y)*8}" text-anchor="middle" font-size="{size}">{escape(text)}</text>')
 rect(0,0,120,60,'#dfe5eb');rect(2.4,2.4,115.2,55.2,'#fff')
 for x,y in [(6,6),(114,6),(6,54),(114,54),(35,38),(73,38)]:
  s.append(f'<circle cx="{64+x*8}" cy="{96+(60-y)*8}" r="15" fill="#b8c4cd" stroke="#526777" stroke-width="2"/>')
 rect(35,11,52,21,'#e2d2ef');label(61,23,'52 × 21 × 10 battery',19);label(61,19,'depth 10.9–20.9')
 rect(12.25,30.3,17.5,28.1,'#b8dfc5');label(21,42,'CHARGER',14);label(21,38,'rear facing',12)
 rect(89,36.8,17.8,21,'#b8dfc5');label(97.9,46,'XIAO',16);label(97.9,42,'front facing',12)
 rect(16.075,53.25,8.85,6.4,'#a9b6bf');rect(93.415,53.15,8.97,6.4,'#a9b6bf')
 rect(35.7,53.35,10.6,5.05,'#f4ce83');rect(55.45,55.49,9.1,3.36,'#f4ce83')
 label(41,50,'POWER');label(60,52,'MODE')
 rect(12,14,13,10,'#f8e4a7');label(18.5,18,'Disconnect',12)
 rect(99,15,8,11.5,'#bfd7ef');label(103,12.5,'C1 inline',12)
 rect(60,43.5,11,4.5,'none','#b35568',True);label(66,40,'Insulated junctions',12)
 rect(35.5,4.8,12.5,5.7,'none','#b35568',True);label(42,2,'R1 inline',12)
 for x,y in [(40,6.8),(80,6.8),(40,53.2),(80,53.2)]:
  rect(x-4,y-4,8,8,'none','#bd8290',True)
 for x,y in [(14,49.4),(14,44.65)]:s.append(f'<circle cx="{64+x*8}" cy="{96+(60-y)*8}" r="4" fill="#d35454"/>')
 # Only representative routes are shown here; the complete coordinate record
 # is a separate fabrication aid rather than a dense all-net visual.
 colors={'H1':'#da8332','H2':'#da8332','H3':'#da8332','H4':'#da8332','F0':'#456fa5','P4':'#8652a1'}
 for name,r,path in ROUTES:
  if name.split()[0] not in colors:continue
  points=' '.join(f'{64+x*8:.1f},{96+(60-y)*8:.1f}' for x,y,d in path)
  s.append(f'<polyline points="{points}" fill="none" stroke="{colors[name.split()[0]]}" stroke-width="2.5" stroke-linejoin="round" opacity=".8"/>')
 s.extend(['<text x="1050" y="134" font-size="15" font-weight="bold">Top USB ports</text>',
 '<text x="1050" y="166" font-size="13">Reset + RGB</text>','<text x="1050" y="186" font-size="13">on front frame</text>',
 '<text x="1050" y="260" font-size="13">Orange: LED harness</text>','<text x="1050" y="283" font-size="13">Blue: service trunk</text>',
 '<text x="1050" y="306" font-size="13">Purple: underside</text>','<text x="1050" y="325" font-size="13">power fanout</text>',
 '<text x="64" y="615" font-size="18" font-weight="bold">10 mm thinner · same display and optical stack</text>',
 '<rect x="64" y="639" width="408" height="58" fill="#fff" stroke="#8796a6" stroke-dasharray="6 4"/>',
 '<rect x="64" y="639" width="288" height="58" fill="#d9e8f1" stroke="#34516b"/>',
 '<rect x="64" y="639" width="114" height="58" fill="#9dbbce"/>',
 '<text x="115" y="675" text-anchor="middle" font-size="13">Front 9.5</text>',
 '<text x="262" y="675" text-anchor="middle" font-size="14">Rear 14.5</text>',
 '<text x="408" y="675" text-anchor="middle" font-size="13">Removed 10</text>',
 '<text x="510" y="655" font-size="15">Both boards mount flat with open solder access.</text>',
 '<text x="510" y="679" font-size="15">Route around the battery; leave its pouch free of wire bundles.</text>',
 '<text x="64" y="737" font-size="14">Lines crossing in this front view may occupy different depths. Follow routing-coordinates.json and assembly instructions.</text>',
 '<text x="64" y="762" font-size="14">Use the fit plate before the full case. Board thickness, solder shape and printer fit still require physical confirmation.</text>',
 '</g></svg>'])
 (OUT/'routing-map.svg').write_text('\n'.join(s),encoding='utf-8')
 (OUT/'routing-coordinates.json').write_text(json.dumps({'units':'mm','coordinates':'front-view XY, positive depth behind face','routes':ROUTES,'bays':BAYS},indent=2))
 with (OUT/'harness-length-guide.csv').open('w',newline='',encoding='utf-8') as f:
  w=csv.writer(f);w.writerow(['Corridor','Nominal polyline length mm','Suggested dressed length including 25 mm slack','Notes'])
  for name,r,path in ROUTES:
   length=sum(math.dist(a,z) for a,z in zip(path,path[1:]));w.writerow([name,round(length),math.ceil((length+25)/5)*5,'Routing segment; measure actual terminations. Split trunks by electrical connection table.'])
if __name__=='__main__':main()
