within ThermoSysPro.Fluid.Examples.Book.SimpleExamples.PressureLoss;
model TestPipePressureLoss

  ThermoSysPro.Fluid.BoundaryConditions.SourceP SourceP1
    annotation (Placement(transformation(extent={{-85,-10},{-65,10}}, rotation=
            0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{64,-10},{84,10}},rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss pipePressureLoss
                                          annotation (Placement(transformation(
          extent={{-40,-53},{38,53}},
                                    rotation=0)));
equation
  connect(pipePressureLoss.C2, PuitsP1.C)
    annotation (Line(points={{38,0},{49,0},{64,0}},
                                              color={0,0,255}));
  connect(SourceP1.C, pipePressureLoss.C1)
    annotation (Line(points={{-65,0},{-65,0},{-40,0}},
                                                 color={0,0,255}));
  annotation (
    experiment(StopTime=1000),
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
<h4>Copyright &copy; EDF 2002 - 2021 </h4>
<h4>ThermoSysPro Version 4.0 </h4>
<p>This model is documented in Sect. 13.4.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola. </p>
</html>"));
end TestPipePressureLoss;
