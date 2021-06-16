within ThermoSysPro.Examples.Book.SimpleExamples.PressureLoss;
model TestCheckValve

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1
                                     annotation (Placement(transformation(
          extent={{-40,-10},{-20,10}},  rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1(
                                   P0=6e5) annotation (Placement(transformation(
          extent={{40,-10},{60,10}},  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Pulse pulse(
    amplitude=6e5,
    width=50,
    period=100,
    offset=3e5) annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
                   rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.CheckValve checkValve3
    annotation (Placement(transformation(extent={{0,-10},{20,10}},   rotation=0)));
equation
  connect(sourceP1.C, checkValve3.C1)
    annotation (Line(points={{-20,0},{-1,0}},      color={0,0,255}));
  connect(checkValve3.C2, puitsP1.C)
    annotation (Line(points={{21,0},{40,0}},    color={0,0,255}));
  connect(pulse.y, sourceP1.IPressure) annotation (Line(points={{-59,0},{-35,0}}));
  annotation (experiment(StopTime=200),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Window(
      x=0.28,
      y=0.03,
      width=0.5,
      height=0.6),
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 13.11.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestCheckValve;
