from pathlib import Path
import importlib.util,html
HERE=Path(__file__).resolve().parent;OUT=HERE.parent/'output/v25'
s=importlib.util.spec_from_file_location('routes23',str(HERE/'harness.py'));h=importlib.util.module_from_spec(s);s.loader.exec_module(h)
def xy(x,y):return 70+x*8,545-y*8
svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="860" viewBox="0 0 1200 860">','<rect width="1200" height="860" fill="white"/>','<g font-family="Arial,sans-serif" fill="#17212b">','<text x="70" y="32" font-size="23" font-weight="bold">ON AIR v2.5 — wire routing, viewed from the front</text>','<rect x="70" y="65" width="960" height="480" rx="24" fill="#f5f7f9" stroke="#394957" stroke-width="2"/>']
for name,x,y,w,ht in [('Battery',35,11,52,21),('Charger',12.25,30.3,17.5,28.1),('POWER',35.7,53.35,10.6,5.05),('MODE',55.45,55.49,9.1,3.36),('XIAO',110.8,36.8,4.37,21),('C1',80,43.5,8,8)]:
 a,b=xy(x,y+ht);svg.append(f'<rect x="{a}" y="{b}" width="{w*8}" height="{ht*8}" fill="#e0e7ed" stroke="#677989"/><text x="{a+2}" y="{b+14}" font-size="11">{name}</text>')
colors=['#c53d39','#9b6916','#507917','#21896f','#186e99','#2546a7','#7434ae','#a43d80','#cc6524','#40819a','#754f49','#536559','#233747']
for i,(name,r,pts) in enumerate(h.ROUTES):
 points=' '.join(f'{xy(x,y)[0]},{xy(x,y)[1]}' for x,y,d in pts)
 svg.append(f'<polyline points="{points}" fill="none" stroke="{colors[i]}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>')
 col=i%2;row=i//2;x=70+col*550;y=625+row*29
 svg.append(f'<path d="M{x},{y-4}h25" stroke="{colors[i]}" stroke-width="4"/><text x="{x+35}" y="{y}" font-size="13">{html.escape(name)} · Ø{r*2:g} mm corridor</text>')
svg.extend(['<text x="70" y="578" font-size="15">Line crossings are separated in depth. Use the checked X/Y/depth coordinates in harness-validation.json.</text>','<text x="70" y="600" font-size="15">Endpoints indicate wire dressing areas, not pin numbers. Leave service slack for the XIAO’s 8 mm assembly slide.</text>','</g></svg>'])
(OUT/'routing-map.svg').write_text('\n'.join(svg),encoding='utf-8')
