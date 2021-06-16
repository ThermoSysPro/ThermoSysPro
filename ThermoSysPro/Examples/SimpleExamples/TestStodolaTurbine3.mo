within ThermoSysPro.Examples.SimpleExamples;
model TestStodolaTurbine3

  ThermoSysPro.WaterSteam.Machines.StodolaTurbine stodolaTurbine
    annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(                 mode=0, P0=
        5000000)
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    h0=3.e6,
    option_temperature=2,
    mode=2,
    P0=23000000)
             annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine stodolaTurbine1
    annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1(                mode=0, P0=
        22500000)
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(
    h0=3.e6,
    option_temperature=2,
    mode=2,
    P0=30000000)
             annotation (Placement(transformation(extent={{-100,0},{-80,20}},
          rotation=0)));
equation
  connect(sourceP.C, stodolaTurbine.Ce)
    annotation (Line(points={{-80,70},{-60.1,70}}, color={0,0,255}));
  connect(stodolaTurbine.Cs, puitsP.C)
    annotation (Line(points={{-39.9,70},{-20,70}}, color={0,0,255}));
  connect(sourceP1.C, stodolaTurbine1.Ce)
    annotation (Line(points={{-80,10},{-60.1,10}}, color={0,0,255}));
  connect(stodolaTurbine1.Cs, puitsP1.C)
    annotation (Line(points={{-39.9,10},{-20,10}}, color={0,0,255}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.32,
      y=0.02,
      width=0.39,
      height=0.47),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{34,76},{82,64}},
          lineColor={0,0,255},
          textString=
               "Supercritrical at the inlet"), Text(
          extent={{20,18},{92,2}},
          lineColor={0,0,255},
          textString=
               "Supercritrical at the inlet and the outlet")}),
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
end TestStodolaTurbine3;
