"""Two-switch circuit clearance routes in X,Y,depth mm; radii include dressing room."""
ROUTES=[
 ('H1 front connector to LED1',1.6,[(68,24,14.4),(47.5,24,14.4),(47.5,6.8,14.4),(47.5,6.8,6.5)]),
 ('H2 LED1 to LED2',1.6,[(32.5,6.8,6.5),(32.5,6.8,18),(87.5,6.8,18),(87.5,6.8,6.5)]),
 ('H3 LED2 to LED3',1.6,[(72.5,6.8,6.5),(72.5,6.8,14.4),(72.5,30,14.4),(87.5,30,14.4),(87.5,53.2,14.4),(87.5,53.2,6.5)]),
 ('H4 LED3 to LED4',1.6,[(72.5,53.2,6.5),(72.5,53.2,14.4),(72.5,45.5,14.4),(34,45.5,14.4),(34,53.2,14.4),(34,53.2,7.5),(32.5,53.2,6.5)]),
 ('B1 battery to charger',1.6,[(87,26,18),(20.5,26,18),(20.5,32,18)]),
 ('P1 charger OUT plus to SPDT',.8,[(23.5,32,18),(23.5,30,18),(41,30,18),(41,49.5,23)]),
 ('P2 SPDT switched plus to DPDT RUN branch',.8,[(42,49.5,23),(50,49.5,24),(60,51,24)]),
 ('P3 switched plus and protected ground distribution',1.2,[(60,51,24),(76,44.5,24)]),
 ('P4 DPDT common A and ground to XIAO',1.2,[(63,51,24),(64.8,44.5,18),(64.8,30,18),(95.5,30,18),(95.5,43.5,18),(101,48.6,16),(107.3,48.6,16)]),
 ('G1 charger OUT minus to ground distribution',.8,[(22.3,32,18),(22.3,27,14.7),(91,27,14.7),(91,33,14.7),(76,43,24)]),
 ('D1 XIAO data to DPDT RUN B',.8,[(114.3,49,12),(114.3,33,12),(98,33,15),(98,28,16.6),(68,28,16.6),(68,39,16.6),(68,51,20.8),(60,51,20.8)]),
 ('D2 DPDT common B to LED harness junction',.8,[(57,51,20.8),(57,41,23),(79,41,23),(79,44,24)]),
 ('H0 LED harness junction to front connector',1.6,[(79,44,24),(79,36,24),(79,36,14.4),(68,36,14.4),(68,24,14.4)])
]
BAYS=[
 ('XIAO BAT and GND underside solder bay',(104.8,46.5,14.5),(108.75,50.5,18.0)),
 ('SPDT insulated solder bay',(36.8,47.0,20.5),(45.2,50.6,25.3)),
 ('Capacitor and distribution bay',(71.5,41.5,16),(90,53,29)),
 ('Front connector service space',(61,18.5,11.5),(74,28.5,19)),
 ('DPDT insulated solder bay',(55.4,48.5,18.5),(64.6,52.0,25.4)),
 ('Charger solder bay',(15.3,31.9,17),(25.7,33.8,21.8)),
 ('Charger OUT left through-hole bay',(12.05,30.4,20),(15.0,33.95,27)),
 ('Charger OUT right through-hole bay',(27.05,30.4,20),(29.95,33.95,27)),
 ('XIAO front pad wiring aisle',(110.5,38.4,11.7),(113.2,55.6,13.4)),
 ('XIAO rear pad wiring aisle',(110.5,38.4,27.7),(115.7,55.6,30.9)),
]
