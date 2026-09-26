"""Reserved harness envelopes; independent of Fusion for documentation and cut lists.
Coordinates X,Y,depth in mm. Three-wire LED bundles; copper is smaller than the
checked diameter, leaving clearance for insulation and hand placement.
"""
ROUTES=[
 ('H1 front connector to LED1',1.6,[(68,24,13.7),(47.5,24,13.7),(47.5,6.8,13.7),(47.5,6.8,6.5)]),
 ('H2 LED1 to LED2',1.6,[(32.5,6.8,6.5),(32.5,6.8,18),(87.5,6.8,18),(87.5,6.8,6.5)]),
 ('H3 LED2 to LED3',1.6,[(72.5,6.8,6.5),(72.5,6.8,13.7),(72.5,30,13.7),(87.5,30,13.7),(87.5,53.2,13.7),(87.5,53.2,6.5)]),
 ('H4 LED3 to LED4',1.6,[(72.5,53.2,6.5),(72.5,53.2,13.7),(72.5,45.5,13.7),(34,45.5,13.7),(34,53.2,13.7),(34,53.2,7.5),(32.5,53.2,6.5)]),
 ('P1 battery to charger',1.6,[(87,26,18),(20.5,26,18),(20.5,32,18)]),
 ('P2 charger to switch',1.6,[(23.5,32,18),(23.5,30,18),(60,30,18),(60,44.5,20.8)]),
 ('P3 protected feed and MOSFET gate',1.6,[(60,44.5,24),(76,44.5,24)]),
 ('P4 switch to XIAO',1.2,[(63,44.5,24),(65.5,44.5,18),(65.5,30,18),(97,30,18),(97,44,18),(109.5,44,18),(109.5,44,24)]),
 ('P5 boost VIN VOUT and ground',1.6,[(49,44,24),(50.5,44,24),(50.5,39.8,24),(76,39.8,24),(76,43,24)]),
 ('D1 XIAO data and ground',1.2,[(109.5,47,18),(97,47,18),(97,30,18),(77,30,18),(77,44,24)]),
 ('H0 signal board to front connector',1.6,[(79,44,24),(79,36,24),(79,36,13.7),(68,36,13.7),(68,24,13.7)])
]
BAYS=[
 ('BOOST envelope', (37.5,42.5,17),(51.8,52.5,29)),
 ('SIGNAL and CAPACITOR envelope',(71.5,41.5,16),(90,53,29)),
 ('FRONT connector service space',(61,18.5,11.5),(74,28.5,19)),
 ('DPDT insulated solder bay',(56.2,42.5,18.5),(63.8,46.4,25.3)),
 ('Charger solder bay',(15.3,31.9,17),(25.7,33.8,21.8)),
 ('XIAO wire approach',(107.6,43,15.8),(110.6,53,26.5)),
]
