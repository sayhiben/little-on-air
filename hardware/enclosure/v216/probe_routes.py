from pathlib import Path
import json,math
OUT=Path(__file__).resolve().parents[1]/'output/v216'
routes=[]
for x in (40,80):
 for y in (6.8,53.2):
  for side in (-1,1):
   for lane in (-2,0,2):
    pts=[(x+side*5.05,y+lane,3.3)]
    pts += [(x+side*(5.05+3*math.sin(math.radians(a))),y+lane,3.3+3*(1-math.cos(math.radians(a)))) for a in range(5,91,5)]
    pts.append((x+side*8.05,y+lane,13))
    routes.append({'name':f'Drop {x},{y} side{side} lane{lane}','radius':1,'points':pts})
(OUT/'candidate-routes.json').write_text(json.dumps(routes,indent=2))
