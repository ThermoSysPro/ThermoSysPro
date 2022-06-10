within ThermoSysPro.Fluid.Examples.CombinedCyclePowerPlant;
model CombinedCycle_Load_100_50 "CCPP model to simulate a load variation from 100% to 50%"
  parameter Real CstHP(fixed=false,start=7872243.329137064)
    "Stodola's ellipse coefficient HP";
  parameter Real CstMP(fixed=false,start=250346.99234192327)
    "Stodola's ellipse coefficient MP";
  parameter Real CstBP(fixed=false,start=10510.769959447052)
    "Stodola's ellipse coefficient BP";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveAHP(fixed=false, start=135)
    "Maximum CV: alim. valve HP Drum  ";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveAMP(fixed=false, start=70)
    "Maximum CV: alim. valve MP Drum ";
  parameter ThermoSysPro.Units.xSI.Cv CvmaxValveVBP(fixed=false, start=32000)
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

  parameter ThermoSysPro.Units.xSI.Cv Cvmax_THP(fixed=false, start=8000)
    "Maximum CV input Turbine HP ";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax_TMP(fixed=false, start=1500)
    "Maximum CV input Turbine MP ";

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonHP(
    L=16.27,
    Vertical=false,
    hl(fixed=false, start=1459929.6557225615),
    hv(fixed=false, start=2664756.9335524077),
    Vv(fixed=false),
    R=1.05,
    xmv(fixed=false),
    P(fixed=false, start=12726786.684064418),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    Pfond(start=12733698.15963666),
    Tp(start=589.4448369021196))
                     annotation (Placement(transformation(extent={{38,10},{-2,
            50}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationHP(
      Cvmax=CvmaxValveAHP,
    C1(P(start=13374652.64958711),
                            h_vol_2(start=1398250.7267619045)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))   annotation (Placement(transformation(extent={{78,46},{58,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurHP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{-18,70},{-28,78}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurHP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2664756.9335524077)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12725274.444912266))   annotation (Placement(transformation(extent={{-22,46},{-42,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeHP(
    z2=0,
    Q(start=150, fixed=true),
    z1=10.83,
    K=KgainChargeHP,
    C2(P(start=12758125.131063813)),
    h(start=1474422.14552527),
    Pm(start=12704000))
            annotation (Placement(transformation(
        origin={28,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapHP(V=5,
    h(start=1459929.6557225615),
    P(start=12704000))                         annotation (Placement(transformation(
          extent={{8,-100},{-12,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurHP(
    Dint=32.8e-3,
    Ntubes=1476,
    L=20.7,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-5.74e7,-2.67e7,-1.24e7}),
      Tp(start={607.9743232022095,605.444949344346,604.0557720629383}),
      Tp1(start={606.517435991606,604.7669177434965,603.7415072757717})),
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
      deltaT(start={106,49,23}),
      T2(start={755.54833984375,674.4067359457392,636.0812177546504,
            618.193603515625}),
      T1(start={714.9775457406769,655.2439768501948,627.1374112677474}),
      Tp(start={609.3279079642047,606.0749042484599,604.3477535039484})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=10.83,
      option_temperature(start=false)=
                         false,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={5.74e7,2.67e7,1.24e7}),
      h(start={1459929.625,1842858.7345266847,2021072.953461077,
            2103674.4922587443,1459929.625}),
      hb(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134}),
      P(start={12758125.0,12740268.20023451,12734647.766847359,
            12730499.45519915,12726787.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-14,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP4(
    Ns=3,
    L=20.726,
    Dint=0.0266,
    Ntubes=246,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-3.5e6,-2.63e6,-2e6}),
      Tp(start={576.9773977809047,582.0830364334571,585.8301318496927}),
      Tp1(start={576.3268547206692,581.5931147025063,585.4596791589167})),
    Cws1(P(start=13301170.910895599),
       h_vol_2(start=1291418.4097512758)),
    Cws2(h_vol_1(start=1398250.726761905)),
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
      deltaT(start={38,29,22}),
      T2(start={618.193603515625,613.1248964422501,609.3035158562986,
            606.41162109375}),
      T1(start={615.6592506115472,611.2142061492743,607.857569142044}),
      Tp(start={577.5724142989593,582.5311413173429,586.1689648703535})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      z2=0,
      option_temperature(start=false)=
                         false,
      inertia=true,
      dW1(start={3.5e6,2.63e6,2e6}),
      h(start={1291418.375,1337416.303924748,1372057.1590979556,
            1398250.726761905,1398250.75}),
      hb(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578}),
      P(start={13301171.0,13320152.543490017,13338662.827011712,
            13356802.623346366,13374653.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={86,-50},
        extent={{20,20},{-20,-20}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP1(
    Ns=3,
    L=20.4,
    Dint=0.0324,
    Ntubes=246,
    ExchangerWall(e=0.0028, lambda=37.61,
    dW1(start={-9.8e6,-7.7e6,-5.9e6}),
      Tp(start={641.773975889456,659.2620935819541,674.5601453613823}),
      Tp1(start={639.7214032623475,657.645496743186,673.3086347868172})),
    Cws1(h_vol_2(start=2664756.9335524077)),
    Cws2(P(start=12720371.43140221),
      h_vol_1(start=2973076.465167672)),
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
      deltaT(start={138,108,84}),
      T2(start={788.2433471679688,774.636330839027,763.888258455914,
            755.54833984375}),
      T1(start={781.4398445109163,769.2622946474705,759.7183069957642}),
      Tp(start={643.6693613731671,660.754890543465,675.715814566568})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      option_temperature(start=false)=
                         false,
      inertia=true,
      dW1(start={9.8e6,7.7e6,5.9e6}),
      h(start={2664757.0,2793366.8463525265,2894659.427023337,2973076.465167672,
            2973076.5}),
      hb(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983}),
      P(start={12723762.0,12723704.875007024,12723025.392511783,
            12721873.859626876,12720371.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-54,-50},
        extent={{-20,20},{20,-20}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP3(
    Dint=26.6e-3,
    Ntubes=1476,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
          dW1(start={-1.6e7,-5.6e6,-2.1e6}),
      Tp(start={556.7923625573021,563.4515089057426,565.7949884705216}),
      Tp1(start={556.3098450461794,563.2778280617686,565.7320909419939})),
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
      St=5, deltaT(start={34,12,4.4}),
      T2(start={602.6719360351563,579.980900946576,571.7829862725544,
            568.8102416992188}),
      T1(start={591.3264094805266,575.8819436095652,570.2965996068247}),
      Tp(start={557.2336952021615,563.6103653709807,565.8525174347154})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={1.6e7,5.6e6,2.1e6}),
      h(start={986348.0625,1191052.0456419336,1264734.6677716642,
            1291418.4097512758,1291418.375}),
      hb(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855}),
      P(start={13219328.0,13241437.958285147,13261883.227869928,
            13281654.651763307,13301171.0}),
      T0(start={290.0,290.0,290.0})))
                  annotation (Placement(transformation(
        origin={206,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP2(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-5e6,-3e6,-2.e6}),
      Tp(start={491.54343078281,498.9069980271022,503.5184174104173}),
      Tp1(start={491.3392380231037,498.7785262547952,503.4374982277421})),
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
      St=5, deltaT(start={36,23,14}),
      T2(start={531.16064453125,523.8360138077611,519.2214124321695,
            516.3124389648438}),
      T1(start={527.4983362936189,521.5287131199652,517.7669224567446}),
      Tp(start={491.73019484551236,499.02450420201814,503.5924298060023})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={5e6,3e6,2.e6}),
      h(start={854493.25,919592.0464622772,960550.2028257779,986348.0919441726,
            986348.0625}),
      hb(start={854494.5625,915007.018247822,957243.396653824,983786.364226731}),
      P(start={13129347.0,13152374.515059257,13174952.371260952,
            13197235.505730344,13219328.0}),
      T0(start={290.0,290.0,290.0})))
                  annotation (Placement(transformation(
        origin={406,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP1(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-9.9999e6,-5e6,-2.4e6}),
      Tp(start={460.16002911133717,469.99835357411166,474.7738719222592}),
      Tp1(start={459.7281425156256,469.7896188414262,474.67326898241726})),
    L=20.726,
    Ntubes=1107,
    Cws1(h_vol_2(start=618649.6677733721)),
    ExchangerFlueGasesMetal(
      Dext=31.8e-3,
      step_L=74e-3,
      step_T=86.9e-3,
      Fa=1,
      CSailettes=8.30057632,
      K(fixed=true, start=40.24),
      p_rho=1.13,
      Encras=Encras_EHP1,
      St=5,   deltaT(start={41,20,10}),
      T2(start={509.31475830078125,493.76452187742854,486.23046610566547,
            482.5950622558594}),
      T1(start={501.5396335543568,489.997493991547,484.4127676365523}),
      Tp(start={460.5550523989298,470.18927193360446,474.8658879848841})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      z1=10.767,
      inertia=true,
      dW1(start={9.9999e6,5e6,2.4e6}),
      h(start={618649.6875,756067.8313424552,822483.2837402308,854493.240474255,
            854493.25}),
      hb(start={618651.9375,752176.893518976,816707.727773953,847728.424287614}),
      advection=true,
      dynamic_mass_balance=true,
      P(start={13034952.0,13059418.53296798,13083081.248541538,
            13106320.315256517,13129347.0}),
      T0(start={290.0,290.0,290.0})))
                  annotation (Placement(transformation(
        origin={526,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP2(
    Ns=3,
    L=20.4,
    Dint=32e-3,
    Ntubes=246,
    ExchangerWall(e=3e-3, lambda=27,
          dW1(start={-8.8e6,-6.6e6,-4.9e6}),
      Tp(start={718.0864855457228,738.9518857688491,755.2055454298172}),
      Tp1(start={715.3026673550778,736.860075660393,753.6461561287115})),
    Cws2(P(start=12711006.754972342),
      h_vol_1(start=3240813.8516343245)),
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
      deltaT(start={124,93,70}),
      T2(start={850.646484375,838.5707346201303,829.4749488031354,
            822.6819458007813}),
      T1(start={844.6086089059804,834.0228417116329,826.0784372242802}),
      Tp(start={720.6412271937046,740.871563720893,756.6366147445857})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.83,
      inertia=true,
      dW1(start={8.8e6,6.6e6,4.9e6}),
      h(start={2973076.5,3088900.88921149,3175933.4050769014,3240813.8516343245,
            3240813.75}),
      hb(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722}),
      P(start={12720371.0,12718678.034082344,12716464.21434507,
            12713872.892207509,12711007.0}),
      T0(start={290.0,290.0,290.0})))
                  annotation (Placement(transformation(
        origin={-174,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP3(
    Ns=3,
    L=20.4,
    Ntubes=246,
    ExchangerWall(lambda=27, e=5e-3,
    dW1(start={-6.3e6,-4.7e6,-3.6e6}),
      Tp(start={789.3906813408935,806.8419831862884,820.1561431707274}),
      Tp1(start={785.7263795421367,804.0878954218736,818.093373707382})),
    Dint=28e-3,
    Cws2(h_vol_1(start=3433271.775819776)),
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
      deltaT(start={97,73,55}),
      T2(start={894.2188110351563,885.636025090525,879.1746662824661,
            874.3292236328125}),
      T1(start={889.9274067093704,882.4053456864956,876.7519418617093}),
      Tp(start={792.5370292454647,809.2067770105702,821.927337447906})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.726,
      inertia=true,
      dW1(start={6.3e6,4.7e6,3.6e6}),
      h(start={3240813.75,3323965.684475156,3386462.568744374,3433271.775819776,
            3433271.75}),
      hb(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987}),
      P(start={12711007.0,12704270.150400551,12696927.059489354,
            12689132.094962938,12681000.0}),
      T0(start={290.0,290.0,290.0})))
                  annotation (Placement(transformation(
        origin={-294,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonMP(
    L=16.27,
    Vertical=false,
    P0=27.29e5,
    hl(fixed=false, start=980708.0463805634),
    hv(fixed=false, start=2798574.7604119307),
    Vv(fixed=false),
    R=1.05,
    P(fixed=false, start=2733824.789876998),
    zl(start=1.05, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=2742370.2498246767),
    Tp(start=497.3822823273814))
                     annotation (Placement(transformation(extent={{358,10},{320,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurMP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{304,70},{292,80}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationMP(
      Cvmax=CvmaxValveAMP,
    C1(P(start=3216971.701899643),
    h_vol_2(start=944504.749093579)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2975000))   annotation (Placement(transformation(extent={{398,46},{378,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurMP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2798574.7604119307)),
    h(fixed=false, start=2798000),
    Cv(start=23914.7),
    Pm(fixed=false, start=2732575.5179918623))   annotation (Placement(transformation(extent={{298,46},{278,66}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurMP(
    Dint=32.8e-3,
    L=20.767,
    Ntubes=738,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-9.7e7,-7.6e6,-5.8e6}),
      Tp(start={504.98976100715464,504.26964479130794,503.6922361659351}),
      Tp1(start={504.4959569394237,503.8875506396794,503.39662949233303})),
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.83,
      continuous_flow_reversal=true,
      inertia=true,
          dW1(start={9.7e7,7.6e6,5.8e6}),
      P(start={2773367.25,2751227.106127094,2743473.7578241928,
            2738204.9403230133,2733824.75}),
      h(start={980708.0625,1045813.9695051656,1096191.4250344052,
            1135165.8819583436,980708.0625}),
      hb(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464}),
      T0(start={290.0,290.0,290.0})),
    Cws1(P(start=2773367.372876323)),
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
      deltaT(start={53,41,32}),
      T2(start={565.2481689453125,550.9126306026692,539.787269523939,
            531.16064453125}),
      T1(start={558.0803978580261,545.349950063304,535.4739641517078}),
      Tp(start={505.44855126670757,504.624646069051,503.9668824707551})))
                          annotation (Placement(transformation(
        origin={306,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeMP(
    z2=0,
    z1=10.83,
    Q(start=150, fixed=true),
    K=KgainChargeMP,
    Pm(start=2734000),
    h(start=978914.570821827))
            annotation (Placement(transformation(
        origin={348,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapMP(V=5,
    h(start=980708.0463805634),
    P(start=2734000))                         annotation (Placement(transformation(
          extent={{328,-100},{308,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurMP(
    ExchangerWall(e=2.6e-3, lambda=47,
        dW1(start={-3e6,-1.4e6,-740379}),
      Tp(start={469.31277462346344,487.36995421739016,497.00024549998545}),
      Tp1(start={468.830886627779,487.11263557868836,496.8627293559427})),
    L=20.726,
    Ns=3,
    Dint=26.6e-3,
    Ntubes=246,
    Cws1(h_vol_2(start=565106.2802015315)),
    Cws2(h_vol_1(start=944504.7490935794)),
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
      deltaT(start={45,24,13}),
      T2(start={516.3124389648438,512.4675048876576,510.41305969109146,
            509.31475830078125}),
      T1(start={514.3899686844887,511.4402822893745,509.8639024611882}),
      Tp(start={469.75353148474505,487.6053096442755,497.12602407127685})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.767,
      z2=0,
      inertia=true,
      dW1(start={3e6,1.4e6,740379}),
      h(start={565106.25,773641.4896138782,884995.1575722523,944504.7490935792,
            944504.75}),
      hb(start={565108.5,727745.440528479,829820.124314816,892414.570867187}),
      P(start={3124223.75,3148825.327098676,3172192.2961615147,
            3194799.9976396263,3216971.75}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={466,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP1(
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.3e6,-0.80263e6,
                                -501864}),
      Tp(start={558.2379692767729,574.1762943611731,584.4002179866045}),
      Tp1(start={557.8513010794924,573.9323757073441,584.2477131820202})),
    L=20.726,
    Ns=3,
    Dint=32.8e-3,
    Ntubes=123,
    Cws1(h_vol_2(start=2798574.7604119307)),
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
      deltaT(start={45,30,19}),
      T2(start={606.41162109375,604.5654891969185,603.4004814494892,
            602.6719360351563}),
      T1(start={605.488555812354,603.9829853232038,603.0361997319833}),
      Tp(start={558.5972202716488,574.4029176513201,584.54190924323})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=0,
      z1=10.77,
      inertia=true,
      dW1(start={1.3e6,0.80263e6,501864}),
      h(start={2798574.75,2900855.9998369273,2965377.215724287,
            3005717.6950751985,3040562.75}),
      hb(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156}),
      P(start={2731326.25,2730394.924575977,2729276.921848465,
            2728029.2082540947,2726700.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={146,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.VolumeB MelangeurHPMP(
    Ce1(h(start=3046256.0341363903)),
    h(start=3040562.6721177064),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={148,-110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP2(
    Ns=3,
    L=20.4,
    Dint=39.3e-3,
    Ntubes=369,
    ExchangerWall(e=2.6e-3, lambda=36.86,
    dW1(start={-1.15e7,-7.9e6,-5.5e6}),
      Tp(start={689.1325590707521,714.3255084496102,731.974510062409}),
      Tp1(start={687.8673243896432,713.4490802987744,731.369523912658})),
    Cws1(P(start=2575582.5771302995),
      h_vol_2(start=3040562.6721177064)),
    Cws2(P(start=2558239.090625735),
      h_vol_1(start=3321940.994604838)),
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
      deltaT(start={125,86,60}),
      T2(start={822.6819458007813,806.8523532375756,795.852828640494,
            788.2433471679688}),
      T1(start={814.7671394415003,801.3525909390348,792.0480934116497}),
      Tp(start={690.3215978858725,715.1491557188672,732.5430623045928})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={1.15e7,7.9e6,5.5e6}),
      h(start={3040562.75,3170178.6567147295,3259963.658181113,
            3321940.994604838,3321941.0}),
      hb(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389}),
      P(start={2575582.5,2571900.999964748,2567682.4202753096,
            2563090.6820579167,2558239.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-114,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP3(
    Ns=3,
    L=20.4,
    Ntubes=369,
    Dint=45.6e-3,
    ExchangerWall(e=2.6e-3, lambda=27,
    dW1(start={-8e6,-5.5e6,-3.8e6}),
      Tp(start={786.239853752146,802.8777020553458,814.3692554800219}),
      Tp1(start={785.1915402608809,802.1579544921993,813.8760433493436})),
    Cws2(h_vol_1(start=3517975.7051807973)),
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
      deltaT(start={82,56,38}),
      T2(start={874.3292236328125,863.3655435931397,855.822658205448,
            850.646484375}),
      T1(start={868.8473805170461,859.5941008992938,853.2345706986391}),
      Tp(start={787.2330782757132,803.5596268196659,814.8365492691358})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={8e6,5.5e6,3.8e6}),
      h(start={3321941.0,3412821.580454202,3475218.0684875553,
            3517975.7051807973,3517975.75}),
      hb(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916}),
      P(start={2558239.0,2556052.5796892336,2553681.6710159215,
            2551184.3906656993,2548600.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={-234,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonBP(
    Vertical=false,
    P0=5e5,
    Vv(fixed=false),
    L=8,
    hl(fixed=false, start=550072.7232069891),
    hv(fixed=false, start=2684673.580149807),
    R=2,
    P(fixed=false, start=485579.1243268126),
    zl(start=1.75, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=501612.0798822072),
    Tp(start=406.2632923392337))
                     annotation (Placement(transformation(extent={{618,10},{578,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurBP(                                                              k=0.5)
    annotation (Placement(transformation(extent={{666,76},{654,86}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurBP(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=510622.8582477031),
    h_vol_1(start=2684673.580149807)),
    h(start=2685000),
    Cv(start=1),
    Pm(start=498000))   annotation (Placement(transformation(extent={{558,46},{538,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationBP(
    Cvmax=285,
    C1(h_vol_2(start=509236.1596958067)),
    h(fixed=false, start=509000),
    Cv(start=142.5),
    Pm(fixed=false, start=957583.6711025466))   annotation (Placement(transformation(extent={{650,44},{630,64}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeBP(
    z2=0,
    z1=10.767,
    Q(start=50, fixed=false),
    K=32766,
    rho(start=934.2358753989836),
    Pm(start=564000),
    h(start=549249.519022482))
            annotation (Placement(transformation(
        origin={610,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapBP(h(start=550072.7232069891),
    V=5,
    P(start=564000))                         annotation (Placement(transformation(
          extent={{592,-100},{572,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurBP(
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.24e7,-8.5e6,-5.8e6}),
      Tp(start={427.75117227047275,426.57196634952743,425.692416702357}),
      Tp1(start={427.2791524733697,426.249857647769,425.4722112637204})),
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
      deltaT(start={45,31,21}),
      T2(start={482.5950622558594,464.01748118772224,451.30051770870455,
            442.58880615234375}),
      T1(start={473.3062751775807,457.6589994482134,446.94466391603106}),
      Tp(start={428.18972290092955,426.87123552234135,425.89700819308825})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={1.24e7,8.5e6,5.8e6}),
      h(start={550072.75,798514.7797723989,968052.8982857756,1083955.4353773424,
            550072.75}),
      hb(start={550075.0,765243.011613326,912673.256542569,1013555.73710231}),
      Q(start={50.00030606442327,50.00030606442327,50.00030606442327,
            50.00030606442327}),
      P(start={512574.0,487903.6002327947,486912.76813325885,486233.0185244784,
            485579.125}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={566,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_ballonBP(k=1)
    annotation (Placement(transformation(extent={{742,6},{728,18}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP(
    Cvmax=308.931,
    C1(h_vol_2(start=550072.7232069891)),
    h(start=550000),
    Cv(start=308.931),
    Pm(start=404001.70325999695))
                 annotation (Placement(transformation(extent={{710,-14},{730,6}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurBP(
    Ns=3,
    L=20.726,
    Dint=39.3e-3,
    Ntubes=123,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.1e6,-782901,-559798}),
      Tp(start={475.35471340675434,500.0471952971929,518.0415300925415}),
      Tp1(start={475.07666786714793,499.8473601819379,517.8986430965637})),
    Cws1(h_vol_2(start=2684673.580149807)),
    Cws2(h_vol_1(start=2914519.282601244)),
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
      deltaT(start={92,66,47}),
      T2(start={568.8102416992188,567.2151210721856,566.0683353396659,
            565.2481689453125}),
      T1(start={568.0126670066404,566.6417282059258,565.6582502265244}),
      Tp(start={475.61601428945164,500.234995799533,518.1758120458845})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      rugosrel=1e-5,
      z1=10.767,
      inertia=true,
      dW1(start={1.1e6,782901,559798}),
      h(start={2684673.5,2787622.843498506,2861613.8808508525,2914519.282601244,
            2914519.25}),
      hb(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762}),
      P(start={510622.84375,508733.6061914782,506650.25202074344,
            504336.5353393364,501850.0}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={266,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsFumees(P0=1.013e5)
    annotation (Placement(transformation(
        origin={722,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurBP(
    Ns=3,
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-2.45e7,-5.5e6,-1.17e6}),
      Tp(start={400.3519750836609,396.09689492479714,395.2201421057111}),
      Tp1(start={400.0855824116385,396.0373810697358,395.20741736846634})),
    Ntubes=3444,
    L=20.726,
    Cws1(h_vol_2(start=194584.50261459063)),
    Cws2(h_vol_1(start=509236.15969580685)),
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
      deltaT(start={23.5,5.3,1.1}),
      T2(start={442.58880615234375,405.54898708865323,397.2418326138536,
            395.4642028808594}),
      T1(start={424.0688986060054,401.3954098512534,396.353024695102}),
      Tp(start={400.59947884299936,396.1521888739459,395.23196457920767})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      inertia=true,
      dW1(start={2.45e7,5.5e6,1.17e6}),
      h(start={194584.5,442113.0226180337,497412.50346040993,509236.1596958068,
            509236.15625}),
      hb(start={194584.515625,462556.370989432,494648.45288738,501287.069880104}),
      P(start={1540564.125,1504650.386070031,1479432.0451056722,
            1454480.269096047,1429588.25}),
      T0(start={290.0,290.0,290.0})))
                          annotation (Placement(transformation(
        origin={680,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineHP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.88057),
    Qmax=140,
    eta_is_nom=0.88057,
    eta_is_min=0.75,
    Cst(start=8182844.56002535)=
        CstHP,
    pros(d(start=10.66426189633104)),
    Hrs(start=3046256.0341363903),
    Pe(fixed=true, start=12431000),
    Ps(fixed=false, start=2726700))
              annotation (Placement(transformation(extent={{-2,-250},{38,-210}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineMP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9625),
    Qmax=150,
    eta_is_nom=0.9625,
    eta_is_min=0.75,
    Cst(start=256335.364995961)=
        CstMP,
    pros(d(start=1.8827680646065352)),
    Hrs(start=3029781.976396904),
    Pe(fixed=true, start=2548500),
    Ps(fixed=false, start=476800))
                annotation (Placement(transformation(extent={{318,-250},{358,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPostTMP1(
    h(start=3017480.4191624634),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={418,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineBP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9538),
    Qmax=150,
    eta_is_nom=0.9538,
    eta_is_min=0.75,
    Cst(start=11944.9445735985)=
        CstBP,
    Cs(h(start=2401033.111118852)),
    Hrs(start=2401030),
    Pe(fixed=true, start=476799.99999954),
    Ps(start=10053))
                annotation (Placement(transformation(extent={{576,-250},{616,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitHP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-292,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitMP(
                                                    alpha=2)
    annotation (Placement(transformation(
        origin={-232,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitHP(
                                                    alpha=0.5,
    Ce(h(start=3046260)),
    P(start=2726700))
    annotation (Placement(transformation(extent={{114,-180},{134,-160}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.SimpleDynamicCondenser Condenseur(
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
    Pfond(start=10000.0),
    Cl(h(start=191812.29519356362)),
    proe(d(start=996.0186965963143)))
    annotation (Placement(transformation(extent={{637,-384},{717,-304}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=29804.5)     annotation (Placement(transformation(extent={{
            572,-377},{620,-329}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{736,-374},{780,-330}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK1(    K=1e-4,
    h(start=2400000),
    C1(h_vol_2(start=2400000), h(start=2400000)),
    Pm(start=10026.561030835077))
    annotation (Placement(transformation(extent={{640,-240},{660,-220}},
          rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeCond1(
    Ce3(h(start=194584.50261452305)),
    h(start=194584.50261459063),
    P(start=1540500))
    annotation (Placement(transformation(
        origin={902,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeKCond1(K=1e-4,
    rho(start=990.3586687482405),
    Pm(start=1540000))
    annotation (Placement(transformation(
        origin={902,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.Fluid.Volumes.VolumeA VolumeAlimMPHP(
    h(start=550072.7232069891),
    P(start=322430))                         annotation (Placement(transformation(
          extent={{742,-20},{762,0}}, rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimMP(
    a3=350,
    b1(fixed=true) = -3.7751,
    a1=-244551,
    Q(fixed=false),
    C1(h_vol_2(start=550072.7232069891)),
    C2(h_vol_1(start=565106.2802015315)),
    Qv(start=0.01332183238847357),
    rho(start=933.5252816181976),
    Pm(start=1725850))
            annotation (Placement(transformation(extent={{804,-20},{824,0}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimHP(
    a3=1600,
    a1=-28056.2,
    b1=-12.7952660447433,
    Q(fixed=false),
    C1(h_vol_2(start=550072.7232069891)),
    C2(h_vol_1(start=618649.6677733721)),
    Qv(start=0.08171817156952406),
    rho(start=931.4140647908531),
    Pm(start=6774000))
             annotation (Placement(transformation(extent={{804,-60},{824,-40}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitBP(alpha=0.5,
    h(start=194585),
    P(start=1540500),
    Cs(h(start=194585)))
    annotation (Placement(transformation(extent={{872,-328},{886,-308}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitBP(alpha=2)
    annotation (Placement(transformation(
        origin={268,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss PerteChargeZero2(
    z2=0,
    z1=0,
    K=K_PerteChargeZero2,
    h(start=3000000),
    C1(
      h_vol_2(start=3000000),
      h(start=3000000),
      P(fixed=true, start=501850)),
    Pm(start=490000))
            annotation (Placement(transformation(
        origin={344,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK3(K=1e-4,
    Pm(start=322424.2818830876))
    annotation (Placement(transformation(
        origin={780,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK8(K=1e-4,
    Pm(start=322424.28218490275))
    annotation (Placement(transformation(
        origin={780,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.ElectroMechanics.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{402,-448},{522,-348}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK(K=1e-4,
    C1(h_vol_2(start=191812.29519356362)),
    C2(h_vol_1(start=191812.29519356362)),
    rho(start=989.8383588386498),
    Pm(start=6200))
    annotation (Placement(transformation(extent={{702,-446},{722,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimBP(
    Qv(start=0.2002405532484127),
    a3=400,
    a1(fixed=true) = -6000,
    Q(start=194.502, fixed=false),
    C2(h_vol_1(start=194584.50261452305)),
    Pm(start=783963.3809799375))
            annotation (Placement(transformation(extent={{742,-446},{762,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK2(
    K=1e-4,
    rho(start=990.3586687495459),
    C1(h_vol_2(start=194584.50261452305),
                            h(start=194585)),
    Pm(start=1546000))
    annotation (Placement(transformation(extent={{840,-446},{860,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_extraction(Cvmax=
        2000,
    h(start=194500),
    Cv(start=2000),
    Pm(start=1549245.4644062065))
                 annotation (Placement(transformation(extent={{802,-440},{822,
            -420}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapHP(C1(h_vol_2(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-58,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauHP(C2(h_vol_1(start=1398000),
        h(start=1398000))) " "
    annotation (Placement(transformation(
        origin={91.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauMP(C2(h_vol_1(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{424,49},{409,63}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapMP(C1(h_vol_2(start=2798000),
        h(start=2798000)))
    annotation (Placement(transformation(
        origin={236,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapBP(C2(h_vol_1(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={514,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBP(C2(h_vol_1(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={663.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBPsortie(C2(h_vol_1(
          start=550000), h(start=550000)))
    annotation (Placement(transformation(extent={{687,-11},{700,1}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauCondenseur(C2(h_vol_1(
          start=194585), h(start=194585)))
    annotation (Placement(transformation(
        origin={685.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapCondenseur(C2(h_vol_1(
          start=2401000), h(start=2401000)))
    annotation (Placement(transformation(
        origin={684.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss lumpedStraightPipeK2(
                                                          K=Kin_SMP2,
    Pm(start=2651000),
    C1(
      P(fixed=true, start=2726700),
      h_vol_2(start=3046000),
      h(start=3046000)))
    annotation (Placement(transformation(extent={{114,-120},{94,-100}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineHP(
    C1(P(fixed=true, start=12680999.9999969)),
    Cvmax=Cvmax_THP,
    h(fixed=false, start=3433000),
    Cv(start=10875),
    Pm(fixed=false, start=12550000))   annotation (Placement(transformation(extent={{-124,-234},{-104,
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
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_BP(
    add(k1=-1, k2=+1),
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10) annotation (Placement(transformation(extent={{568,108},{588,128}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{716,-246},{740,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
                                                add(k1=+1, k2=-1),
    edge(uL(signal(start=true))))
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
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP1_2(
    V=1,
    h0=988332,
    h(start=854493.2404741034),
    dynamic_mass_balance=true,
    P0=7010000,
    P(start=13129347.20636851))                        annotation (Placement(transformation(
          extent={{456,-98},{436,-78}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP2_3(
    V=1,
    h0=983786,
    h(start=986348.0919441726),
    dynamic_mass_balance=true,
    P0=7000000,
    P(start=13219328.239579093))                        annotation (Placement(transformation(
          extent={{252,-20},{232,0}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP1(
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    Pm(start=13130272.672059398))
                 annotation (Placement(transformation(extent={{754,-98},{730,
            -122}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP2(
    Cvmax=308.931,
    h(start=565000),
    Cv(start=308.931),
    Pm(start=3126744.5275077047))
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
  ThermoSysPro.Fluid.Volumes.VolumeD VolumePreTHP(
    h0=3e6,
    h(start=3433271.775819776),
    dynamic_mass_balance=true,
    P0=12700000,
    P(start=12700000))                annotation (Placement(transformation(
        origin={-52,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPreTMP(
    h0=3523910,
    h(start=3517975.7051812997),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=2400000))                     annotation (Placement(transformation(
        origin={-50,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineMP(
    C1(P(fixed=true, start=25.486e5)),
    Cvmax=Cvmax_TMP,
    h(fixed=false, start=3518000),
    Cv(start=3.312e6),
    Pm(fixed=false, start=2547000))   annotation (Placement(transformation(extent={{-124,-318},{-104,
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
  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ sourceCombustible(
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
    LHV=46989e3) annotation (Placement(transformation(extent={{-421,24},{-385,60}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourceEau(             Q0=0.0)
          annotation (Placement(transformation(extent={{-473,27},{-445,57}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Humidite(k=0.93)
    annotation (Placement(transformation(extent={{-539,23},{-518,43}}, rotation=
           0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ SourceFumees(
    Xso2=0,
    Xco2=0,
    Xh2o=0,
    Xo2=0.20994,
    Q0=600,
    T0=29.4 + 273.16,
    P0=1.013e5,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
    annotation (Placement(transformation(extent={{-539,-74},{-495,-28}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.GasTurbine GasTurbine(
    comp_tau_n=14.0178,
    comp_eff_n=0.87004,
    exp_tau_n=0.06458,
    exp_eff_n=0.89045,
    TurbQred=0.0175634,
    Kcham=2.02088,
    chambreCombustionTAC(Pea(fixed=false, start=14.0e5),
      Psf(start=1333898.05061735),
      Tsf(start=1493.5527523474145)),
    Wpth=1e6,
    Compresseur(
      is_eff(fixed=false, start=0.88),
      Xtau(fixed=false, start=1.00),
      Ps(start=1419889.7074729432),
      Ts(start=678.0795840911329),
      Tis(start=630.7876402069812)),
    TurbineAgaz(
      Ps(fixed=false),
      is_eff(fixed=false, start=0.87),
      Pe(fixed=false, start=1333900),
      Te(start=1493.59),
      Ts(fixed=false, start=893.16),
      Tis(start=814.7448743706253)),
    xAIR(rho_air(start=1.099457970518182)))
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
      points={{-4,-50},{76,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP4.Cfg2, SurchauffeurMP1.Cfg1)          annotation (Line(
      points={{96,-50},{136,-50}},
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
      points={{690,-50},{712,-50}},
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
  connect(MelangeurPostTMP1.Ce2, PerteChargeZero2.C2) annotation (Line(points={{418,
          -240},{418,-278},{354,-278}},      color={255,0,0}));
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
    annotation (Line(points={{114,-110},{138,-110}},   color={255,0,0}));
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-550,
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
<p><b>Copyright &copy; EDF 2002 - 2021 </p>
<p><b>ThermoSysPro Version 4.0 </h4>
</html>"));
end CombinedCycle_Load_100_50;
