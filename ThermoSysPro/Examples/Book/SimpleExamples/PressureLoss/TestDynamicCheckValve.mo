within ThermoSysPro.Examples.Book.SimpleExamples.PressureLoss;
model TestDynamicCheckValve

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1
                                     annotation (Placement(transformation(
          extent={{-38,-10},{-18,10}},rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1(
                                   P0=6e5) annotation (Placement(transformation(
          extent={{42,-10},{62,10}},rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.DynamicCheckValve checkValve(J=10)
    annotation (Placement(transformation(extent={{2,-10},{22,10}},rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Sinusoide pulse(
    period=100,
    amplitude=3e5,
    offset=6e5) annotation (Placement(transformation(extent={{-78,-10},{-58,10}},
          rotation=0)));
equation
  connect(sourceP1.C, checkValve.C1)
    annotation (Line(points={{-18,0},{2,0}},   color={0,0,255}));
  connect(checkValve.C2, puitsP1.C) annotation (Line(points={{22,0},{32,0},{42,
          0}},             color={0,0,255}));
  connect(sourceP1.IPressure, pulse.y)
    annotation (Line(points={{-33,0},{-57,0}},   color={28,108,200}));
  annotation (
    Diagram(graphics,
            coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),
    Window(
      x=0.28,
      y=0.03,
      width=0.5,
      height=0.6),
    experiment(StopTime=300),
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
<p>This model is documented in Sect. 13.12.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestDynamicCheckValve;
