import adsk.core as C
import adsk.fusion as F
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct);bad=[]
 for i in range(d.timeline.count):
  e=d.timeline.item(i).entity
  if hasattr(e,'healthState') and e.healthState!=F.FeatureHealthStates.HealthyFeatureHealthState:
   assert e.name=='DPDT body 0.20 mm running space' and 'No target body' in e.errorOrWarningMessage
   bad.append(e)
 for e in bad:e.deleteMe()
 print('Removed redundant cut that already lay entirely in the empty DPDT pocket:',len(bad))
