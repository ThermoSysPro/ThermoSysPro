within ThermoSysPro.Examples.Book.PowerPlants.CombinedCyclePowerPlant;
model GasTurbineTrip "CCPP model to simulate a gas turbine trip"
  parameter Real CstHP(fixed=false,start=7618660.65374636)
    "Stodola's ellipse coefficient HP";
  parameter Real EtaIsNomHP(fixed=false,start=0.875)
    "Turbine HP: Nominal isentropic efficiency ";
  parameter Real CstMP(fixed=false,start=278905.664031036)
    "Stodola's ellipse coefficient MP";
  //parameter Real EtaIsNomMP(fixed=false,start=0.96)
  //  "Turbine MP: Nominal isentropic efficiency ";
  parameter Real CstBP(fixed=false,start=13491.6445678148)
    "Stodola's ellipse coefficient BP";
  parameter Real EtaIsNomBP(fixed=false,start=0.92)
    "Turbine MP: Nominal isentropic efficiency ";
// //
  //parameter Modelica.SIunits.AbsolutePressure PoutPumpEx(fixed=false,start=22e5)"Flow pressure at the outlet of the pump";
  //parameter Modelica.SIunits.Length zc(fixed=false,start=1.5) "Condenser water level";

  parameter Real LP_Pump_a1(fixed=false,start=-6000)
    "x^2 coef. of the pump characteristics hn = f(vol_flow) (s2/m5)";

  //parameter Real a3_PumpBP(fixed=false,start=400)"Constant coef. of the pump characteristics hn = f(vol_flow) (m)";

  parameter ThermoSysPro.Units.Cv CvmaxValveAHP(fixed=false,start=135)
    "Maximum CV: alim. valve MP Drum ";
  parameter ThermoSysPro.Units.Cv CvmaxValveVHP(fixed=false,start=47829.4)
    "Maximum CV: steame valve HP Drum  ";
  parameter ThermoSysPro.Units.Cv CvmaxValveAMP(fixed=false,start=70)
    "Maximum CV: alim. valve MP Drum ";
  parameter ThermoSysPro.Units.Cv CvmaxValveVMP(fixed=false,start=47829.4)
    "Maximum CV: steame valve  Drum MP";
  parameter ThermoSysPro.Units.Cv CvmaxValveVBP(fixed=false,start=32000)
    "Maximum CV: steame valve BP Drum ";

  //parameter ThermoSysPro.Units.Cv CvmaxValveWBP(fixed=false,start=10000)
  //  "Maximum CV: Water valve BP Drum ";

  parameter Real Fouling_SHP(fixed=false,start=0.075)
    "Sur HP: heat exchange fouling coefficient";

  //parameter Real Fouling_EHP(fixed=false,start=1)
  //  "Eco HP1: heat exchange fouling coefficient";
  parameter Real Fouling_EHP1(fixed=false,start=0.07)
    "Eco HP1: heat exchange fouling coefficient";
  parameter Real Fouling_EHP2(fixed=false,start=0.11)
    "Eco HP2: heat exchange fouling coefficient";
  parameter Real Fouling_EHP3(fixed=false,start=0.06)
    "Eco HP3: heat exchange fouling coefficient";
  parameter Real Fouling_EHP4(fixed=false,start=0.03)
    "Eco HP4: heat exchange fouling coefficient";

  parameter Real Fouling_SMP(fixed=false,start=0.1358)
    "Sur MP1: heat exchange fouling coefficient";

  //parameter Real Fouling_SMP(fixed=true,start=0.065)
  //  "Sur MP1: heat exchange fouling coefficient";

  parameter Real Fouling_EMP(fixed=false,start=0.09)
    "Eco MP: heat exchange fouling coefficient";

  parameter Real Fouling_EvHP(fixed=false,start=0.24)
    "Evapo HP: heat exchange fouling coefficient";
  parameter Real Fouling_EvMP(fixed=false,start=0.08)
    "Evapo MP: heat exchange fouling coefficient";
  parameter Real Fouling_EvBP(fixed=false,start=0.09)
    "Evapo BP: heat exchange fouling coefficient";

  parameter Real Fouling_SBP(fixed=false,start=0.05)
    "Sur BP: heat exchange fouling coefficient";
  parameter Real Fouling_EBP(fixed=false,start=0.06)
    "Eco BP: heat exchange fouling coefficient";

  parameter Real K_HP_DownComer(fixed=false,start=720.183)
    "HP: Friction pressure loss coefficient";
  parameter Real K_IP_DownComer(fixed=false,start=1090.9)
    "MP: Friction pressure loss coefficient";
  parameter Real K_Dp_HP_2(fixed=false,start=10.)
    "SMPin: Friction pressure loss coefficient";

  //parameter Real K_PerteChargeZero2(fixed=true,start=1e-4)
  //  "TurbineMP out: Friction pressure loss coefficient";
  parameter Real K_Dp_HP_IP(fixed=false,start=1.)
    "Outlet THP: Friction pressure loss coefficient";

  parameter ThermoSysPro.Units.Cv Cvmax_THP(fixed=false,start=8000)
    "Maximum CV input Turbine HP ";
  parameter ThermoSysPro.Units.Cv Cvmax_TMP(fixed=false,start=1500)
    "Maximum CV input Turbine MP ";

  ThermoSysPro.WaterSteam.Volumes.DynamicDrum HP_Drum(
    L=16.27,
    Vertical=false,
    hl(fixed=false, start=1474422.14552527),
    hv(fixed=false, start=2666558.75582585),
    Vv(fixed=false),
    R=1.05,
    xmv(fixed=false),
    P(fixed=false, start=12703151.2960688),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    Pfond(start=12703151.3),
    Tp(start=596.924860294475),
    Cv(Q(fixed=true, start=76.58)))
                     annotation (Placement(transformation(extent={{38,10},{-2,
            50}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HP_FeedValve(
    Cvmax=CvmaxValveAHP,
    C1(P(start=12721657.0), h_vol(start=1396865.59043578)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))
                 annotation (Placement(transformation(extent={{78,46},{58,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    HP_SteamValve_Constante(                                                              k=0.5)
    annotation (Placement(transformation(extent={{-18,70},{-28,78}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HP_SteamValve(
    mode=0,
    C2(h_vol(start=2666558.75582585),P(start=12700000.0)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12721657.16928),
    C1(P(start=132.1e5, fixed=true)),
    Cvmax=CvmaxValveVHP)
                 annotation (Placement(transformation(extent={{-22,46},{-42,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss HP_DownComer(
    z2=0,
    mode=1,
    Q(start=150, fixed=true),
    z1=10.83,
    K=K_HP_DownComer,
    C2(P(start=12768600.0)),
    h(start=1474422.14552527),
    Pm(start=12704000))
            annotation (Placement(transformation(
        origin={28,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapHP(mode=1, V=5,     h(start=1474422.14552527))
                                           annotation (Placement(transformation(
          extent={{8,-100},{-12,-80}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_Evaporator(
    Dint=32.8e-3,
    Ntubes=1476,
    L=20.7,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-5.74e7,-2.67e7,-1.24e7}),
      Tp(start={607.668721736158,605.187884376142,603.825778846274}),
      Tp1(start={606.357,604.602,603.578})),
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=10.83,
      option_temperature=2,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={5.74e7,2.67e7,1.24e7}),
      Tp1(start={606.2,604.6,603.7}),
      h(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134,
            1459929.875}),
      hb(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134}),
      P(start={12758125,12740000,12734000,12730000,12726787})),
    ExchangerFlueGasesMetal(
      Dext=0.038,
      step_L=0.092,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=11.86442072,
      p_rho=1.05,
      Encras(start=0.24)=Fouling_EvHP,
      K(fixed=false, start=407),      DeltaT(start={106,49,23}),
      T(start={755.54821777344,673.68082608925,635.57157972092,618.19360351563}),
      Tm(start={643.15,633.15,626.621}),
      Tp(start={609.11670087771,605.86035558168,604.13687003529})))
                          annotation (Placement(transformation(
        origin={-14,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_Economizer_4(
    Ns=3,
    L=20.726,
    Dint=0.0266,
    Ntubes=246,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-3.5e6,-2.63e6,-2e6}),
      Tp(start={576.803345033827,581.933438017921,585.694098500999}),
      Tp1(start={575.762,580.856,584.579})),
    Cws1(P(start=13703700.0), h_vol(start=1306078.18827954)),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      z2=0,
      option_temperature=2,
inertia=true,
      dW1(start={3.5e6,2.63e6,2e6}),
      Tp1(start={577.5,582.6,586.4}),
      h(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578,
            1398251.0}),
      hb(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578}),
      P(start={13301176,13320000,13338000,13357000,13374658})),
    Cws2(h(fixed=false, start=1500e3)),
    ExchangerFlueGasesMetal(
      Dext=0.0318,
      step_L=0.111,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=11.39069779,
      p_rho=1.06,
      Encras(start=0.03)=Fouling_EHP4,
      K(fixed=true, start=47.53),DeltaT(start={38,29,22}),
      T(start={618.19360351563,612.7722894387,608.97249438439,606.41162109375}),
      Tm(start={623.15,613.15,607.844}),
      Tp(start={577.44979072627,582.41942947968,586.06092597683})))
                          annotation (Placement(transformation(
        origin={86,-50},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_SuperHeater_1(
    Ns=3,
    L=20.4,
    Dint=0.0324,
    Ntubes=246,
    ExchangerWall(e=0.0028, lambda=37.61,
    dW1(start={-9.8e6,-7.7e6,-5.9e6}),
      Tp(start={629.445777860324,651.664976699235,671.075818762815}),
      Tp1(start={629,651,670.})),
    Cws1(h_vol(start=2665000.0)),
    Cws2(P(start=12720900.0), h_vol(start=2981170.0)),
    ExchangerFlueGasesMetal(
      Dext=0.038,
      step_L=0.111,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=10.25056,
      p_rho=1.04,
      Encras(start=0.075)=Fouling_SHP,
      K(fixed=false, start=34.71),      DeltaT(start={138,108,84}),
      T(start={788.2431640625,774.65344332519,763.17487871399,755.54821777344}),
      Tm(start={778.15,768.15,759.527}),
      Tp(start={631.68675322573,653.38616970968,672.36458008039})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      option_temperature=2,
      inertia=true,
      dpfCorr=2,      dW1(start={9.8e6,7.7e6,5.9e6}),
      Tp1(start={639.5,657,673}),
      h(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983,
            2973076.25}),
      hb(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983}),
      P(start={12723762,12723600,12723500,12720000,12719000})))
         annotation (Placement(transformation(
        origin={-64,-50},
        extent={{-20,20},{20,-20}},
        rotation=270)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_Economizer_3(
    Dint=26.6e-3,
    Ntubes=1476,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
          dW1(start={-1.6e7,-5.6e6,-2.1e6}),
      Tp(start={556.530623976228,563.226831750573,565.575075374951}),
      Tp1(start={555.49,562.473,564.857})),
    L=20.726,
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={1.6e7,5.6e6,2.1e6}),
      Tp1(start={558,565,567}),
      h(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855,
            1291418.875}),
      hb(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855}),
      P(start={13219333,13241000,13261000,13282000,13301176})),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=12.451,
      p_rho=1.08,
      Encras(start=0.06)=Fouling_EHP3,
      K(fixed=true, start=36.03),
      St=5, DeltaT(start={34,12,4.4}),
      T(start={602.67193603516,579.67183226637,571.50875350574,568.81030273438}),
      Tm(start={593.15,583.15,571.919}),
      Tp(start={557.01185690541,563.39937105652,565.63731055685})))      annotation (Placement(
        transformation(
        origin={206,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_Economizer_2(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-5e6,-3e6,-2.e6}),
      Tp(start={490.631370193221,498.229397165878,502.978053774656}),
      Tp1(start={490,497.024,501.871})),
    L=20.767,
    Ntubes=1107,
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={5e6,3e6,2.e6}),
      Tp1(start={499,503,507}),
      h(start={854494.5625,915007.018247822,957243.396653824,983786.364226731,
            986348.9375}),
      hb(start={854494.5625,915007.018247822,957243.396653824,983786.364226731}),
      P(start={13129352,13152000,13175000,13197000,13219333})),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=111e-3,
      CSailettes=2.76134577,
      p_rho=1.11,
      Encras(start=0.11)=Fouling_EHP2,
      K(fixed=true, start=65),
      St=5, DeltaT(start={36,23,14}),
      T(start={531.16070556641,523.74706132958,519.01561663699,516.31256103516}),
      Tm(start={538.15,528.15,521.399}),
      Tp(start={490.84070882241,498.36081646341,503.06064272486})))      annotation (Placement(
        transformation(
        origin={406,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_Economizer_1(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-9.9999e6,-5e6,-2.4e6}),
      Tp(start={458.958585923538,468.506814782426,473.132256983258}),
      Tp1(start={458.001,467.576,472.607})),
    L=20.726,
    Ntubes=1107,
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={9.9999e6,5e6,2.4e6}),
      Tp1(start={467.4,476.5,480.9}),
      h(start={618651.9375,752176.893518976,816707.727773953,847728.424287614,
            854494.5625}),
      hb(start={618651.9375,752176.893518976,816707.727773953,847728.424287614}),
      dynamic_mass_balance=true,
      P(start={13034956,13060000,13080000,13100000,13129352})),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=8.30057632,
      p_rho=1.13,
      Encras(start=0.07)=Fouling_EHP1,
      K(fixed=true, start=40.),
      St=5,   DeltaT(start={41,20,10}),
      T(start={509.31488037109,491.44087131458,484.15889910859,482.59533691406}),
      Tm(start={503.15,498.15,494.131}),
      Tp(start={459.37586976399,468.70800090382,473.22896941053})))      annotation (Placement(
        transformation(
        origin={526,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_SuperHeater_2(
    Ns=3,
    L=20.4,
    Dint=32e-3,
    Ntubes=246,
    ExchangerWall(e=3e-3, lambda=27,
          dW1(start={-8.8e6,-6.6e6,-4.9e6}),
      Tp(start={714.604505161814,740.492493660215,759.200099714419}),
      Tp1(start={710.485,734.082,752.527})),
    Cws2(P(start=127113000.0), h_vol(start=3254970.0)),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.83,
      inertia=true,
      dpfCorr=2,
      dW1(start={8.8e6,6.6e6,4.9e6}),
      Tp1(start={714,735.6,752}),
      h(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722,
            3240813.5}),
      hb(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722}),
      P(start={12720371,12718000,12716000,12714000,12711007})),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      CSailettes=10.2505424803872,
      p_rho=1.02,
      Encras(start=0.075)=Fouling_SHP,
      K(fixed=false, start=34.74),
      St=5,
      DeltaT(start={124,93,70}),
      T(start={850.64624023438,839.40882309811,830.36536707939,822.68170166016}),
      Tm(start={843.15,833.15,825.24}),
      Tp(start={717.48312916257,742.56566858011,760.69152533026})))      annotation (Placement(
        transformation(
        origin={-174,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    HP_SuperHeater_3(
    Ns=3,
    L=20.4,
    Ntubes=246,
    ExchangerWall(lambda=27,e=5e-3,
    dW1(start={-6.3e6,-4.7e6,-3.6e6}),
      Tp(start={793.335674512128,811.477076678823,824.721389633254}),
      Tp1(start={783.815,803.639,818.56})),
    Dint=28e-3,
    Cws2(h(fixed=true, start=3511e3)),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.726,
      inertia=true,
      dpfCorr=2,
      dW1(start={6.3e6,4.7e6,3.6e6}),
      Tp1(start={783.6,801.6,815}),
      h(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987,
            3433271.25}),
      hb(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987}),
      P(start={12711007,12704000,12697000,12689000,12681000})),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      p_rho=1,
      Encras(start=0.075)=Fouling_SHP,
      CSailettes=6.59672846,
      K(fixed=false, start=49.33),
      St=5,
      DeltaT(start={97,73,55}),
      T(start={894.21850585938,885.5393240412,879.47464880089,874.32891845703}),
      Tm(start={893.15,883.15,875.939}),
      Tp(start={796.82789474964,814.05266276572,826.6253996051})))      annotation (Placement(
        transformation(
        origin={-294,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.WaterSteam.Volumes.DynamicDrum IP_Drum(
    L=16.27,
    Vertical=false,
    P0=27.29e5,
    hl(fixed=false, start=978914.570821827),
    hv(fixed=false, start=2799158.13966473),
    Vv(fixed=false),
    R=1.05,
    P(fixed=false, start=28.3e5),
    zl(start=1.05, fixed=true),
    Kvl=0,
    Kpa=5,
    Mp=5000,
    Cv(Q(fixed=true, start=10.9)),
    Pfond(start=2732995.0),
    Tp(start=500.955757665063))
                     annotation (Placement(transformation(extent={{358,10},{320,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    IP_SteamValve_Constante(                                                              k=0.5)
    annotation (Placement(transformation(extent={{304,70},{292,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve IP_FeedValve(
      Cvmax=CvmaxValveAMP,
    C1(P(start=2952995.0), h_vol(start=892414.570867188)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2945000))
                 annotation (Placement(transformation(extent={{398,46},{378,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve IP_SteamValve(
    Pm(fixed=false, start=2731689.4244255),
    C2(h_vol(start=2798000),P(start=27.3e5)),
    h(fixed=false, start=2798000),
    mode=0,
    Cv(start=27829.4),
    Cvmax=CvmaxValveVMP,
    C1(P(start=28.3e5, fixed=true)))
                 annotation (Placement(transformation(extent={{298,46},{278,66}},
          rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    IP_Evaporator(
    Dint=32.8e-3,
    L=20.767,
    Ntubes=738,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-9.7e7,-7.6e6,-5.8e6}),
      Tp(start={504.957792851478,504.19488464586,503.59993822766}),
      Tp1(start={504.427,503.806,503.304})),
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.83,
      continuous_flow_reversal=true,
      inertia=true,
          dW1(start={9.7e7,7.6e6,5.8e6}),
      Tp1(start={504.5,503.9,503.4}),
      P(start={2773367.5,2754933.93610513,2745233.82043873,2738517.46232967,2733824.75}),
      h(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464,980708.125}),
      hb(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464})),
    ExchangerFlueGasesMetal(
      Dext=38e-3,
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=10.0676093,
      p_rho=1.1,
      Encras(start=0.08)=Fouling_EvMP,
      K(fixed=false, start=46.9),
      St=5,
      DeltaT(start={53,41,32}),
      T(start={565.24822998047,551.20973998682,539.98034586472,531.16070556641}),
      Tm(start={553.15,543.15,536.901}),
      Tp(start={505.45492567199,504.57970000924,503.89762940507})))              annotation (Placement(
        transformation(
        origin={306,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss IP_DownComer(
    z2=0,
    z1=10.83,
    mode=1,
    K=K_IP_DownComer,
    Q(start=22, fixed=true),
    Pm(start=2734000),
    h(start=978914.570821827))
            annotation (Placement(transformation(
        origin={348,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapMP(mode=1, V=5,
    h(start=978914.570821827),
    P(start=2834000))                      annotation (Placement(transformation(
          extent={{328,-100},{308,-80}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    IP_Economizer(
    ExchangerWall(e=2.6e-3, lambda=47,
        dW1(start={-3e6,-1.4e6,-740379}),
      Tp(start={457.584681885759,475.409334769727,486.332585528225}),
      Tp1(start={456.76,474.926,485.122})),
    L=20.726,
    Ns=3,
    Dint=26.6e-3,
    Ntubes=246,
    Cws1(h_vol(start=671235.0)),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.767,
      z2=0,
      inertia=true,
      dW1(start={3e6,1.4e6,740379}),
      Tp1(start={474,491,499.9}),
      h(start={565108.5,727745.440528479,829820.124314816,892414.570867187,
            944505.4375}),
      hb(start={565108.5,727745.440528479,829820.124314816,892414.570867187}),
      P(start={3124229.75,3148000,3172000,3195000,3216977.75})),
    Cws2(h(fixed=false, start=990e3)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      CSailettes=7.16188651,
      p_rho=1.12,
      Encras(start=0.09)=Fouling_EMP,
      K(fixed=true, start=50),
      St=5,
      DeltaT(start={45,24,13}),
      T(start={516.31256103516,511.25046295073,508.31162431247,509.31488037109}),
      Tm(start={533.15,523.15,514.647}),
      Tp(start={458.18343678065,475.77644311925,486.55770446184})))              annotation (Placement(
        transformation(
        origin={466,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    IP_SuperHeater_1(
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.3e6,-0.80263e6,
                                -501864}),
      Tp(start={557.102699668877,574.070651369638,584.64928514972}),
      Tp1(start={556.102699668877,573.070651369638,583.64928514972})),
    L=20.726,
    Ns=3,
    Dint=32.8e-3,
    Ntubes=123,
    Cws1(h_vol(start=2800000.0),P(start=2.73467e+06)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      CSailettes=14.46509765,
      p_rho=1.07,
      Encras(start=0.1385)=Fouling_SMP,
      K(fixed=false, start=22.09),
      St=5,
      DeltaT(start={45,30,19}),
      T(start={606.41162109375,604.22099235915,603.06310204059,602.67193603516}),
      Tm(start={623.15,613.15,603.024}),
      Tp(start={557.49575399383,574.31250418519,584.79699207547})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=0,
      z1=10.77,
      dpfCorr=2,
      inertia=false,
      dW1(start={1.3e6,0.80263e6,501864}),
      Tp1(start={557,573,583}),
      h(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156,
            3040562.25}),
      hb(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156}),
      P(start={2731326.25,2729591.6901521,2728654.3204706,2727686.1714029,
            2726700})))     annotation (Placement(transformation(
        origin={146,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.WaterSteam.Volumes.VolumeB VolumeLP(
    Ce1(h(start=3091610.0)),
    h(start=3042573.51976705),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={146,-110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    IP_SuperHeater_2(
    Ns=3,
    L=20.4,
    Dint=39.3e-3,
    Ntubes=369,
    ExchangerWall(e=2.6e-3, lambda=36.86,
    dW1(start={-1.15e7,-7.9e6,-5.5e6}),
      Tp(start={689.66516778766,716.376344387713,734.591437191304}),
      Tp1(start={687.7,713.5,731.5})),
    Cws1(P(start=2576650.0), h_vol(start=3078800.0)),
    Cws2(P(start=2558540.0), h_vol(start=3342910.0)),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dpfCorr=2,
      dW1(start={1.15e7,7.9e6,5.5e6}),
      Tp1(start={685.6,711,729}),
      h(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389,
            3321940.75}),
      hb(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389}),
      P(start={2575582.5,2572000,2568000,2563000,2558239})),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=92e-3,
      CSailettes=5.814209831,
      p_rho=1.03,
      Encras(start=0.1385)=Fouling_SMP,
      K(fixed=false, start=45.22),
      St=5,
      DeltaT(start={125,86,60}),
      T(start={822.68170166016,807.90772072705,797.00284433443,788.2431640625}),
      Tm(start={813.15,803.15,792.527}),
      Tp(start={690.93545553661,717.24269857866,735.18209370035})))              annotation (Placement(
        transformation(
        origin={-114,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    IP_SuperHeater_3(
    Ns=3,
    L=20.4,
    Ntubes=369,
    Dint=45.6e-3,
    ExchangerWall(e=2.6e-3, lambda=27,
    dW1(start={-8e6,-5.5e6,-3.8e6}),
      Tp(start={788.901616786331,805.674094596818,817.083010473709}),
      Tp1(start={786.717,804.102,815.901})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dpfCorr=2,
      dW1(start={8e6,5.5e6,3.8e6}),
      Tp1(start={782,798.7,810}),
      h(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916,
            3517975.25}),
      hb(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916}),
      P(start={2558239,2556000,2554000,2552000,2548600})),
    Cws2(h(fixed=true, start=3606e3)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      step_L=92e-3,
      Dext=50.8e-3,
      p_rho=1.01,
      CSailettes=5.695842178,
      Encras(start=0.1385)=Fouling_SMP,
      K(fixed=false, start=43.23),
      St=5,
      DeltaT(start={82,56,38}),
      T(start={874.32891845703,864.2444076086,856.92248545484,850.64624023438}),
      Tm(start={873.15,863.15,853.059}),
      Tp(start={789.92521486539,806.37044583028,817.55662835373})))              annotation (Placement(
        transformation(
        origin={-234,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.WaterSteam.Volumes.DynamicDrum LP_Drum(
    Vertical=false,
    P0=5e5,
    Vv(fixed=false),
    L=8,
    hl(fixed=false, start=549249.519022482),
    hv(fixed=false, start=2709858.97470349),
    R=2,
    zl(start=1.75, fixed=true),
    Kvl=0,
    Kpa=5,
    Mp=5000,
    P(fixed=false, start=520000),
    Cv(Q(fixed=true, start=9.23)),
    Pfond(start=564775.0),
    Tp(start=406.411032587651))
                     annotation (Placement(transformation(extent={{618,10},{578,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    LP_SteamValve_Constante(                                                              k=0.5)
    annotation (Placement(transformation(extent={{666,76},{654,86}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve LP_SteamValve(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=503542.0), h_vol(start=2709858.97470349)),
    h(start=2685000),
    Cv(start=7555),
    Pm(start=498000))
                 annotation (Placement(transformation(extent={{558,46},{538,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve LP_FeedValve(
    C1(h_vol(start=511900.0)),
    h(fixed=false, start=509000),
    Pm(fixed=false, start=5.0698e5),
    Cvmax=250,
    Cv(start=142.5),
    C2(P(fixed=true, start=5.2e5)))
                 annotation (Placement(transformation(extent={{650,46},{630,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss LP_DownComer(
    z2=0,
    z1=10.767,
    K=32766,
    mode=1,
    Q(start=20, fixed=false),
    pro(d(start=934.452746556487)),
    Pm(start=564000),
    h(start=549249.519022482))
            annotation (Placement(transformation(
        origin={610,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapBP(h(start=549249.519022482),
                                                                       mode=1,
    V=5,
    P(start=523000))                                   annotation (Placement(
        transformation(extent={{592,-100},{572,-80}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    LP_Evaporator(
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.24e7,-8.5e6,-5.8e6}),
      Tp(start={433.127441964236,432.076030201586,431.28112439162}),
      Tp1(start={432.956,431.127,430.61})),
    L=20.726,
    Ntubes=984,
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={1.24e7,8.5e6,5.8e6}),
      Tp1(start={442.5,441.7,441}),
      h(start={550075.0,765243.011613326,912673.256542569,1013555.73710231,
            550075.0}),
      hb(start={550075.0,765243.011613326,912673.256542569,1013555.73710231}),
      Q(start={49.787311368631,49.787311368631,49.787311368631,49.787311368631}),
      P(start={522583.375,488000,487000,486000,485588.46875})),
    ExchangerFlueGasesMetal(
      Dext=38e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=138e-3,
      CSailettes=11.07985,
      p_rho=1.14,
      Encras(start=0.09)=Fouling_EvBP,
      K(fixed=false, start=46.7),
      St=5,
      DeltaT(start={45,31,21}),
      T(start={482.59533691406,464.53146753441,453.496360082,442.5893859863}),
      Tm(start={483.15,478.15,472.098}),
      Tp(start={433.5360639938,432.3549425205,431.471976456})))              annotation (Placement(
        transformation(
        origin={566,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_LP_Drum(k=0.25)
    annotation (Placement(transformation(extent={{742,32},{728,44}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HPIP_FeedValve(
      Pm(start=5.0698e5), mode=1,
    C1(h_vol(start=549249.519022482)),
    h(start=550000),
    Cv(start=308.931))
                 annotation (Placement(transformation(extent={{710,12},{730,32}},
          rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    LP_SuperHeater(
    Ns=3,
    L=20.726,
    Dint=39.3e-3,
    Ntubes=123,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.1e6,-782901,-559798}),
      Tp(start={489.606851797367,513.610203520748,530.080624448955}),
      Tp1(start={488.486,512.197,529.53})),
    Cws1(h_vol(start=2642240.0),P(start=484264)),
    Cws2(h_vol(start=2979330.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=222.1e-3,
      K(fixed=true, start=30.46),
      CSailettes=3.25763059984175,
      p_rho=1.09,
      Encras(start=0.05)=Fouling_SBP,
      St=5,
      DeltaT(start={92,66,47}),
      T(start={568.81030273438,567.21003420557,566.29303411055,565.24822998047}),
      Tm(start={583.15,573.15,568.703}),
      Tp(start={489.84170505864,513.76963980951,530.18834052149})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      rugosrel=1e-5,
      z1=10.767,
      inertia=false,
      dpfCorr=0.25,
      dW1(start={1.1e6,782901,559798}),
      Tp1(start={485,511,529}),
      h(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762,
            2914520.25}),
      hb(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762}),
      P(start={510622.6875,505757.57962259,504477.27858572,503172.36919354,501850})))      annotation (Placement(
        transformation(
        origin={266,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkP SinkP_Gas(P0=104400)
    annotation (Placement(transformation(
        origin={722,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    LP_Economizer(
    Ns=3,
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-2.45e7,-5.5e6,-1.17e6}),
      Tp(start={398.142807363473,393.825926964772,392.943738968771}),
      Tp1(start={397.622,392.348,391.516})),
    Ntubes=3444,
    L=20.726,
    Cws1(h_vol(start=195526.0)),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      inertia=true,
      dpfCorr=0.5,
      dW1(start={2.45e7,5.5e6,1.17e6}),
      Tp1(start={409,404.7,404}),
      h(start={194584.515625,462556.370989432,494648.45288738,501287.069880104,
            509237.875}),
      hb(start={194584.515625,462556.370989432,494648.45288738,501287.069880104}),
      P(start={1540571.25,1500000,1480000,1450000,1429595.375})),
    Cws2(h(fixed=false, start=500e3)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=92e-3,
      CSailettes=11.673758598919,
      p_rho=1.15,
      Encras(start=0.06)=Fouling_EBP,
      K(fixed=true, start=30),
      St=5,
      DeltaT(start={23.5,5.3,1.1}),
      T(start={442.5893859863,403.9873508455,395.0465605839,395.464630127}),
      Tm(start={423.15,418.15,414.742}),
      Tp(start={398.4437772187,393.8897987349,392.9569515805})))              annotation (Placement(
        transformation(
        origin={680,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Machines.StodolaTurbine HP_Turbine(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.88057),
    eta_is_min=0.75,
    Cst(start=8182844.56002535)=
        CstHP,
    Pe(fixed=true, start=125.20e5),
    Ps(fixed=false, start=2726700),
    eta_is_nom=EtaIsNomHP,
    Cs(h(fixed=true, start=3106e3)),
    pros(d(start=10.0)),
    Hrs(start=3046260),
    Qmax=151,
    a=-1.20211,
    b=2.32571,
    c=-0.25) annotation (Placement(transformation(extent={{-2,-250},{38,-210}},
          rotation=0)));

  ThermoSysPro.WaterSteam.Machines.StodolaTurbine IP_Turbine(
    W_fric=1,
    Ps(fixed=false, start=476800),
    eta_stato=1,
    eta_is(start=0.9625),
    eta_is_min=0.75,
    Cst(start=256335.364995961)=
        CstMP,
    Pe(fixed=true, start=25.13e5),
    pros(d(start=30.0)),
    Hrs(start=3029780),
    Cs(h(fixed=false, start=2990e3)),
    eta_is_nom=0.96,
    b=2.4957,
    Qmax=170,
    a=-1.2728,
    c=-0.26202)   annotation (Placement(transformation(extent={{318,-250},{358,
            -210}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeIP1(
    h(start=2997231.36734756),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={418,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine LP_Turbine(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9538),
    eta_is_min=0.75,
    Cst(start=11944.9445735985)=
        CstBP,
    Hrs(start=2401030),
    Pe(fixed=true, start=4.77e5),
        Ps(start=10053),
    Cs(h(fixed=true, start=2399.9e3)),
    eta_is_nom=EtaIsNomBP,
    Qmax=192,
    a=-1.22335,
    b=2.2957,
    c=-0.14)   annotation (Placement(transformation(extent={{576,-250},{616,
            -210}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitHP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-292,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitMP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-232,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier MoitieDebitHP(Cs(h(start=3000000)),
                                                    alpha=0.5)
    annotation (Placement(transformation(extent={{114,-180},{134,-160}},
          rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.SimpleDynamicCondenser Condenser(
    D=0.018,
    V=1000,
    A=100,
    lambda=0.01,
    ntubes=28700,
    continuous_flow_reversal=true,
    Vf0=0.15,
    steady_state=false,
    yNiveau(signal(start=1.5)),
    Cse(h(start=128076)),
    P0=6100,
    P(fixed=false, start=6136),
    Pfond(start=6200)) annotation (Placement(transformation(extent={{639,-384},{
            719,-304}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=17224)       annotation (Placement(transformation(extent={{
            572,-377},{620,-329}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{736,-374},{780,-330}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss Dp_Cond_In(
    K=1e-4,
    h(start=2400000),
    C1(h_vol(start=2400000), h(start=2400000)),
    Q(start=190.55),
    Pm(start=10026)) annotation (Placement(transformation(extent={{640,-240},{660,
            -220}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeCond1(mode=1,
    Ce3(h(start=163768.700887002)),
    h(start=163768.700887002),
    P(start=1540500))
    annotation (Placement(transformation(
        origin={902,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss Dp_Cond_Out2(
    K=1e-4,
    mode=1,
    pro(d(start=993.470128235971)),
    Pm(start=1540000)) annotation (Placement(transformation(
        origin={902,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA VolumeAlimMPHP(mode=1,
    h(start=549249.519022482),
    P(start=322430))                       annotation (Placement(transformation(
          extent={{742,6},{762,26}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump IP_Pump(
    a3=350,
    mode=1,
    Q(fixed=false, start=10.9),
    a1=-244551,
    C1(h_vol(start=576000.0)),
    C2(h_vol(start=561000.0)),
    h(start=571000.0),
    hn(start=317),
    Qv(start=0.0207237016869104),
    pro(d(start=930.0)),
    Pm(start=1725850))
            annotation (Placement(transformation(extent={{804,6},{824,26}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump HP_Pump(
    a3=1600,
    a1=-28056.2,
    Q(fixed=false),
    mode=1,
    C1(h_vol(start=561000.0)),
    C2(h_vol(start=630000.0)),
    h(start=630000),
    hn(start=1413),
    Qv(start=0.0810383142105344),
    pro(d(start=929.0)),
    Pm(start=6774000))  annotation (Placement(transformation(extent={{804,-46},
            {824,-26}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier MoitieDebitBP(
                                                    alpha=0.5,
    h(start=194585),
    P(start=1540500),
    Cs(h(start=194585)))
    annotation (Placement(transformation(extent={{872,-328},{886,-308}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitBP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={266,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss Dp_LP_Turbine(
    z2=0,
    mode=0,
    z1=0,
    h(start=3000000),
    C1(
      h_vol(start=3000000),
      h(start=3000000),
      P(fixed=false, start=5.0185e5)),
    K=1e-4,
    Pm(start=490000)) annotation (Placement(transformation(
        origin={344,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss DP_HP_Pump(
    K=1e-4,
    mode=1,
    C2(h_vol(start=599600)),
    Pm(start=372718)) annotation (Placement(transformation(
        origin={780,-36},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss DP_IP_Pump(
    K=1e-4,
    mode=1,
    C2(h_vol(start=599600)),
    Pm(start=372718)) annotation (Placement(transformation(
        origin={780,16},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{402,-448},{522,-348}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss Dp_Cond_Out(
    K=1e-4,
    mode=1,
    C1(h_vol(start=153206.462779274)),
    C2(h_vol(start=153206.462779274)),
    pro(d(start=993.441492649513)),
    Pm(start=6200)) annotation (Placement(transformation(extent={{702,-446},{722,
            -426}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump LP_Pump(
    Qv(start=0.1934),
    mode=1,
    a3=400,
    C2(P(fixed=false, start=16.7e5), h_vol(start=194669.0)),
    h(start=193000),
    hn(start=183),
    a1=LP_Pump_a1,
    Q(start=193.43, fixed=false),
    Pm(start=1103065, fixed=false)) annotation (Placement(transformation(extent=
           {{742,-446},{762,-426}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss Dp_Cond_Out1(
    K=1e-4,
    mode=1,
    pro(d(start=994.045785814739)),
    C1(h_vol(start=194585), h(start=194585)),
    Pm(start=1546000)) annotation (Placement(transformation(extent={{840,-446},{
            860,-426}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve ExtractionValve(
    mode=1,
    Cvmax=2500,
    h(start=195000),
    Cv(start=2000),
    C1(h_vol(start=195000)),
    C2(h_vol(start=195000)),
    Pm(start=1549000)) annotation (Placement(transformation(extent={{802,-440},{
            822,-420}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_SteamHP(C1(h_vol(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-58,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_WaterHP(C2(h_vol(start=1398000),
        h(start=1398000)))
    annotation (Placement(transformation(
        origin={91.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_WaterMP(C2(h_vol(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{424,49},{409,63}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_SteamMP(C1(h_vol(start=2798000),
        h(start=2798000)),C2(h_vol(start=2798000)))
    annotation (Placement(transformation(
        origin={236,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_SteamBP(C2(h_vol(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={514,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_WaterBP(C2(h_vol(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={663.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_WaterBP_Out(C2(h_vol(start=550000),
        h(start=550000))) annotation (Placement(transformation(extent={{687,15},
            {700,27}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_WaterCondenser(C2(h_vol(start=
           194585), h(start=194585))) annotation (Placement(transformation(
        origin={685.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ SensorQ_SteamCondenser(C2(h_vol(start=
           2401000), h(start=2401000))) annotation (Placement(transformation(
        origin={684.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss HP_PressureLoss_2(
    C1(
      P(fixed=true, start=27.267e5),
      h_vol(start=3046000),
      h(start=3046000)),
    K=K_Dp_HP_2,
    Pm(start=2651000)) annotation (Placement(transformation(extent={{114,-120},{
            94,-100}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HP_Turbine_Valve(
    mode=0,
    h(fixed=false, start=3433000),
    Cv(start=10875),
    Pm(fixed=false, start=12550000),
    C1(P(fixed=true, start=126.81e5)),
    Cvmax=Cvmax_THP)
                 annotation (Placement(transformation(extent={{-124,-234},{-104,
            -214}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauHP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{-158,113},{-124,131}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_HP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500,
    minval=0.007) annotation (Placement(transformation(extent={{-40,106},{-20,
            126}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauMP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{173,113},{207,131}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_MP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500) annotation (Placement(transformation(extent={{262,106},{282,126}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauBP(                                                              k=1.75)
    annotation (Placement(transformation(extent={{470,114},{504,132}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_BP(
    add(k1=-1, k2=+1),
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10) annotation (Placement(transformation(extent={{568,108},{588,128}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{704,-246},{740,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
      add(k1=+1, k2=-1)) annotation (Placement(transformation(extent={{758,-282},
            {778,-262}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneHP_Turbine(Table=[0,0.8; 10,0.8; 600,0.8; 650,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-216},{
            -138,-142}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe StopPumpingMp(
    Initialvalue=1400,
    Starttime=200000,
    Duration=800,
    Finalvalue=1300)
                   annotation (Placement(transformation(extent={{944,-16},{906,
            16}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe StopPumpingHP(
    Initialvalue=1400,
    Starttime=2000,
    Duration=1000,
    Finalvalue=700)
                   annotation (Placement(transformation(extent={{945,-82},{907,
            -50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe StopPumpingBP(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{945,-458},{907,
            -426}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeECO_HP1_2(
    mode=1,
    V=1,
    h0=988332,
    h(start=988332),
    P0=70.1e5,
    P(start=13129000),
    dynamic_mass_balance=true)            annotation (Placement(transformation(
          extent={{456,-98},{436,-78}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeECO_HP2_3(
    mode=1,
    V=1,
    h0=983786,
    h(start=983786),
    P0=70.0e5,
    P(start=13219000),
    dynamic_mass_balance=true)            annotation (Placement(transformation(
          extent={{252,-20},{232,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HPIP_FeedValve1(
                          mode=1,
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    C1(h_vol(start=618600)),
    Pm(start=13130000))
                 annotation (Placement(transformation(extent={{754,-98},{730,
            -122}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve HPIP_FeedValve2(
      Pm(start=3126000), mode=1,
    Q(start=10.9, fixed=false),
    h(start=565000),
    C1(h_vol(start=565000)),
    Cv(start=308.931),
    Cvmax=308.931)
                 annotation (Placement(transformation(extent={{804,-138},{780,
            -162}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe StopPumpingMp1(
    Initialvalue=0.8,
    Duration=800,
    Starttime=2000,
    Finalvalue=0.01) annotation (Placement(transformation(extent={{946,-150},{
            908,-118}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe StopPumpingHP1(
    Initialvalue=0.8,
    Duration=800,
    Starttime=2000,
    Finalvalue=0.01) annotation (Placement(transformation(extent={{946,-194},{
            908,-162}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD VolumePreTHP(
    P0=127e5,
    h0=3e6,
    P(start=127e5),
    h(start=3450835.48993987),
    dynamic_mass_balance=true)        annotation (Placement(transformation(
        origin={-52,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeIP(
    h0=3523910,
    h(start=3523910),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=24e5))                        annotation (Placement(transformation(
        origin={-50,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve IP_Turbine_Valve(
    h(fixed=false, start=3518000),
    mode=0,
    Pm(fixed=false, start=2547000),
    Cv(start=3.312e6),
    C1(P(fixed=true, start=25.486e5)),
    Cvmax=Cvmax_TMP)
                 annotation (Placement(transformation(extent={{-124,-318},{-104,
            -298}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneIP_Turbine(Table=[0,0.8; 10,0.8; 600,0.8; 2000,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-300},{
            -138,-226}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(T0={303.16})
    annotation (Placement(transformation(extent={{5,68},{31,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(T0={303.16})
    annotation (Placement(transformation(extent={{326,68},{352,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource2(T0={303.16})
    annotation (Placement(transformation(extent={{585,64},{611,94}}, rotation=0)));

  WaterSteam.Volumes.VolumeA SeparateurMP(h(start=3106000), P(start=27.26e+005),
    rho(start=10))
    annotation (Placement(transformation(
        origin={74,-200},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss HP_PressureLoss_1(
    K=1e-4,
    pro(d(start=10)),
    h(start=3106000),
    C1(
      P(start=27.26e+005),
      h_vol(start=3106000),
      Q(start=153),
      h(start=3106000)),
    C2(
      P(start=27.259e+005),
      h_vol(start=3106000),
      Q(start=153),
      h(start=3106000)),
    Pm(start=2726000)) annotation (Placement(transformation(extent={{88,-182},{102,
            -158}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss HP_IP_PressureLoss(
    Q(fixed=true, start=3.09),
    continuous_flow_reversal=true,
    h(start=3106000),
    C1(
      P(start=27.26e+005),
      h_vol(start=3106000),
      h(start=3106000),
      Q(start=3.09)),
    C2(
      P(start=27.259e+005),
      h_vol(start=3106000),
      h(start=3106000),
      Q(start=3.09)),
    K=K_Dp_HP_IP,
    Pm(start=2726000)) annotation (Placement(transformation(extent={{134,-210},{
            154,-190}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe Q_water(
    Starttime=200,
    Duration=800,
    Initialvalue=21000,
    Finalvalue=15000)
                   annotation (Placement(transformation(extent={{555,-364},{575,
            -344}}, rotation=0)));
  FlueGases.BoundaryConditions.SourceQ SourceFumees(
    Xso2=0,
    T0=893.75,
    Q0=606.94,
    Xco2=0.0604033,
    Xh2o=0.076375,
    Xo2=0.111559)
    annotation (Placement(transformation(extent={{-451,-92},{-349,-8}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps FuelMassFlowRate(Table=[0,
        606.941; 10,606.941; 600,50; 650,50]) annotation (Placement(
        transformation(extent={{-505,-26},{-435,48}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps GasTemperature(Table=[0,
        893.76; 10,893.76; 600,423.16; 650,423.16]) annotation (Placement(
        transformation(extent={{-505,-164},{-435,-90}}, rotation=0)));
equation
  connect(HP_SuperHeater_3.Cws1, HP_SuperHeater_2.Cws2)
    annotation (Line(points={{-294,-30},{-294,-10},{-174,-10},{-174,-30}},
        color={255,0,0}));
  connect(HP_SuperHeater_2.Cws1, HP_SuperHeater_1.Cws2)
    annotation (Line(points={{-174,-70},{-174,-90},{-64,-90},{-64,-70}}, color=
          {255,0,0}));
  connect(HP_SteamValve_Constante.y, HP_SteamValve.Ouv)
    annotation (Line(points={{-28.5,74},{-32,74},{-32,67}}));
  connect(HP_SteamValve.C1, HP_Drum.Cv)
    annotation (Line(points={{-22,50},{-2,50}}, color={255,0,0}));
  connect(HP_DownComer.C1, HP_Drum.Cd)
    annotation (Line(points={{38,-90},{48,-90},{48,10},{38,10}}, color={0,0,0}));
  connect(HP_Drum.Cm, HP_Evaporator.Cws2)
    annotation (Line(points={{-2,10},{-14,10},{-14,-30}}, color={0,0,0}));
  connect(VolumeEvapHP.Cs, HP_Evaporator.Cws1)
    annotation (Line(points={{-12,-90},{-12,-70},{-14,-70}}, color={0,0,0}));
  connect(VolumeEvapHP.Ce1, HP_DownComer.C2)
                                      annotation (Line(points={{8,-90},{18,-90}},
        color={0,0,0}));
  connect(HP_Economizer_4.Cws1, HP_Economizer_3.Cws2)
    annotation (Line(points={{86,-70},{86,-82},{206,-82},{206,-70}}));
  connect(IP_Drum.Cm, IP_Evaporator.Cws2)
    annotation (Line(points={{320,10},{306,10},{306,-30}}, color={0,0,0}));
  connect(IP_Evaporator.Cws1, VolumeEvapMP.Cs)
    annotation (Line(points={{306,-70},{306,-90},{308,-90}}, color={0,0,0}));
  connect(VolumeEvapMP.Ce1, IP_DownComer.C2)
    annotation (Line(points={{328,-90},{338,-90}}, color={0,0,0}));
  connect(IP_SteamValve_Constante.y, IP_SteamValve.Ouv)
    annotation (Line(points={{291.4,75},{288,75},{288,67}}));
  connect(HP_SuperHeater_1.Cfg2, HP_Evaporator.Cfg1)        annotation (Line(
      points={{-54,-50},{-54,-50},{-24,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_Evaporator.Cfg2, HP_Economizer_4.Cfg1)        annotation (Line(
      points={{-4,-50},{96,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_Economizer_4.Cfg2, IP_SuperHeater_1.Cfg1)          annotation (Line(
      points={{76,-50},{136,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_SuperHeater_1.Cfg2, HP_Economizer_3.Cfg1)           annotation (Line(
      points={{156,-50},{196,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_Evaporator.Cfg2, HP_Economizer_2.Cfg1)           annotation (Line(
      points={{316,-50},{396,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_Economizer_2.Cfg2, IP_Economizer.Cfg1)           annotation (Line(
      points={{416,-50},{456,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_Economizer.Cfg2, HP_Economizer_1.Cfg1)           annotation (Line(
      points={{476,-50},{516,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_DownComer.C1, IP_Drum.Cd)
    annotation (Line(points={{358,-90},{368,-90},{368,10},{358,10}}, color={0,0,
          0}));
  connect(IP_SuperHeater_2.Cfg2, HP_SuperHeater_1.Cfg1)          annotation (Line(
      points={{-104,-50},{-74,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_SuperHeater_2.Cfg1, HP_SuperHeater_2.Cfg2)           annotation (Line(
      points={{-124,-50},{-164,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_SuperHeater_3.Cfg2, HP_SuperHeater_2.Cfg1)           annotation (Line(
      points={{-224,-50},{-184,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_SuperHeater_3.Cfg2, IP_SuperHeater_3.Cfg1)           annotation (Line(
      points={{-284,-50},{-244,-50}},
      color={0,0,0},
      thickness=1));
  connect(IP_SuperHeater_3.Cws1,IP_SuperHeater_2. Cws2)
    annotation (Line(points={{-234,-30},{-234,10},{-114,10},{-114,-30}}, color=
          {255,0,0}));
  connect(IP_SuperHeater_1.Cws2, VolumeLP.Ce2) annotation (Line(
      points={{146,-70},{146,-100}},
      color={255,0,0},
      pattern=LinePattern.None));
  connect(LP_SteamValve.C1, LP_Drum.Cv)
    annotation (Line(points={{558,50},{578,50}}, color={255,0,0}));
  connect(LP_Evaporator.Cws1, VolumeEvapBP.Cs)  annotation (Line(points={{566,
          -70},{566,-90},{572,-90}}, color={0,0,0}));
  connect(VolumeEvapBP.Ce1, LP_DownComer.C2)
                                        annotation (Line(points={{592,-90},{600,
          -90}}, color={0,0,0}));
  connect(LP_Drum.Cd, LP_DownComer.C1) annotation (Line(points={{618,10},{628,
          10},{628,-90},{620,-90}}, color={0,0,0}));
  connect(LP_Economizer.Cfg2, SinkP_Gas.C)     annotation (Line(
      points={{690,-50},{712.2,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_Economizer_3.Cfg2, LP_SuperHeater.Cfg1)  annotation (Line(
      points={{216,-50},{256,-50}},
      color={0,0,0},
      thickness=1));
  connect(LP_SuperHeater.Cfg2, IP_Evaporator.Cfg1)  annotation (Line(
      points={{276,-50},{296,-50}},
      color={0,0,0},
      thickness=1));
  connect(HP_Economizer_1.Cfg2, LP_Evaporator.Cfg1) annotation (Line(
      points={{536,-50},{556,-50}},
      color={0,0,0},
      thickness=1));
  connect(LP_Evaporator.Cfg2, LP_Economizer.Cfg1) annotation (Line(
      points={{576,-50},{670,-50}},
      color={0,0,0},
      thickness=1));
  connect(LP_Drum.Cm, LP_Evaporator.Cws2)
    annotation (Line(points={{578,10},{566,10},{566,-30}}, color={0,0,0}));
  connect(IP_SteamValve.C1, IP_Drum.Cv)   annotation (Line(points={{298,50},{
          320,50}}, color={255,0,0}));
  connect(HPIP_FeedValve.Ouv, constante_LP_Drum.y)
    annotation (Line(points={{720,33},{720,38},{727.3,38}}));
  connect(HP_SuperHeater_3.Cws2, DoubleDebitHP.Ce)
    annotation (Line(points={{-294,-70},{-294,-80},{-292,-80},{-292,-90}},
        color={255,0,0}));
  connect(IP_SuperHeater_3.Cws2, DoubleDebitMP.Ce)
    annotation (Line(points={{-234,-70},{-234,-80},{-232,-80},{-232,-90}},
        color={255,0,0}));
  connect(VolumeCond1.Cs, Dp_Cond_Out2.C1)
    annotation (Line(points={{902,-308},{902,-282}}, color={0,0,255}));
  connect(HPIP_FeedValve.C2, VolumeAlimMPHP.Ce1)
                                               annotation (Line(points={{730,16},
          {742,16}}, color={0,0,255}));
  connect(LP_SuperHeater.Cws2, DoubleDebitBP.Ce)
    annotation (Line(points={{266,-70},{266,-90}}, color={255,0,0}));
  connect(DP_IP_Pump.C2, IP_Pump.C1)
    annotation (Line(points={{790,16},{798,15},{804,16}}, color={0,0,255}));
  connect(VolumeAlimMPHP.Cs1, DP_IP_Pump.C1) annotation (Line(points={{762,16},{
          766,15},{766,16},{770,16}}, color={0,0,255}));
  connect(VolumeAlimMPHP.Cs2, DP_HP_Pump.C1)
    annotation (Line(points={{752,6},{752,-36},{770,-36}}, color={0,0,255}));
  connect(DP_HP_Pump.C2, HP_Pump.C1)
    annotation (Line(points={{790,-36},{804,-36}}, color={0,0,255}));
  connect(VolumeIP1.Ce2, Dp_LP_Turbine.C2) annotation (Line(points={{418,-239},{
          418,-278},{354,-278}}, color={255,0,0}));
  connect(Dp_Cond_Out.C2, LP_Pump.C1)
    annotation (Line(points={{722,-436},{742,-436}}, color={0,0,255}));
  connect(ExtractionValve.C2, Dp_Cond_Out1.C1)
    annotation (Line(points={{822,-436},{840,-436}}, color={0,0,255}));
  connect(HP_FeedValve.C1, SensorQ_WaterHP.C2)
    annotation (Line(points={{78,50},{86.3,50},{86.3,38.12}}));
  connect(HP_SteamValve.C2, SensorQ_SteamHP.C1) annotation (Line(points={{
          -42,50},{-53.2,50},{-53.2,14}}, color={255,0,0}));
  connect(SensorQ_SteamHP.C2, HP_SuperHeater_1.Cws1) annotation (Line(points={{-53.2,
          1.88},{-53.2,-3.06},{-64,-3.06},{-64,-30}},        color={255,0,0}));
  connect(IP_FeedValve.C1, SensorQ_WaterMP.C2)
    annotation (Line(points={{398,50},{403.425,50},{403.425,50.4},{408.85,50.4}}));
  connect(SensorQ_SteamMP.C1, IP_SteamValve.C2) annotation (Line(points={{
          244,49.6},{260,49.6},{260,50},{278,50}}, color={255,0,0}));
  connect(SensorQ_SteamMP.C2, IP_SuperHeater_1.Cws1) annotation (Line(points={
          {227.84,49.6},{146,49.6},{146,-30}}, color={255,0,0}));
  connect(SensorQ_SteamBP.C2, LP_SuperHeater.Cws1) annotation (Line(points={{
          505.84,49.6},{490,49.6},{490,-2},{266,-2},{266,-30}}, color={255,0,0}));
  connect(SensorQ_SteamBP.C1, LP_SteamValve.C2) annotation (Line(points={{
          522,49.6},{530,49.6},{530,50},{538,50}}, color={255,0,0}));
  connect(SensorQ_WaterBP.C2, LP_FeedValve.C1) annotation (Line(
        points={{658.3,40.12},{658.3,50},{650,50}}, color={0,0,255}));
  connect(SensorQ_WaterBP_Out.C2, HPIP_FeedValve.C1) annotation (Line(points={{700.13,
          16.2},{705.065,16.2},{705.065,16},{710,16}}, color={0,0,255}));
  connect(SensorQ_WaterCondenser.C2, Dp_Cond_Out.C1) annotation (Line(points={{680.3,
          -422.2},{680.3,-436},{702,-436}}, color={0,0,255}));
  connect(Dp_Cond_In.C2, SensorQ_SteamCondenser.C1) annotation (Line(points={{660,
          -230},{679.3,-230},{679.3,-254}}, color={255,0,0}));
  connect(VolumeLP.Ce1, MoitieDebitHP.Cs)
    annotation (Line(points={{146,-120},{146,-170},{134,-170}}, color={255,0,0}));
  connect(Dp_Cond_Out1.C2, MoitieDebitBP.Ce) annotation (Line(points={{860,-436},
          {862,-436},{862,-318},{872,-318}}, color={0,0,255}));
  connect(MoitieDebitBP.Cs, VolumeCond1.Ce3) annotation (Line(points={{886,-318},
          {892,-318}}, color={0,0,255}));
  connect(IP_SuperHeater_2.Cws1, HP_PressureLoss_2.C2) annotation (Line(points={{-114,-70},
          {-114,-110},{94,-110}}, color={255,0,0}));
  connect(HP_PressureLoss_2.C1, VolumeLP.Cs2)
    annotation (Line(points={{114,-110},{136.2,-110}}, color={255,0,0}));
  connect(DoubleDebitHP.Cs, HP_Turbine_Valve.C1) annotation (Line(points=
          {{-292,-110},{-292,-230},{-124,-230}}, color={255,0,0}));
  connect(DoubleDebitBP.Cs, Dp_LP_Turbine.C1) annotation (Line(points={{266,-110},
          {266,-278},{334,-278}}, color={255,0,0}));
  connect(LP_Pump.C2, ExtractionValve.C1)
    annotation (Line(points={{762,-436},{802,-436}}, color={0,0,255}));
  connect(HP_Drum.yLevel,regulation_Niveau_HP. MesureNiveauEau)
    annotation (Line(points={{-4,30},{-68,30},{-68,125},{-40.5,125}}));
  connect(regulation_Niveau_HP.SortieReelle1, HP_FeedValve.Ouv)
    annotation (Line(points={{-19.5,107},{68,107},{68,67}}));
  connect(ConsigneNiveauEauMP.y,regulation_Niveau_MP. ConsigneNiveauEau)
    annotation (Line(
      points={{208.7,122},{234,122},{234,110},{261.5,110}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(IP_Drum.yLevel,regulation_Niveau_MP. MesureNiveauEau)
    annotation (Line(points={{318.1,30},{252,30},{252,125},{261.5,125}}));
  connect(regulation_Niveau_MP.SortieReelle1, IP_FeedValve.Ouv)
    annotation (Line(points={{282.5,107},{377.25,107},{377.25,67},{388,67}}));
  connect(ConsigneNiveauEauBP.y,regulation_Niveau_BP. ConsigneNiveauEau)
    annotation (Line(
      points={{505.7,123},{529.85,123},{529.85,112},{567.5,112}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(LP_Drum.yLevel,regulation_Niveau_BP. MesureNiveauEau)
    annotation (Line(points={{576,30},{518,30},{518,127},{567.5,127}}));
  connect(ConsigneNiveauCondenseur1.y, regulation_Niveau_Condenseur.ConsigneNiveauEau)
    annotation (Line(
      points={{741.8,-238},{752,-238},{752,-269},{757.5,-269}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(regulation_Niveau_Condenseur.SortieReelle1, ExtractionValve.Ouv)
    annotation (Line(points={{778.5,-281},{812,-281},{812,-419}}));
  connect(SensorQ_WaterBP.C1, LP_Economizer.Cws2)
    annotation (Line(points={{658.3,28},{660,28},{660,6},{680,6},{680,-30}}));
  connect(LP_Economizer.Cws1, Dp_Cond_Out2.C2)
    annotation (Line(points={{680,-70},{680,-186},{902,-186},{902,-258}}));
  connect(SensorQ_SteamCondenser.Measure, regulation_Niveau_Condenseur.MesureDebitVapeur)
    annotation (Line(points={{691.13,-264},{704,-264},{704,-280.9},{757.6,-280.9}}));
  connect(regulation_Niveau_Condenseur.MesureDebitEau, SensorQ_WaterCondenser.Measure)
    annotation (Line(points={{757.45,-274.95},{750,-274.95},{750,-310},{792,-310},
          {792,-412},{692.13,-412}}));
  connect(ConstantVanneHP_Turbine.y, HP_Turbine_Valve.Ouv)
    annotation (Line(points={{-134.5,-179},{-114,-179},{-114,-213}}));
  connect(regulation_Niveau_BP.SortieReelle1, LP_SteamValve.Ouv)
    annotation (Line(points={{588.5,109},{600,109},{600,90},{548,90},{548,67}}));
  connect(LP_FeedValve.Ouv, LP_SteamValve_Constante.y)
    annotation (Line(points={{640,67},{640,81},{653.4,81}}));
  connect(HP_Economizer_1.Cws2, VolumeECO_HP1_2.Ce1) annotation (Line(points={{
          526,-70},{526,-88},{456,-88}}, color={0,0,255}));
  connect(VolumeECO_HP1_2.Cs, HP_Economizer_2.Cws1) annotation (Line(points={{
          436,-88},{406,-88},{406,-70}}, color={0,0,255}));
  connect(HP_Economizer_2.Cws2, VolumeECO_HP2_3.Ce1) annotation (Line(points={{
          406,-30},{406,-10},{252,-10}}, color={0,0,255}));
  connect(VolumeECO_HP2_3.Cs, HP_Economizer_3.Cws1) annotation (Line(points={{
          232,-10},{206,-10},{206,-30}}, color={0,0,255}));
  connect(HPIP_FeedValve1.C1, HP_Pump.C2)
    annotation (Line(points={{754,-102.8},{842,-102.8},{842,-36},{824,-36}}));
  connect(IP_Pump.C2, HPIP_FeedValve2.C1) annotation (Line(points={
          {824,16},{870,16},{870,-142.8},{804,-142.8}}, color={0,0,255}));
  connect(StopPumpingMp1.y, HPIP_FeedValve1.Ouv)
    annotation (Line(
      points={{906.1,-134},{856,-134},{856,-122},{742,-122},{742,-123.2}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(StopPumpingHP1.y, HPIP_FeedValve2.Ouv)
    annotation (Line(
      points={{906.1,-178},{883.05,-178},{883.05,-163.2},{792,-163.2}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(HPIP_FeedValve1.C2, HP_Economizer_1.Cws1) annotation (Line(
        points={{730,-102.8},{636,-102.8},{636,-106},{548,-106},{548,-6},{526,
          -6},{526,-30}}, color={0,0,255}));
  connect(IP_Economizer.Cws1, HPIP_FeedValve2.C2)
    annotation (Line(points={{466,-70},{466,-142.8},{780,-142.8}}));
  connect(ConstantVanneIP_Turbine.y, IP_Turbine_Valve.Ouv)
    annotation (Line(points={{-134.5,-263},{-114,-263},{-114,-297}}));
  connect(HP_Turbine_Valve.C2, VolumePreTHP.Ce) annotation (Line(points={
          {-104,-230},{-62,-230}}, color={255,0,0}));
  connect(DoubleDebitMP.Cs, IP_Turbine_Valve.C1) annotation (Line(points=
          {{-232,-110},{-232,-314},{-124,-314}}, color={255,0,0}));
  connect(IP_Turbine_Valve.C2, VolumeIP.Ce1) annotation (Line(
        points={{-104,-314},{-60,-314}}, color={255,0,0}));
  connect(SourceCaloporteur.C, Condenser.Cee) annotation (Line(points={{620,-353},
          {638,-353},{638,-352},{639,-352.8}}, color={0,0,255}));
  connect(Condenser.Cse, PuitsCaloporteur.C)
    annotation (Line(points={{719,-352},{736,-352}}, color={0,0,255}));
  connect(SensorQ_SteamCondenser.C2, Condenser.Cv) annotation (Line(points={{679.3,
          -274.2},{679.3,-288.1},{679,-288.1},{679,-304}}, color={0,0,255}));
  connect(SensorQ_WaterCondenser.C1, Condenser.Cl)
    annotation (Line(points={{680.3,-402},{679.8,-402},{679.8,-384}}));
  connect(ConsigneNiveauEauHP.y, regulation_Niveau_HP.ConsigneNiveauEau)
    annotation (Line(
      points={{-122.3,122},{-100,122},{-100,110},{-40.5,110}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(Condenser.yNiveau, regulation_Niveau_Condenseur.MesureNiveauEau)
    annotation (Line(points={{723,-372.8},{780,-372.8},{780,-326},{732,-326},{732,
          -263},{757.5,-263}}));
  connect(LP_Drum.Cs, SensorQ_WaterBP_Out.C1) annotation (Line(points={{578,22},
          {564,22},{564,16},{642,16},{642,16.2},{687,16.2}}, color={0,0,255}));
  connect(LP_Drum.Ce1, LP_FeedValve.C2)
    annotation (Line(points={{618,50},{630,50}}));
  connect(IP_Drum.Ce1, IP_FeedValve.C2)
    annotation (Line(points={{358,50},{378,50}}));
  connect(HP_Drum.Ce1, HP_FeedValve.C2)
    annotation (Line(points={{38,50},{58,50}}));
  connect(VolumePreTHP.Cs3, HP_Turbine.Ce) annotation (Line(points={{-42,-230},{
          -2.2,-230}}, color={255,0,0}));
  connect(VolumeIP.Cs, IP_Turbine.Ce) annotation (Line(points={{-40,-314},
          {106,-314},{106,-230},{317.8,-230}}, color={255,0,0}));
  connect(IP_Turbine.Cs, VolumeIP1.Ce1) annotation (Line(points={{358.2,
          -230},{408,-230}}, color={255,0,0}));
  connect(VolumeIP1.Cs, LP_Turbine.Ce) annotation (Line(points={{428,
          -230},{575.8,-230}}, color={255,0,0}));
  connect(LP_Turbine.Cs, Dp_Cond_In.C1)
    annotation (Line(points={{616.2,-230},{640,-230}}, color={255,0,0}));
  connect(IP_Economizer.Cws2, SensorQ_WaterMP.C1) annotation (Line(points={{
          466,-30},{470,-30},{470,50.4},{424,50.4}}, color={0,0,255}));
  connect(IP_Turbine.MechPower, Alternateur.Wmec2)
    annotation (Line(points={{360,-248},{368,-248},{368,-378},{402,-378}}));
  connect(LP_Turbine.MechPower, Alternateur.Wmec1) annotation (Line(points={{618,
          -248},{628,-248},{628,-290},{388,-290},{388,-358},{402,-358}}));
  connect(HP_Turbine.MechPower, Alternateur.Wmec3)
    annotation (Line(points={{40,-248},{48,-248},{48,-398},{402,-398}}));
  connect(heatSource.C[1], HP_Drum.Cex) annotation (Line(points={{18,68.3},{18,
          50}}, color={191,95,0}));
  connect(heatSource1.C[1], IP_Drum.Cex) annotation (Line(points={{339,68.3},{
          339,50}}, color={191,95,0}));
  connect(heatSource2.C[1], LP_Drum.Cex) annotation (Line(points={{598,64.3},{
          598,50}}, color={191,95,0}));
  connect(SensorQ_WaterHP.C1, HP_Economizer_4.Cws2)
    annotation (Line(points={{86.3,26},{86,26},{86,-30}}, smooth=Smooth.None));
  connect(IP_Pump.rpm_or_mpower, StopPumpingMp.y)
    annotation (Line(
      points={{814,5},{814,0},{904.1,0}},
      color={0,0,0},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(HP_Pump.rpm_or_mpower, StopPumpingHP.y)
    annotation (Line(
      points={{814,-47},{814,-66},{905.1,-66}},
      color={0,0,0},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(LP_Pump.rpm_or_mpower, StopPumpingBP.y) annotation (Line(
      points={{752,-447},{754,-447},{754,-456},{878,-456},{878,-442},{905.1,-442}},
      color={0,0,0},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));

  connect(HP_Turbine.Cs,SeparateurMP. Ce1)   annotation (Line(points={{38.2,-230},
          {74,-230},{74,-210}}, color={255,0,0}));
  connect(SeparateurMP.Cs1, HP_PressureLoss_1.C1)
    annotation (Line(points={{74,-190},{74,-170},{88,-170}}, color={255,0,0}));
  connect(HP_PressureLoss_1.C2, MoitieDebitHP.Ce)
    annotation (Line(points={{102,-170},{114,-170}}, color={0,0,255}));
  connect(SeparateurMP.Cs2, HP_IP_PressureLoss.C1)
    annotation (Line(points={{84,-200},{134,-200}}, color={255,0,0}));
  connect(HP_IP_PressureLoss.C2, VolumeIP1.Ce3) annotation (Line(points={{154,-200},
          {418,-200},{418,-220}}, color={255,0,0}));
  connect(Q_water.y, SourceCaloporteur.IMassFlow)
    annotation (Line(points={{576,-354},{582,-354},{582,-341},{596,-341}}));
  connect(GasTemperature.y, SourceFumees.ITemperature)
    annotation (Line(points={{-431.5,-127},{-400,-127},{-400,-71}}));
  connect(FuelMassFlowRate.y, SourceFumees.IMassFlow)
    annotation (Line(points={{-431.5,11},{-400,11},{-400,-29}}));
  connect(SourceFumees.C, HP_SuperHeater_3.Cfg1) annotation (Line(
      points={{-349,-50},{-327.5,-50},{-327.5,-50},{-304,-50}},
      color={0,0,0},
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-550,
            -460},{950,150}},
        initialScale=0.1), graphics={
        Text(
          extent={{-507,-25},{-469,-51}},
          lineColor={255,0,0},
          textString=
               "GT"),
        Text(
          extent={{-517,-45},{-411,-72}},
          lineColor={255,0,0},
          textString=
               "Exhaust")}), experiment(StopTime=10000),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni</li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"),
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
end GasTurbineTrip;
