within ThermoSysPro.Examples.Book.SimpleExamples.PressureLoss;
model TestDiaphragm

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP SourceP1
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}},rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{44,-10},{64,10}},rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.Diaphragm Diaphragm
                                          annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
                                    rotation=0)));
equation
  connect(Diaphragm.C2, PuitsP1.C)
    annotation (Line(points={{10,0},{44,0}},  color={0,0,255}));
  connect(SourceP1.C, Diaphragm.C1)
    annotation (Line(points={{-44,0},{-10,0}},   color={0,0,255}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 13.7.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestDiaphragm;
