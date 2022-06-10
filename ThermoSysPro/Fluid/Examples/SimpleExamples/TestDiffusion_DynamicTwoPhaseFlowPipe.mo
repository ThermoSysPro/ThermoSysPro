within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDiffusion_DynamicTwoPhaseFlowPipe

  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowPipe
    dynamicTwoPhaseFlowPipe(L=20,
    Q(start={5.492026593727256E-28,5.492026607285849E-28,5.492026607285849E-28,
          5.492026607285849E-28,5.492026607285849E-28,5.492026607285849E-28,
          5.492026607285849E-28,5.492026607285849E-28,5.492026607285849E-28,
          5.492026607285849E-28,5.492026607285849E-28}),
    h(start={84011.8111671368,96057.08454715868,107718.52365349933,
          119295.22918923412,130792.44987567255,142215.00322033433,
          153567.34130353143,164853.6027022597,176077.65400298327,
          187243.1234252416,198353.42841254506,209411.79856705698}),
    continuous_flow_reversal=true,
    inertia=false,
    dynamic_mass_balance=false,
    advection=true,
    dynamic_energy_balance=false,
    cpl2(start={4183.826265167646,4182.239614474996,4181.0130500668565,
          4180.0726819587735,4179.380584625066,4178.908955510578,
          4178.63729871947,4178.550389628282,4178.636803895239,
          4178.887855575399,4179.29683238825}),
    cpv2(start={2049.2168798430116,2046.3449415228738,2043.4582034172774,
          2040.5558258112756,2037.636860922887,2034.7002308786582,
          2031.744699351002,2028.7688344361377,2025.770959168656,
          2022.7490841743909,2019.518356822069}),
    kl2(start={0.5995743350581909,0.5995743350579683,0.5995743350571023,
          0.5995743350562764,0.5995743350555206,0.5995743350548642,
          0.5995743350543319,0.5995743350539415,0.5995743350536991,
          0.599574335053346,0.5995743403506435}),
    kv2(start={0.024965829345847085,0.024990303852044017,0.025018417766029456,
          0.02505065954620164,0.025087620205457677,0.025130023834108832,
          0.025178770324693366,0.02523499664554269,0.025300167212669696,
          0.02537621164077076,0.0254715737844706}),
    diffusion=true,
    pro2(T(start={294.61264959452353,297.4461204783121,300.22404336919567,
            302.982702661547,305.7232156830587,308.44660714369365,
            311.15382285197893,313.8457405734291,316.5231787363566,
            319.18690350188376,321.8376345796106}), d(start={997.892715521068,
            997.2253707910008,996.4959923473901,995.7017938222477,
            994.8471177790162,993.9357736693299,992.9711212203756,
            991.9561376232762,990.8934721677539,989.7854910510117,
            988.6343144234495})),
    P(start={99999.999999976,99999.999999978,99999.999999981,99999.999999983,99999.999999985,
          99999.999999988,99999.99999999,99999.999999992,100000,100000,100000,100000}))
                            annotation (Placement(transformation(extent={{-10,30},
            {10,50}},    rotation=0)));
  BoundaryConditions.SourceP                                 sourceP(
    continuous_flow_reversal=true,
    diffusion=true,
    P0=100000,
    T0=293.15)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}}, rotation=0)));

  BoundaryConditions.SinkP                                 sinkP(diffusion=true,
      T0=323.15)
    annotation (Placement(transformation(extent={{30,30},{50,50}}, rotation=0)));
  Thermal.BoundaryConditions.HeatSource              heatSource(
    option_temperature=2,
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    W0={0,0,0,0,0,0,0,0,0,0})
    annotation (Placement(transformation(extent={{-10,70},{10,90}},rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall              heatExchangerWall(Ns=10,
      dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,50},{10,70}},rotation=0)));
  PressureLosses.SwitchValve switchValve(Qmin=0)
    annotation (Placement(transformation(extent={{-40,36},{-20,56}})));
  InstrumentationAndControl.Blocks.Logique.Echelon echelon(startTime=1)
    annotation (Placement(transformation(extent={{-74,66},{-66,74}})));
  InstrumentationAndControl.Blocks.Logique.NONL nONL
    annotation (Placement(transformation(extent={{-54,66},{-46,74}})));
  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowPipe
    dynamicTwoPhaseFlowPipe1(
                            L=20,
    Q(start={4.9243335191367076E-05,4.924351014778949E-05,4.924351014778949E-05,
          4.924351014778949E-05,4.924351014778949E-05,4.924351014778949E-05,
          4.924351014778949E-05,4.924351014778949E-05,4.924351014778949E-05,
          4.924351014778949E-05,4.924351014778949E-05}),
    h(start={84011.8111671368,95792.53373784182,107482.21110144592,
          119086.65906940492,130611.17116650468,142060.60442474802,
          153439.44619534744,164751.8668430315,176001.7618457063,
          187192.78587129858,198328.3807233511,209411.79856705698}),
    continuous_flow_reversal=true,
    inertia=false,
    dynamic_mass_balance=false,
    advection=true,
    cpl2(start={4183.8461052314415,4182.2694439224715,4181.033777873867,
          4180.086463719214,4179.389099400846,4178.913555072556,
          4178.639109839789,4178.550383980675,4178.6358456341095,
          4178.886733579299,4179.2962820044995}),
    cpv2(start={2049.2168798430116,2046.3449415228738,2043.4582034172774,
          2040.5558258112756,2037.636860922887,2034.7002308786582,
          2031.744699351002,2028.7688344361377,2025.770959168656,
          2022.7490841743909,2019.518356822069}),
    kl2(start={0.5995743350581909,0.5995743350579683,0.5995743350571023,
          0.5995743350562764,0.5995743350555206,0.5995743350548642,
          0.5995743350543319,0.5995743350539415,0.5995743350536991,
          0.599574335053346,0.5995743403506435}),
    kv2(start={0.024965829345847085,0.024990303852044017,0.025018417766029456,
          0.02505065954620164,0.025087620205457677,0.025130023834108832,
          0.025178770324693366,0.02523499664554269,0.025300167212669696,
          0.02537621164077076,0.0254715737844706}),
    diffusion=true,
    pro2(T(start={294.58103295016184,297.3862511962513,300.1708576823335,
            302.9360907339107,305.6830771234792,308.4128498965468,
            311.12636229776916,313.82449878754863,316.50808386868016,
            319.1778892498971,321.83463973606456}), d(start={997.8997091804818,
            997.2402860410343,996.5106311231898,995.7157728656836,
            994.8600940026633,993.9474377103298,992.9811922410435,
            991.9643590731059,990.8996082946633,989.7893240021328,
            988.6356418174122})),
    dynamic_energy_balance=false,
    P(start={99999.999999976,99999.999999978,99999.999999981,99999.999999983,
          99999.999999985,99999.999999988,99999.99999999,99999.999999992,100000,
          100000,100000,100000}))
                            annotation (Placement(transformation(extent={{-10,-70},
            {10,-50}},   rotation=0)));
  BoundaryConditions.SourceQ                                 sourceP1(
    continuous_flow_reversal=true,
    diffusion=true,
    Q0=0,
    T0=293.15,
    option_temperature=true)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}},
                                                                     rotation=0)));
  BoundaryConditions.SinkP                                 sinkP1(
                                                                 diffusion=true,
      T0=323.15)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}},
                                                                   rotation=0)));
  Thermal.BoundaryConditions.HeatSource              heatSource1(
    option_temperature=2,
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    W0={0,0,0,0,0,0,0,0,0,0})
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}},
                                                                   rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall              heatExchangerWall1(
                                                                        Ns=10,
      dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}},
                                                                   rotation=0)));
equation
  connect(dynamicTwoPhaseFlowPipe.C2,sinkP. C) annotation (Line(points={{10,40},
          {30,40}}, color={0,0,255}));
  connect(heatSource.C,heatExchangerWall. WT2) annotation (Line(points={{0,70.2},
          {0,62}},         color={191,95,0}));
  connect(sourceP.C, switchValve.C1)
    annotation (Line(points={{-60,40},{-40,40}}, color={0,0,0}));
  connect(switchValve.C2, dynamicTwoPhaseFlowPipe.C1)
    annotation (Line(points={{-20,40},{-10,40}}, color={0,0,0}));
  connect(echelon.yL, nONL.uL)
    annotation (Line(points={{-65.6,70},{-54.4,70}}, color={0,0,255}));
  connect(nONL.yL, switchValve.Ouv) annotation (Line(points={{-45.6,70},{-30,70},
          {-30,53.2}}, color={0,0,255}));
  connect(heatExchangerWall.WT1, dynamicTwoPhaseFlowPipe.CTh)
    annotation (Line(points={{0,58},{0,43}}, color={0,0,0}));
  connect(dynamicTwoPhaseFlowPipe1.C2, sinkP1.C)
    annotation (Line(points={{10,-60},{30,-60}}, color={0,0,255}));
  connect(heatSource1.C, heatExchangerWall1.WT2)
    annotation (Line(points={{0,-29.8},{0,-38}}, color={191,95,0}));
  connect(heatExchangerWall1.WT1, dynamicTwoPhaseFlowPipe1.CTh)
    annotation (Line(points={{0,-42},{0,-57}}, color={0,0,0}));
  connect(sourceP1.C, dynamicTwoPhaseFlowPipe1.C1)
    annotation (Line(points={{-60,-60},{-10,-60}}, color={0,0,0}));
  annotation (experiment(StopTime=10),   Icon(graphics={
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestDiffusion_DynamicTwoPhaseFlowPipe;
