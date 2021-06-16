within ThermoSysPro.Examples.Book.PowerPlants;
model SupercriticalPulverizedCoalPowerPlant
  "Model of a supercritical pulverized coal power plant"

  parameter Integer NCEL = 7;

  parameter Real dpfCorr=1.00
    "Corrective term for the friction pressure loss (dpf) for each node";
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine    Turbine_HP(
    eta_is_min=0.75,
    W_fric=1,
    Qmax=50,
    eta_is(start=0.96),
    eta_is_nom=0.94,
    pros(d(start=35.19870673587873)),
    Cst(fixed=false,
      start=2001324.343046339)=
                       2.00537e6,
    Pe(start=26999999.985564, fixed=true))
    annotation (Placement(transformation(extent={{-24,136},{60,214}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeD splitter_Turbine_HP1(h(start=
          3071530.861772407),
    dynamic_mass_balance=true,
    P(start=6401000),
    Ce(Q(start=549.193976505918)))
    annotation (Placement(transformation(extent={{272,185},{294,167}})));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_IP2(
    eta_stato=1,
    mode_e=2,
    mode_s=2,
    mode_ps=2,
    W_fric=1,
    eta_is(start=0.94),
    eta_is_nom=0.94,
    Qmax=50,
    pros(d(start=6.887350366974513)),
    Cst(fixed=false,
      start=53978.86314853486)=
                       53802.6,
    Pe(start=3799997.860026793,
                      fixed=true))
    annotation (Placement(transformation(extent={{602,38},{656,97}})));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_LP2(
    W_fric=1,
    eta_stato=1,
    eta_is_min=0.75,
    Qmax=50,
    eta_is_nom=0.91,
    eta_is(start=0.91),
    pros(d(start=0.3736533771704811)),
    xm(start=0.9898250653294598),
    Cst(fixed=false,
      start=1220.138716068697)=
                       1215.75,
    Pe(start=299998.1114947147,
                     fixed=true))
                annotation (Placement(transformation(extent={{1182,38},{1236,96}},
                    rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_IP1(
    eta_stato=1,
    eta_is_min=0.75,
    mode_e=2,
    mode_s=2,
    mode_ps=2,
    eta_is_nom=0.94,
    eta_is(start=0.94),
    W_fric=1,
    Qmax=50,
    pros(d(start=10.384234361858882)),
    Cst(fixed=false,
      start=102744.34781655352)=
                       102478,
    Pe(start=5999998.330854355,
                             fixed=true))
    annotation (Placement(transformation(extent={{396,38},{450,96}})));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_LP1(
    W_fric=1,
    eta_stato=1,
    eta_is_min=0.75,
    Qmax=50,
    eta_is_nom=0.91,
    eta_is(start=0.91),
    pros(d(start=1.390561376459253)),
    Cst(fixed=false,
      start=4501.927059584096)=
                       4485.97,
    Pe(start=729997.7575424919,
                     fixed=true))
                annotation (Placement(transformation(extent={{1004,38},{1058,96}},
                    rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_IP3(
    eta_stato=1,
    eta_is_min=0.75,
    mode_e=2,
    mode_s=2,
    mode_ps=2,
    W_fric=1,
    Qmax=50,
    eta_is(start=0.94),
    eta_is_nom=0.94,
    pros(d(start=2.8084284519008316)),
    Cst(fixed=false,
      start=34193.21955188417)=
                       34076.9,
    Pe(start=2270000, fixed=true))
    annotation (Placement(transformation(extent={{802,38},{856,96}})));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Turbine_LP3(
    W_fric=1,
    eta_stato=1,
    eta_is_min=0.75,
    Qmax=50,
    eta_is_nom=0.91,
    eta_is(start=0.91),
    pros(d(start=0.17053836551218424)),
    xm(start=0.9624448460730977),
    Cst(fixed=false,
      start=59.44671753933515)=
                       59.4076,
    Pe(start=59999.53282881782,
                    fixed=true),
    Ps(start=25000))
                annotation (Placement(transformation(extent={{1358,38},{1412,96}},
                    rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine Echappement(
    W_fric=1,
    eta_stato=1,
    xm(start=0.9213019144264654),
    Qmax=50,
    Cst(fixed=false,
      start=14.295718727368532)=
                       14.7,
    eta_is(start=0.8),
    eta_is_nom=0.91,
    pros(d(start=0.04238683084570735)),
    Pe(start=24999.77493390328,
                    fixed=true),
    Ps(start=5000))
                annotation (Placement(transformation(extent={{1514,37},{1568,97}},
                    rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineIP1(h(start=
          3537588.8079320663))
    annotation (Placement(transformation(extent={{518,79},{542,55}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineIP2(h(start=
          3369888.816557468),
      dynamic_mass_balance=true)
    annotation (Placement(transformation(extent={{732,80},{760,54}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_IP3(
                                                                       K(fixed=
          false) = 10, Q(start=19.00114371733354,
                                   fixed=true),
    C2(P(start=580155.4529087848),h_vol(start=311761.22672647523)))
    annotation (Placement(transformation(extent={{27,-21},{-27,21}}, rotation=270,
        origin={945,290})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineIP3(
      h(start=3059443.3348694695),
                          P(start=774340))
    annotation (Placement(transformation(extent={{932,78},{958,56}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineLP1(
      h(start=2869360.296898901),
                          P(start=190280))
    annotation (Placement(transformation(extent={{1112,79},{1136,55}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_LP1(
                                                                       K(fixed=
          false) = 10, Q(start=28.001397928754212,
                                   fixed=true),
    C2(P(start=236489.70540554097)))
    annotation (Placement(transformation(extent={{27,-20},{-27,20}}, rotation=270,
        origin={1124,291})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineLP2(h(start=
          2606190.1863981914))
    annotation (Placement(transformation(extent={{1284,79},{1308,55}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_LP2(
                     K(fixed=false) = 10, Q(start=9.0003750371771,
                                                     fixed=true),
    C2(P(start=44661.45635759075)))
    annotation (Placement(transformation(extent={{-27,-21},{27,21}}, rotation=90,
        origin={1296,291})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_TurbineLP3(                h(
        start=2489005.0530445203),
                          P(start=23000))
    annotation (Placement(transformation(extent={{1460,81},{1486,53}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_LP3(
    h(start=3.048e6),
    K(fixed=false) = 10,
    Q(start=16.000569587384174,
                fixed=true),
    C2(P(start=19457.45212821197),h_vol(start=225941.66047852393)))
    annotation (Placement(transformation(extent={{27,-22},{-27,22}}, rotation=270,
        origin={1474,291})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{1764,-54},{1826,-4}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ SourceCaloporteur(
                 Q0=16400, h0=121652)
                                 annotation (Placement(transformation(extent={{1562,
            -54},{1614,-4}},       rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_Condenser2(K=1e-4,
      Pm(start=4999.990549904409),
    C1(h_vol(start=137765.1189884895)),
    C2(P(start=4999.981099808819),h_vol(start=137765.1189884895)))
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, rotation=270,
        origin={1694,-164})));
  ThermoSysPro.WaterSteam.HeatExchangers.SimpleDynamicCondenser Condenser(
    Vf0=0.15,
    A=100,
    ntubes=28700,
    lambda=0.018,
    Kvl=1,
    V=1000,
    steady_state=false,
    continuous_flow_reversal=true,
    yNiveau(signal(start=1.5, fixed=false)),
    P0=5000,
    P(start=5000),
    Cv(Q(start=433.2001545496264)),
    proe(d(start=994.1205995939429)))
    annotation (Placement(transformation(extent={{1636,-72},{1746,30}})));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump(
    C1(P(start=5000)),
    a1(fixed=false) = -390,
    a3=350,
    C2(P(start=2699869.622037593,
                        fixed=true), h_vol(start=140956.11701829222)),
    Qv(start=0.43524240668307135),
    h(start=139360.61800339087),
    hn(start=276.1071665616722))
    annotation (Placement(transformation(extent={{1760,-226},{1796,-188}})));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff ReDrum(
    DTfroid(displayUnit="K") = 5,
    Kf=305,
    DPf(start=57524.2563411452),
    Ec(h(start=311761.22672647523)),
    Ef(h_vol(start=140956.11701829222)),
    Sc(h_vol(start=150272.7724602458)),
    Sf(h_vol(start=161833.76268010825)),
    promc(d(start=985.5919033987386)))
    annotation (Placement(transformation(extent={{1798,440},{1666,548}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterLP3(
    SPurge=200,
    KCond=1535.50,
    KPurge=100,
    Ep(Q(start=0.001)),
    SCondDes=3255,
    lambdaE=256,
    Ee(P(start=2650000)),
    P(start=25000),
    HDesF(start=245425.15364009212),
    HeiF(start=162682.43852863708),
    Hep(start=248917.79589378808),
    SDes(start=1E-009),
    Se(
      P(start=2511836.0997127844),
      h(start=245425.15364009212),
      h_vol(start=245425.15364009212)))
    annotation (Placement(transformation(extent={{1568,552},{1452,434}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterLP2(
    KCond=1530.50,
    SPurge=482.5,
    KPurge=109.55,
    Se(P(start=2413894.9462802503),
      h(start=306860.7316879813),
      h_vol(start=306860.7316879813)),
    lambdaE=512.2,
    Ee(P(start=2600000)),
    SCondDes=1477,
    P(start=60000),
    Ep(h(start=438607.090332969)),
    HDesF(start=306860.7316879813),
    HeiF(start=247625.18923762313),
    Hep(start=328778.4878550007),
    SDes(start=1E-009))
    annotation (Placement(transformation(extent={{1390,552},{1272,434}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterLP1(
    KCond=1530.50,
    SPurge=504,
    KPurge=155.7,
    lambdaE=1258,
    Ee(P(start=2500000)),
    SCondDes=1408,
    P(start=300000),
    Ep(h(start=464182.2380411874)),
    HDesF(start=455062.8963466834),
    HeiF(start=313734.293691341),
    Hep(start=501954.8282730701),
    SDes(start=131.63162125559273),
    Se(
      P(start=2169310.5330650215),
      h(start=465109.255940298),
      h_vol(start=465109.255940298)))
    annotation (Placement(transformation(extent={{1214,551},{1106,437}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterIP(
    KCond=1730.50,
    SPurge=239,
    KPurge=2795,
    lambdaE=885,
    Ee(P(start=2250000)),
    SCondDes=795,
    P(start=730000),
    HDesF(start=565579.5385524093),
    HeiF(start=473909.76996909064),
    Hep(start=664813.6284480324),
    SDes(start=98.33315286951769),
    Se(h(start=578948.0240115122), P(start=1992791.4733867273)))
    annotation (Placement(transformation(extent={{1030,551},{924,437}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss pipePressureLoss_LP3_Drum(K=1e-4, pro(d(
          start=986.1624696132673)))
    annotation (Placement(transformation(extent={{1562,555},{1602,605}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeI Drum_1(h(start=167087.86591036225),
                                                                  V=10)
    annotation (Placement(transformation(extent={{1872,493},{1926,555}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_IP1(
    h(start=3463.4e3),
    K(fixed=false) = 10,
    Q(start=25.00040036422368,
                fixed=true),
    Pm(start=3900000),
    C2(h_vol(start=3537588.8079320663)))
    annotation (Placement(transformation(extent={{26.5,-22},{-26.5,22}},
                                                                     rotation=270,
        origin={530,290.5})));
  ThermoSysPro.WaterSteam.Volumes.VolumeI Drum_2(
    h(start=778321.3350751515),
    V=200,
    P(start=2070000))
    annotation (Placement(transformation(extent={{774,433},{712,503}})));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump1(
                                                                               rm=0.7,
    C2(Q(start=599.993976505918,
                    fixed=true), P(start=32854107.921229515),
      h_vol(start=827111.4901416934)),
    C1(P(start=2070000)),
    a1(fixed=false) = -3050,
    a3=5000,
    Qv(start=0.6740415564019792),
    h(start=821565.0),
    hn(start=3535.3592725080375))
    annotation (Placement(transformation(extent={{683,509},{655,483}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating  ReheaterHP3(
    Se(P(start=32900000), h(start=932438.8978014372)),
    KPurge=1200,
    lambdaE=1712,
    SPurge=1098,
    Ee(P(start=33600000), h_vol(start=827111.4901416933)),
    KCond=1588,
    SCondDes=750,
    P(start=3771567.571218525),
    HDesF(start=927325.1475293547),
    HeiF(start=855187.674900425),
    Hep(start=964242.0430144744),
    SDes(start=79.82059037582069),
    h(start=841102.4802107343))
    annotation (Placement(transformation(extent={{572,546},{474,448}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_Desu(
    C2(P(start=3800000)),
    C1(h_vol(start=2924612.095560695)),
    K=1e-4,
    Pm(start=3771567.5730999485))
    annotation (Placement(transformation(extent={{22.5,-14.5},{-22.5,14.5}},
                                                                     rotation=180,
        origin={274.5,375.5})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating  ReheaterHP2(
    lambdaE=1157,
    Se(P(start=32400000), h(start=1168614.317235736)),
    KCond=1588,
    KPurge=1200,
    SPurge=849,
    SCondDes=1667.5,
    P(start=5568798.758801826),
    Ee(Q(start=299.99698825295724),
                       h(start=932438.8978014372)),
    Ep(P(start=8930425.05990273), h(start=1170923.9907383516)),
    HDesF(start=1139894.576035795),
    HeiF(start=977219.550756442),
    Hep(start=1180774.7250052856),
    SDes(start=337.2006466251369),
    h(start=940451.6341612964))
    annotation (Placement(transformation(extent={{404,482},{302,376}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_HP1(
    h(start=3.07903e6),
    K(fixed=false) = 10,
    Q(start=61, fixed=true),
    Pm(start=6401000))
    annotation (Placement(transformation(extent={{27,-20},{-27,20}}, rotation=270,
        origin={322,291})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating  ReheaterHP1(
    KPurge=1279,
    lambdaE=750,
    Se(h(start=1338936.264843952),
                         P(start=32050000)),
    KCond=1588,
    SCondDes=1692.5,
    SPurge=1049,
    P(start=10000000),
    Ee(h(start=1168614.317235733)),
    HDesF(start=1301805.3904686682),
    HeiF(start=1184664.7287055368),
    Hep(start=1360493.8691474798),
    SDes(start=416.53928018645576))
    annotation (Placement(transformation(extent={{208,480},{104,378}})));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff Desuperheater(
    Sf(
      Q(start=600),
      h(start=1.369E6),
      P(start=31940231.739229403),
      h_vol(start=1364477.62662973)),
    Ef(h(start=1338936.2648439475)),
    promc(d(start=12.67201785254116)),
    DTfroid(displayUnit="K") = 5,
    Kf=10,
    Tsf(start=580.3334486723465))
    annotation (Placement(transformation(extent={{34,545},{-70,447}})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_HP(
    h(start=3.19e6),
    Q(fixed=true, start=50.8),
    K(fixed=false) = 10,
    Pm(start=10000000))
    annotation (Placement(transformation(extent={{21.5,-18},{-21.5,18}},
                                                                     rotation=270,
        origin={128,296.5})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_HP_IP(
    h(start=3.07903e6),
    K(fixed=false) = 10,
    Q(fixed=true, start=3),
    Pm(start=6401000))
    annotation (Placement(transformation(extent={{-15.5,-16.5},{15.5,16.5}},
                                                                     rotation=0,
        origin={883.5,-8.5})));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine   Turbine_HP1(
    eta_is_min=0.75,
    W_fric=1,
    Qmax=50,
    eta_is(start=0.96),
    eta_is_nom=0.92,
    pros(d(start=24.64344118791907)),
    Cst(fixed=false,
      start=278836.9406128902)=
                       279474,
    Pe(start=10000000, fixed=true),
    Ps(start=6401000))
    annotation (Placement(transformation(extent={{172,136},{256,214}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeD splitter_Turbine_HP(h(start=
          3182580.38391812),
    dynamic_mass_balance=true,
    P(start=10000000))
    annotation (Placement(transformation(extent={{116,184},{140,166}})));
  ThermoSysPro.WaterSteam.Machines.Generator generator(eta=99.7)
    annotation (Placement(transformation(extent={{48,-194},{-84,-314}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add
                                          annotation (Placement(transformation(
          extent={{94,-218},{76,-200}},
                                    rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add3 add1
                                          annotation (Placement(transformation(
          extent={{96,-240},{76,-220}},
                                    rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add3 add2
                                          annotation (Placement(transformation(
          extent={{94,-264},{76,-244}},
                                    rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorT sensorT(C1(h_vol(start=
            3474803.0992788016)),
                                C2(h_vol(start=3474803.0992788034)))
    annotation (Placement(transformation(extent={{-202,170},{-180,200}})));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValveHP(
                             C1(P(fixed=true, start=27019900)),
    h(start=3.4756e6),
    Cvmax(fixed=false) = 8005,
    T(displayUnit="K", start=873.1))
    annotation (Placement(transformation(extent={{-157,166},{-121,204}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constantHP(k=0.5)
    annotation (Placement(transformation(extent={{-84,200},{-114,230}})));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValveIP(Cvmax(
        fixed=false) = 8005,
    h(start=3.70545e6),
    C1(P(fixed=true, start=6009998.640295431),
                                     h_vol(start=3701594.2696911553)))
    annotation (Placement(transformation(extent={{-158,245},{-122,285}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constantIP(k=0.5)
    annotation (Placement(transformation(extent={{-84,274},{-120,310}})));
  ThermoSysPro.Combustion.CombustionChambers.GenericCombustion1D
    genericCombustion(
    EPSPAR=0.4,
    ImbCV=0.01,
    ImbBF=0.007,
    Kec=15,
    SM={635.7,635.7,635.7,635.7,635.7,635.7,635.7},
    Psf,
    Tea(start=577.3294631233695),
    Tpi(start={662.130125894802,685.614566355283,696.9408592330145,
          703.5449672340172,712.7782107613066,727.9340239141302,
          750.6768400836096}),
    Tsf(start=1501.2484101541468),
    deltaPccb(start=2223.1944617307236))
                      annotation (Placement(transformation(extent={{-238,-102},
            {-436,68}},
                      rotation=0)));

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe Wall_screen(
    Ns=NCEL,
    L=65,
    ntubes=912,
    mode=0,
    z2=65,
    D=0.034,
    option_temperature=2,
    P(start={30342043.891952675,30282117.04096996,30227397.738711014,
          30178994.328953177,30137426.097264428,30101658.687952235,
          30069281.864402287,30038017.722720534,30006184.603574578}),
    Q(start={597.6590942672652,597.6590942672652,597.6590942672652,
          597.6590942672652,597.6590942672652,597.6590942672652,
          597.6590942672652,597.6590942672652}),
    h(start={1479747.0728819133,1653147.2981052676,1836593.6418651666,
          2019276.7199909666,2201503.0794841815,2383076.101933648,
          2563538.204063644,2742239.471375197,2742239.471375197}),
    mu2(start={8.337682531388398E-05,7.290904575803869E-05,6.19675832347849E-05,
          5.107649475602911E-05,4.1856937780558395E-05,3.577140353596319E-05,
          3.242959431491525E-05,3.102497852505804E-05}),
    pro2(d(start={696.792093597009,625.1171632839697,535.5755100207667,
            432.7397163943108,333.50837586843403,256.1304727342381,
            200.77652123807803,161.8541988249301})))
                  annotation (Placement(transformation(extent={{-66,44},{66,-44}},
                   rotation=90,
        origin={-520,-18})));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(
    Ns=NCEL,
    lambda=40,
    L=65,
    e=0.008,
    ntubes=912,
    D=0.034,
    Tp(start={653.6406823320823,676.633278239129,687.9969395834568,
          694.6234079190576,703.8886379558984,719.0988402846453,
          741.927864576376}))
              annotation (Placement(transformation(
        extent={{-66,37},{66,-37}},
        rotation=90,
        origin={-465,-18})));
  ThermoSysPro.FlueGases.Junctions.Splitter2 splitter2_1 annotation (Placement(
        transformation(
        extent={{-12,-19},{12,19}},
        rotation=90,
        origin={-335,102})));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    Boiler_walls(
    Ns=3,
    ExchangerWall(lambda=40, e=8e-3,
      Tp(start={718.6571040634899,718.1194034334801,717.724499487972}),
      Tp1(start={717.5714868892015,717.6719267649172,717.5487415294846})),
    Dint=34e-3,
    Ntubes=912,
    L=40,
    z2=40,
    ExchangerFlueGasesMetal(St=292.41, Dext=50e-3,
      DeltaT(start={554.0628991212207,228.3772089692427,89.70101646279409}),
      T(start={1501.2484130859375,1045.9831048360795,847.7485555139816,
            767.3925170898438}),
      Tm(start={1273.6157574951133,946.8658301750306,807.5705357170625})),
    TwoPhaseFlowPipe(rugosrel=0.0014,
      P(start={30006184.0,29959265.487962805,29911856.28834493,
            29864219.536209688,29816476.0}),
      h(start={2742239.5,2768510.843637918,2779339.5468098293,2783592.798199836,
            2783592.75})),
    Cws2(P(start=29816475.42940753),h_vol(start=2783592.798199836)))
    annotation (Placement(transformation(extent={{202,-27},{-202,27}},
        rotation=-90,
        origin={-521,308})));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink puitsFumeesPTQXA1(T(start=
          398.86640471653106))
    annotation (Placement(transformation(extent={{-392,-166},{-446,-110}},
                                                                     rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases RMT_RHT(
    Ns=3,
    L=17.1,
    ExchangerWall(lambda=40, e=6e-3,
      Tp(start={908.5197253834301,914.4577273376398,917.7248494787165}),
      Tp1(start={906.7665349453516,913.5361998085987,917.2460906463742})),
    Dint=54.5e-3,
    Ntubes=4900,
    ExchangerFlueGasesMetal(
      St=292.41,
      Dext=66.5e-3,
      step_T=0.22,
      step_L=0.9619,
      DeltaT(start={215.99646104532553,113.53397822935688,58.984016359030534}),
      T(start={1189.486083984375,1062.720872868754,994.9311731733584,
            959.3534545898438}),
      Tm(start={1126.1034611836415,1028.8260230210562,977.1423166436323})),
    Cws2(h(start=3.7057e6), P(start=6000000)),
    TwoPhaseFlowPipe(rugosrel=0.0015,
      P(start={6010948.5,6010749.460821071,6010514.567152408,6010261.309075393,
            6009998.5}),
      h(start={3264769.75,3507624.3814902483,3635275.8367294283,
            3701594.2696911553,3701594.25})),
    Cws1(P(start=6010948.472475457),h_vol(start=3264769.660736534)))
    annotation (Placement(transformation(extent={{-348,288},{-246,218}})));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases SBT(
    Ns=3,
    L=17.1,
    Dint=38.3e-3,
    TwoPhaseFlowPipe(rugosrel=0.0145,
      P(start={29816474.0,29814038.312406328,29811347.95808922,
            29808483.096597232,29805500.0}),
      h(start={2783592.75,2877312.3915758613,2940320.6561487615,
            2982465.835108181,2982465.75})),
    ExchangerWall(lambda=40, e=6.5e-3,
      Tp(start={749.7844520576,755.6415626459205,759.6971986304427}),
      Tp1(start={747.8691146804046,754.3538694340593,758.8358820836914})),
    Ntubes=3200,
    ExchangerFlueGasesMetal(
      St=292.41,
      Dext=51.3e-3,
      step_L=0.7,
      DeltaT(start={176.62815353948065,118.74820438652762,79.42869651947797}),
      T(start={959.3534545898438,896.7825168405388,854.222865602998,
            825.5177612304688}),
      Tm(start={928.0679884772226,875.5026912217684,839.8703116077473})),
    Cws2(h_vol(start=2982465.835108181)))
    annotation (Placement(transformation(extent={{-244,368},{-348,302}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss_SBT(K(fixed=
          false) = 910.878, C1(P(fixed=true, start=29805500)))
    annotation (Placement(transformation(extent={{-376,321},{-400,350}})));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases RBT(
    Ns=3,
    L=17.1,
    TwoPhaseFlowPipe(rugosrel=0.0028,
      P(start={6401069.0,6400829.006029598,6400559.967505192,6400281.512735571,
            6400000.0}),
      h(start={3071530.75,3206249.001381632,3250421.0375270667,
            3264769.6607365347,3264769.75})),
    ExchangerWall(lambda=40, e=7.5e-3,
      Tp(start={731.5611188100817,719.1011974452427,714.9322174305115}),
      Tp1(start={730.6241511341694,718.7939799453013,714.8324224349741})),
    Dint=45.7e-3,
    Ntubes=7400,
    ExchangerFlueGasesMetal(
      St=292.41,
      Dext=60.7e-3,
      step_L=0.7,
      DeltaT(start={55.41873058878309,18.170961815555074,5.902564318895884}),
      T(start={825.5177612304688,750.0683189765095,725.0092641729291,
            716.83349609375}),
      Tm(start={787.793038294503,737.5387915747193,720.9213932561836})),
    Cws1(P(start=6401069.169670619),
                             h_vol(start=3071530.861772407)),
    Cws2(h_vol(start=3264769.660736535)))
    annotation (Placement(transformation(extent={{-244,445},{-348,385}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss_RBT(K(fixed=
          false) = 34.39, C1(P(fixed=true, start=6400000)))
    annotation (Placement(transformation(extent={{-390,401},{-416,429}})));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases Economiseur(
    Ns=3,
    L=17.1,
    ExchangerWall(lambda=40, e=7e-3,
      Tp(start={597.8632830911926,601.9643838890306,604.4388143032807}),
      Tp1(start={597.0798518240282,601.4765869344108,604.1356180309247})),
    TwoPhaseFlowPipe(rugosrel=0.0015,
      P(start={31940232.0,31940175.652893864,31940118.025039315,
            31940059.354486804,31940000.0}),
      h(start={1364477.625,1421835.5302184983,1457548.9512506293,
            1479747.0728819133,1479747.125})),
    Dint=37.1e-3,
    Ntubes=5300,
    ExchangerFlueGasesMetal(
      St=292.41,
      Dext=48.3e-3,
      step_L=0.7,
      DeltaT(start={97.96280056397143,60.995722003917535,37.91265067585584}),
      T(start={716.83349609375,676.15417968096,650.5975916707414,
            634.6221923828125}),
      Tm(start={696.493851010199,663.3758856758507,642.6098980814818})))
    annotation (Placement(transformation(extent={{-244,527},{-348,465}})));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases SMT_SHT(
    L=17.1,
    TwoPhaseFlowPipe(rugosrel=0.0015,
      P(start={27030444.0,27028361.67511348,27025839.239372097,
            27022989.150393303,27019900.0}),
      h(start={2976603.0,3194812.5584599497,3356176.887995873,3474803.099278803,
            3474803.0})),
    ExchangerWall(lambda=40, e=8e-3,
      Tp(start={854.8283610087926,887.434475626394,912.4750108334613}),
      Tp1(start={846.3932984841808,881.1968091408571,907.8894202971029})),
    Dint=37.9e-3,
    Ntubes=2075,
    ExchangerFlueGasesMetal(
      St=292.41,
      Dext=53.9e-3,
      step_T=0.22,
      step_L=1.016,
      DeltaT(start={571.7995516807581,422.84154854302676,310.84993208179515}),
      T(start={1501.2484130859375,1366.1601385670497,1264.857744235079,
            1189.486083984375})),
    Cws2(P(start=27000000), h(start=3.4751e6)),
    Ns=3)
    annotation (Placement(transformation(extent={{-348,206},{-246,140}})));
  ThermoSysPro.FlueGases.PressureLosses.InvSingularPressureLoss singularPressureLoss
                          annotation (Placement(transformation(extent={{-496,
            551},{-472,579}},
                       rotation=0)));
  ThermoSysPro.FlueGases.Junctions.Mixer2 mixer2_1(T(start=639.3587532777143))
                                                   annotation (Placement(
        transformation(
        extent={{-18,-20},{18,20}},
        rotation=90,
        origin={-336,572})));
  ThermoSysPro.FlueGases.HeatExchangers.StaticFluegasesFluegasesExchangerKS RA(
    DPc(displayUnit="bar") = 0.01,
    K=350,
    S=7475,
    DPf=0.01,
    Tsc(displayUnit="degC", start=401.15),
    Tsf(start=573.15, displayUnit="degC"))
    annotation (Placement(transformation(extent={{-37,34},{37,-34}},
        rotation=90,
        origin={-338,-159})));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ sourceAir(
    Xh2o=0.016,
    Xo2=0.206,
    Xco2=0,
    Q0=708,
    P0=101000,
    T0=288.15)
    annotation (Placement(transformation(extent={{-444,-260},{-394,-204}})));
  ThermoSysPro.FlueGases.Volumes.VolumeATh AirPreheater(h(start=72890))
    annotation (Placement(transformation(extent={{-368,-242},{-348,-222}})));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(T0={305.15})
    annotation (Placement(transformation(extent={{-368,-222},{-348,-202}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volumeA1(                   h(start=
          1479747.0728819133),
                      P(start=32000000),
    Cs2(Q(start=2.340852247894304)))
    annotation (Placement(transformation(extent={{-366,484},{-394,508}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volumeA(
    h(start=2976603.0385964634),
    dynamic_mass_balance=true,
    P(start=27030443.91251134))
    annotation (Placement(transformation(extent={{-390,162},{-370,184}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourceQ(
                                                             Q0=0, P0=100000)
    annotation (Placement(transformation(extent={{-144,-8},{-206,60}}, rotation=
           0)));
  ThermoSysPro.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    rho=1200,
    Hum=0.03,
    T0(displayUnit="K") = 288.15,
    Xc=0.6652,
    Xh=0.0378,
    Xo=0.0546,
    Xn=0.0156,
    Xs=0.0052,
    Xashes=0.1415,
    Vol=0.229,
    Q0=65.765,
    LHV=26030e3)
    annotation (Placement(transformation(extent={{-140,-94},{-208,-26}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValveEco(
    T(displayUnit="K"),
    Cvmax(fixed=true) = 200,
    Q(start=2.35, fixed=false))
                             annotation (Placement(transformation(
        extent={{14,14},{-14,-14}},
        rotation=90,
        origin={-372,443})));
  ThermoSysPro.Examples.Control.TemperatureControl TemperatureControl(
    Ti=5,
    pIsat(Ti=20, Limiteur1(u(signal(start=-0.028450421536047304)))),
    add(k1=+1, k2=-1))
    annotation (Placement(transformation(extent={{-148,441},{-180,477}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constant_Temperature(k=873.15)
    annotation (Placement(transformation(extent={{-104,435},{-132,461}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Q_flueGases_wall(k=
        0.03506165)
    annotation (Placement(transformation(extent={{-422,60},{-380,92}})));
  ThermoSysPro.WaterSteam.LoopBreakers.LoopBreakerP loopBreakerP_Drum_2
                                                                 annotation (
      Placement(transformation(
        extent={{22,-20},{-22,20}},
        rotation=180,
        origin={764,594})));
  ThermoSysPro.WaterSteam.LoopBreakers.LoopBreakerP loopBreakerP_ReDrum
                                                                 annotation (
      Placement(transformation(
        extent={{19,-19},{-19,19}},
        rotation=180,
        origin={1795,550})));
  ThermoSysPro.WaterSteam.LoopBreakers.LoopBreakerP loopBreakerP_Cond
                                                                 annotation (
      Placement(transformation(
        extent={{26,-26},{-26,26}},
        rotation=90,
        origin={1930,285})));
  ThermoSysPro.WaterSteam.Sensors.SensorQ Sensor_Qvap_Cond(C1(h_vol(start=
            1957787.8431100189)))
    annotation (Placement(transformation(
        origin={1704,53},
        extent={{-13,-18},{13,18}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ Sensor_Qvap_Cond2
    annotation (Placement(transformation(
        origin={1706,-113},
        extent={{-15,-16},{15,16}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_Low(mode=1, K=
       1e-4,
    C1(h_vol(start=140956.11701829222), P(start=2617886.004032243)),
    Pm(start=2617885.994610223))
                 annotation (Placement(transformation(extent={{-27,-24},{27,24}},
                    rotation=90,
        origin={1830,290})));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve_Condenser(
    mode=1,
    Cvmax=2000,
    C2(P(start=2696400)))
    annotation (Placement(transformation(
        extent={{-18,-17},{18,17}},
        rotation=90,
        origin={1819,-160})));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante ConsigneLevelCondenser1(k=1.5)
    annotation (Placement(transformation(extent={{1932,-38},{1896,-2}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Level_Condenser(
    add(k1=+1, k2=-1),
    pIsat(
      Ti=200,
      minval=0.3,
      Limiteur1(u(signal(start=0.8)))),
    pIsat1(Ti=100, minval=0.3),
    edge(uL(signal(start=true))))
                                annotation (Placement(transformation(extent={{
            1896,-98},{1940,-54}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_Condenser1(
                                                                                       K=1e-4, Pm(start=
          5191.555663955529))
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, rotation=0,
        origin={1661,67})));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipe_HP2(
    h(start=3.07903e6),
    K(fixed=false) = 1e-4,
    Pm(start=6401000),
    C1(P(fixed=true, start=6401100)))
    annotation (Placement(transformation(extent={{28,-19},{-28,19}}, rotation=270,
        origin={285,291})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA splitter_condenser(h(start=
          1957787.8431100189),
    h0=1.959e6,
    P0=538300000,
    P(start=5000))
    annotation (Placement(transformation(extent={{1600,53},{1628,81}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss_Eco(K(fixed=
          false) = 3867, C1(P(fixed=true, start=31940000)))
    annotation (Placement(transformation(extent={{-416,482},{-442,510}})));
  ThermoSysPro.WaterSteam.PressureLosses.CheckValve CheckValve(
    Qmin=1,
    Q(fixed=true, start=30.011367796945933),
    k(fixed=false) = 100,
    touvert(start=true))
    annotation (Placement(transformation(
        extent={{-18,-16},{18,16}},
        rotation=90,
        origin={745,288})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps V_staticCentrifugalPump(Table=[0,
        1400; 100,1400; 700,1000; 800,950; 900,950; 1000,950])
                   annotation (Placement(transformation(extent={{1670,-310},{
            1738,-244}}, rotation=0)));
  ThermoSysPro.Examples.Control.MassFlowControl Pump_VelocityControl(
    pT1_1(k=1, Ti=1),
    Ti=5,
    maxval=1400,
    pIsat(Limiteur1(u(signal(start=1400.006776094082)))))
    annotation (Placement(transformation(extent={{628,637},{694,699}})));
  ThermoSysPro.WaterSteam.Sensors.SensorQ sensorQ
    annotation (Placement(transformation(extent={{626,494},{606,514}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_1(
    k=1,
    U0=1400,
    permanent=true,
    Ti=10)
    annotation (Placement(transformation(extent={{712,631},{732,651}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe ramp_Kcor(
    Starttime=100,
    Duration=600,
    Initialvalue=1,
    Finalvalue=0.5)
    annotation (Placement(transformation(extent={{-244,-170},{-274,-148}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeB volume_HP1(
    h0=850000,
    dynamic_mass_balance=true,
    P0=32200000,
    P(start=31945061.30060599),
    h(start=1338936.2648439475),
    Ce1(h(start=1338936.264843952)))
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={86,496})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterHP1_1(
    KPurge=1279,
    lambdaE=750,
    Se(h(start=1.369e6), P(start=32050000)),
    KCond=1588,
    SCondDes=1692.5,
    SPurge=1049,
    P(start=8930425.05990273),
    Ee(h(start=1168614.3172357369)),
    Ev(Q(start=25.40000000000056)),
    HDesF(start=1301805.3904686691),
    HeiF(start=1184664.7287055398),
    Hep(start=1360493.8691474795),
    SDes(start=416.5392801864518),
    Sp(h(start=1170923.990738357)),
    h(start=940451.6341612969))
    annotation (Placement(transformation(extent={{208,610},{104,508}})));
  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating ReheaterHP2_1(
    lambdaE=1157,
    Se(P(start=32400000), h(start=1168614.317235736)),
    KCond=1588,
    KPurge=1200,
    SCondDes=1667.5,
    SPurge=849,
    P(start=5568798.758801826),
    Ee(h(start=932438.8978014372)),
    Ev(Q(start=30.499999999999968)),
    HDesF(start=1139894.576035795),
    HeiF(start=977219.5507564419),
    Hep(start=1180774.725005288),
    SDes(start=337.20064662513767))
    annotation (Placement(transformation(extent={{404,612},{302,506}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeB volume_HP2(
    h0=820000,
    h(start=932438.8978014372),
    dynamic_mass_balance=true,
    P0=32400000,
    P(start=32156093.56417011))
    annotation (Placement(transformation(extent={{416,487},{436,507}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeB volume_HP3(
    h0=990400,
    h(start=940451.6341612943),
    P0=6400171,
    P(start=5568798.758431694))
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={498,565})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volume_HP1Vap(
    h0=990400,
    dynamic_mass_balance=true,
    h(start=3182580.38391812),
    P0=10000000,
    P(start=8930425.061957654))
                       annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={128,342})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volume_HP1Vap1(
    h0=990400,
    dynamic_mass_balance=true,
    h(start=3071530.861772407),
    P0=6400171,
    P(start=5568798.763146943))
                      annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={322,342})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1(K=1e-4, pro(d(start=844.2396226650313)))
    annotation (Placement(transformation(extent={{524,555},{544,575}})));
  ThermoSysPro.WaterSteam.LoopBreakers.LoopBreakerP singularPressureLoss2
    annotation (Placement(transformation(extent={{433,592},{453,612}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={384,470})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4(K=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={292,470})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={322,382})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss6(K=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={128,389})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss7(K=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,470})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volume_HP21(
    h0=1168600,
    h(start=1168614.3172357369),
    P0=32060000,
    dynamic_mass_balance=true,
    P(start=32031852.891034454))
    annotation (Placement(transformation(extent={{266,549},{246,569}})));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volume_HP22(
    h0=1168600,
    h(start=1168614.317235733),
    P0=32060000,
    dynamic_mass_balance=true,
    P(start=32031852.513327856))
    annotation (Placement(transformation(extent={{264,419},{244,439}})));
  ThermoSysPro.Examples.Control.MassFlowRateAirCoalWater
    MassFlowRateAirCoalWater
    annotation (Placement(transformation(extent={{-408,620},{-488,708}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Power_MW(
    Starttime=100,
    Duration=600,
    Initialvalue=804.461,
    Finalvalue=399.8)
    annotation (Placement(transformation(extent={{-340,678},{-370,700}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_2(
    k=1,
    permanent=true,
    U0=708,
    Ti=5)
    annotation (Placement(transformation(extent={{-554,648},{-582,671}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_3(
    k=1,
    permanent=true,
    U0=804,
    Ti=5)
    annotation (Placement(transformation(extent={{-556,684},{-580,709}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_4(
    k=1,
    permanent=true,
    U0=600,
    Ti=5)
    annotation (Placement(transformation(extent={{-370,636},{-344,662}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_5(
    k=1,
    permanent=true,
    U0=0.8,
    Ti=10)
    annotation (Placement(transformation(extent={{1766,-170},{1786,-150}})));
equation

  connect(lumpedStraightPipe_IP3.C1, splitter_TurbineIP3.Cs2) annotation (Line(
      points={{945,263},{945,78}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_LP2.Cs, splitter_TurbineLP2.Ce1) annotation (Line(
      points={{1236.27,67},{1284,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_TurbineLP2.Cs1, Turbine_LP3.Ce) annotation (Line(
      points={{1308,67},{1357.73,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_LP2.C1, splitter_TurbineLP2.Cs2) annotation (Line(
      points={{1296,264},{1296,79}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_LP3.Cs, splitter_TurbineLP3.Ce1) annotation (Line(
      points={{1412.27,67},{1460,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(SourceCaloporteur.C, Condenser.Cee) annotation (Line(
      points={{1614,-29},{1616,-29},{1616,-32.22},{1636,-32.22}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Condenser.Cse, PuitsCaloporteur.C) annotation (Line(
      points={{1746,-31.2},{1741,-31.2},{1741,-29},{1764,-29}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lumpedStraightPipe_LP3.C2, ReheaterLP3.Ev) annotation (Line(
      points={{1474,318},{1474,474.12},{1475.2,474.12}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_LP1.C2, ReheaterLP1.Ev) annotation (Line(
      points={{1124,318},{1124,475.76},{1127.6,475.76}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterLP1.Sp, ReheaterLP2.Ep) annotation (Line(
      points={{1192.4,512.81},{1192.4,555},{1248,555},{1248,453},{1366.4,453},{
          1366.4,472.94}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lumpedStraightPipe_LP1.C1, splitter_TurbineLP1.Cs2) annotation (Line(
      points={{1124,264},{1124,79}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Drum_1.Ce3, pipePressureLoss_LP3_Drum.C2)
                                             annotation (Line(
      points={{1872,499.2},{1852,499.2},{1852,580},{1602,580}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pipePressureLoss_LP3_Drum.C1, ReheaterLP3.Sp)
                                                annotation (Line(
      points={{1562,580},{1544.8,580},{1544.8,512.47}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterIP.Sp, ReheaterLP1.Ep)  annotation (Line(
      points={{1008.8,512.81},{1008.8,549},{1072,549},{1072,451},{1192.4,451},{
          1192.4,474.62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lumpedStraightPipe_LP3.C1, splitter_TurbineLP3.Cs2) annotation (Line(
      points={{1474,264},{1474,81},{1473,81}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));

  connect(ReheaterHP3.Ev, lumpedStraightPipe_Desu.C2)
                                                     annotation (Line(
      points={{493.6,481.32},{493.6,375.5},{297,375.5}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Desuperheater.Sc, lumpedStraightPipe_Desu.C1)
    annotation (Line(
      points={{-38.8,475.91},{-38.8,376},{252,376},{252,375.5}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Desuperheater.Ec, lumpedStraightPipe_IP1.C2)
    annotation (Line(
      points={{2.8,475.91},{2.8,364},{530,364},{530,317}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_HP1.Cs, splitter_Turbine_HP1.Ce)
                                             annotation (Line(
      points={{256.42,175},{256.42,173.5},{272,173.5},{272,176}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_Turbine_HP.Cs2, lumpedStraightPipe_HP.C1)
                                                   annotation (Line(
      points={{128,183.82},{128,275}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterHP1.Sp, ReheaterHP2.Ep) annotation (Line(
      points={{187.2,445.83},{188,460},{188,474},{242,474},{242,392},{383.6,392},
          {383.6,410.98}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterLP2.Ev, lumpedStraightPipe_LP2.C2) annotation (Line(
      points={{1295.6,474.12},{1295.6,418.38},{1296,418.38},{1296,318}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_HP_IP.C2, splitter_TurbineIP3.Ce2) annotation (
      Line(
      points={{899,-8.5},{945,-8.5},{945,56.22}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_Turbine_HP1.Cs3, lumpedStraightPipe_HP_IP.C1) annotation (
      Line(
      points={{294,176},{294,-8.5},{868,-8.5}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_Turbine_HP1.Cs1, lumpedStraightPipe_HP1.C1) annotation (Line(
      points={{283,167},{322,167},{322,264}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(generator.Wmec5,add. y) annotation (Line(
      points={{48,-206},{48,-209},{75.1,-209}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Turbine_HP.MechPower,add. u1) annotation (Line(
      points={{64.2,139.9},{64.2,-198.05},{94.9,-198.05},{94.9,-203.6}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Turbine_HP1.MechPower,add. u2) annotation (Line(
      points={{260.2,139.9},{260.2,-214.4},{94.9,-214.4}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(generator.Wmec4,add1. y) annotation (Line(
      points={{48,-230},{75,-230}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Turbine_IP1.MechPower,add1. u1) annotation (Line(
      points={{452.7,40.9},{452.7,-222},{97,-222}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Turbine_IP2.MechPower,add1. u2) annotation (Line(
      points={{658.7,40.95},{658.7,-230},{97,-230}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Turbine_IP3.MechPower,add1. u3) annotation (Line(
      points={{858.7,40.9},{858.7,-238},{97,-238}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(generator.Wmec3,add2. y) annotation (Line(
      points={{48,-254},{75.1,-254}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Turbine_LP1.MechPower,add2. u1) annotation (Line(
      points={{1060.7,40.9},{1060.7,-246},{94.9,-246}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Turbine_LP2.MechPower,add2. u2) annotation (Line(
      points={{1238.7,40.9},{1238.7,-254},{94.9,-254}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Turbine_LP3.MechPower,add2. u3) annotation (Line(
      points={{1414.7,40.9},{1414.7,-262},{94.9,-262}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Echappement.MechPower,generator. Wmec2) annotation (Line(
      points={{1570.7,40},{1570.7,-278},{48,-278}},
      color={0,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(controlValveHP.C2, Turbine_HP.Ce) annotation (Line(
      points={{-121,173.6},{-34,173.6},{-34,175},{-24.42,175}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sensorT.C2, controlValveHP.C1) annotation (Line(
      points={{-179.78,173},{-151.89,173},{-151.89,173.6},{-157,173.6}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(constantIP.y, controlValveIP.Ouv)  annotation (Line(
      points={{-121.8,292},{-140,292},{-140,287}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(controlValveIP.C2, Turbine_IP1.Ce) annotation (Line(
      points={{-122,253},{-36,253},{-36,67},{395.73,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(genericCombustion.Cfg,splitter2_1. Ce) annotation (Line(
      points={{-337,59.5},{-336,76},{-336,90},{-335,90}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(Boiler_walls.Cws1, Wall_screen.C2)          annotation (Line(
      points={{-521,106},{-522,82},{-520,48}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter2_1.Cs1, Boiler_walls.Cfg1)   annotation (Line(
      points={{-354,106.8},{-472,106.8},{-472,308},{-507.5,308}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(genericCombustion.Cth,heatExchangerWall. WT2) annotation (Line(
      points={{-426.1,-17},{-454,-17},{-454,-18},{-457.6,-18}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(heatExchangerWall.WT1, Wall_screen.CTh)        annotation (Line(
      points={{-472.4,-18},{-506.8,-18}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(SBT.Cfg1,RMT_RHT. Cfg2) annotation (Line(
      points={{-296,318.5},{-296,270.5},{-297,270.5}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(RBT.Cfg1,SBT. Cfg2)      annotation (Line(
      points={{-296,400},{-296,351.5}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(singularPressureLoss_RBT.C2,RMT_RHT. Cws1) annotation (Line(
      points={{-416,415},{-418,415},{-418,253},{-348,253}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(SBT.Cws1, Boiler_walls.Cws2)   annotation (Line(
      points={{-244,335},{-234,335},{-234,538},{-520,538},{-520,510},{-521,510}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(SMT_SHT.Cfg1,splitter2_1. Cs2) annotation (Line(
      points={{-297,156.5},{-298,132},{-298,108},{-316,108},{-316,106.8}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(RMT_RHT.Cfg1,SMT_SHT. Cfg2) annotation (Line(
      points={{-297,235.5},{-297,189.5}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(singularPressureLoss.C1, Boiler_walls.Cfg2)    annotation (Line(
      points={{-496,565},{-550,565},{-550,308},{-534.5,308}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(Economiseur.Cfg2,mixer2_1. Ce2) annotation (Line(
      points={{-296,511.5},{-296,564.8},{-316,564.8}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(RA.Sc,puitsFumeesPTQXA1. C)
    annotation (Line(
      points={{-358.4,-136.8},{-358.4,-138},{-392.54,-138}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(RA.Sf,genericCombustion. Ca)
    annotation (Line(
      points={{-338,-122},{-338,-93.5},{-337,-93.5}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(singularPressureLoss.C2, mixer2_1.Ce1)  annotation (Line(
      points={{-472,565},{-458,565},{-458,564.8},{-356,564.8}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(mixer2_1.Cs,RA. Ec) annotation (Line(
      points={{-336,590},{-564,590},{-564,-184},{-358.4,-184},{-358.4,-181.2}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(AirPreheater.Cs1,RA. Ef) annotation (Line(
      points={{-348,-232},{-338,-232},{-338,-196}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(sourceAir.C, AirPreheater.Ce1)  annotation (Line(
      points={{-394,-232},{-368,-232}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(heatSource.C[1],AirPreheater. Cth) annotation (Line(
      points={{-358,-221.8},{-358,-232}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(singularPressureLoss_SBT.C2,volumeA. Ce1) annotation (Line(
      points={{-400,335.5},{-400,173},{-390,173}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(volumeA1.Ce1,Economiseur. Cws2) annotation (Line(
      points={{-366,496},{-348,496}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(fuelSourcePQ.C,genericCombustion. Cfuel) annotation (Line(
      points={{-208,-60},{-208,-59.5},{-247.9,-59.5}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(Economiseur.Cfg1, RBT.Cfg2) annotation (Line(
      points={{-296,480.5},{-296,430}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(controlValveEco.C1,volumeA1. Cs2) annotation (Line(
      points={{-380.4,457},{-380.4,484},{-380,484}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(controlValveEco.C2,volumeA. Ce2) annotation (Line(
      points={{-380.4,429},{-380.4,280},{-380,280},{-380,183.78}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(TemperatureControl.MesureNiveauEau, sensorT.Measure) annotation (Line(
      points={{-147.2,475.2},{-191,475.2},{-191,200}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(TemperatureControl.ConsigneNiveauEau, constant_Temperature.y)
    annotation (Line(
      points={{-147.2,448.2},{-136,448.2},{-136,448},{-133.4,448}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(controlValveEco.Ouv, TemperatureControl.SortieReelle1) annotation (
      Line(
      points={{-356.6,443},{-276.625,443},{-276.625,442.8},{-180.8,442.8}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(genericCombustion.Cws, sourceQ.C) annotation (Line(
      points={{-247.9,25.5},{-203.95,25.5},{-203.95,26},{-206,26}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(splitter_TurbineIP1.Cs2, lumpedStraightPipe_IP1.C1) annotation (Line(
      points={{530,79},{530,264}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterIP.Ev, lumpedStraightPipe_IP3.C2) annotation (Line(
      points={{945.2,475.76},{945.2,428.04},{945,428.04},{945,317}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterIP.Ee, ReheaterLP1.Se) annotation (Line(
      points={{1031.06,494},{1040,496},{1040,493},{1100,493},{1106,494}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterLP1.Ee, ReheaterLP2.Se) annotation (Line(
      points={{1215.08,494},{1222,496},{1222,493},{1272,493}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterLP2.Ee, ReheaterLP3.Se) annotation (Line(
      points={{1391.18,493},{1396,496},{1396,493},{1452,493}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Q_flueGases_wall.y, splitter2_1.Ialpha1)
                                              annotation (Line(
      points={{-377.9,76},{-346.4,76},{-346.4,103.2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterLP2.Sp, ReDrum.Ec)
                                   annotation (Line(
      points={{1366.4,512.47},{1366.4,605},{1758.4,605},{1758.4,516.14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(loopBreakerP_ReDrum.C1, ReDrum.Sc)
                                     annotation (Line(
      points={{1776,550},{1706,550},{1706,545},{1705.6,545},{1705.6,516.14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(loopBreakerP_ReDrum.C2, Drum_1.Ce1)
                                         annotation (Line(
      points={{1814,550},{1814,549},{1834,549},{1834,548.8},{1872,548.8}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(staticCentrifugalPump1.C1, Drum_2.Cs1)  annotation (Line(
      points={{683,496},{712,496}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(loopBreakerP_Drum_2.C1, ReheaterHP3.Sp)
                                            annotation (Line(
      points={{742,594},{552,594},{552,513.17},{552.4,513.17}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(loopBreakerP_Drum_2.C2, Drum_2.Ce2)
                                         annotation (Line(
      points={{786,594},{834,594},{834,468},{774,468}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Drum_1.Cs1, loopBreakerP_Cond.C1)
                                         annotation (Line(
      points={{1926,548.8},{1928,548.8},{1928,311},{1930,311}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Sensor_Qvap_Cond.C2, Condenser.Cv)          annotation (Line(
      points={{1689.6,39.74},{1689.6,45.87},{1691,45.87},{1691,30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReDrum.Ef, lumpedStraightPipe_Low.C2)
                                        annotation (Line(
      points={{1798,494},{1830,494},{1830,317}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_Low.C1, controlValve_Condenser.C2)
                                                annotation (Line(
      points={{1830,263},{1830,-142},{1829.2,-142}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(controlValve_Condenser.C1, staticCentrifugalPump.C2)
                                                     annotation (Line(
      points={{1829.2,-178},{1829.2,-206},{1796,-206},{1796,-207}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ConsigneLevelCondenser1.y, regulation_Level_Condenser.ConsigneNiveauEau)
    annotation (Line(points={{1894.2,-20},{1852,-20},{1852,-69.4},{1894.9,-69.4}}));
  connect(Sensor_Qvap_Cond.Measure, regulation_Level_Condenser.MesureDebitVapeur)
    annotation (Line(points={{1722.36,53},{1816,53},{1816,-96},{1856,-96},{
          1895.12,-95.58}}));

  connect(regulation_Level_Condenser.MesureDebitEau, Sensor_Qvap_Cond2.Measure)
                                        annotation (Line(
      points={{1894.79,-82.49},{1774,-82.49},{1774,-113},{1722.32,-113}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Condenser.yNiveau, regulation_Level_Condenser.MesureNiveauEau)
    annotation (Line(
      points={{1751.5,-57.72},{1860,-57.72},{1860,-56.2},{1894.9,-56.2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Sensor_Qvap_Cond2.C2, lumpedStraightPipe_Condenser2.C1)
    annotation (Line(
      points={{1693.2,-128.3},{1693.2,-125.13},{1694,-125.13},{1694,-148}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Sensor_Qvap_Cond2.C1, Condenser.Cl)          annotation (Line(
      points={{1693.2,-98},{1694,-98},{1694,-72},{1692.1,-72}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_TurbineIP2.Cs1, Turbine_IP3.Ce) annotation (Line(
      points={{760,67},{801.73,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_IP3.Cs, splitter_TurbineIP3.Ce1) annotation (Line(
      points={{856.27,67},{932,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_TurbineLP3.Cs1, Echappement.Ce) annotation (Line(
      points={{1486,67},{1513.73,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_Condenser1.C2, Sensor_Qvap_Cond.C1)
    annotation (Line(
      points={{1677,67},{1688,67},{1688,66},{1689.6,66}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Economiseur.Cws1, Desuperheater.Sf)
                                     annotation (Line(
      points={{-244,496},{-162,496},{-162,495.51},{-70,495.51}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(RBT.Cws1, lumpedStraightPipe_HP2.C2) annotation (Line(
      points={{-244,415},{285,415},{285,319}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Echappement.Cs, splitter_condenser.Ce1) annotation (Line(
      points={{1568.27,67},{1600,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_condenser.Cs1, lumpedStraightPipe_Condenser1.C1) annotation (
     Line(
      points={{1628,67},{1645,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(loopBreakerP_Cond.C2, splitter_condenser.Ce2)
                                                    annotation (Line(
      points={{1930,259},{1927,259},{1927,80.72},{1614,80.72}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(singularPressureLoss_Eco.C1, volumeA1.Cs1) annotation (Line(
      points={{-416,496},{-412,496},{-412,497},{-406,497},{-406,496},{-394,496}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Wall_screen.C1, singularPressureLoss_Eco.C2)        annotation (Line(
      points={{-520,-84},{-442,-84},{-442,496}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ReheaterLP3.Ee, ReDrum.Sf)
                                   annotation (Line(
      points={{1569.16,493},{1615.55,493},{1615.55,494.54},{1666,494.54}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(volumeA.Cs1, SMT_SHT.Cws1) annotation (Line(
      points={{-370,173},{-352,174},{-352,172},{-350,174},{-348,173}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_Turbine_HP.Cs3, Turbine_HP1.Ce) annotation (Line(
      points={{140,175},{171.58,175}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_HP.Cs, splitter_Turbine_HP.Ce) annotation (Line(
      points={{60.42,175},{116,175}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Drum_2.Ce1, ReheaterIP.Se) annotation (Line(
      points={{774,496},{918,497},{918,495},{922,495},{924,494}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_HP2.C1, splitter_Turbine_HP1.Cs2) annotation (Line(
      points={{285,263},{284,263},{284,184.82},{283,184.82}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splitter_TurbineIP1.Cs1, Turbine_IP2.Ce) annotation (Line(
      points={{542,67},{570,67},{570,67.5},{601.73,67.5}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_IP1.Cs, splitter_TurbineIP1.Ce1) annotation (Line(
      points={{450.27,67},{518,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(Turbine_IP2.Cs, splitter_TurbineIP2.Ce1) annotation (Line(
      points={{656.27,67.5},{694.14,67.5},{694.14,67},{732,67}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(lumpedStraightPipe_Condenser2.C2, staticCentrifugalPump.C1)
    annotation (Line(
      points={{1694,-180},{1694,-207},{1760,-207}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(controlValveIP.C1, RMT_RHT.Cws2) annotation (Line(
      points={{-158,253},{-246,253}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(singularPressureLoss_RBT.C1, RBT.Cws2) annotation (Line(
      points={{-390,415},{-348,415}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(singularPressureLoss_SBT.C1, SBT.Cws2) annotation (Line(
      points={{-376,335.5},{-362,335.5},{-362,335},{-348,335}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sensorT.C1, SMT_SHT.Cws2) annotation (Line(
      points={{-202,173},{-246,173}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(controlValveHP.Ouv, constantHP.y) annotation (Line(
      points={{-139,205.9},{-139,215},{-115.5,215}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(CheckValve.C1, splitter_TurbineIP2.Cs2)      annotation (Line(
      points={{745,268.2},{746,268.2},{746,80}},
      color={255,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(V_staticCentrifugalPump.y, staticCentrifugalPump.rpm_or_mpower)
    annotation (Line(
      points={{1741.4,-277},{1778,-277},{1778,-227.9}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensorQ.C2, ReheaterHP3.Ee) annotation (Line(
      points={{605.8,496},{590,496},{590,497},{572.98,497}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sensorQ.C1, staticCentrifugalPump1.C2) annotation (Line(
      points={{626,496},{655,496}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sensorQ.Measure,Pump_VelocityControl. Mesure_Q_water) annotation (
      Line(
      points={{616,514.2},{616,614},{528,614},{528,694},{626.35,694},{626.35,
          695.9}},
      color={127,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Pump_VelocityControl.SortieReelle1, pT1_1.u) annotation (Line(
      points={{695.65,640.1},{704.825,640.1},{704.825,641},{711,641}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pT1_1.y, staticCentrifugalPump1.rpm_or_mpower) annotation (Line(
      points={{733,641},{733,642},{732,614},{670,614},{669,510.3}},
      color={127,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(splitter_TurbineIP3.Cs1, Turbine_LP1.Ce) annotation (Line(
      points={{958,67},{1003.73,67}},
      color={255,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(Turbine_LP1.Cs, splitter_TurbineLP1.Ce1) annotation (Line(
      points={{1058.27,67},{1112,67}},
      color={255,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(splitter_TurbineLP1.Cs1, Turbine_LP2.Ce) annotation (Line(
      points={{1136,67},{1181.73,67}},
      color={255,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(RA.Kcorr, ramp_Kcor.y) annotation (Line(
      points={{-314.2,-159},{-275.5,-159}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterHP3.Se, volume_HP2.Ce2) annotation (Line(
      points={{474,497},{436,497}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP2.Cs2, ReheaterHP2.Ee) annotation (Line(
      points={{426,487.2},{428,487.2},{428,429},{405.02,429}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP2.Cs1, ReheaterHP2_1.Ee) annotation (Line(
      points={{426,506},{426,560},{405.02,560},{405.02,559}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ReheaterHP1_1.Se, volume_HP1.Ce1) annotation (Line(
      points={{104,559},{86,559},{86,506}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ReheaterHP1.Se, volume_HP1.Ce2) annotation (Line(
      points={{104,429},{86,429},{86,486}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP1.Cs2, Desuperheater.Ef) annotation (Line(
      points={{76.2,496},{34,496}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ReheaterHP1_1.Sp, ReheaterHP2_1.Ep) annotation (Line(
      points={{187.2,575.83},{187.2,602},{244,602},{244,518},{383.6,518},{383.6,
          540.98}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lumpedStraightPipe_HP.C2, volume_HP1Vap.Ce1) annotation (Line(
      points={{128,318},{128,332}},
      color={255,0,0},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(lumpedStraightPipe_HP1.C2, volume_HP1Vap1.Ce1) annotation (Line(
      points={{322,318},{322,332}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP3.Cs2, singularPressureLoss1.C1) annotation (Line(
      points={{507.8,565},{524,565}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(singularPressureLoss1.C2, ReheaterHP3.Ep) annotation (Line(
      points={{544,565},{588,565},{588,461},{552.4,461},{552.4,480.34}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterHP2_1.Sp, singularPressureLoss2.C1) annotation (Line(
      points={{383.6,576.49},{383.6,602},{433,602}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(singularPressureLoss2.C2, volume_HP3.Ce2) annotation (Line(
      points={{453,602},{498,602},{498,575}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ReheaterHP2.Sp, singularPressureLoss3.C1) annotation (Line(
      points={{383.6,446.49},{383.6,460},{384,460}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(singularPressureLoss3.C2, volume_HP3.Ce1) annotation (Line(
      points={{384,480},{400,480},{400,516},{416,516},{416,528},{498,528},{498,
          555}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(volume_HP1Vap1.Cs1, singularPressureLoss5.C1) annotation (Line(
      points={{322,352},{322,372}},
      color={255,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(singularPressureLoss5.C2, ReheaterHP2.Ev) annotation (Line(
      points={{322,392},{322,412.04},{322.4,412.04}},
      color={255,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume_HP1Vap1.Cs2, singularPressureLoss4.C1) annotation (Line(
      points={{312,342},{292,342},{292,460}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(singularPressureLoss4.C2, ReheaterHP2_1.Ev) annotation (Line(
      points={{292,480},{290,480},{290,524},{322.4,524},{322.4,542.04}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP1Vap.Cs1, singularPressureLoss6.C1) annotation (Line(
      points={{128,352},{128,379}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(singularPressureLoss6.C2, ReheaterHP1.Ev) annotation (Line(
      points={{128,399},{128,412.68},{124.8,412.68}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP1Vap.Cs2, singularPressureLoss7.C1) annotation (Line(
      points={{118,342},{70,342},{70,460}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(singularPressureLoss7.C2, ReheaterHP1_1.Ev) annotation (Line(
      points={{70,480},{70,526},{124.8,526},{124.8,542.68}},
      color={255,0,0},
      pattern=LinePattern.Dash,
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP21.Ce1, ReheaterHP2_1.Se) annotation (Line(
      points={{266,559},{302,559}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ReheaterHP1_1.Ee, volume_HP21.Cs1) annotation (Line(
      points={{209.04,559},{246,559}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(ReheaterHP1.Ee, volume_HP22.Cs1) annotation (Line(
      points={{209.04,429},{244,429}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(volume_HP22.Ce1, ReheaterHP2.Se) annotation (Line(
      points={{264,429},{302,429}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(Power_MW.y, MassFlowRateAirCoalWater.Electrical_power_MW) annotation (
     Line(
      points={{-371.5,689},{-384,689},{-384,706.24},{-444,706.24}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(pT1_3.y, fuelSourcePQ.IMassFlow) annotation (Line(
      points={{-581.2,696.5},{-590,688},{-600,688},{-600,-272},{-174,-272},{
          -174,-43}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(pT1_3.u, MassFlowRateAirCoalWater.Q_coal) annotation (Line(
      points={{-554.8,696.5},{-523.4,696.5},{-523.4,697},{-492,697}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(pT1_2.y, sourceAir.IMassFlow) annotation (Line(
      points={{-583.4,659.5},{-592,659.5},{-592,-218},{-419,-218}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(pT1_2.u, MassFlowRateAirCoalWater.Q_air) annotation (Line(
      points={{-552.6,659.5},{-522.3,659.5},{-522.3,660.04},{-492,660.04}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(pT1_4.y,Pump_VelocityControl. Consigne_Q_water) annotation (Line(
      points={{-342.7,649},{141.65,649},{141.65,649.4},{626.35,649.4}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(MassFlowRateAirCoalWater.Q_water, pT1_4.u) annotation (Line(
      points={{-492,624.84},{-508,624.84},{-508,610},{-392,610},{-392,649},{-371.3,
          649}},
      color={0,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(CheckValve.C2, Drum_2.Ce4) annotation (Line(
      points={{745,307.8},{745,296.9},{743,296.9},{743,433}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(regulation_Level_Condenser.SortieReelle1, pT1_5.u) annotation (Line(
      points={{1941.1,-95.8},{1954,-95.8},{1954,-128},{1752,-128},{1752,-160},{
          1765,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pT1_5.y, controlValve_Condenser.Ouv) annotation (Line(
      points={{1787,-160},{1800.3,-160}},
      color={0,0,255},
      smooth=Smooth.None));
annotation (
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </h4>
<p><b>ThermoSysPro Version 3.2 </h4>
<p>This is the dynamic model of a once-through supercritical coal-fired power plant. </p>
<p>It is documented in Sect. 6.6 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Cecilia Rioual</li>
</ul>
</html>"),
   Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-600,-400},{2000,800}},
        initialScale=0.1), graphics={Text(
          extent={{80,134},{188,114}},
          lineColor={0,0,255},
          textString="Turbine_HP"),  Text(
          extent={{385,18},{489,-2}},
          lineColor={0,0,255},
          textString="Turbine_IP"),  Text(
          extent={{990,22},{1104,2}},
          lineColor={0,0,255},
          textString="Turbine_LP"),  Text(
          extent={{-543,-104},{-492,-112}},
          lineColor={0,0,255},
          textString="Wall_screen"), Text(
          extent={{-394,204},{-308,194}},
          lineColor={0,0,255},
          textString="SMT_SHT"),     Text(
          extent={{-566,514},{-408,524}},
          lineColor={0,0,255},
          textString="Boiler_walls"),Text(
          extent={{-394,282},{-306,272}},
          lineColor={0,0,255},
          textString="RMT_RHT"),     Text(
          extent={{-384,354},{-334,344}},
          lineColor={0,0,255},
          textString="SBT"),         Text(
          extent={{-384,432},{-334,422}},
          lineColor={0,0,255},
          textString="RBT"),         Text(
          extent={{-382,526},{-332,513}},
          lineColor={0,0,255},
          textString="Eco"),         Text(
          extent={{1426,542},{1540,522}},
          lineColor={0,0,255},
          textString="LP_RH3"),      Text(
          extent={{1256,538},{1370,518}},
          lineColor={0,0,255},
          textString="LP_RH2"),      Text(
          extent={{1088,538},{1202,518}},
          lineColor={0,0,255},
          textString="LP_RH1"),      Text(
          extent={{902,540},{1016,520}},
          lineColor={0,0,255},
          textString="IP_RH"),       Text(
          extent={{466,468},{580,448}},
          lineColor={0,0,255},
          textString="HP_RH3"),      Text(
          extent={{290,502},{404,482}},
          lineColor={0,0,255},
          textString="HP_RH2"),      Text(
          extent={{98,502},{212,482}},
          lineColor={0,0,255},
          textString="HP_RH1"),      Text(
          extent={{-74,546},{40,526}},
          lineColor={0,0,255},
          textString="Desu"),
        Text(
          extent={{6,-226},{1248,-540}},
          lineColor={28,108,200},
          textString="New model DynamicExchangerWaterSteamFlueGases_New_hi
Dp; h convectif")}),
    experiment(StopTime=1200),
    Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end SupercriticalPulverizedCoalPowerPlant;
