import adsk.core as C
import adsk.fusion as F
def run(_context:str):
 d=F.Design.cast(C.Application.get().activeProduct)
 for name,value,note in [('actuator_d',1.42,'Confirmed actuator thickness'),('switch_throw',2.58,'Confirmed: full slot 4 mm minus actuator width 1.42 mm')]:
  p=d.userParameters.itemByName(name);p.expression=f'{value} mm';p.comment=note
 print('Confirmed DPDT dimensions applied')
