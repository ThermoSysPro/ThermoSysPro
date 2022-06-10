within ThermoSysPro.Fluid.Examples.CombinedCyclePowerPlant;
model CombinedCycle_TripTAC "CCPP model to simulate a load variation from 100% to 50%"
  parameter Real CstHP(fixed=false,start=7921079.316566086)
    "Stodola's ellipse coefficient HP";
  parameter Real CstMP(fixed=false,start=251309.80339850043)
    "Stodola's ellipse coefficient MP";
  parameter Real CstBP(fixed=false,start=10675.291494903773)
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
    hl(fixed=false, start=1460508.128907675),
    hv(fixed=false, start=2664791.3052738607),
    Vv(fixed=false),
    R=1.05,
    xmv(fixed=false),
    zl(start=1.05, fixed=true),
    Mp=5000,
    Kpa=5,
    Kvl=1000,
    P(fixed=false, start=12726424.235625941),
    Pfond(start=12733333.038455429),
    Tp(start=589.5151351323206))
                     annotation (Placement(transformation(extent={{5,10},{-35,
            50}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationHP(
      Cvmax=CvmaxValveAHP,
    C1(P(start=13394232.807871036),
    h_vol_2(start=1399087.0448386343)),
    h(start=1398000),
    Cv(start=178),
    Pm(start=13050700))
                 annotation (Placement(transformation(extent={{45,46},{25,66}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurHP(k=0.5)
    annotation (Placement(transformation(extent={{-51,70},{-61,78}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurHP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2664791.3052738607)),
    h(start=2674000),
    Cv(start=23914.7),
    Pm(start=12724920.902023433))
                 annotation (Placement(transformation(extent={{-55,46},{-75,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeHP(
    z2=0,
    Q(start=150, fixed=true),
    z1=10.83,
    K=KgainChargeHP,
    C2(P(start=12757776.366696326)),
    h(start=1474422.14552527),
    Pm(start=12704000),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
            annotation (Placement(transformation(
        origin={-5,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapHP(V=5,
    h(start=1460508.128907675),
    P(start=12704000),
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
                                           annotation (Placement(transformation(
          extent={{-25,-100},{-45,-80}},
                                       rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurHP(
    Dint=32.8e-3,
    Ntubes=1476,
    L=20.7,
    ExchangerWall(e=0.0026, lambda=47,
      dW1(start={-5.74e7,-2.67e7,-1.24e7}),
      Tp(start={607.95945081921,605.4313602675011,604.0450760348469}),
      Tp1(start={606.5065615724875,604.7563153894058,603.7327223072098})),
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
      T2(start={755.2099609375,674.1281000784297,635.8939469832528,
            618.0787353515625}),
      T1(start={714.669037024263,655.0110235308413,626.9863546635906}),
      Tp(start={609.3093210980612,606.0585402262541,604.3352819224443})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=10.83,
      option_temperature=false,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={5.74e7,2.67e7,1.24e7}),
      h(start={1460508.125,1842386.3805685563,2019815.5675635953,
            2101914.802366878,1460508.125}),
      hb(start={1459929.875,1760591.32331318,1893494.15765019,1954976.19646134}),
      P(start={12757776.0,12739926.315661393,12734300.718607338,
            12730145.067304946,12726424.0})))
                          annotation (Placement(transformation(
        origin={-47,-50},
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
      Tp(start={577.1652678885227,582.2393934514894,585.9616914189281}),
      Tp1(start={576.5195841307088,581.753378536046,585.5943808718256})),
    Cws1(P(start=13320777.811415095),
    h_vol_2(start=1292777.0058783418)),
    Cws2(h_vol_1(start=1399087.0448386343)),
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
      T2(start={618.0787353515625,613.037602447671,609.2389186305828,
            606.3656616210938}),
      T1(start={615.5581823957998,611.1382605391269,607.8022941316214}),
      Tp(start={577.7558398657263,582.6839249827347,586.2976504908789})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      z2=0,
      option_temperature=false,
      inertia=true,
      dW1(start={3.5e6,2.63e6,2e6}),
      h(start={1292777.0,1338569.0293807227,1373037.3060893763,
            1399087.0448386343,1399087.0}),
      hb(start={1291418.875,1336078.18827954,1370718.78680301,1396865.59043578}),
      P(start={13320778.0,13339750.403131645,13358253.29250947,
            13376387.23615858,13394233.0})))
                          annotation (Placement(transformation(
        origin={53,-50},
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
      Tp(start={641.7766266045941,659.2542181292313,674.5323393956571}),
      Tp1(start={639.7295258289556,657.6427819154001,673.2854985024741})),
    Cws1(h_vol_2(start=2664791.3052738607)),
    Cws2(P(start=12720084.224503415),
      h_vol_1(start=2973079.185217006)),
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
      T2(start={787.8693237304688,774.2709985521502,763.5355376271307,
            755.2099609375}),
      T1(start={781.0701669240514,768.9032680896405,759.3727557986135}),
      Tp(start={643.6669592742874,660.7422496694279,675.683696525852})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.83,
      option_temperature=false,
      inertia=true,
      dW1(start={9.8e6,7.7e6,5.9e6}),
      h(start={2664791.25,2793445.279188231,2894719.078252342,2973079.185217006,
            2973079.25}),
      hb(start={2664757.0,2808108.09290342,2916825.81170239,2998229.34382983}),
      P(start={12723418.0,12723372.064267773,12722706.076957166,
            12721569.805902744,12720084.0})))
                          annotation (Placement(transformation(
        origin={-87,-50},
        extent={{-20,20},{20,-20}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP3(
    Dint=26.6e-3,
    Ntubes=1476,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
      dW1(start={-1.6e7,-5.6e6,-2.1e6}),
      Tp(start={557.1357570088924,563.7223638401374,566.037182893163}),
      Tp1(start={556.657781456147,563.5505466405001,565.9750435970707})),
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
      T2(start={602.606689453125,580.0827929934445,571.956039969206,
            569.0130004882813}),
      T1(start={591.3447334381658,576.0194164813253,570.4845269121585}),
      Tp(start={557.5729353703138,563.879515730797,566.0940183432008})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={1.6e7,5.6e6,2.1e6}),
      h(start={989834.8125,1193223.55215195,1266335.416732016,
            1292777.0058783418,1292777.0}),
      hb(start={986348.9375,1189594.8774342,1263384.6284551,1290000.70037855}),
      P(start={13239006.0,13261089.90163249,13281516.713631846,
            13301273.845180616,13320778.0})))
                  annotation (Placement(transformation(
        origin={173,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP2(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
      dW1(start={-5e6,-3e6,-2.e6}),
      Tp(start={492.5265031447411,499.7298617398276,504.2372403374727}),
      Tp1(start={492.3269425182926,499.6044056390882,504.15828372038055})),
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
      T2(start={531.2528686523438,524.0786479337396,519.5624877991071,
            516.7178344726563}),
      T1(start={527.6657680129605,521.8205678664233,518.1401706426662}),
      Tp(start={492.70903044592376,499.8446096432236,504.3094576805689})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.767,
      inertia=true,
      dW1(start={5e6,3e6,2.e6}),
      h(start={860655.375,924469.2991480937,964586.6772085332,989834.8113335292,
            989834.8125}),
      hb(start={854494.5625,915007.018247822,957243.396653824,983786.364226731}),
      P(start={13149154.0,13172140.227906534,13194684.103908138,
            13216938.318123804,13239006.0})))
                  annotation (Placement(transformation(
        origin={373,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurHP1(
    Dint=26.6e-3,
    Ns=3,
    ExchangerWall(e=2.6e-3, lambda=47,
              dW1(start={-9.9999e6,-5e6,-2.4e6}),
      Tp(start={461.83700038875077,471.4458881656956,476.1007075853514}),
      Tp1(start={461.41562496249884,471.24253667400546,476.002824325766})),
    L=20.726,
    Ntubes=1107,
    Cws1(h_vol_2(start=630040.8772883223)),
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
      T2(start={509.81195068359375,494.60709242744036,487.25141439639447,
            483.7066345214844}),
      T1(start={502.2095163065458,490.92925341191744,485.4790272730564}),
      Tp(start={462.22240967868714,471.63188276609173,476.1902361036878})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      z1=10.767,
      inertia=true,
      dW1(start={9.9999e6,5e6,2.4e6}),
      h(start={630040.875,764519.0167009356,829416.7979796123,860655.3510811749,
            860655.375}),
      hb(start={618651.9375,752176.893518976,816707.727773953,847728.424287614}),
      advection=true,
      dynamic_mass_balance=true,
      P(start={13054959.0,13079363.233486831,13102973.863543343,
            13126167.933420062,13149154.0})))
                  annotation (Placement(transformation(
        origin={493,-50},
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
      Tp(start={718.0595138013858,738.8988421059552,755.1216906441867}),
      Tp1(start={715.284148781996,736.8146275114044,753.568899547355})),
    Cws2(P(start=12710803.048741188),
                               h_vol_1(start=3240679.101987554)),
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
      T2(start={850.2295532226563,838.165359685431,829.0838172755421,
            822.3056030273438}),
      T1(start={844.1974477839519,833.6245884804865,825.6946997760892}),
      Tp(start={720.6064978764006,740.8115495674804,756.5467047118})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.83,
      inertia=true,
      dW1(start={8.8e6,6.6e6,4.9e6}),
      h(start={2973079.25,3088900.225778996,3175878.2994419048,
            3240679.101987554,3240679.0}),
      hb(start={2973076.25,3118965.9792171,3205920.08101435,3268474.17308722}),
      P(start={12720084.0,12718408.787041187,12716215.067117244,
            12713645.694467228,12710803.0})))
                  annotation (Placement(transformation(
        origin={-207,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurHP3(
    Ns=3,
    L=20.4,
    Ntubes=246,
    ExchangerWall(lambda=27, e=5e-3,
    dW1(start={-6.3e6,-4.7e6,-3.6e6}),
      Tp(start={789.2881838358564,806.7088039780044,819.9912755140301}),
      Tp1(start={785.6370057524725,803.9662515359148,817.9384055160485})),
    Dint=28e-3,
    Cws2(h_vol_1(start=3432930.991856911)),
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
      T2(start={893.75,885.1796729176981,878.7316754228791,873.8992309570313}),
      T1(start={889.464836458849,881.9556741702886,876.315464574507}),
      Tp(start={792.4232630808997,809.0636930146954,821.7539696298131})),
    TwoPhaseFlowPipe(
      rugosrel=5e-6,
      z2=0,
      advection=false,
      z1=10.726,
      inertia=true,
      dW1(start={6.3e6,4.7e6,3.6e6}),
      h(start={3240679.0,3323783.054261407,3386205.9057494565,3432930.991856911,
            3432931.0}),
      hb(start={3240813.5,3348361.34780186,3407279.82422176,3450835.48993987}),
      P(start={12710803.0,12704112.803652512,12696819.484746953,
            12689077.136342296,12681000.0})))
                  annotation (Placement(transformation(
        origin={-327,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonMP(
    L=16.27,
    Vertical=false,
    P0=27.29e5,
    hl(fixed=false, start=980960.1562978515),
    hv(fixed=false, start=2798761.3254371085),
    Vv(fixed=false),
    R=1.05,
    P(fixed=false, start=2733918.2848144253),
    zl(start=1.05, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=2742462.980913138),
    Tp(start=497.4249792990277))
                     annotation (Placement(transformation(extent={{325,10},{287,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurMP(k=0.5)
    annotation (Placement(transformation(extent={{271,70},{259,80}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationMP(
      Cvmax=CvmaxValveAMP,
    C1(P(start=3253417.522956237),
    h_vol_2(start=947830.5281155076)),
    h(start=944000),
    Cv(start=28),
    Pm(start=2975000))
                 annotation (Placement(transformation(extent={{365,46},{345,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurMP(
    Cvmax=47829.4,
    C2(h_vol_1(start=2798761.3254371085)),
    h(fixed=false, start=2798000),
    Cv(start=23914.7),
    Pm(fixed=false, start=2732653.9482791456))
                 annotation (Placement(transformation(extent={{265,46},{245,66}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurMP(
    Dint=32.8e-3,
    L=20.767,
    Ntubes=738,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-9.7e7,-7.6e6,-5.8e6}),
      Tp(start={504.9993271430632,504.2768804788304,503.69756244079724}),
      Tp1(start={504.503193578626,503.89321384657916,503.40091865289605})),
    Ns=3,
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.83,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={9.7e7,7.6e6,5.8e6}),
      P(start={2773378.75,2751240.3575119935,2743530.0500684776,
            2738283.631137228,2733918.25}),
      h(start={980960.1875,1046373.213452734,1096957.9937272775,
            1136069.1896699532,980960.1875}),
      hb(start={980708.125,1028103.09460604,1066178.43156513,1095633.31556464})),
    Cws1(P(start=2773378.6567335734)),
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
      T2(start={565.5570068359375,551.1237970278224,539.9287004763471,
            531.2528686523438}),
      T1(start={558.3404164937012,545.5262487520847,535.5907942842642}),
      Tp(start={505.4602817233831,504.6333427384495,503.9731723219999})))
                          annotation (Placement(transformation(
        origin={273,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeMP(
    z2=0,
    z1=10.83,
    Q(start=150, fixed=true),
    K=KgainChargeMP,
    Pm(start=2734000),
    h(start=978914.570821827),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
            annotation (Placement(transformation(
        origin={315,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapMP(V=5,
    h(start=980960.1562978515),
    P(start=2734000),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                           annotation (Placement(transformation(
          extent={{295,-100},{275,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurMP(
    ExchangerWall(e=2.6e-3, lambda=47,
        dW1(start={-3e6,-1.4e6,-740379}),
      Tp(start={470.48677107325835,488.1938632909576,497.65207032563256}),
      Tp1(start={470.01280565475304,487.9402946158829,497.51626768286917})),
    L=20.726,
    Ns=3,
    Dint=26.6e-3,
    Ntubes=246,
    Cws1(h_vol_2(start=576430.3612424443)),
    Cws2(h_vol_1(start=947830.5281155076)),
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
      T2(start={516.7178344726563,512.927875284067,510.89894284399503,
            509.81195068359375}),
      T1(start={514.8228643851462,511.91340906403104,510.35544151482316}),
      Tp(start={470.920281581991,488.4257888303293,497.7762816508864})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=10.767,
      z2=0,
      inertia=true,
      dW1(start={3e6,1.4e6,740379}),
      h(start={576430.375,780326.2782299566,889409.3790325949,947830.5281155076,
            947830.5}),
      hb(start={565108.5,727745.440528479,829820.124314816,892414.570867187}),
      P(start={3160828.5,3185369.6108956896,3208693.506993564,
            3231270.1974957627,3253417.5})))
                          annotation (Placement(transformation(
        origin={433,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurMP1(
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.3e6,-0.80263e6,
                                -501864}),
      Tp(start={558.0934551632172,574.0136440053798,584.242260992374}),
      Tp1(start={557.706011115662,573.7688585895307,584.0889760553388})),
    L=20.726,
    Ns=3,
    Dint=32.8e-3,
    Ntubes=123,
    Cws1(h_vol_2(start=2798761.3254371085)),
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
      T2(start={606.3656616210938,604.5120304885253,603.3404748736327,
            602.606689453125}),
      T1(start={605.4388500605926,603.926252681079,602.9735743782599}),
      Tp(start={558.4534269956265,574.2410725985397,584.3846770655402})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z2=0,
      z1=10.77,
      inertia=true,
      dW1(start={1.3e6,0.80263e6,501864}),
      h(start={2798761.25,2900642.773718668,2965011.0169332824,
            3005318.492253628,3040245.5}),
      hb(start={2798574.75,2904836.50693844,2969862.15109307,3009575.30461156}),
      P(start={2731389.5,2730444.2277886732,2729310.613093969,
            2728046.4038641006,2726700.0})))
                          annotation (Placement(transformation(
        origin={113,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.VolumeB MelangeurHPMP(
    Ce1(h(start=3046003.380872726)),
    h(start=3040245.422545259),
    P(start=2726000))
    annotation (Placement(transformation(
        origin={115,-110},
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
      Tp(start={688.9747491924221,714.1387227867799,731.7594455240543}),
      Tp1(start={687.7117385985722,713.2642402785228,731.156085252147})),
    Cws1(P(start=2575477.4929098235),
      h_vol_2(start=3040245.422545259)),
    Cws2(P(start=2558200.620927911),
      h_vol_1(start=3321522.540904887)),
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
      T2(start={822.3056030273438,806.4713844816748,795.4738313791455,
            787.8693237304688}),
      T1(start={814.3884833791556,800.9726079304102,791.671583337549}),
      Tp(start={690.1616978609907,714.9605415853846,732.3264698030932})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={1.15e7,7.9e6,5.5e6}),
      h(start={3040245.5,3169860.5211362485,3259603.344415277,3321522.540904887,
            3321522.5}),
      hb(start={3040562.25,3176242.27636476,3267406.25678814,3329559.35651389}),
      P(start={2575477.5,2571810.3704688977,2567607.9202979314,
            2563033.661146952,2558200.5})))
                          annotation (Placement(transformation(
        origin={-147,-50},
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
      Tp(start={786.0003533757151,802.6089712721623,814.0750543986999}),
      Tp1(start={784.9544439166481,801.8912118855588,813.583437630984})),
    Cws2(h_vol_1(start=3517381.1285517)),
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
      T2(start={873.8992309570313,862.9376291442026,855.3997728669909,
            850.2295532226563}),
      T1(start={868.4184414351687,859.1687010055967,852.814654374732}),
      Tp(start={786.9913001992309,803.2890123388494,814.5408366613608})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      z1=10.83,
      rugosrel=1e-5,
      inertia=true,
      dW1(start={8e6,5.5e6,3.8e6}),
      h(start={3321522.5,3412353.763453483,3474687.0390689597,3517381.1285517,
            3517381.25}),
      hb(start={3321940.75,3420707.89900972,3482716.02631475,3524890.37222916}),
      P(start={2558200.5,2556022.8892716086,2553661.4076231164,
            2551174.061990546,2548600.0})))
                          annotation (Placement(transformation(
        origin={-267,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum BallonBP(
    Vertical=false,
    P0=5e5,
    Vv(fixed=false),
    L=8,
    hl(fixed=false, start=561432.6820300646),
    hv(fixed=false, start=2682927.2097681486),
    R=2,
    P(fixed=false, start=536006.6647383622),
    zl(start=1.75, fixed=true),
    Kpa=5,
    Mp=5000,
    Kvl=1000,
    Pfond(start=552000.8087452435),
    Tp(start=409.09918124890646))
                     annotation (Placement(transformation(extent={{585,10},{545,
            50}}, rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_vanne_vapeurBP(k=0.5)
    annotation (Placement(transformation(extent={{633,76},{621,86}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_vapeurBP(
    p_rho=3, Cvmax=CvmaxValveVBP,
    C2(P(start=509651.8053666252),
    h_vol_1(start=2682927.2097681486)),
    h(start=2685000),
    Cv(start=1),
    Pm(start=498000))
                 annotation (Placement(transformation(extent={{525,46},{505,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_alimentationBP(
    Cvmax=285,
    C1(h_vol_2(start=517521.1338868904)),
    h(fixed=false, start=509000),
    Cv(start=142.5),
    Pm(fixed=false, start=1001940.4305634197))
                 annotation (Placement(transformation(extent={{617,44},{597,64}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss GainChargeBP(
    z2=0,
    z1=10.767,
    Q(start=50, fixed=false),
    K=32766,
    rho(start=931.9744461081724),
    Pm(start=564000),
    h(start=549249.519022482),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
            annotation (Placement(transformation(
        origin={577,-90},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeEvapBP(h(start=561432.682030064),
    V=5,
    P(start=564000),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                           annotation (Placement(transformation(
          extent={{559,-100},{539,-80}}, rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EvaporateurBP(
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.24e7,-8.5e6,-5.8e6}),
      Tp(start={431.3608522222893,430.24126699702373,429.39686929842486}),
      Tp1(start={430.9104943759602,429.93425668934924,429.1871126238492})),
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
      T2(start={483.7066345214844,465.9440370193418,453.7982409323057,
            445.483154296875}),
      T1(start={474.8253385845301,459.8711389758238,449.6406958379268}),
      Tp(start={431.7792768702483,430.5265083466735,429.59175290805825})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      continuous_flow_reversal=true,
      inertia=true,
      dW1(start={1.24e7,8.5e6,5.8e6}),
      h(start={561432.6875,799363.0194709267,961560.8510406071,
            1072378.2305328134,561432.6875}),
      hb(start={550075.0,765243.011613326,912673.256542569,1013555.73710231}),
      Q(start={49.81331881379377,49.81331881379377,49.81331881379377,
            49.81331881379377}),
      P(start={563167.375,538556.7569255093,537410.7752779912,536682.3739734262,
            536006.6875})))
                          annotation (Placement(transformation(
        origin={533,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    constante_ballonBP(k=1)
    annotation (Placement(transformation(extent={{709,6},{695,18}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP(
    Cvmax=308.931,
    C1(h_vol_2(start=561432.6820300646)),
    h(start=550000),
    Cv(start=308.931),
    Pm(start=454319.5384961263),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                 annotation (Placement(transformation(extent={{677,-14},{697,6}},
          rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    SurchauffeurBP(
    Ns=3,
    L=20.726,
    Dint=39.3e-3,
    Ntubes=123,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-1.1e6,-782901,-559798}),
      Tp(start={477.52260500819597,502.61487297914,520.6394670364305}),
      Tp1(start={477.2504107508904,502.4219869045609,520.5035062463255})),
    Cws1(h_vol_2(start=2682927.2097681486)),
    Cws2(h_vol_1(start=2919992.1127030067)),
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
      T2(start={569.0130004882813,567.4482541171128,566.3390581546068,
            565.5570068359375}),
      T1(start={568.2306339861118,566.8936561358598,565.9480470570934}),
      Tp(start={477.77840698873644,502.79614293098246,520.7672398988061})),
    TwoPhaseFlowPipe(
      advection=false,
      z2=0,
      rugosrel=1e-5,
      z1=10.767,
      inertia=true,
      dW1(start={1.1e6,782901,559798}),
      h(start={2682927.25,2790287.093854774,2866365.945824299,
            2919992.1127030067,2919992.0}),
      hb(start={2684673.5,2819292.38908571,2893584.12921908,2943776.05560762}),
      P(start={509651.8125,507980.5977658856,506129.5447082628,
            504067.5333025372,501850.0})))
                          annotation (Placement(transformation(
        origin={233,-50},
        extent={{20,-20},{-20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsFumees(P0=1.013e5)
    annotation (Placement(transformation(
        origin={689,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger
    EconomiseurBP(
    Ns=3,
    Dint=32.8e-3,
    ExchangerWall(e=2.6e-3, lambda=47,
    dW1(start={-2.45e7,-5.5e6,-1.17e6}),
      Tp(start={402.39147626030376,398.05961040088295,397.171667377241}),
      Tp1(start={402.1199525074059,397.9993065179613,397.15885396154556})),
    Ntubes=3444,
    L=20.726,
    Cws1(h_vol_2(start=194669.37425632242)),
    Cws2(h_vol_1(start=517521.1338868904)),
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
      T2(start={445.483154296875,407.64728846356843,399.20963445670407,
            397.4152526855469}),
      T1(start={426.56521960355815,403.42846146013625,398.31244500376624}),
      Tp(start={402.64374727467464,398.11563835995787,397.18357224132967})),
    TwoPhaseFlowPipe(
      advection=false,
      rugosrel=5e-6,
      z1=0,
      z2=10.767,
      inertia=true,
      dW1(start={2.45e7,5.5e6,1.17e6}),
      h(start={194669.375,449026.540992922,505517.82265620184,517521.1338868904,
            517521.125}),
      hb(start={194584.515625,462556.370989432,494648.45288738,501287.069880104}),
      P(start={1578579.375,1542823.2506358635,1517636.5908885582,
            1492724.792065889,1467874.25})))
                          annotation (Placement(transformation(
        origin={647,-50},
        extent={{-20,-20},{20,20}},
        rotation=90)));

  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineHP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.88057),
    Qmax=140,
    eta_is_nom=0.88057,
    eta_is_min=0.75,
    Cst(start=8182844.56002535)=CstHP,
    pros(d(start=10.66670150764929)),
    Hrs(start=3046003.380872726),
    Pe(fixed=true, start=12431000),
    Ps(fixed=false, start=2726700))
              annotation (Placement(transformation(extent={{-35,-250},{5,-210}},
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
    pros(d(start=1.883484197675123)),
    Hrs(start=3029367.6706168973),
    Pe(fixed=true, start=2548500),
    Ps(fixed=false, start=476800))
                annotation (Placement(transformation(extent={{285,-250},{325,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPostTMP1(
    h(start=3018320.043117248),
    P(start=476799.99999954),
    Ce1(h(start=3029780)))                 annotation (Placement(transformation(
        origin={385,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine TurbineBP(
    W_fric=1,
    eta_stato=1,
    eta_is(start=0.9538),
    Qmax=150,
    eta_is_nom=0.9538,
    eta_is_min=0.75,
    Cst(start=11944.9445735985)=CstBP,
    Cs(h(start=2401478.8015108025)),
    Hrs(start=2401030),
    Pe(fixed=true, start=476799.99999954),
    Ps(start=10053))
                annotation (Placement(transformation(extent={{543,-250},{583,
            -210}}, rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitHP(alpha=2)
    annotation (Placement(transformation(
        origin={-325,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitMP(alpha=2)
    annotation (Placement(transformation(
        origin={-265,-100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitHP(
    alpha=0.5,
    Ce(h(start=3046260)),
    P(start=2726700))
    annotation (Placement(transformation(extent={{81,-180},{101,-160}},
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
    proe(d(start=996.0227362797892)))
    annotation (Placement(transformation(extent={{604,-384},{684,-304}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ SourceCaloporteur(
    h0=113.38e3, Q0=29804.5)     annotation (Placement(transformation(extent={{539,
            -377},{587,-329}},     rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsCaloporteur
    annotation (Placement(transformation(extent={{703,-374},{747,-330}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK1(K=1e-4,
    h(start=2400000),
    C1(h_vol_2(start=2400000), h(start=2400000)),
    Pm(start=10026.138683139128))
    annotation (Placement(transformation(extent={{607,-240},{627,-220}},
          rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeCond1(
    Ce3(h(start=194669.37425631672)),
    h(start=194669.37425632242),
    P(start=1540500),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(
        origin={869,-318},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeKCond1(K=1e-4,
    rho(start=990.3699122081223),
    Pm(start=1540000))
    annotation (Placement(transformation(
        origin={869,-270},
        extent={{12,-12},{-12,12}},
        rotation=270)));
  ThermoSysPro.Fluid.Volumes.VolumeA VolumeAlimMPHP(
    h(start=561432.6820300613),
    P(start=322430),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                           annotation (Placement(transformation(
          extent={{709,-20},{729,0}}, rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimMP(
    a3=350,
    b1(fixed=true) = -3.7751,
    a1=-244551,
    Q(fixed=false),
    C1(h_vol_2(start=561432.6820300613)),
    C2(h_vol_1(start=576430.3612424443)),
    Qv(start=0.013433660889458656),
    rho(start=931.2517020786314),
    Pm(start=1725850),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
            annotation (Placement(transformation(extent={{771,-20},{791,0}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimHP(
    a3=1600,
    a1=-28056.2,
    b1=-12.7952660447433,
    Q(fixed=false),
    C1(h_vol_2(start=561432.6820300613)),
    C2(h_vol_1(start=630040.8772883223)),
    Qv(start=0.08167585768192882),
    rho(start=929.0940034498418),
    Pm(start=6774000),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
             annotation (Placement(transformation(extent={{771,-60},{791,-40}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier MoitieDebitBP(
    alpha=0.5,
    h(start=194585),
    P(start=1540500),
    Cs(h(start=194585)))
    annotation (Placement(transformation(extent={{839,-328},{853,-308}},
          rotation=0)));
  ThermoSysPro.Fluid.Junctions.MassFlowMultiplier DoubleDebitBP(alpha=2)
    annotation (Placement(transformation(
        origin={235,-100},
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
        origin={311,-278},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK3(K=1e-4,
    Pm(start=372632.41194491077),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(
        origin={747,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK8(K=1e-4,
    Pm(start=372632.41224549303),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(
        origin={747,-10},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.ElectroMechanics.Machines.Generator Alternateur
    annotation (Placement(transformation(extent={{369,-448},{489,-348}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK(
    K=1e-4,
    C1(h_vol_2(start=191812.29519356362)),
    C2(h_vol_1(start=191812.29519356362)),
    rho(start=989.8383588386666),
    Pm(start=6200),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(extent={{669,-446},{689,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump PompeAlimBP(
    Qv(start=0.19861699733512259),
    a3=400,
    a1(fixed=true) = -6000,
    Q(start=194.502, fixed=false),
    C2(h_vol_1(start=194669.37425631672)),
    Pm(start=802830.7060548771),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
            annotation (Placement(transformation(extent={{709,-446},{729,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss perteChargeK2(
    K=1e-4,
    rho(start=990.3699122094005),
    C1(h_vol_2(start=194669.37425631672),
    h(start=194585)),
    Pm(start=1546000),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(extent={{807,-446},{827,-426}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_extraction(Cvmax=2000,
    h(start=194500),
    Cv(start=2000),
    Pm(start=1587120.4167526974),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                 annotation (Placement(transformation(extent={{769,-440},{789,
            -420}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapHP(C1(h_vol_2(start=2674000),
        h(start=2674000)))
    annotation (Placement(transformation(
        origin={-91,8},
        extent={{-6,6},{6,-6}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauHP(C2(h_vol_1(start=1398000),
        h(start=1398000))) " "
    annotation (Placement(transformation(
        origin={58.5,32},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauMP(C2(h_vol_1(start=944000),
        h(start=944000)))
    annotation (Placement(transformation(extent={{391,49},{376,63}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapMP(C1(h_vol_2(start=2798000),
        h(start=2798000)))
    annotation (Placement(transformation(
        origin={203,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapBP(C2(h_vol_1(start=2685000),
        h(start=2685000)))
    annotation (Placement(transformation(
        origin={481,56},
        extent={{-8,8},{8,-8}},
        rotation=180)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBP(C2(h_vol_1(start=550000),
        h(start=550000)))
    annotation (Placement(transformation(
        origin={630.5,34},
        extent={{6,-6.5},{-6,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauBPsortie(C2(h_vol_1(
          start=550000), h(start=550000)))
    annotation (Placement(transformation(extent={{654,-11},{667,1}}, rotation=0)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitEauCondenseur(C2(h_vol_1(
          start=194585), h(start=194585)))
    annotation (Placement(transformation(
        origin={652.5,-412},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.Sensors.SensorQ CapteurDebitVapCondenseur(C2(h_vol_1(
          start=2401000), h(start=2401000)))
    annotation (Placement(transformation(
        origin={651.5,-264},
        extent={{-10,-6.5},{10,6.5}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss lumpedStraightPipeK2(
                                                          K=Kin_SMP2,
    Pm(start=2651000),
    C1(
      P(fixed=true, start=2726700),
      h_vol_2(start=3046000),
      h(start=3046000)))
    annotation (Placement(transformation(extent={{81,-120},{61,-100}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineHP(
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
  ThermoSysPro.Examples.Control.Drum_LevelControl regulation_Niveau_BP(
    add(k1=-1, k2=+1),
    pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
    Ti=10,
    minval=0.006) annotation (Placement(transformation(extent={{535,108},{555,128}},
          rotation=0)));
   ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauCondenseur1(                                 k=1.5)
    annotation (Placement(transformation(extent={{683,-246},{707,-230}},
          rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl
    regulation_Niveau_Condenseur(pIsat(Ti=500, Limiteur1(u(signal(start=0.8)))),
                                                add(k1=+1, k2=-1),
    edge(uL(signal(start=true))))
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
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP1_2(
    V=1,
    h0=988332,
    h(start=860655.3510813401),
    dynamic_mass_balance=true,
    P0=7010000,
    P(start=13149153.870557636),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                          annotation (Placement(transformation(
          extent={{423,-98},{403,-78}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.VolumeC VolumeECO_HP2_3(
    V=1,
    h0=983786,
    h(start=989834.8113335292),
    dynamic_mass_balance=true,
    P0=7000000,
    P(start=13239005.657249678),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                          annotation (Placement(transformation(
          extent={{219,-20},{199,0}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP1(
    Cvmax=308.931,
    h(start=618600),
    Cv(start=308.931),
    Pm(start=13150193.68579806),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                 annotation (Placement(transformation(extent={{721,-98},{697,
            -122}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Vanne_alimentationMPHP2(
    Cvmax=308.931,
    h(start=565000),
    Cv(start=308.931),
    Pm(start=3163391.8442005403),
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
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
  ThermoSysPro.Fluid.Volumes.VolumeD VolumePreTHP(
    h0=3e6,
    h(start=3432930.9918569606),
    dynamic_mass_balance=true,
    P0=12700000,
    P(start=12700000))                annotation (Placement(transformation(
        origin={-85,-230},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Volumes.VolumeC MelangeurPreTMP(
    h0=3523910,
    h(start=3517381.1285518324),
    dynamic_mass_balance=true,
    P0=2400000,
    P(start=2400000))                     annotation (Placement(transformation(
        origin={-83,-314},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve vanne_entree_TurbineMP(
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

  ThermoSysPro.Fluid.BoundaryConditions.SourceQ SourceFumees(
    Xco2=0.0613,
    Xso2=0,
    Xh2o=0.0706,
    T0=893.75,
    Xo2=0.1380,
    Q0=606.94,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases)
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
      points={{-37,-50},{43,-50}},
      color={0,0,0},
      thickness=1));
  connect(EconomiseurHP4.Cfg2, SurchauffeurMP1.Cfg1)          annotation (Line(
      points={{63,-50},{103,-50}},
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
      points={{657,-50},{679,-50}},
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
          -240},{385,-278},{321,-278}},      color={255,0,0}));
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
    annotation (Line(points={{81,-110},{105,-110}},    color={255,0,0}));
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
  connect(Debit.y,SourceFumees. IMassFlow)
    annotation (Line(points={{-453.5,18},{-422,18},{-422,-28}}));
  connect(Temperature.y, SourceFumees.ISpecificEnthalpyOrTemperature)
    annotation (Line(points={{-453.5,-120},{-422,-120},{-422,-70}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-560,-460},
            {950,150}},
        initialScale=0.1)),
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
<p><b>Copyright &copy; EDF 2002 - 2021 </p>
<p><b>ThermoSysPro Version 4.0 </h4>
</html>"));
end CombinedCycle_TripTAC;
