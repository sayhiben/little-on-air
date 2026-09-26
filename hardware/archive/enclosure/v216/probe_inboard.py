from pathlib import Path
import json
OUT=Path(__file__).resolve().parents[1]/'output/v216'
routes=[]
for x in (37.3,44.6,74.8,85.3):
 for y in (50.8,52.8,54.8):
  routes.append({'name':f'Upper rear-emerging lead {x},{y}','radius':1,'points':[(x,y,5.3),(x,y,13)]})
for y in (48.3,50.3,52.3):
 routes.append({'name':f'Upper under-mount cross-run y{y}','radius':1,'points':[(37.3,y,13.5),(74.8,y,13.5)]})
for y in (4.8,6.8,8.8):
 routes.append({'name':f'Lower under-mount cross-run y{y}','radius':1,'points':[(48.05,y,12.8),(71.95,y,12.8)]})
(OUT/'candidate-routes.json').write_text(json.dumps(routes,indent=2))
