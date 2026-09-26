import adsk.core as C
def run(_context:str):
 print(C.Camera.viewExtents.__doc__)
 print(C.Application.get().activeViewport.camera.viewExtents)
