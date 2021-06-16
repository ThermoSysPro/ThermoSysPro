within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPump11

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(
    mode_car_hn=2,
    mode_car_Cr=2,
    mode_car=1,
    dynamic_energy_balance=true,
    continuous_flow_reversal=true,
    hn_nom_p=40,
    p_rho=500)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(P0=10000000,
      option_temperature=2)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP(P0=15000000)
    annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe3(
    Duration=100,
    Starttime=10,
    Initialvalue=290e3,
    Finalvalue=3000e3)                         annotation (Placement(
        transformation(extent={{-100,0},{-80,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe1(
    Duration=100,
    Starttime=200,
    Initialvalue=100e5,
    Finalvalue=150e5)                          annotation (Placement(
        transformation(extent={{40,60},{60,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe
    dynamicOnePhaseFlowPipe(
      inertia=true) annotation (Placement(transformation(extent={{0,20},{20,40}},
          rotation=0)));
equation
  connect(sourceP.C, centrifugalPump.C1)
    annotation (Line(points={{-60,30},{-40,30}}, color={0,0,255}));
  connect(rampe1.y, sinkP.IPressure)
    annotation (Line(points={{61,70},{80,70},{80,30},{55,30}}));
  connect(centrifugalPump.C2, dynamicOnePhaseFlowPipe.C1)
    annotation (Line(points={{-20,30},{0,30}}, color={0,0,255}));
  connect(dynamicOnePhaseFlowPipe.C2, sinkP.C)
    annotation (Line(points={{20,30},{40,30}}, color={0,0,255}));
  connect(rampe3.y, sourceP.ISpecificEnthalpy)
    annotation (Line(points={{-79,10},{-70,10},{-70,25}}, smooth=Smooth.None));
  annotation (experiment(StopTime=1000), Diagram(graphics),
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
end TestCentrifugalPump11;
