within ThermoSysPro.Examples.CombinedCyclePowerPlant;
model CombinedCycle_TripTAC
  "CCPP model to simulate a load variation from 100% to 50%"
  parameter Real CstHP(fixed=false,start=7618660.65374636)
    "Stodola's ellipse coefficient HP";
  parameter Real CstMP(fixed=false,start=278905.664031036)
    "Stodola's ellipse coefficient MP";
  parameter Real CstBP(fixed=false,start=13491.6445678148)
    "Stodola's ellipse coefficient BP";
  parameter ThermoSysPro.Units.Cv CvmaxValveAHP(fixed=false,start=135)
    "Maximum CV: alim. valve HP Drum  ";
  parameter ThermoSysPro.Units.Cv CvmaxValveAMP(fixed=false,start=70)
    "Maximum CV: alim. valve MP Drum ";
  parameter ThermoSysPro.Units.Cv CvmaxValveVBP(fixed=false,start=32000)
    "Maximum CV: steam valve BP Drum ";
  parameter Real Encras_SHP1(fixed=false,start=1)
    "Sur HP1: heat exchange fouling coefficient";
  parameter Real Encras_SHP2(fixed=false,start=1)
    "Sur HP2: heat exchange fouling coefficient";
  parameter Real Encras_SHP3(fixed=false,start=1)
    "Sur HP3: heat exchange fouling coefficient";
  parameter Real Encras_EHP1(fixed=false,start=1)
    "Eco HP1: heat exchange fouling coefficient";
  parameter Real Encras_EHP2(fixed=false,start=1)
    "Eco HP2: heat exchange fouling coefficient";
  parameter Real Encras_EHP3(fixed=false,start=1)
    "Eco HP3: heat exchange fouling coefficient";
  parameter Real Encras_EHP4(fixed=false,start=1)
    "Eco HP4: heat exchange fouling coefficient";

  parameter Real Encras_SMP1(fixed=false,start=1)
    "Sur MP1: heat exchange fouling coefficient";
  parameter Real Encras_SMP2(fixed=false,start=1)
    "Sur MP2: heat exchange fouling coefficient";
  parameter Real Encras_SMP3(fixed=false,start=1)
    "Sur MP3: heat exchange fouling coefficient";
  parameter Real Encras_EMP(fixed=false,start=1)
    "Eco MP: heat exchange fouling coefficient";

  parameter Real Encras_EvHP(fixed=false,start=1)
    "Evapo HP: heat exchange fouling coefficient";
  parameter Real Encras_EvMP(fixed=false,start=1)
    "Evapo MP: heat exchange fouling coefficient";
  parameter Real Encras_EvBP(fixed=false,start=1)
    "Evapo BP: heat exchange fouling coefficient";

  parameter Real Encras_SBP(fixed=false,start=1)
    "Sur BP: heat exchange fouling coefficient";
  parameter Real Encras_EBP(fixed=false,start=1)
    "Eco BP: heat exchange fouling coefficient";

  parameter Real KgainChargeHP(fixed=false,start=720.183)
    "HP: Friction pressure loss coefficient";
  parameter Real KgainChargeMP(fixed=false,start=1090.9)
    "MP: Friction pressure loss coefficient";
  parameter Real Kin_SMP2(fixed=false,start=10.)
    "SMPin: Friction pressure loss coefficient";
  parameter Real K_PerteChargeZero2(fixed=false,start=1e-4)
    "TurbineMP out: Friction pressure loss coefficient";

  parameter ThermoSysPro.Units.Cv Cvmax_THP(fixed=false,start=8000)
    "Maximum CV input Turbine HP ";
  parameter ThermoSysPro.Units.Cv Cvmax_TMP(fixed=false,start=1500)
    "Maximum CV input Turbine MP ";

  ThermoSysPro.WaterSteam.Volumes.DynamicDrum BallonHP(
    L=16.27,
    Vertical=false,
    hl(fixed=false, start=1474422.14552527),
    hv(fixed=false, start=2666558.75582585),
    Vv(fixed=false),
    R=1.05,
    xmv(fixed=false),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    P(fixed=false, start=12703151.296069),
    Pfond(start=12703151.3),
    Tp(start=596.92486029448))
                     annotation (Placement(transformation(extent={{5,10},{-35,
            50}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationHP(
      Cvmax=CvmaxValveAHP,
    C1(P(start=12721657.0), h_vol(start=1396865.59043578)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))
                 annotation (Placement(transformation(extent={{45,46},{25,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurHP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{-51,70},{-61,78}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurHP(
    Cvmax=47829.4,
    mode=0,
    C2(h_vol(start=2666558.75582585)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12721657.16928))
                 annotation (Placement(transformation(extent={{-55,46},{-75,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss GainChargeHP(
    z2=0,
    mode=1,
    Q(start=150, fixed=true),
    z1=10.83,
    K=KgainChargeHP,
    C2(P(start=12768600.0)),
    h(start=1474422.14552527),
    Pm(start=12704000))
            annotation (Placement(transformation(
        origin={-5,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapHP(mode=1, V=5,
    h(start=1474422.14552527),
    P(start=12704000))                     annotation (Placement(transformation(
          extent={{-25,-100},{-45,-80}},
                                       rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EvaporateurHP(
    Dint=32.8e-3,
    Ntubes=1476,
    L=20.7,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-5.74e7,-2.67e7,-1.24e7}),
      Tp(start={607.668721736158,605.187884376142,603.825778846274}),
      Tp1(start={606.357,604.602,603.578})),
    Ns=3,
    ExchangerFlueGasesMetal(
      Dext=0.038,
      step_L=0.092,
      step_T=0.0869,
      St=1,
      Fa=1,
      K(fixed=true, start=37.69),
      CSailettes=11.86442072,
      p_rho=1.05,
      Encras=Encras_EvHP,
      DeltaT(start={106,49,23}),
      T(start={755.54821777344,673.68082608925,635.57157972092,618.19360351563}),
      Tm(start={643.15,633.15,626.621}),
      Tp(start={609.11670087771,605.86035558168,604.13687003529})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=10.83,
      option_temperature=2,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={5.74e7,2.67e7,1.24e7}),
      h(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134,
            1459929.875}),
      hb(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134}),
      P(start={12758125,12740000,12734000,12730000,12726787})))
                          annotation (Placement(transformation(
        origin={-47,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurHP4(
    Ns=3,
    L=20.726,
    Dint=0.0266,
    Ntubes=246,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-3.5e6,-2.63e6,-2e6}),
      Tp(start={576.803345033827,581.933438017921,585.694098500999}),
      Tp1(start={575.762,580.856,584.579})),
    Cws1(P(start=13703700.0), h_vol(start=1306078.18827954)),
    Cws2(h_vol(start=1406865.59043578)),
    ExchangerFlueGasesMetal(
      Dext=0.0318,
      step_L=0.111,
      step_T=0.0869,
      St=1,
      Fa=1,
      CSailettes=11.39069779,
      K(fixed=true, start=47.53),
      p_rho=1.06,
      Encras=Encras_EHP4,
      DeltaT(start={38,29,22}),
      T(start={618.19360351563,612.7722894387,608.97249438439,606.41162109375}),
      Tm(start={623.15,613.15,607.844}),
      Tp(start={577.44979072627,582.41942947968,586.06092597683})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      z2=0,
      option_temperature=2,
      inertia=true,
      dW1(start={3.5e6,2.63e6,2e6}),
      h(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578,
            1398251.0}),
      hb(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578}),
      P(start={13301176,13320000,13338000,13357000,13374658})))
                          annotation (Placement(transformation(
        origin={53,-50},
        extent={{20,-20},{-20,20}},
        rotation=270)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurHP1(
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
      K(fixed=true, start=34.71),
      p_rho=1.04,
      Encras=Encras_SHP1,
      DeltaT(start={138,108,84}),
      T(start={788.2431640625,774.65344332519,763.17487871399,755.54821777344}),
      Tm(start={778.15,768.15,759.527}),
      Tp(start={631.68675322573,653.38616970968,672.36458008039})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      option_temperature=2,
      inertia=true,
      dW1(start={9.8e6,7.7e6,5.9e6}),
      h(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983,
            2973076.25}),
      hb(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983}),
      P(start={12723762,12723600,12723500,12720000,12719000})))
                          annotation (Placement(transformation(
        origin={-87,-50},
        extent={{-20,20},{20,-20}},
        rotation=270)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurHP3(
    Dint=26.6e-3,
    Ntubes=1476,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
          dW1(start={-1.6e7,-5.6e6,-2.1e6}),
      Tp(start={556.530623976228,563.226831750573,565.575075374951}),
      Tp1(start={555.49,562.473,564.857})),
    L=20.726,
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=12.451,
      K(fixed=true, start=36.0300000000857),
      p_rho=1.08,
      Encras=Encras_EHP3,
      St=5, DeltaT(start={34,12,4.4}),
      T(start={602.67193603516,579.67183226637,571.50875350574,568.81030273438}),
      Tm(start={593.15,583.15,571.919}),
      Tp(start={557.01185690541,563.39937105652,565.63731055685})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={1.6e7,5.6e6,2.1e6}),
      h(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855,
            1291418.875}),
      hb(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855}),
      P(start={13219333,13241000,13261000,13282000,13301176})))
                  annotation (Placement(transformation(
        origin={173,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurHP2(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-5e6,-3e6,-2.e6}),
      Tp(start={490.631370193221,498.229397165878,502.978053774656}),
      Tp1(start={490,497.024,501.871})),
    L=20.767,
    Ntubes=1107,
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=111e-3,
      CSailettes=2.76134577,
      K(fixed=true, start=65.5300000000393),
      p_rho=1.11,
      Encras=Encras_EHP2,
      St=5, DeltaT(start={36,23,14}),
      T(start={531.16070556641,523.74706132958,519.01561663699,516.31256103516}),
      Tm(start={538.15,528.15,521.399}),
      Tp(start={490.84070882241,498.36081646341,503.06064272486})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={5e6,3e6,2.e6}),
      h(start={854494.5625,915007.018247822,957243.396653824,983786.364226731,
            986348.9375}),
      hb(start={854494.5625,915007.018247822,957243.396653824,983786.364226731}),
      P(start={13129352,13152000,13175000,13197000,13219333})))
                  annotation (Placement(transformation(
        origin={373,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurHP1(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-9.9999e6,-5e6,-2.4e6}),
      Tp(start={458.958585923538,468.506814782426,473.132256983258}),
      Tp1(start={458.001,467.576,472.607})),
    L=20.726,
    Ntubes=1107,
    Cws1(h_vol(start=723821.0)),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=8.30057632,
      K(fixed=true, start=40.24),
      p_rho=1.13,
      Encras=Encras_EHP1,
      St=5,   DeltaT(start={41,20,10}),
      T(start={509.31488037109,491.44087131458,484.15889910859,482.59533691406}),
      Tm(start={503.15,498.15,494.131}),
      Tp(start={459.37586976399,468.70800090382,473.22896941053})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      z1=10.767,
      inertia=true,
      dW1(start={9.9999e6,5e6,2.4e6}),
      h(start={618651.9375,752176.893518976,816707.727773953,847728.424287614,
            854494.5625}),
      hb(start={618651.9375,752176.893518976,816707.727773953,847728.424287614}),
      advection=true,
      dynamic_mass_balance=true,
      P(start={13034956,13060000,13080000,13100000,13129352})))
                  annotation (Placement(transformation(
        origin={493,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurHP2(
    Ns=3,
    L=20.4,
    Dint=32e-3,
    Ntubes=246,
    ExchangerWall(e=3e-3, lambda=27,
          dW1(start={-8.8e6,-6.6e6,-4.9e6}),
      Tp(start={714.604505161814,740.492493660215,759.200099714419}),
      Tp1(start={710.485,734.082,752.527})),
    Cws2(P(start=127113000.0), h_vol(start=3254970.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      K(fixed=true, start=34.74),
      CSailettes=10.2505424803872,
      p_rho=1.02,
      Encras=Encras_SHP2,
      St=5,
      DeltaT(start={124,93,70}),
      T(start={850.64624023438,839.40882309811,830.36536707939,822.68170166016}),
      Tm(start={843.15,833.15,825.24}),
      Tp(start={717.48312916257,742.56566858011,760.69152533026})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.83,
      inertia=true,
      dW1(start={8.8e6,6.6e6,4.9e6}),
      h(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722,
            3240813.5}),
      hb(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722}),
      P(start={12720371,12718000,12716000,12714000,12711007})))
                  annotation (Placement(transformation(
        origin={-207,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurHP3(
    Ns=3,
    L=20.4,
    Ntubes=246,
    ExchangerWall(lambda=27, e=5e-3,
    dW1(start={-6.3e6,-4.7e6,-3.6e6}),
      Tp(start={793.335674512128,811.477076678823,824.721389633254}),
      Tp1(start={783.815,803.639,818.56})),
    Dint=28e-3,
    Cws2(h_vol(start=3446260.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=111e-3,
      K(fixed=true, start=49.33),
      CSailettes=6.59672842597229,
      p_rho=1,
      Encras=Encras_SHP3,
      St=5,
      DeltaT(start={97,73,55}),
      T(start={894.21850585938,885.5393240412,879.47464880089,874.32891845703}),
      Tm(start={893.15,883.15,875.939}),
      Tp(start={796.82789474964,814.05266276572,826.6253996051})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.726,
      inertia=true,
      dW1(start={6.3e6,4.7e6,3.6e6}),
      h(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987,
            3433271.25}),
      hb(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987}),
      P(start={12711007,12704000,12697000,12689000,12681000})))
                  annotation (Placement(transformation(
        origin={-327,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Volumes.DynamicDrum BallonMP(
    L=16.27,
    Vertical=false,
    P0=27.29e5,
    hl(fixed=false, start=978914.570821827),
    hv(fixed=false, start=2799158.13966473),
    Vv(fixed=false),
    R=1.05,
    P(fixed=false, start=2732895.21562269),
    zl(start=1.05, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=2732995.0),
    Tp(start=500.955757665063))
                     annotation (Placement(transformation(extent={{325,10},{287,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurMP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{271,70},{259,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationMP(
      Cvmax=CvmaxValveAMP,
    C1(P(start=2752995.0), h_vol(start=892414.570867188)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2975000))
                 annotation (Placement(transformation(extent={{365,46},{345,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurMP(
    Cvmax=47829.4,
    mode=0,
    C2(h_vol(start=2799158.13966473)),
    h(fixed=false, start=2798000),
    Cv(start=23914.7),
    Pm(fixed=false, start=2731689.4244255))
                 annotation (Placement(transformation(extent={{265,46},{245,66}},
          rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EvaporateurMP(
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
      P(start={2773367.5,2754933.93610513,2745233.82043873,2738517.46232967,2733824.75}),
      h(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464,980708.125}),
      hb(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464})),
    Cws1(P(start=2773640.0)),
    ExchangerFlueGasesMetal(
      K(fixed=true, start=30.22),
      Dext=38e-3,
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=10.0676093,
      p_rho=1.1,
      Encras=Encras_EvMP,
      St=5,
      DeltaT(start={53,41,32}),
      T(start={565.24822998047,551.20973998682,539.98034586472,531.16070556641}),
      Tm(start={553.15,543.15,536.901}),
      Tp(start={505.45492567199,504.57970000924,503.89762940507})))
                          annotation (Placement(transformation(
        origin={273,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss GainChargeMP(
    z2=0,
    z1=10.83,
    mode=1,
    Q(start=150, fixed=true),
    K=KgainChargeMP,
    Pm(start=2734000),
    h(start=978914.570821827))
            annotation (Placement(transformation(
        origin={315,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapMP(mode=1, V=5,
    h(start=978914.570821827),
    P(start=2734000))                      annotation (Placement(transformation(
          extent={{295,-100},{275,-80}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurMP(
    ExchangerWall(e=2.6e-3, lambda=47,
        dW1(start={-3e6,-1.4e6,-740379}),
      Tp(start={457.584681885759,475.409334769727,486.332585528225}),
      Tp1(start={456.76,474.926,485.122})),
    L=20.726,
    Ns=3,
    Dint=26.6e-3,
    Ntubes=246,
    Cws1(h_vol(start=671235.0)),
    Cws2(h_vol(start=977376.0)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      K(fixed=true, start=47.78),
      CSailettes=7.16188651,
      p_rho=1.12,
      Encras=Encras_EMP,
      St=5,
      DeltaT(start={45,24,13}),
      T(start={516.31256103516,511.25046295073,508.31162431247,509.31488037109}),
      Tm(start={533.15,523.15,514.647}),
      Tp(start={458.18343678065,475.77644311925,486.55770446184})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.767,
      z2=0,
      inertia=true,
      dW1(start={3e6,1.4e6,740379}),
      h(start={565108.5,727745.440528479,829820.124314816,892414.570867187,
            944505.4375}),
      hb(start={565108.5,727745.440528479,829820.124314816,892414.570867187}),
      P(start={3124229.75,3148000,3172000,3195000,3216977.75})))
                          annotation (Placement(transformation(
        origin={433,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurMP1(
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.3e6,-0.80263e6,
                                -501864}),
      Tp(start={557.102699668877,574.070651369638,584.64928514972}),
      Tp1(start={556.102699668877,573.070651369638,583.64928514972})),
    L=20.726,
    Ns=3,
    Dint=32.8e-3,
    Ntubes=123,
    Cws1(h_vol(start=2800000.0)),
    ExchangerFlueGasesMetal(
      step_L=111e-3,
      step_T=86.9e-3,
      Fa=1,
      Dext=31.8e-3,
      K(fixed=true, start=22.09),
      CSailettes=14.46509765,
      p_rho=1.07,
      Encras=Encras_SMP1,
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
      inertia=true,
      dW1(start={1.3e6,0.80263e6,501864}),
      h(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156,
            3040562.25}),
      hb(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156}),
      P(start={2731326.25,2729591.6901521,2728654.3204706,2727686.1714029,
            2726700})))   annotation (Placement(transformation(
        origin={113,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Volumes.VolumeB MelangeurHPMP(
    Ce1(h(start=3091610.0)),
    h(start=3042573.51976705),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={115,-110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurMP2(
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
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=92e-3,
      K(fixed=true, start=45.22),
      CSailettes=5.814209831,
      p_rho=1.03,
      Encras=Encras_SMP2,
      St=5,
      DeltaT(start={125,86,60}),
      T(start={822.68170166016,807.90772072705,797.00284433443,788.2431640625}),
      Tm(start={813.15,803.15,792.527}),
      Tp(start={690.93545553661,717.24269857866,735.18209370035})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={1.15e7,7.9e6,5.5e6}),
      h(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389,
            3321940.75}),
      hb(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389}),
      P(start={2575582.5,2572000,2568000,2563000,2558239})))
                          annotation (Placement(transformation(
        origin={-147,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurMP3(
    Ns=3,
    L=20.4,
    Ntubes=369,
    Dint=45.6e-3,
    ExchangerWall(e=2.6e-3, lambda=27,
    dW1(start={-8e6,-5.5e6,-3.8e6}),
      Tp(start={788.901616786331,805.674094596818,817.083010473709}),
      Tp1(start={786.717,804.102,815.901})),
    Cws2(h_vol(start=3529920.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      step_L=92e-3,
      Dext=50.8e-3,
      K(fixed=true, start=43.23),
      CSailettes=5.695842178,
      p_rho=1.01,
      Encras=Encras_SMP3,
      St=5,
      DeltaT(start={82,56,38}),
      T(start={874.32891845703,864.2444076086,856.92248545484,850.64624023438}),
      Tm(start={873.15,863.15,853.059}),
      Tp(start={789.92521486539,806.37044583028,817.55662835373})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={8e6,5.5e6,3.8e6}),
      h(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916,
            3517975.25}),
      hb(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916}),
      P(start={2558239,2556000,2554000,2552000,2548600})))
                          annotation (Placement(transformation(
        origin={-267,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Volumes.DynamicDrum BallonBP(
    Vertical=false,
    P0=5e5,
    Vv(fixed=false),
    L=8,
    hl(fixed=false, start=549249.519022482),
    hv(fixed=false, start=2709858.97470349),
    R=2,
    P(fixed=false, start=563775.329209196),
    zl(start=1.75, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=564775.0),
    Tp(start=406.411032587651))
                     annotation (Placement(transformation(extent={{585,10},{545,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurBP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{633,76},{621,86}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurBP(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=503542.0), h_vol(start=2709858.97470349)),
    h(start=2685000),
    Cv(start=1),
    Pm(start=498000))
                 annotation (Placement(transformation(extent={{525,46},{505,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationBP(
    Cvmax=285,
    C1(h_vol(start=511900.0)),
    h(fixed=false, start=509000),
    Cv(start=142.5),
    Pm(fixed=false, start=969800))
                 annotation (Placement(transformation(extent={{617,44},{597,64}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss GainChargeBP(
    z2=0,
    z1=10.767,
    Q(start=50, fixed=false),
    K=32766,
    mode=1,
    pro(d(start=934.452746556487)),
    Pm(start=564000),
    h(start=549249.519022482))
            annotation (Placement(transformation(
        origin={577,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapBP(h(start=549249.519022482),
                                                                       mode=1,
    V=5,
    P(start=564000))                       annotation (Placement(transformation(
          extent={{559,-100},{539,-80}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EvaporateurBP(
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.24e7,-8.5e6,-5.8e6}),
      Tp(start={433.127441964236,432.076030201586,431.28112439162}),
      Tp1(start={432.956,431.127,430.61})),
    L=20.726,
    Ntubes=984,
    Ns=3,
    ExchangerFlueGasesMetal(
      Dext=38e-3,
      step_T=86.9e-3,
      Fa=1,
      step_L=138e-3,
      K(fixed=true, start=30.62),
      CSailettes=11.07985,
      p_rho=1.14,
      Encras=Encras_EvBP,
      St=5,
      DeltaT(start={45,31,21}),
      T(start={482.59533691406,464.53146753441,453.496360082,442.5893859863}),
      Tm(start={483.15,478.15,472.098}),
      Tp(start={433.5360639938,432.3549425205,431.471976456})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={1.24e7,8.5e6,5.8e6}),
      h(start={550075.0,765243.011613326,912673.256542569,1013555.73710231,
            550075.0}),
      hb(start={550075.0,765243.011613326,912673.256542569,1013555.73710231}),
      Q(start={49.787311368631,49.787311368631,49.787311368631,49.787311368631}),
      P(start={512583.375,488000,487000,486000,485588.46875})))
                          annotation (Placement(transformation(
        origin={533,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_ballonBP(k=1)
    annotation (Placement(transformation(extent={{709,6},{695,18}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP(
                          mode=1,
    Cvmax=308.931,
    C1(h_vol(start=549249.519022482)),
    h(start=550000),
    Cv(start=308.931),
    Pm(start=490000))
                 annotation (Placement(transformation(extent={{677,-14},{697,6}},
          rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    SurchauffeurBP(
    Ns=3,
    L=20.726,
    Dint=39.3e-3,
    Ntubes=123,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.1e6,-782901,-559798}),
      Tp(start={489.606851797367,513.610203520748,530.080624448955}),
      Tp1(start={488.486,512.197,529.53})),
    Cws1(h_vol(start=2642240.0)),
    Cws2(h_vol(start=2979330.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=44.5e-3,
      step_L=222.1e-3,
      K(fixed=true, start=30.46),
      CSailettes=3.25763059984175,
      p_rho=1.09,
      Encras=Encras_SBP,
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
      inertia=true,
      dW1(start={1.1e6,782901,559798}),
      h(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762,
            2914520.25}),
      hb(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762}),
      P(start={510622.6875,505757.57962259,504477.27858572,503172.36919354,
            501850})))    annotation (Placement(transformation(
        origin={233,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.FlueGases.BoundaryConditions.SinkP PuitsFumees(P0=1.013e5)
    annotation (Placement(transformation(
        origin={689,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases
    EconomiseurBP(
    Ns=3,
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-2.45e7,-5.5e6,-1.17e6}),
      Tp(start={398.142807363473,393.825926964772,392.943738968771}),
      Tp1(start={397.622,392.348,391.516})),
    Ntubes=3444,
    L=20.726,
    Cws1(h_vol(start=195526.0)),
    Cws2(h_vol(start=588078.0)),
    ExchangerFlueGasesMetal(
      step_T=86.9e-3,
      Fa=1,
      Dext=38e-3,
      step_L=92e-3,
      K(fixed=true, start=31.53),
      CSailettes=11.673758598919,
      p_rho=1.15,
      Encras=Encras_EBP,
      St=5,
      DeltaT(start={23.5,5.3,1.1}),
      T(start={442.5893859863,403.9873508455,395.0465605839,395.464630127}),
      Tm(start={423.15,418.15,414.742}),
      Tp(start={398.4437772187,393.8897987349,392.9569515805})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      inertia=true,
      dW1(start={2.45e7,5.5e6,1.17e6}),
      h(start={194584.515625,462556.370989432,494648.45288738,501287.069880104,
            509237.875}),
      hb(start={194584.515625,462556.370989432,494648.45288738,501287.069880104}),
      P(start={1540571.25,1500000,1480000,1450000,1429595.375})))
                          annotation (Placement(transformation(
        origin={647,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Machines.StodolaTurbine TurbineHP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.88057),
    Qmax=140,
    eta_is_nom=0.88057,
    eta_is_min=0.75,
    Cst(start=8182844.56002535)=
        CstHP,
    pros(d(start=10.0)),
    Hrs(start=3046260),
    Pe(fixed=true, start=12431000),
    Ps(fixed=false, start=2726700))
              annotation (Placement(transformation(extent={{-35,-250},{5,-210}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine TurbineMP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9625),
    Qmax=150,
    eta_is_nom=0.9625,
    eta_is_min=0.75,
    Cst(start=256335.364995961)=
        CstMP,
    pros(d(start=30.0)),
    Hrs(start=3029780),
    Pe(fixed=true, start=2548500),
    Ps(fixed=false, start=476800))
                annotation (Placement(transformation(extent={{285,-250},{325,
            -210}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC MelangeurPostTMP1(
    h(start=2997231.36734756),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={385,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine TurbineBP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9538),
    Qmax=150,
    eta_is_nom=0.9538,
    eta_is_min=0.75,
    Cst(start=11944.9445735985)=
        CstBP,
    Cs(h(start=2400000.0)),
    Hrs(start=2401030),
    Pe(fixed=true, start=476799.99999954),
    Ps(start=10053))
                annotation (Placement(transformation(extent={{543,-250},{583,
            -210}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitHP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-325,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitMP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-265,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier MoitieDebitHP(
                                                    alpha=0.5,
    Ce(h(start=3046260)),
    P(start=2726700))
    annotation (Placement(transformation(extent={{81,-180},{101,-160}},
          rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.SimpleDynamicCondenser Condenseur(
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
    P(fixed=false, start=6136),
    Pfond(start=6200))
    annotation (Placement(transformation(extent={{604,-384},{684,-304}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=29804.5)     annotation (Placement(transformation(extent={{539,
            -377},{587,-329}},     rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{703,-374},{747,-330}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK1(    K=1e-4,
    h(start=2400000),
    C1(h_vol(start=2400000), h(start=2400000)),
    Pm(start=10026))
    annotation (Placement(transformation(extent={{607,-240},{627,-220}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeCond1(mode=1,
    Ce3(h(start=163768.700887002)),
    h(start=163768.700887002),
    P(start=1540500))
    annotation (Placement(transformation(
        origin={869,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeKCond1(    K=1e-4, mode=1,
    pro(d(start=993.470128235971)),
    Pm(start=1540000))
    annotation (Placement(transformation(
        origin={869,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA VolumeAlimMPHP(mode=1,
    h(start=549249.519022482),
    P(start=322430))                       annotation (Placement(transformation(
          extent={{709,-20},{729,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump PompeAlimMP(
    a3=350,
    b1(fixed=true) = -3.7751,
    a1=-244551,
    Q(fixed=false),
    mode=1,
    C1(h_vol(start=576000.0)),
    C2(h_vol(start=561000.0)),
    Qv(start=0.0207237016869104),
    pro(d(start=930.0)),
    Pm(start=1725850))
            annotation (Placement(transformation(extent={{771,-20},{791,0}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump PompeAlimHP(
    a3=1600,
    a1=-28056.2,
    b1=-12.7952660447433,
    Q(fixed=false),
    mode=1,
    C1(h_vol(start=561000.0)),
    C2(h_vol(start=630000.0)),
    Qv(start=0.0810383142105344),
    pro(d(start=929.0)),
    Pm(start=6774000))
             annotation (Placement(transformation(extent={{771,-60},{791,-40}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier MoitieDebitBP(
                                                    alpha=0.5,
    h(start=194585),
    P(start=1540500),
    Cs(h(start=194585)))
    annotation (Placement(transformation(extent={{839,-328},{853,-308}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier DoubleDebitBP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={235,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss PerteChargeZero2(
    z2=0,
    mode=0,
    z1=0,
    K=K_PerteChargeZero2,
    h(start=3000000),
    C1(
      h_vol(start=3000000),
      h(start=3000000),
      P(fixed=true, start=501850)),
    Pm(start=490000))
            annotation (Placement(transformation(
        origin={311,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK3(    K=1e-4, mode=1,
    Pm(start=372718))
    annotation (Placement(transformation(
        origin={747,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK8(    K=1e-4, mode=1,
    Pm(start=372718))
    annotation (Placement(transformation(
        origin={747,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{369,-448},{489,-348}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK(
                                                         K=1e-4, mode=1,
    C1(h_vol(start=153206.462779274)),
    C2(h_vol(start=153206.462779274)),
    pro(d(start=993.441492649513)),
    Pm(start=6200))
    annotation (Placement(transformation(extent={{669,-446},{689,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump PompeAlimBP(
    Qv(start=0.193483547611118),
    mode=1,
    a3=400,
    a1(fixed=true) = -6000,
    Q(start=194.502, fixed=false),
    C2(h_vol(start=194669.0)),
    Pm(start=800000))
            annotation (Placement(transformation(extent={{709,-446},{729,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK2(
                                                         K=1e-4, mode=1,
    pro(d(start=994.045785814739)),
    C1(h_vol(start=194585), h(start=194585)),
    Pm(start=1546000))
    annotation (Placement(transformation(extent={{807,-446},{827,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_extraction(            mode=1, Cvmax=
        2000,
    h(start=194500),
    Cv(start=2000),
    Pm(start=1549000))
                 annotation (Placement(transformation(extent={{769,-440},{789,
            -420}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapHP(C1(h_vol(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-91,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauHP(C2(h_vol(start=1398000),
        h(start=1398000))) " "
    annotation (Placement(transformation(
        origin={58.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauMP(C2(h_vol(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{391,49},{376,63}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapMP(C1(h_vol(start=2798000),
        h(start=2798000)))
    annotation (Placement(transformation(
        origin={203,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapBP(C2(h_vol(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={481,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauBP(C2(h_vol(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={630.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauBPsortie(C2(h_vol(
          start=550000), h(start=550000)))
    annotation (Placement(transformation(extent={{654,-11},{667,1}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauCondenseur(C2(h_vol(
          start=194585), h(start=194585)))
    annotation (Placement(transformation(
        origin={652.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapCondenseur(C2(h_vol(
          start=2401000), h(start=2401000)))
    annotation (Placement(transformation(
        origin={651.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipeK2(
                                                          K=Kin_SMP2,
    Pm(start=2651000),
    C1(
      P(fixed=true, start=2726700),
      h_vol(start=3046000),
      h(start=3046000)))
    annotation (Placement(transformation(extent={{81,-120},{61,-100}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_entree_TurbineHP(
    mode=0,
    C1(P(fixed=true, start=12680999.9999969)),
    Cvmax=Cvmax_THP,
    h(fixed=false, start=3433000),
    Cv(start=10875),
    Pm(fixed=false, start=12550000))
                 annotation (Placement(transformation(extent={{-157,-234},{-137,
            -214}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauHP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{-191,113},{-157,131}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_HP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500,
    minval=0.007)
    annotation (Placement(transformation(extent={{-73,106},{-53,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauMP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{140,113},{174,131}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_MP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500)
    annotation (Placement(transformation(extent={{229,106},{249,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauBP(                                                              k=1.75)
    annotation (Placement(transformation(extent={{437,126},{471,144}}, rotation=
           0)));
  Control.Drum_LevelControl regulation_Niveau_BP(
                     add(k1=-1, k2=+1), pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10,
    minval=0.006)
    annotation (Placement(transformation(extent={{535,108},{555,128}}, rotation=
           0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{683,-246},{707,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
                                                add(k1=+1, k2=-1))
                                 annotation (Placement(transformation(extent={{725,
            -282},{745,-262}},     rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineHP(Table=[0,0.8; 10,0.8; 600,0.8; 650,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-241,-216},{
            -171,-142}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp(
    Initialvalue=1400,
    Duration=1000,
    Starttime=4000,
    Finalvalue=1000)
                   annotation (Placement(transformation(extent={{911,-42},{873,
            -10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP(
    Initialvalue=1400,
    Starttime=4000,
    Duration=1000,
    Finalvalue=700)
                   annotation (Placement(transformation(extent={{912,-96},{874,
            -64}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesBP(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{912,-458},{874,
            -426}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeECO_HP1_2(
    mode=1,
    V=1,
    h0=988332,
    h(start=988332),
    dynamic_mass_balance=true,
    P0=7010000,
    P(start=13129000))                    annotation (Placement(transformation(
          extent={{423,-98},{403,-78}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeECO_HP2_3(
    mode=1,
    V=1,
    h0=983786,
    h(start=983786),
    dynamic_mass_balance=true,
    P0=7000000,
    P(start=13219000))                    annotation (Placement(transformation(
          extent={{219,-20},{199,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP1(
                          mode=1,
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    Pm(start=13130000))
                 annotation (Placement(transformation(extent={{721,-98},{697,
            -122}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP2(
                          mode=1,
    Cvmax=308.931,
    h(start=565000),
    Cv(start=308.931),
    Pm(start=3126000))
                 annotation (Placement(transformation(extent={{771,-138},{747,
            -162}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp1(
    Initialvalue=0.8,
    Duration=1000,
    Starttime=3000,
    Finalvalue=0.005)
                     annotation (Placement(transformation(extent={{913,-150},{
            875,-118}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP1(
    Initialvalue=0.8,
    Duration=1000,
    Starttime=3000,
    Finalvalue=0.005)
                     annotation (Placement(transformation(extent={{913,-194},{
            875,-162}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD VolumePreTHP(
    h0=3e6,
    h(start=3450835.48993987),
    dynamic_mass_balance=true,
    P0=12700000,
    P(start=12700000))                annotation (Placement(transformation(
        origin={-85,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC MelangeurPreTMP(
    h0=3523910,
    h(start=3523910.30137915),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=2400000))                     annotation (Placement(transformation(
        origin={-83,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_entree_TurbineMP(
    mode=0,
    C1(P(fixed=true, start=25.486e5)),
    Cvmax=Cvmax_TMP,
    h(fixed=false, start=3518000),
    Cv(start=3.312e6),
    Pm(fixed=false, start=2547000))
                 annotation (Placement(transformation(extent={{-157,-318},{-137,
            -298}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineMP(Table=[0,0.8; 10,0.8; 600,0.8; 2000,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-241,-300},{
            -171,-226}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(T0={303.16})
    annotation (Placement(transformation(extent={{-28,68},{-2,98}},
                                                                  rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(T0={303.16})
    annotation (Placement(transformation(extent={{293,68},{319,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource2(T0={303.16})
    annotation (Placement(transformation(extent={{552,64},{578,94}}, rotation=0)));

  FlueGases.BoundaryConditions.SourceQ SourceFumees(
    Xco2=0.0613,
    Xso2=0,
    Xh2o=0.0706,
    T0=893.75,
    Xo2=0.1380,
    Q0=606.94)
    annotation (Placement(transformation(extent={{-473,-91},{-371,-7}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Debit(             Table=[0,606.94; 10,606.94; 600,
        50; 650,50])
                annotation (Placement(transformation(extent={{-527,-19},{-457,
            55}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Temperature(
      Table=[0,893.75; 10,893.75; 600,423; 650,423])
                   annotation (Placement(transformation(extent={{-527,-157},{
            -457,-83}}, rotation=0)));
equation
  connect(SurchauffeurHP3.Cws1, SurchauffeurHP2.Cws2)
    annotation (Line(points={{-327,-30},{-327,-10},{-207,-10},{-207,-30}},
        color={255,0,0}));
  connect(SurchauffeurHP2.Cws1, SurchauffeurHP1.Cws2)
    annotation (Line(points={{-207,-70},{-207,-90},{-87,-90},{-87,-70}}, color=
          {255,0,0}));
  connect(constante_vanne_vapeurHP.y, vanne_vapeurHP.Ouv)
    annotation (Line(points={{-61.5,74},{-65,74},{-65,67}}));
  connect(vanne_vapeurHP.C1, BallonHP.Cv)
    annotation (Line(points={{-55,50},{-35,50}},color={255,0,0}));
  connect(GainChargeHP.C1, BallonHP.Cd)
    annotation (Line(points={{5,-90},{15,-90},{15,10},{5,10}},   color={255,128,
          0}));
  connect(BallonHP.Cm, EvaporateurHP.Cws2)
    annotation (Line(points={{-35,10},{-47,10},{-47,-30}}));
  connect(VolumeEvapHP.Cs, EvaporateurHP.Cws1)
    annotation (Line(points={{-45,-90},{-45,-70},{-47,-70}}, color={255,128,0}));
  connect(VolumeEvapHP.Ce1, GainChargeHP.C2)
                                      annotation (Line(points={{-25,-90},{-15,
          -90}},
        color={255,128,0}));
  connect(EconomiseurHP4.Cws1, EconomiseurHP3.Cws2)
    annotation (Line(points={{53,-70},{53,-82},{173,-82},{173,-70}}));
  connect(BallonMP.Cm, EvaporateurMP.Cws2)
    annotation (Line(points={{287,10},{273,10},{273,-30}}));
  connect(EvaporateurMP.Cws1, VolumeEvapMP.Cs)
    annotation (Line(points={{273,-70},{273,-80},{275,-80},{275,-90}}, color={
          255,128,0}));
  connect(VolumeEvapMP.Ce1, GainChargeMP.C2)
    annotation (Line(points={{295,-90},{305,-90}}, color={255,128,0}));
  connect(constante_vanne_vapeurMP.y, vanne_vapeurMP.Ouv)
    annotation (Line(points={{258.4,75},{255,75},{255,67}}));
  connect(SurchauffeurHP1.Cfg2, EvaporateurHP.Cfg1)        annotation (Line(
      points={{-77,-50},{-57,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurHP.Cfg2, EconomiseurHP4.Cfg1)        annotation (Line(
      points={{-37,-50},{63,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP4.Cfg2, SurchauffeurMP1.Cfg1)          annotation (Line(
      points={{43,-50},{103,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP1.Cfg2, EconomiseurHP3.Cfg1)           annotation (Line(
      points={{123,-50},{163,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurMP.Cfg2, EconomiseurHP2.Cfg1)           annotation (Line(
      points={{283,-50},{363,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP2.Cfg2, EconomiseurMP.Cfg1)           annotation (Line(
      points={{383,-50},{423,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurMP.Cfg2, EconomiseurHP1.Cfg1)           annotation (Line(
      points={{443,-50},{483,-50}},
      color={0,0,0},
      thickness=1));
  connect(GainChargeMP.C1, BallonMP.Cd)
    annotation (Line(points={{325,-90},{335,-90},{335,10},{325,10}}, color={255,
          128,0}));
  connect(SurchauffeurMP2.Cfg2, SurchauffeurHP1.Cfg1)          annotation (Line(
      points={{-137,-50},{-97,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP2.Cfg1, SurchauffeurHP2.Cfg2)           annotation (Line(
      points={{-157,-50},{-197,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cfg2, SurchauffeurHP2.Cfg1)           annotation (Line(
      points={{-257,-50},{-217,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurHP3.Cfg2, SurchauffeurMP3.Cfg1)           annotation (Line(
      points={{-317,-50},{-277,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cws1,SurchauffeurMP2. Cws2)
    annotation (Line(points={{-267,-30},{-267,10},{-147,10},{-147,-30}}, color=
          {255,0,0}));
  connect(SurchauffeurMP1.Cws2, MelangeurHPMP.Ce2) annotation (Line(
      points={{113,-70},{113,-85},{115,-85},{115,-100}},
      color={255,0,0},
      pattern=LinePattern.None));
  connect(vanne_vapeurBP.C1, BallonBP.Cv)
    annotation (Line(points={{525,50},{545,50}}, color={255,0,0}));
  connect(EvaporateurBP.Cws1, VolumeEvapBP.Cs)  annotation (Line(points={{533,-70},
          {533,-90},{539,-90}},      color={255,128,0}));
  connect(VolumeEvapBP.Ce1, GainChargeBP.C2)
                                        annotation (Line(points={{559,-90},{567,
          -90}}, color={255,128,0}));
  connect(BallonBP.Cd, GainChargeBP.C1)
                                       annotation (Line(points={{585,10},{595,
          10},{595,-90},{587,-90}}, color={255,128,0}));
  connect(EconomiseurBP.Cfg2, PuitsFumees.C)     annotation (Line(
      points={{657,-50},{679.2,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP3.Cfg2, SurchauffeurBP.Cfg1)  annotation (Line(
      points={{183,-50},{223,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurBP.Cfg2, EvaporateurMP.Cfg1)  annotation (Line(
      points={{243,-50},{263,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP1.Cfg2, EvaporateurBP.Cfg1) annotation (Line(
      points={{503,-50},{523,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurBP.Cfg2, EconomiseurBP.Cfg1) annotation (Line(
      points={{543,-50},{637,-50}},
      color={0,0,0},
      thickness=1));
  connect(BallonBP.Cm, EvaporateurBP.Cws2)
    annotation (Line(points={{545,10},{533,10},{533,-30}}));
  connect(vanne_vapeurMP.C1, BallonMP.Cv)   annotation (Line(points={{265,50},{
          287,50}}, color={255,0,0}));
  connect(Vanne_alimentationMPHP.Ouv, constante_ballonBP.y)
    annotation (Line(points={{687,7},{687,12},{694.3,12}}));
  connect(SurchauffeurHP3.Cws2, DoubleDebitHP.Ce)
    annotation (Line(points={{-327,-70},{-327,-80},{-325,-80},{-325,-90}},
        color={255,0,0}));
  connect(SurchauffeurMP3.Cws2, DoubleDebitMP.Ce)
    annotation (Line(points={{-267,-70},{-267,-80},{-265,-80},{-265,-90}},
        color={255,0,0}));
  connect(VolumeCond1.Cs, perteChargeKCond1.C1) annotation (Line(points={{869,
          -308},{869,-282}}, color={0,0,255}));
  connect(Vanne_alimentationMPHP.C2, VolumeAlimMPHP.Ce1)
                                               annotation (Line(points={{697,-10},
          {709,-10}},      color={0,0,255}));
  connect(SurchauffeurBP.Cws2, DoubleDebitBP.Ce)
    annotation (Line(points={{233,-70},{233,-80},{235,-80},{235,-90}}, color={
          255,0,0}));
  connect(perteChargeK8.C2, PompeAlimMP.C1)
    annotation (Line(points={{757,-10},{764,-10},{771,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs1, perteChargeK8.C1)
    annotation (Line(points={{729,-10},{733,-10},{737,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs2, perteChargeK3.C1)
                                         annotation (Line(points={{719,-20},{
          719,-50},{737,-50}}, color={0,0,255}));
  connect(perteChargeK3.C2, PompeAlimHP.C1)
    annotation (Line(points={{757,-50},{771,-50}}, color={0,0,255}));
  connect(MelangeurPostTMP1.Ce2, PerteChargeZero2.C2) annotation (Line(points={{385,
          -239},{385,-278},{321,-278}},      color={255,0,0}));
  connect(perteChargeK.C2,PompeAlimBP. C1)
                                         annotation (Line(points={{689,-436},{
          709,-436}}, color={0,0,255}));
  connect(vanne_extraction.C2, perteChargeK2.C1) annotation (Line(points={{789,
          -436},{807,-436}}, color={0,0,255}));
  connect(vanne_alimentationHP.C1, CapteurDebitEauHP.C2)
    annotation (Line(points={{45,50},{53.3,50},{53.3,38.12}}));
  connect(vanne_vapeurHP.C2, CapteurDebitVapHP.C1) annotation (Line(points={{-75,50},
          {-86.2,50},{-86.2,14}},         color={255,0,0}));
  connect(CapteurDebitVapHP.C2, SurchauffeurHP1.Cws1) annotation (Line(points={{-86.2,
          1.88},{-86.2,-3.06},{-87,-3.06},{-87,-30}},        color={255,0,0}));
  connect(vanne_alimentationMP.C1, CapteurDebitEauMP.C2)
    annotation (Line(points={{365,50},{370.425,50},{370.425,50.4},{375.85,50.4}}));
  connect(CapteurDebitVapMP.C1, vanne_vapeurMP.C2) annotation (Line(points={{211,
          49.6},{227,49.6},{227,50},{245,50}},     color={255,0,0}));
  connect(CapteurDebitVapMP.C2, SurchauffeurMP1.Cws1) annotation (Line(points={{194.84,
          49.6},{113,49.6},{113,-30}},         color={255,0,0}));
  connect(CapteurDebitVapBP.C2, SurchauffeurBP.Cws1) annotation (Line(points={{472.84,
          49.6},{457,49.6},{457,-2},{233,-2},{233,-30}},        color={255,0,0}));
  connect(CapteurDebitVapBP.C1, vanne_vapeurBP.C2) annotation (Line(points={{489,
          49.6},{497,49.6},{497,50},{505,50}},     color={255,0,0}));
  connect(CapteurDebitEauBP.C2, vanne_alimentationBP.C1) annotation (Line(
        points={{625.3,40.12},{625.3,48},{617,48}}, color={0,0,255}));
  connect(CapteurDebitEauBPsortie.C2, Vanne_alimentationMPHP.C1) annotation (Line(
        points={{667.13,-9.8},{672.065,-9.8},{672.065,-10},{677,-10}}, color={0,
          0,255}));
  connect(CapteurDebitEauCondenseur.C2, perteChargeK.C1) annotation (Line(
        points={{647.3,-422.2},{647.3,-436},{669,-436}}, color={0,0,255}));
  connect(perteChargeK1.C2, CapteurDebitVapCondenseur.C1) annotation (Line(
        points={{627,-230},{646.3,-230},{646.3,-254}}, color={255,0,0}));
  connect(MelangeurHPMP.Ce1, MoitieDebitHP.Cs)
    annotation (Line(points={{115,-120},{115,-170},{101,-170}}, color={255,0,0}));
  connect(perteChargeK2.C2, MoitieDebitBP.Ce) annotation (Line(points={{827,
          -436},{829,-436},{829,-318},{839,-318}}, color={0,0,255}));
  connect(MoitieDebitBP.Cs, VolumeCond1.Ce3) annotation (Line(points={{853,-318},
          {859,-318}}, color={0,0,255}));
  connect(SurchauffeurMP2.Cws1, lumpedStraightPipeK2.C2)
    annotation (Line(points={{-147,-70},{-147,-110},{61,-110}}, color={255,0,0}));
  connect(lumpedStraightPipeK2.C1, MelangeurHPMP.Cs2)
    annotation (Line(points={{81,-110},{105.2,-110}},  color={255,0,0}));
  connect(DoubleDebitHP.Cs, vanne_entree_TurbineHP.C1) annotation (Line(points={{-325,
          -110},{-325,-230},{-157,-230}},        color={255,0,0}));
  connect(DoubleDebitBP.Cs, PerteChargeZero2.C1) annotation (Line(points={{235,
          -110},{235,-278},{301,-278}}, color={255,0,0}));
  connect(PompeAlimBP.C2, vanne_extraction.C1) annotation (Line(points={{729,
          -436},{769,-436}}, color={0,0,255}));
  connect(BallonHP.yLevel,regulation_Niveau_HP. MesureNiveauEau)
    annotation (Line(points={{-37,30},{-101,30},{-101,125},{-73.5,125}}));
  connect(regulation_Niveau_HP.SortieReelle1, vanne_alimentationHP.Ouv)
    annotation (Line(points={{-52.5,107},{35,107},{35,67}}));
  connect(ConsigneNiveauEauMP.y,regulation_Niveau_MP. ConsigneNiveauEau)
    annotation (Line(points={{175.7,122},{201,122},{201,110},{228.5,110}}));
  connect(BallonMP.yLevel,regulation_Niveau_MP. MesureNiveauEau)
    annotation (Line(points={{285.1,30},{219,30},{219,125},{228.5,125}}));
  connect(regulation_Niveau_MP.SortieReelle1, vanne_alimentationMP.Ouv)
    annotation (Line(points={{249.5,107},{344.25,107},{344.25,67},{355,67}}));
  connect(ConsigneNiveauEauBP.y,regulation_Niveau_BP. ConsigneNiveauEau)
    annotation (Line(points={{472.7,135},{496.85,135},{496.85,112},{534.5,112}}));
  connect(BallonBP.yLevel,regulation_Niveau_BP. MesureNiveauEau)
    annotation (Line(points={{543,30},{485,30},{485,127},{534.5,127}}));
  connect(ConsigneNiveauCondenseur1.y, regulation_Niveau_Condenseur.ConsigneNiveauEau)
    annotation (Line(points={{708.2,-238},{719,-238},{719,-269},{724.5,-269}}));
  connect(regulation_Niveau_Condenseur.SortieReelle1, vanne_extraction.Ouv)
    annotation (Line(points={{745.5,-281},{779,-281},{779,-419}}));
  connect(CapteurDebitEauBP.C1, EconomiseurBP.Cws2)
    annotation (Line(points={{625.3,28},{627,28},{627,6},{647,6},{647,-30}}));
  connect(EconomiseurBP.Cws1, perteChargeKCond1.C2) annotation (Line(points={{647,-70},
          {647,-186},{869,-186},{869,-258}}));
  connect(CapteurDebitVapCondenseur.Measure, regulation_Niveau_Condenseur.MesureDebitVapeur)
    annotation (Line(points={{658.13,-264},{671,-264},{671,-280.9},{724.6,
          -280.9}}));
  connect(regulation_Niveau_Condenseur.MesureDebitEau,
    CapteurDebitEauCondenseur.Measure) annotation (Line(points={{724.45,-274.95},
          {717,-274.95},{717,-310},{759,-310},{759,-412},{659.13,-412}}));
  connect(ConstantVanneTurbineHP.y, vanne_entree_TurbineHP.Ouv)
    annotation (Line(points={{-167.5,-179},{-147,-179},{-147,-213}}));
  connect(regulation_Niveau_BP.SortieReelle1, vanne_vapeurBP.Ouv)
    annotation (Line(points={{555.5,109},{567,109},{567,90},{515,90},{515,67}}));
  connect(vanne_alimentationBP.Ouv, constante_vanne_vapeurBP.y)
    annotation (Line(points={{607,65},{607,81},{620.4,81}}));
  connect(EconomiseurHP1.Cws2, VolumeECO_HP1_2.Ce1) annotation (Line(points={{493,-70},
          {493,-88},{423,-88}},          color={0,0,255}));
  connect(VolumeECO_HP1_2.Cs, EconomiseurHP2.Cws1) annotation (Line(points={{403,-88},
          {373,-88},{373,-70}},          color={0,0,255}));
  connect(EconomiseurHP2.Cws2, VolumeECO_HP2_3.Ce1) annotation (Line(points={{373,-30},
          {373,-10},{219,-10}},          color={0,0,255}));
  connect(VolumeECO_HP2_3.Cs, EconomiseurHP3.Cws1) annotation (Line(points={{199,-10},
          {173,-10},{173,-30}},          color={0,0,255}));
  connect(Vanne_alimentationMPHP1.C1, PompeAlimHP.C2)
    annotation (Line(points={{721,-102.8},{809,-102.8},{809,-50},{791,-50}}));
  connect(PompeAlimMP.C2, Vanne_alimentationMPHP2.C1) annotation (Line(points={{791,-10},
          {837,-10},{837,-142.8},{771,-142.8}},           color={0,0,255}));
  connect(arretPomesMp1.y, Vanne_alimentationMPHP1.Ouv)
    annotation (Line(points={{873.1,-134},{823,-134},{823,-122},{709,-122},{709,
          -123.2}}));
  connect(arretPomesHP1.y, Vanne_alimentationMPHP2.Ouv)
    annotation (Line(points={{873.1,-178},{850.05,-178},{850.05,-163.2},{759,
          -163.2}}));
  connect(Vanne_alimentationMPHP1.C2, EconomiseurHP1.Cws1) annotation (Line(
        points={{697,-102.8},{603,-102.8},{603,-106},{515,-106},{515,-6},{493,
          -6},{493,-30}}, color={0,0,255}));
  connect(EconomiseurMP.Cws1, Vanne_alimentationMPHP2.C2)
    annotation (Line(points={{433,-70},{433,-142.8},{747,-142.8}}));
  connect(ConstantVanneTurbineMP.y, vanne_entree_TurbineMP.Ouv)
    annotation (Line(points={{-167.5,-263},{-147,-263},{-147,-297}}));
  connect(vanne_entree_TurbineHP.C2, VolumePreTHP.Ce) annotation (Line(points={{-137,
          -230},{-95,-230}},       color={255,0,0}));
  connect(DoubleDebitMP.Cs, vanne_entree_TurbineMP.C1) annotation (Line(points={{-265,
          -110},{-265,-314},{-157,-314}},        color={255,0,0}));
  connect(vanne_entree_TurbineMP.C2, MelangeurPreTMP.Ce1) annotation (Line(
        points={{-137,-314},{-93,-314}}, color={255,0,0}));
  connect(SourceCaloporteur.C, Condenseur.Cee) annotation (Line(points={{587,
          -353},{605,-353},{605,-352.8},{604,-352.8}},
                                                     color={0,0,255}));
  connect(Condenseur.Cse, PuitsCaloporteur.C) annotation (Line(points={{684,
          -352},{703,-352}}, color={0,0,255}));
  connect(CapteurDebitVapCondenseur.C2, Condenseur.Cv) annotation (Line(points={{646.3,
          -274.2},{646.3,-288.1},{644,-288.1},{644,-304}},         color={0,0,
          255}));
  connect(CapteurDebitEauCondenseur.C1, Condenseur.Cl)
    annotation (Line(points={{647.3,-402},{644.8,-402},{644.8,-384}}));
  connect(ConsigneNiveauEauHP.y, regulation_Niveau_HP.ConsigneNiveauEau)
    annotation (Line(points={{-155.3,122},{-133,122},{-133,110},{-73.5,110}}));
  connect(Condenseur.yNiveau, regulation_Niveau_Condenseur.MesureNiveauEau)
    annotation (Line(points={{688,-372.8},{747,-372.8},{747,-326},{699,-326},{
          699,-263},{724.5,-263}}));
  connect(BallonBP.Cs, CapteurDebitEauBPsortie.C1) annotation (Line(points={{545,22},
          {531,22},{531,16},{609,16},{609,-9.8},{654,-9.8}},         color={0,0,
          255}));
  connect(BallonBP.Ce1, vanne_alimentationBP.C2)
    annotation (Line(points={{585,50},{591,50},{591,48},{597,48}}));
  connect(BallonMP.Ce1, vanne_alimentationMP.C2)
    annotation (Line(points={{325,50},{345,50}}));
  connect(BallonHP.Ce1, vanne_alimentationHP.C2)
    annotation (Line(points={{5,50},{25,50}}));
  connect(TurbineHP.Cs, MoitieDebitHP.Ce) annotation (Line(points={{5.2,-230},{
          41,-230},{41,-170},{81,-170}},   color={255,0,0}));
  connect(VolumePreTHP.Cs3, TurbineHP.Ce) annotation (Line(points={{-75,-230},{
          -35.2,-230}},color={255,0,0}));
  connect(MelangeurPreTMP.Cs, TurbineMP.Ce) annotation (Line(points={{-73,-314},
          {73,-314},{73,-230},{284.8,-230}},   color={255,0,0}));
  connect(TurbineMP.Cs, MelangeurPostTMP1.Ce1) annotation (Line(points={{325.2,
          -230},{375,-230}}, color={255,0,0}));
  connect(MelangeurPostTMP1.Cs, TurbineBP.Ce) annotation (Line(points={{395,
          -230},{542.8,-230}}, color={255,0,0}));
  connect(TurbineBP.Cs, perteChargeK1.C1) annotation (Line(points={{583.2,-230},
          {607,-230}}, color={255,0,0}));
  connect(EconomiseurMP.Cws2, CapteurDebitEauMP.C1) annotation (Line(points={{433,-30},
          {437,-30},{437,50.4},{391,50.4}},          color={0,0,255}));
  connect(TurbineMP.MechPower, Alternateur.Wmec2)
    annotation (Line(points={{327,-248},{335,-248},{335,-378},{369,-378}}));
  connect(TurbineBP.MechPower, Alternateur.Wmec1) annotation (Line(points={{585,
          -248},{595,-248},{595,-290},{355,-290},{355,-358},{369,-358}}));
  connect(TurbineHP.MechPower, Alternateur.Wmec3)
    annotation (Line(points={{7,-248},{15,-248},{15,-398},{369,-398}}));
  connect(heatSource.C[1], BallonHP.Cex) annotation (Line(points={{-15,68.3},{
          -15,50}},
                color={191,95,0}));
  connect(heatSource1.C[1], BallonMP.Cex) annotation (Line(points={{306,68.3},{
          306,50}}, color={191,95,0}));
  connect(heatSource2.C[1], BallonBP.Cex) annotation (Line(points={{565,64.3},{
          565,50}}, color={191,95,0}));
  connect(CapteurDebitEauHP.C1, EconomiseurHP4.Cws2)
    annotation (Line(points={{53.3,26},{53,26},{53,-30}}, smooth=Smooth.None));
  connect(PompeAlimMP.rpm_or_mpower, arretPomesMp.y)
    annotation (Line(points={{781,-21},{781,-26},{871.1,-26}}, smooth=Smooth.None));
  connect(PompeAlimHP.rpm_or_mpower, arretPomesHP.y)
    annotation (Line(points={{781,-61},{781,-80},{872.1,-80}}, smooth=Smooth.None));
  connect(PompeAlimBP.rpm_or_mpower, arretPomesBP.y) annotation (Line(points={{719,
          -447},{721,-447},{721,-460},{845,-460},{845,-442},{872.1,-442}},
        smooth=Smooth.None));
  connect(SourceFumees.C, SurchauffeurHP3.Cfg1) annotation (Line(
      points={{-371,-49},{-371,-50},{-337,-50}},
      color={0,0,0},
      thickness=1));
  connect(Temperature.y,SourceFumees. ITemperature)
    annotation (Line(points={{-453.5,-120},{-422,-120},{-422,-70}}));
  connect(Debit.y,SourceFumees. IMassFlow)
    annotation (Line(points={{-453.5,18},{-422,18},{-422,-28}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-560,-460},
            {950,150}},
        initialScale=0.1),     graphics),
    experiment(StopTime=10000, Tolerance=0.001),
    experimentSetupOutput,
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end CombinedCycle_TripTAC;
