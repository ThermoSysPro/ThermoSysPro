within ThermoSysPro.Examples.CombinedCyclePowerPlant;
model CombinedCycle_Load_100_50
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
    P(fixed=false, start=12703151.2960688),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    Pfond(start=12703151.3),
    Tp(start=596.924860294475))
                     annotation (Placement(transformation(extent={{38,10},{-2,
            50}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationHP(
      Cvmax=CvmaxValveAHP,
    C1(P(start=12721657.0), h_vol(start=1396865.59043578)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))
                 annotation (Placement(transformation(extent={{78,46},{58,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurHP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{-18,70},{-28,78}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurHP(
    Cvmax=47829.4,
    mode=0,
    C2(h_vol(start=2666558.75582585)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12721657.16928))
                 annotation (Placement(transformation(extent={{-22,46},{-42,66}},
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
        origin={28,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapHP(mode=1, V=5,
    h(start=1474422.14552527),
    P(start=12704000))                     annotation (Placement(transformation(
          extent={{8,-100},{-12,-80}}, rotation=0)));
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
        origin={-14,-50},
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
        origin={86,-50},
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
        origin={-54,-50},
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
        origin={206,-50},
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
        origin={406,-50},
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
        origin={526,-50},
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
        origin={-174,-50},
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
        origin={-294,-50},
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
                     annotation (Placement(transformation(extent={{358,10},{320,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurMP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{304,70},{292,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationMP(
      Cvmax=CvmaxValveAMP,
    C1(P(start=2752995.0), h_vol(start=892414.570867188)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2975000))
                 annotation (Placement(transformation(extent={{398,46},{378,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurMP(
    Cvmax=47829.4,
    mode=0,
    C2(h_vol(start=2799158.13966473)),
    h(fixed=false, start=2798000),
    Cv(start=23914.7),
    Pm(fixed=false, start=2731689.4244255))
                 annotation (Placement(transformation(extent={{298,46},{278,66}},
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
        origin={306,-50},
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
        origin={348,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapMP(mode=1, V=5,
    h(start=978914.570821827),
    P(start=2734000))                      annotation (Placement(transformation(
          extent={{328,-100},{308,-80}}, rotation=0)));
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
        origin={466,-50},
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
        origin={146,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.WaterSteam.Volumes.VolumeB MelangeurHPMP(
    Ce1(h(start=3091610.0)),
    h(start=3042573.51976705),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={148,-110},
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
        origin={-114,-50},
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
        origin={-234,-50},
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
                     annotation (Placement(transformation(extent={{618,10},{578,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurBP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{666,76},{654,86}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_vapeurBP(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=503542.0), h_vol(start=2709858.97470349)),
    h(start=2685000),
    Cv(start=1),
    Pm(start=498000))
                 annotation (Placement(transformation(extent={{558,46},{538,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_alimentationBP(
    Cvmax=285,
    C1(h_vol(start=511900.0)),
    h(fixed=false, start=509000),
    Cv(start=142.5),
    Pm(fixed=false, start=969800))
                 annotation (Placement(transformation(extent={{650,44},{630,64}},
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
        origin={610,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeEvapBP(h(start=549249.519022482),
                                                                       mode=1,
    V=5,
    P(start=564000))                       annotation (Placement(transformation(
          extent={{592,-100},{572,-80}}, rotation=0)));
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
        origin={566,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_ballonBP(k=1)
    annotation (Placement(transformation(extent={{742,6},{728,18}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP(
                          mode=1,
    Cvmax=308.931,
    C1(h_vol(start=549249.519022482)),
    h(start=550000),
    Cv(start=308.931),
    Pm(start=490000))
                 annotation (Placement(transformation(extent={{710,-14},{730,6}},
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
        origin={266,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.FlueGases.BoundaryConditions.SinkP PuitsFumees(P0=1.013e5)
    annotation (Placement(transformation(
        origin={722,-50},
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
        origin={680,-50},
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
              annotation (Placement(transformation(extent={{-2,-250},{38,-210}},
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
                annotation (Placement(transformation(extent={{318,-250},{358,
            -210}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC MelangeurPostTMP1(
    h(start=2997231.36734756),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={418,-230},
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
                annotation (Placement(transformation(extent={{576,-250},{616,
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
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier MoitieDebitHP(
                                                    alpha=0.5,
    Ce(h(start=3046260)),
    P(start=2726700))
    annotation (Placement(transformation(extent={{114,-180},{134,-160}},
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
    annotation (Placement(transformation(extent={{637,-384},{717,-304}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=29804.5)     annotation (Placement(transformation(extent={{
            572,-377},{620,-329}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{736,-374},{780,-330}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK1(    K=1e-4,
    h(start=2400000),
    C1(h_vol(start=2400000), h(start=2400000)),
    Pm(start=10026))
    annotation (Placement(transformation(extent={{640,-240},{660,-220}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeCond1(mode=1,
    Ce3(h(start=163768.700887002)),
    h(start=163768.700887002),
    P(start=1540500))
    annotation (Placement(transformation(
        origin={902,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeKCond1(    K=1e-4, mode=1,
    pro(d(start=993.470128235971)),
    Pm(start=1540000))
    annotation (Placement(transformation(
        origin={902,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA VolumeAlimMPHP(mode=1,
    h(start=549249.519022482),
    P(start=322430))                       annotation (Placement(transformation(
          extent={{742,-20},{762,0}}, rotation=0)));
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
            annotation (Placement(transformation(extent={{804,-20},{824,0}},
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
             annotation (Placement(transformation(extent={{804,-60},{824,-40}},
          rotation=0)));
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
        origin={268,-100},
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
        origin={344,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK3(    K=1e-4, mode=1,
    Pm(start=372718))
    annotation (Placement(transformation(
        origin={780,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK8(    K=1e-4, mode=1,
    Pm(start=372718))
    annotation (Placement(transformation(
        origin={780,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{402,-448},{522,-348}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK(
                                                         K=1e-4, mode=1,
    C1(h_vol(start=153206.462779274)),
    C2(h_vol(start=153206.462779274)),
    pro(d(start=993.441492649513)),
    Pm(start=6200))
    annotation (Placement(transformation(extent={{702,-446},{722,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump PompeAlimBP(
    Qv(start=0.193483547611118),
    mode=1,
    a3=400,
    a1(fixed=true) = -6000,
    Q(start=194.502, fixed=false),
    C2(h_vol(start=194669.0)),
    Pm(start=800000))
            annotation (Placement(transformation(extent={{742,-446},{762,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss perteChargeK2(
                                                         K=1e-4, mode=1,
    pro(d(start=994.045785814739)),
    C1(h_vol(start=194585), h(start=194585)),
    Pm(start=1546000))
    annotation (Placement(transformation(extent={{840,-446},{860,-426}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_extraction(            mode=1, Cvmax=
        2000,
    h(start=194500),
    Cv(start=2000),
    Pm(start=1549000))
                 annotation (Placement(transformation(extent={{802,-440},{822,
            -420}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapHP(C1(h_vol(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-58,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauHP(C2(h_vol(start=1398000),
        h(start=1398000))) " "
    annotation (Placement(transformation(
        origin={91.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauMP(C2(h_vol(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{424,49},{409,63}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapMP(C1(h_vol(start=2798000),
        h(start=2798000)))
    annotation (Placement(transformation(
        origin={236,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapBP(C2(h_vol(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={514,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauBP(C2(h_vol(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={663.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauBPsortie(C2(h_vol(
          start=550000), h(start=550000)))
    annotation (Placement(transformation(extent={{687,-11},{700,1}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitEauCondenseur(C2(h_vol(
          start=194585), h(start=194585)))
    annotation (Placement(transformation(
        origin={685.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ CapteurDebitVapCondenseur(C2(h_vol(
          start=2401000), h(start=2401000)))
    annotation (Placement(transformation(
        origin={684.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss lumpedStraightPipeK2(
                                                          K=Kin_SMP2,
    Pm(start=2651000),
    C1(
      P(fixed=true, start=2726700),
      h_vol(start=3046000),
      h(start=3046000)))
    annotation (Placement(transformation(extent={{114,-120},{94,-100}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_entree_TurbineHP(
    mode=0,
    C1(P(fixed=true, start=12680999.9999969)),
    Cvmax=Cvmax_THP,
    h(fixed=false, start=3433000),
    Cv(start=10875),
    Pm(fixed=false, start=12550000))
                 annotation (Placement(transformation(extent={{-124,-234},{-104,
            -214}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauHP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{-158,113},{-124,131}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_HP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500)
    annotation (Placement(transformation(extent={{-40,106},{-20,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauMP(                                                              k=1.05)
    annotation (Placement(transformation(extent={{173,113},{207,131}}, rotation=
           0)));
  ThermoSysPro.Examples.Control.Drum_LevelControl
    regulation_Niveau_MP(
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    add(k1=-1, k2=+1),
    Ti=500)
    annotation (Placement(transformation(extent={{262,106},{282,126}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauEauBP(                                                              k=1.75)
    annotation (Placement(transformation(extent={{470,126},{504,144}}, rotation=
           0)));
  Control.Drum_LevelControl regulation_Niveau_BP(
                     add(k1=-1, k2=+1), pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10)
    annotation (Placement(transformation(extent={{568,108},{588,128}}, rotation=
           0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{716,-246},{740,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
                                                add(k1=+1, k2=-1))
                                 annotation (Placement(transformation(extent={{
            758,-282},{778,-262}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineHP(Table=[0,0.8; 10,0.8; 600,0.8; 650,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-216},{
            -138,-142}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{944,-42},{906,
            -10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP(
    Initialvalue=1400,
    Finalvalue=1000,
    Duration=1000,
    Starttime=200000)
                   annotation (Placement(transformation(extent={{945,-96},{907,
            -64}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesBP(
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
    dynamic_mass_balance=true,
    P0=7010000,
    P(start=13129000))                    annotation (Placement(transformation(
          extent={{456,-98},{436,-78}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC VolumeECO_HP2_3(
    mode=1,
    V=1,
    h0=983786,
    h(start=983786),
    dynamic_mass_balance=true,
    P0=7000000,
    P(start=13219000))                    annotation (Placement(transformation(
          extent={{252,-20},{232,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP1(
                          mode=1,
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    Pm(start=13130000))
                 annotation (Placement(transformation(extent={{754,-98},{730,
            -122}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Vanne_alimentationMPHP2(
                          mode=1,
    Cvmax=308.931,
    h(start=565000),
    Cv(start=308.931),
    Pm(start=3126000))
                 annotation (Placement(transformation(extent={{804,-138},{780,
            -162}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesMp1(
    Initialvalue=0.8,
    Finalvalue=0.01,
    Duration=1000,
    Starttime=200000)
                     annotation (Placement(transformation(extent={{946,-150},{
            908,-118}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe arretPomesHP1(
    Initialvalue=0.8,
    Finalvalue=0.01,
    Duration=1000,
    Starttime=200000)
                     annotation (Placement(transformation(extent={{946,-194},{
            908,-162}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD VolumePreTHP(
    h0=3e6,
    h(start=3450835.48993987),
    dynamic_mass_balance=true,
    P0=12700000,
    P(start=12700000))                annotation (Placement(transformation(
        origin={-52,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC MelangeurPreTMP(
    h0=3523910,
    h(start=3523910.30137915),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=2400000))                     annotation (Placement(transformation(
        origin={-50,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve vanne_entree_TurbineMP(
    mode=0,
    C1(P(fixed=true, start=25.486e5)),
    Cvmax=Cvmax_TMP,
    h(fixed=false, start=3518000),
    Cv(start=3.312e6),
    Pm(fixed=false, start=2547000))
                 annotation (Placement(transformation(extent={{-124,-318},{-104,
            -298}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    ConstantVanneTurbineMP(Table=[0,0.8; 10,0.8; 600,0.8; 2000,0.8; 3000,0.8;
        3100,0.8]) annotation (Placement(transformation(extent={{-208,-300},{
            -138,-226}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(T0={303.16})
    annotation (Placement(transformation(extent={{5,68},{31,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource1(T0={303.16})
    annotation (Placement(transformation(extent={{326,68},{352,98}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource2(T0={303.16})
    annotation (Placement(transformation(extent={{585,64},{611,94}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Gain Gain_2GasTurbine(Gain=
       2) annotation (Placement(transformation(extent={{-18,-448},{2,-428}},
          rotation=0)));
  Combustion.BoundaryConditions.FuelSourcePQ sourceCombustible(
    Hum=0,
    Xo=0,
    Xn=0,
    Xs=0,
    rho=0.838,
    Q0=13.4368286133,
    T0=185 + 273.16,
    Xc=0.755,
    Xh=0.245,
    Cp=2255,
    LHV=46989e3)
          annotation (Placement(transformation(extent={{-421,24},{-385,60}},
          rotation=0)));
  WaterSteam.BoundaryConditions.SourcePQ sourceEau(             Q0=0.0)
          annotation (Placement(transformation(extent={{-473,27},{-445,57}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante Humidite(k=0.93)
    annotation (Placement(transformation(extent={{-539,23},{-518,43}}, rotation=
           0)));
  FlueGases.BoundaryConditions.SourcePQ SourceFumees(
    Xso2=0,
    Xco2=0,
    Xh2o=0,
    Xo2=0.20994,
    Q0=600,
    T0=29.4 + 273.16,
    P0=1.013e5)
    annotation (Placement(transformation(extent={{-539,-74},{-495,-28}},
          rotation=0)));
  FlueGases.TAC.GasTurbine GasTurbine(
    comp_tau_n=14.0178,
    comp_eff_n=0.87004,
    exp_tau_n=0.06458,
    exp_eff_n=0.89045,
    TurbQred=0.0175634,
    Kcham=2.02088,
    chambreCombustionTAC(Pea(fixed=false, start=14.0e5)),
    Wpth=1e6,
    Compresseur(
      is_eff(fixed=false, start=0.88),
      Xtau(fixed=false, start=1.00),
      Ps(start=1420000),
      Ts(start=678.07),
      Tis(start=630.75)),
    TurbineAgaz(
      Ps(fixed=false),
      is_eff(fixed=false, start=0.87),
      Pe(fixed=false, start=1333900),
      Te(start=1493.59),
      Ts(fixed=false, start=893.16),
      Tis(start=813.95)))
    annotation (Placement(transformation(extent={{-471,-115},{-341,13}},
          rotation=0)));

  InstrumentationAndControl.Blocks.Sources.Rampe rampeQfuel(
    Starttime=200,
    Duration=800,
    Initialvalue=13.507,
    Finalvalue=8.756)
                     annotation (Placement(transformation(extent={{-539,64},{
            -519,84}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe rampeIQair(
    Starttime=200,
    Duration=800,
    Finalvalue=415.70,
    Initialvalue=592.7)
                   annotation (Placement(transformation(extent={{-541,-20},{
            -521,0}}, rotation=0)));
equation
  connect(SurchauffeurHP3.Cws1, SurchauffeurHP2.Cws2)
    annotation (Line(points={{-294,-30},{-294,-10},{-174,-10},{-174,-30}},
        color={255,0,0}));
  connect(SurchauffeurHP2.Cws1, SurchauffeurHP1.Cws2)
    annotation (Line(points={{-174,-70},{-174,-90},{-54,-90},{-54,-70}}, color=
          {255,0,0}));
  connect(constante_vanne_vapeurHP.y, vanne_vapeurHP.Ouv)
    annotation (Line(points={{-28.5,74},{-32,74},{-32,67}}));
  connect(vanne_vapeurHP.C1, BallonHP.Cv)
    annotation (Line(points={{-22,50},{-2,50}}, color={255,0,0}));
  connect(GainChargeHP.C1, BallonHP.Cd)
    annotation (Line(points={{38,-90},{48,-90},{48,10},{38,10}}, color={255,128,
          0}));
  connect(BallonHP.Cm, EvaporateurHP.Cws2)
    annotation (Line(points={{-2,10},{-14,10},{-14,-30}}));
  connect(VolumeEvapHP.Cs, EvaporateurHP.Cws1)
    annotation (Line(points={{-12,-90},{-12,-70},{-14,-70}}, color={255,128,0}));
  connect(VolumeEvapHP.Ce1, GainChargeHP.C2)
                                      annotation (Line(points={{8,-90},{18,-90}},
        color={255,128,0}));
  connect(EconomiseurHP4.Cws1, EconomiseurHP3.Cws2)
    annotation (Line(points={{86,-70},{86,-82},{206,-82},{206,-70}}));
  connect(BallonMP.Cm, EvaporateurMP.Cws2)
    annotation (Line(points={{320,10},{306,10},{306,-30}}));
  connect(EvaporateurMP.Cws1, VolumeEvapMP.Cs)
    annotation (Line(points={{306,-70},{306,-80},{308,-80},{308,-90}}, color={
          255,128,0}));
  connect(VolumeEvapMP.Ce1, GainChargeMP.C2)
    annotation (Line(points={{328,-90},{338,-90}}, color={255,128,0}));
  connect(constante_vanne_vapeurMP.y, vanne_vapeurMP.Ouv)
    annotation (Line(points={{291.4,75},{288,75},{288,67}}));
  connect(SurchauffeurHP1.Cfg2, EvaporateurHP.Cfg1)        annotation (Line(
      points={{-44,-50},{-24,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurHP.Cfg2, EconomiseurHP4.Cfg1)        annotation (Line(
      points={{-4,-50},{96,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP4.Cfg2, SurchauffeurMP1.Cfg1)          annotation (Line(
      points={{76,-50},{136,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP1.Cfg2, EconomiseurHP3.Cfg1)           annotation (Line(
      points={{156,-50},{196,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurMP.Cfg2, EconomiseurHP2.Cfg1)           annotation (Line(
      points={{316,-50},{396,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP2.Cfg2, EconomiseurMP.Cfg1)           annotation (Line(
      points={{416,-50},{456,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurMP.Cfg2, EconomiseurHP1.Cfg1)           annotation (Line(
      points={{476,-50},{516,-50}},
      color={0,0,0},
      thickness=1));
  connect(GainChargeMP.C1, BallonMP.Cd)
    annotation (Line(points={{358,-90},{368,-90},{368,10},{358,10}}, color={255,
          128,0}));
  connect(SurchauffeurMP2.Cfg2, SurchauffeurHP1.Cfg1)          annotation (Line(
      points={{-104,-50},{-64,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP2.Cfg1, SurchauffeurHP2.Cfg2)           annotation (Line(
      points={{-124,-50},{-164,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cfg2, SurchauffeurHP2.Cfg1)           annotation (Line(
      points={{-224,-50},{-184,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurHP3.Cfg2, SurchauffeurMP3.Cfg1)           annotation (Line(
      points={{-284,-50},{-244,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurMP3.Cws1,SurchauffeurMP2. Cws2)
    annotation (Line(points={{-234,-30},{-234,10},{-114,10},{-114,-30}}, color=
          {255,0,0}));
  connect(SurchauffeurMP1.Cws2, MelangeurHPMP.Ce2) annotation (Line(
      points={{146,-70},{146,-85},{148,-85},{148,-100}},
      color={255,0,0},
      pattern=LinePattern.None));
  connect(vanne_vapeurBP.C1, BallonBP.Cv)
    annotation (Line(points={{558,50},{578,50}}, color={255,0,0}));
  connect(EvaporateurBP.Cws1, VolumeEvapBP.Cs)  annotation (Line(points={{566,
          -70},{566,-90},{572,-90}}, color={255,128,0}));
  connect(VolumeEvapBP.Ce1, GainChargeBP.C2)
                                        annotation (Line(points={{592,-90},{600,
          -90}}, color={255,128,0}));
  connect(BallonBP.Cd, GainChargeBP.C1)
                                       annotation (Line(points={{618,10},{628,
          10},{628,-90},{620,-90}}, color={255,128,0}));
  connect(EconomiseurBP.Cfg2, PuitsFumees.C)     annotation (Line(
      points={{690,-50},{712.2,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP3.Cfg2, SurchauffeurBP.Cfg1)  annotation (Line(
      points={{216,-50},{256,-50}},
      color={0,0,0},
      thickness=1));
  connect(SurchauffeurBP.Cfg2, EvaporateurMP.Cfg1)  annotation (Line(
      points={{276,-50},{296,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP1.Cfg2, EvaporateurBP.Cfg1) annotation (Line(
      points={{536,-50},{556,-50}},
      color={0,0,0},
      thickness=1));
  connect(EvaporateurBP.Cfg2, EconomiseurBP.Cfg1) annotation (Line(
      points={{576,-50},{670,-50}},
      color={0,0,0},
      thickness=1));
  connect(BallonBP.Cm, EvaporateurBP.Cws2)
    annotation (Line(points={{578,10},{566,10},{566,-30}}));
  connect(vanne_vapeurMP.C1, BallonMP.Cv)   annotation (Line(points={{298,50},{
          320,50}}, color={255,0,0}));
  connect(Vanne_alimentationMPHP.Ouv, constante_ballonBP.y)
    annotation (Line(points={{720,7},{720,12},{727.3,12}}));
  connect(SurchauffeurHP3.Cws2, DoubleDebitHP.Ce)
    annotation (Line(points={{-294,-70},{-294,-80},{-292,-80},{-292,-90}},
        color={255,0,0}));
  connect(SurchauffeurMP3.Cws2, DoubleDebitMP.Ce)
    annotation (Line(points={{-234,-70},{-234,-80},{-232,-80},{-232,-90}},
        color={255,0,0}));
  connect(VolumeCond1.Cs, perteChargeKCond1.C1) annotation (Line(points={{902,
          -308},{902,-282}}, color={0,0,255}));
  connect(Vanne_alimentationMPHP.C2, VolumeAlimMPHP.Ce1)
                                               annotation (Line(points={{730,
          -10},{742,-10}}, color={0,0,255}));
  connect(SurchauffeurBP.Cws2, DoubleDebitBP.Ce)
    annotation (Line(points={{266,-70},{266,-80},{268,-80},{268,-90}}, color={
          255,0,0}));
  connect(perteChargeK8.C2, PompeAlimMP.C1)
    annotation (Line(points={{790,-10},{797,-10},{804,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs1, perteChargeK8.C1)
    annotation (Line(points={{762,-10},{766,-10},{770,-10}},           color={0,
          0,255}));
  connect(VolumeAlimMPHP.Cs2, perteChargeK3.C1)
                                         annotation (Line(points={{752,-20},{
          752,-50},{770,-50}}, color={0,0,255}));
  connect(perteChargeK3.C2, PompeAlimHP.C1)
    annotation (Line(points={{790,-50},{804,-50}}, color={0,0,255}));
  connect(MelangeurPostTMP1.Ce2, PerteChargeZero2.C2) annotation (Line(points={
          {418,-239},{418,-278},{354,-278}}, color={255,0,0}));
  connect(perteChargeK.C2,PompeAlimBP. C1)
                                         annotation (Line(points={{722,-436},{
          742,-436}}, color={0,0,255}));
  connect(vanne_extraction.C2, perteChargeK2.C1) annotation (Line(points={{822,
          -436},{840,-436}}, color={0,0,255}));
  connect(vanne_alimentationHP.C1, CapteurDebitEauHP.C2)
    annotation (Line(points={{78,50},{86.3,50},{86.3,38.12}}));
  connect(vanne_vapeurHP.C2, CapteurDebitVapHP.C1) annotation (Line(points={{
          -42,50},{-53.2,50},{-53.2,14}}, color={255,0,0}));
  connect(CapteurDebitVapHP.C2, SurchauffeurHP1.Cws1) annotation (Line(points={
          {-53.2,1.88},{-53.2,-3.06},{-54,-3.06},{-54,-30}}, color={255,0,0}));
  connect(vanne_alimentationMP.C1, CapteurDebitEauMP.C2)
    annotation (Line(points={{398,50},{403.425,50},{403.425,50.4},{408.85,50.4}}));
  connect(CapteurDebitVapMP.C1, vanne_vapeurMP.C2) annotation (Line(points={{
          244,49.6},{260,49.6},{260,50},{278,50}}, color={255,0,0}));
  connect(CapteurDebitVapMP.C2, SurchauffeurMP1.Cws1) annotation (Line(points={
          {227.84,49.6},{146,49.6},{146,-30}}, color={255,0,0}));
  connect(CapteurDebitVapBP.C2, SurchauffeurBP.Cws1) annotation (Line(points={{
          505.84,49.6},{490,49.6},{490,-2},{266,-2},{266,-30}}, color={255,0,0}));
  connect(CapteurDebitVapBP.C1, vanne_vapeurBP.C2) annotation (Line(points={{
          522,49.6},{530,49.6},{530,50},{538,50}}, color={255,0,0}));
  connect(CapteurDebitEauBP.C2, vanne_alimentationBP.C1) annotation (Line(
        points={{658.3,40.12},{658.3,48},{650,48}}, color={0,0,255}));
  connect(CapteurDebitEauBPsortie.C2, Vanne_alimentationMPHP.C1) annotation (Line(
        points={{700.13,-9.8},{705.065,-9.8},{705.065,-10},{710,-10}}, color={0,
          0,255}));
  connect(CapteurDebitEauCondenseur.C2, perteChargeK.C1) annotation (Line(
        points={{680.3,-422.2},{680.3,-436},{702,-436}}, color={0,0,255}));
  connect(perteChargeK1.C2, CapteurDebitVapCondenseur.C1) annotation (Line(
        points={{660,-230},{679.3,-230},{679.3,-254}}, color={255,0,0}));
  connect(MelangeurHPMP.Ce1, MoitieDebitHP.Cs)
    annotation (Line(points={{148,-120},{148,-170},{134,-170}}, color={255,0,0}));
  connect(perteChargeK2.C2, MoitieDebitBP.Ce) annotation (Line(points={{860,
          -436},{862,-436},{862,-318},{872,-318}}, color={0,0,255}));
  connect(MoitieDebitBP.Cs, VolumeCond1.Ce3) annotation (Line(points={{886,-318},
          {892,-318}}, color={0,0,255}));
  connect(SurchauffeurMP2.Cws1, lumpedStraightPipeK2.C2)
    annotation (Line(points={{-114,-70},{-114,-110},{94,-110}}, color={255,0,0}));
  connect(lumpedStraightPipeK2.C1, MelangeurHPMP.Cs2)
    annotation (Line(points={{114,-110},{138.2,-110}}, color={255,0,0}));
  connect(DoubleDebitHP.Cs, vanne_entree_TurbineHP.C1) annotation (Line(points=
          {{-292,-110},{-292,-230},{-124,-230}}, color={255,0,0}));
  connect(DoubleDebitBP.Cs, PerteChargeZero2.C1) annotation (Line(points={{268,
          -110},{268,-278},{334,-278}}, color={255,0,0}));
  connect(PompeAlimBP.C2, vanne_extraction.C1) annotation (Line(points={{762,
          -436},{802,-436}}, color={0,0,255}));
  connect(BallonHP.yLevel,regulation_Niveau_HP. MesureNiveauEau)
    annotation (Line(points={{-4,30},{-68,30},{-68,125},{-40.5,125}}));
  connect(regulation_Niveau_HP.SortieReelle1, vanne_alimentationHP.Ouv)
    annotation (Line(points={{-19.5,107},{68,107},{68,67}}));
  connect(ConsigneNiveauEauMP.y,regulation_Niveau_MP. ConsigneNiveauEau)
    annotation (Line(points={{208.7,122},{234,122},{234,110},{261.5,110}}));
  connect(BallonMP.yLevel,regulation_Niveau_MP. MesureNiveauEau)
    annotation (Line(points={{318.1,30},{252,30},{252,125},{261.5,125}}));
  connect(regulation_Niveau_MP.SortieReelle1, vanne_alimentationMP.Ouv)
    annotation (Line(points={{282.5,107},{377.25,107},{377.25,67},{388,67}}));
  connect(ConsigneNiveauEauBP.y,regulation_Niveau_BP. ConsigneNiveauEau)
    annotation (Line(points={{505.7,135},{529.85,135},{529.85,112},{567.5,112}}));
  connect(BallonBP.yLevel,regulation_Niveau_BP. MesureNiveauEau)
    annotation (Line(points={{576,30},{518,30},{518,127},{567.5,127}}));
  connect(ConsigneNiveauCondenseur1.y, regulation_Niveau_Condenseur.ConsigneNiveauEau)
    annotation (Line(points={{741.2,-238},{752,-238},{752,-269},{757.5,-269}}));
  connect(regulation_Niveau_Condenseur.SortieReelle1, vanne_extraction.Ouv)
    annotation (Line(points={{778.5,-281},{812,-281},{812,-419}}));
  connect(CapteurDebitEauBP.C1, EconomiseurBP.Cws2)
    annotation (Line(points={{658.3,28},{660,28},{660,6},{680,6},{680,-30}}));
  connect(EconomiseurBP.Cws1, perteChargeKCond1.C2) annotation (Line(points={{
          680,-70},{680,-186},{902,-186},{902,-258}}));
  connect(CapteurDebitVapCondenseur.Measure, regulation_Niveau_Condenseur.MesureDebitVapeur)
    annotation (Line(points={{691.13,-264},{704,-264},{704,-280.9},{757.6,
          -280.9}}));
  connect(regulation_Niveau_Condenseur.MesureDebitEau,
    CapteurDebitEauCondenseur.Measure) annotation (Line(points={{757.45,-274.95},
          {750,-274.95},{750,-310},{792,-310},{792,-412},{692.13,-412}}));
  connect(ConstantVanneTurbineHP.y, vanne_entree_TurbineHP.Ouv)
    annotation (Line(points={{-134.5,-179},{-114,-179},{-114,-213}}));
  connect(regulation_Niveau_BP.SortieReelle1, vanne_vapeurBP.Ouv)
    annotation (Line(points={{588.5,109},{600,109},{600,90},{548,90},{548,67}}));
  connect(vanne_alimentationBP.Ouv, constante_vanne_vapeurBP.y)
    annotation (Line(points={{640,65},{640,81},{653.4,81}}));
  connect(EconomiseurHP1.Cws2, VolumeECO_HP1_2.Ce1) annotation (Line(points={{
          526,-70},{526,-88},{456,-88}}, color={0,0,255}));
  connect(VolumeECO_HP1_2.Cs, EconomiseurHP2.Cws1) annotation (Line(points={{
          436,-88},{406,-88},{406,-70}}, color={0,0,255}));
  connect(EconomiseurHP2.Cws2, VolumeECO_HP2_3.Ce1) annotation (Line(points={{
          406,-30},{406,-10},{252,-10}}, color={0,0,255}));
  connect(VolumeECO_HP2_3.Cs, EconomiseurHP3.Cws1) annotation (Line(points={{
          232,-10},{206,-10},{206,-30}}, color={0,0,255}));
  connect(Vanne_alimentationMPHP1.C1, PompeAlimHP.C2)
    annotation (Line(points={{754,-102.8},{842,-102.8},{842,-50},{824,-50}}));
  connect(PompeAlimMP.C2, Vanne_alimentationMPHP2.C1) annotation (Line(points={
          {824,-10},{870,-10},{870,-142.8},{804,-142.8}}, color={0,0,255}));
  connect(arretPomesMp1.y, Vanne_alimentationMPHP1.Ouv)
    annotation (Line(points={{906.1,-134},{856,-134},{856,-122},{742,-122},{742,
          -123.2}}));
  connect(arretPomesHP1.y, Vanne_alimentationMPHP2.Ouv)
    annotation (Line(points={{906.1,-178},{883.05,-178},{883.05,-163.2},{792,
          -163.2}}));
  connect(Vanne_alimentationMPHP1.C2, EconomiseurHP1.Cws1) annotation (Line(
        points={{730,-102.8},{636,-102.8},{636,-106},{548,-106},{548,-6},{526,
          -6},{526,-30}}, color={0,0,255}));
  connect(EconomiseurMP.Cws1, Vanne_alimentationMPHP2.C2)
    annotation (Line(points={{466,-70},{466,-142.8},{780,-142.8}}));
  connect(ConstantVanneTurbineMP.y, vanne_entree_TurbineMP.Ouv)
    annotation (Line(points={{-134.5,-263},{-114,-263},{-114,-297}}));
  connect(vanne_entree_TurbineHP.C2, VolumePreTHP.Ce) annotation (Line(points={
          {-104,-230},{-62,-230}}, color={255,0,0}));
  connect(DoubleDebitMP.Cs, vanne_entree_TurbineMP.C1) annotation (Line(points=
          {{-232,-110},{-232,-314},{-124,-314}}, color={255,0,0}));
  connect(vanne_entree_TurbineMP.C2, MelangeurPreTMP.Ce1) annotation (Line(
        points={{-104,-314},{-60,-314}}, color={255,0,0}));
  connect(SourceCaloporteur.C, Condenseur.Cee) annotation (Line(points={{620,-353},
          {638,-353},{638,-352.8},{637,-352.8}},     color={0,0,255}));
  connect(Condenseur.Cse, PuitsCaloporteur.C) annotation (Line(points={{717,-352},
          {736,-352}},       color={0,0,255}));
  connect(CapteurDebitVapCondenseur.C2, Condenseur.Cv) annotation (Line(points={{679.3,
          -274.2},{679.3,-288.1},{677,-288.1},{677,-304}},         color={0,0,
          255}));
  connect(CapteurDebitEauCondenseur.C1, Condenseur.Cl)
    annotation (Line(points={{680.3,-402},{677.8,-402},{677.8,-384}}));
  connect(ConsigneNiveauEauHP.y, regulation_Niveau_HP.ConsigneNiveauEau)
    annotation (Line(points={{-122.3,122},{-100,122},{-100,110},{-40.5,110}}));
  connect(Condenseur.yNiveau, regulation_Niveau_Condenseur.MesureNiveauEau)
    annotation (Line(points={{721,-372.8},{780,-372.8},{780,-326},{732,-326},{732,
          -263},{757.5,-263}}));
  connect(BallonBP.Cs, CapteurDebitEauBPsortie.C1) annotation (Line(points={{
          578,22},{564,22},{564,16},{642,16},{642,-9.8},{687,-9.8}}, color={0,0,
          255}));
  connect(BallonBP.Ce1, vanne_alimentationBP.C2)
    annotation (Line(points={{618,50},{624,50},{624,48},{630,48}}));
  connect(BallonMP.Ce1, vanne_alimentationMP.C2)
    annotation (Line(points={{358,50},{378,50}}));
  connect(BallonHP.Ce1, vanne_alimentationHP.C2)
    annotation (Line(points={{38,50},{58,50}}));
  connect(TurbineHP.Cs, MoitieDebitHP.Ce) annotation (Line(points={{38.2,-230},
          {74,-230},{74,-170},{114,-170}}, color={255,0,0}));
  connect(VolumePreTHP.Cs3, TurbineHP.Ce) annotation (Line(points={{-42,-230},{
          -2.2,-230}}, color={255,0,0}));
  connect(MelangeurPreTMP.Cs, TurbineMP.Ce) annotation (Line(points={{-40,-314},
          {106,-314},{106,-230},{317.8,-230}}, color={255,0,0}));
  connect(TurbineMP.Cs, MelangeurPostTMP1.Ce1) annotation (Line(points={{358.2,
          -230},{408,-230}}, color={255,0,0}));
  connect(MelangeurPostTMP1.Cs, TurbineBP.Ce) annotation (Line(points={{428,
          -230},{575.8,-230}}, color={255,0,0}));
  connect(TurbineBP.Cs, perteChargeK1.C1) annotation (Line(points={{616.2,-230},
          {640,-230}}, color={255,0,0}));
  connect(EconomiseurMP.Cws2, CapteurDebitEauMP.C1) annotation (Line(points={{
          466,-30},{470,-30},{470,50.4},{424,50.4}}, color={0,0,255}));
  connect(TurbineMP.MechPower, Alternateur.Wmec2)
    annotation (Line(points={{360,-248},{368,-248},{368,-378},{402,-378}}));
  connect(TurbineBP.MechPower, Alternateur.Wmec1) annotation (Line(points={{618,
          -248},{628,-248},{628,-290},{388,-290},{388,-358},{402,-358}}));
  connect(TurbineHP.MechPower, Alternateur.Wmec3)
    annotation (Line(points={{40,-248},{48,-248},{48,-398},{402,-398}}));
  connect(heatSource.C[1], BallonHP.Cex) annotation (Line(points={{18,68.3},{18,
          50}}, color={191,95,0}));
  connect(heatSource1.C[1], BallonMP.Cex) annotation (Line(points={{339,68.3},{
          339,50}}, color={191,95,0}));
  connect(heatSource2.C[1], BallonBP.Cex) annotation (Line(points={{598,64.3},{
          598,50}}, color={191,95,0}));
  connect(Gain_2GasTurbine.y, Alternateur.Wmec5)
    annotation (Line(points={{3,-438},{402,-438}}));
  connect(CapteurDebitEauHP.C1, EconomiseurHP4.Cws2)
    annotation (Line(points={{86.3,26},{86,26},{86,-30}}, smooth=Smooth.None));
  connect(PompeAlimMP.rpm_or_mpower, arretPomesMp.y)
    annotation (Line(points={{814,-21},{814,-26},{904.1,-26}}, smooth=Smooth.None));
  connect(PompeAlimHP.rpm_or_mpower, arretPomesHP.y)
    annotation (Line(points={{814,-61},{814,-80},{905.1,-80}}, smooth=Smooth.None));
  connect(PompeAlimBP.rpm_or_mpower, arretPomesBP.y) annotation (Line(points={{
          752,-447},{754,-447},{754,-460},{878,-460},{878,-442},{905.1,-442}},
        smooth=Smooth.None));
  connect(SourceFumees.C,GasTurbine. Entree_air)
                                                annotation (Line(
      points={{-495,-51},{-471,-51}},
      color={0,0,0},
      thickness=1));
  connect(sourceCombustible.C,GasTurbine. Entree_combustible) annotation (Line(
        points={{-385,42},{-367,42},{-367,13}}, color={0,0,0}));
  connect(sourceEau.C,GasTurbine. Entree_eau_combustion)
    annotation (Line(points={{-445,42},{-445,13}}, color={0,0,255}));
  connect(sourceCombustible.IMassFlow,rampeQfuel. y)
    annotation (Line(points={{-403,51},{-403,74},{-518,74}}));
  connect(rampeIQair.y,SourceFumees. IMassFlow)
    annotation (Line(points={{-520,-10},{-520,-36},{-517,-36},{-517,-39.5}}));
  connect(Humidite.y, GasTurbine.Huminide)
    annotation (Line(points={{-516.95,33},{-487,33},{-487,-12.6},{-473.6,-12.6}}));
  connect(GasTurbine.Sortie_fumees, SurchauffeurHP3.Cfg1) annotation (Line(
      points={{-341,-51},{-290,-50},{-304,-50}},
      color={0,0,0},
      thickness=1));
  connect(GasTurbine.PuissanceMeca, Gain_2GasTurbine.u)
    annotation (Line(points={{-338.4,-76.6},{-326,-76.6},{-326,-438},{-19,-438}}));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false,extent={{-550,
            -460},{950,150}},
        initialScale=0.1)),
    experiment(StopTime=2500, Tolerance=0.001),
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
end CombinedCycle_Load_100_50;
