within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestSwitchValve

  ThermoSysPro.Fluid.BoundaryConditions.SourceP SourceP1
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}},rotation=
            0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{80,-10},{100,10}},
                                    rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SwitchValve SwitchValve
                                          annotation (Placement(transformation(
          extent={{-10,-4},{10,16}},rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Pulse pulse(
                                         width=10, period=20)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe              perteDP2
                                        annotation (Placement(transformation(
          extent={{-60,-10},{-39,10}},rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe              perteDP1
                                        annotation (Placement(transformation(
          extent={{40,-10},{60,10}},rotation=0)));
equation
  connect(pulse.yL, SwitchValve.Ouv) annotation (Line(points={{-39,60},{0,60},{
          0,13.2}}));
  connect(SourceP1.C, perteDP2.C1)
    annotation (Line(points={{-80,0},{-60,0}},   color={0,0,255}));
  connect(perteDP2.C2, SwitchValve.C1) annotation (Line(points={{-39,0},{-10,0}},
                                      color={0,0,255}));
  connect(SwitchValve.C2, perteDP1.C1) annotation (Line(points={{10,0},{40,0}},
                                   color={0,0,255}));
  connect(perteDP1.C2, PuitsP1.C)
    annotation (Line(points={{60,0},{80,0}},           color={0,0,255}));
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestSwitchValve;
