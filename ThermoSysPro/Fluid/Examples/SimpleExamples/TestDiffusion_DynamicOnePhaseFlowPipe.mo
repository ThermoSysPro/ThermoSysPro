within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDiffusion_DynamicOnePhaseFlowPipe

  HeatExchangers.DynamicOnePhaseFlowPipe
    dynamicOnePhaseFlowPipe(L=20,
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
    diffusion=true,
    P(start={99999.999999976,99999.999999978,99999.999999981,99999.999999983,
          99999.999999985,99999.999999988,99999.99999999,99999.999999992,100000,
          100000,100000,100000}))
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
  HeatExchangers.DynamicOnePhaseFlowPipe
    dynamicOnePhaseFlowPipe1(
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
    dynamic_energy_balance=false,
    diffusion=true,
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
  connect(dynamicOnePhaseFlowPipe.C2,sinkP. C) annotation (Line(points={{10,40},
          {30,40}}, color={0,0,255}));
  connect(heatSource.C,heatExchangerWall. WT2) annotation (Line(points={{0,70.2},
          {0,62}},         color={191,95,0}));
  connect(sourceP.C, switchValve.C1)
    annotation (Line(points={{-60,40},{-40,40}}, color={0,0,0}));
  connect(switchValve.C2,dynamicOnePhaseFlowPipe. C1)
    annotation (Line(points={{-20,40},{-10,40}}, color={0,0,0}));
  connect(echelon.yL, nONL.uL)
    annotation (Line(points={{-65.6,70},{-54.4,70}}, color={0,0,255}));
  connect(nONL.yL, switchValve.Ouv) annotation (Line(points={{-45.6,70},{-30,70},
          {-30,53.2}}, color={0,0,255}));
  connect(heatExchangerWall.WT1,dynamicOnePhaseFlowPipe. CTh)
    annotation (Line(points={{0,58},{0,43}}, color={0,0,0}));
  connect(dynamicOnePhaseFlowPipe1.C2, sinkP1.C)
    annotation (Line(points={{10,-60},{30,-60}}, color={0,0,255}));
  connect(heatSource1.C, heatExchangerWall1.WT2)
    annotation (Line(points={{0,-29.8},{0,-38}}, color={191,95,0}));
  connect(heatExchangerWall1.WT1,dynamicOnePhaseFlowPipe1. CTh)
    annotation (Line(points={{0,-42},{0,-57}}, color={0,0,0}));
  connect(sourceP1.C,dynamicOnePhaseFlowPipe1. C1)
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
end TestDiffusion_DynamicOnePhaseFlowPipe;
