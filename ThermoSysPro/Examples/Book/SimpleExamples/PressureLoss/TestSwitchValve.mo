within ThermoSysPro.Examples.Book.SimpleExamples.PressureLoss;
model TestSwitchValve

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP SourceP1
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{70,-10},{90,10}},rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SwitchValve SwitchValve
                                          annotation (Placement(transformation(
          extent={{-18,-9},{18,37}},rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Pulse pulse(
                                         width=10, period=20)
    annotation (Placement(transformation(extent={{-50,31},{-30,51}}, rotation=0)));
  WaterSteam.PressureLosses.LumpedStraightPipe              perteDP2
                                        annotation (Placement(transformation(
          extent={{-55,-10},{-35,10}},rotation=0)));
  WaterSteam.PressureLosses.LumpedStraightPipe              perteDP1
                                        annotation (Placement(transformation(
          extent={{34,-10},{54,10}},rotation=0)));
equation
  connect(pulse.yL, SwitchValve.Ouv) annotation (Line(points={{-29,41},{0,41},{
          0,30.56}}));
  connect(SourceP1.C, perteDP2.C1)
    annotation (Line(points={{-70,0},{-55,0}},   color={0,0,255}));
  connect(perteDP2.C2, SwitchValve.C1) annotation (Line(points={{-35,0},{-20,0},
          {-20,0.2},{-18,0.2}},       color={0,0,255}));
  connect(SwitchValve.C2, perteDP1.C1) annotation (Line(points={{18,0.66},{20,
          0.66},{20,0},{34,0}},    color={0,0,255}));
  connect(perteDP1.C2, PuitsP1.C)
    annotation (Line(points={{54,0},{54,0},{70,0}},    color={0,0,255}));
  annotation (experiment(StopTime=100),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
    Diagram(graphics,
            coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2})),
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
<p>This model is documented in Sect. 13.10.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestSwitchValve;
