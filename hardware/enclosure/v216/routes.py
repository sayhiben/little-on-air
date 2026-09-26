"""Rearward inter-pixel harness: actual circular fillets, 3 mm center radius."""
import json,math
from pathlib import Path
OUT=Path(__file__).resolve().parents[1]/'output/v216'
def unit(v):
 n=math.sqrt(sum(x*x for x in v));return [x/n for x in v]
def smooth(path,r=3):
 fillets=[]
 for i,p in enumerate(path[1:-1],1):
  u=unit([path[i-1][j]-p[j] for j in range(3)]);v=unit([path[i+1][j]-p[j] for j in range(3)])
  dot=sum(x*y for x,y in zip(u,v));angle=math.acos(max(-1,min(1,dot)))
  if abs(math.pi-angle)<1e-7:fillets.append((p,p,[p]));continue
  distance=r/math.tan(angle/2)
  assert distance<=min(math.dist(path[i-1],p),math.dist(path[i+1],p))+1e-6,(i,path)
  a=[p[j]+u[j]*distance for j in range(3)];z=[p[j]+v[j]*distance for j in range(3)]
  c=[p[j]+(u[j]+v[j])*r/math.sin(angle) for j in range(3)]
  au=unit([a[j]-c[j] for j in range(3)]);bu=unit([z[j]-c[j] for j in range(3)])
  turn=math.pi-angle;v2=unit([bu[j]-au[j]*math.cos(turn) for j in range(3)])
  samples=[[c[j]+r*(au[j]*math.cos(turn*k/18)+v2[j]*math.sin(turn*k/18)) for j in range(3)] for k in range(19)]
  fillets.append((a,z,samples))
 for i in range(len(fillets)-1):
  segment=math.dist(path[i+1],path[i+2]);used=math.dist(path[i+1],fillets[i][1])+math.dist(path[i+2],fillets[i+1][0])
  assert used<=segment+1e-6,('Adjacent fillets overlap',i,used,segment)
 result=[path[0]]
 for a,z,s in fillets:result.extend(s)
 result.append(path[-1]);return result
def main():
 routes=[]
 def add(name,path):routes.append({'name':name,'radius':1,'bend_radius':3,'control_points':path,'points':smooth(path)})
 for lane,y in enumerate((4.8,6.8,8.8)):
  add(f'H2 lower inner-pad connection lane{lane}',[(45.15,y,3.3),(48.15,y,3.3),(48.15,y,12.8),(71.85,y,12.8),(71.85,y,3.3),(74.85,y,3.3)])
 # Three separate wire columns cross the front of the charger at D13.85.
 # Opposite terminal ordering at the two ends keeps these paths nested.
 for lane,(col,low,high) in enumerate(zip((21,23.2,25.4),(4.8,6.8,8.8),(54.05,52.05,50.05))):
  add(f'H3 left interior connection lane{lane}',[(34.85,low,3.3),(31.85,low,3.3),(31.85,low,13.85),(col,low,13.85),(col,high,13.85),(31.85,high,13.85),(31.85,high,3.3),(34.85,high,3.3)])
 for lane,(y,cross) in enumerate(zip((50.05,52.05,54.05),(43.3,45.4,47.5))):
  add(f'H4 upper interior connection lane{lane}',[(45.15,y,3.3),(48.15,y,3.3),(48.15,y,12.85),(71.85,y,12.85),(71.85,y,3.3),(74.85,y,3.3)])
 for lane,(col,exit_y,feed_y,pad_y) in enumerate(zip((22,24.2,26.4),(16,18.2,20.4),(3.8,6.8,8.3),(4.8,6.8,8.8))):
  dep=16.8 if lane==2 else 19.6
  add(f'H1 input to lower-right pixel lane{lane}',[(18.15,exit_y,dep),(col,exit_y,dep),(col,feed_y,dep),(88,feed_y,dep),(94,pad_y,dep),(99,pad_y,dep),(99,pad_y,dep-6),(88.15,pad_y,dep-6),(88.15,pad_y,3.3),(85.15,pad_y,3.3)])
 (OUT/'candidate-routes.json').write_text(json.dumps(routes,indent=2))
if __name__=='__main__':main()
