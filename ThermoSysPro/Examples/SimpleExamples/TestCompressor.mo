within ThermoSysPro.Examples.SimpleExamples;
model TestCompressor

  ThermoSysPro.WaterSteam.Machines.Compressor compressor(Pe(start=100000))
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink puitsP
    annotation (Placement(transformation(extent={{60,60},{80,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourceP(
    P0=100000,
    Q0=1,
    h0=3.e4) annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(
      fluid=2) annotation (Placement(transformation(extent={{-60,60},{-40,80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe1(
     fluid=2) annotation (Placement(transformation(extent={{20,60},{40,80}},
          rotation=0)));
equation
  connect(sourceP.C, lumpedStraightPipe.C1)
    annotation (Line(points={{-80,70},{-60,70}}, color={0,0,255}));
  connect(lumpedStraightPipe.C2, compressor.C1)
    annotation (Line(points={{-40,70},{-20,70}}, color={0,0,255}));
  connect(compressor.C2, lumpedStraightPipe1.C1)
    annotation (Line(points={{0,70},{20,70}}, color={0,0,255}));
  connect(lumpedStraightPipe1.C2, puitsP.C)
    annotation (Line(points={{40,70},{60,70}}, color={0,0,255}));
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
end TestCompressor;
