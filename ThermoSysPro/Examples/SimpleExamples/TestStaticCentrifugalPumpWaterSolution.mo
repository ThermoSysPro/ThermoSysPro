within ThermoSysPro.Examples.SimpleExamples;
model TestStaticCentrifugalPumpWaterSolution

  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Pulse Pulse1(
                                          width=200, period=400)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Pulse pulse(
    width=200,
    period=500,
    amplitude=1000,
    offset=400) annotation (Placement(transformation(extent={{-40,0},{-20,20}},
          rotation=0)));
  ThermoSysPro.WaterSolution.PressureLosses.SingularPressureLoss
    singularPressureLossWaterLiBr annotation (Placement(transformation(extent={
            {40,30},{60,50}}, rotation=0)));
  ThermoSysPro.WaterSolution.Machines.StaticCentrifugalPump
    staticCentrifugalPumpWaterLiBr annotation (Placement(transformation(extent=
            {{0,30},{20,50}}, rotation=0)));
  ThermoSysPro.WaterSolution.BoundaryConditions.SourcePQ sourceSolution
    annotation (Placement(transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  ThermoSysPro.WaterSolution.BoundaryConditions.Sink sinkSolution
    annotation (Placement(transformation(extent={{80,30},{100,50}}, rotation=0)));
equation
  connect(pulse.y, staticCentrifugalPumpWaterLiBr.VRotation) annotation (Line(
        points={{-19,10},{10,10},{10,29}}));
  connect(Pulse1.yL, staticCentrifugalPumpWaterLiBr.commandePompe) annotation (Line(
        points={{-19,70},{10,70},{10,51}}));
  connect(staticCentrifugalPumpWaterLiBr.C2, singularPressureLossWaterLiBr.C1)
    annotation (Line(points={{20,40},{30,40},{30,40},{41,40}}, color={0,0,0}));
  connect(sourceSolution.Cs, staticCentrifugalPumpWaterLiBr.C1)
    annotation (Line(points={{-60,40},{0,40}}, color={0,0,0}));
  connect(singularPressureLossWaterLiBr.C2, sinkSolution.Ce)
    annotation (Line(points={{59,40},{80,40}}, color={0,0,0}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.32,
      y=0.02,
      width=0.39,
      height=0.47),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
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
end TestStaticCentrifugalPumpWaterSolution;
