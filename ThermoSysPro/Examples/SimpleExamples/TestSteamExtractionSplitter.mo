within ThermoSysPro.Examples.SimpleExamples;
model TestSteamExtractionSplitter

  ThermoSysPro.WaterSteam.Junctions.SteamExtractionSplitter
    steamExtractionSplitter(alpha=0.9)
                            annotation (Placement(transformation(extent={{-20,
            20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceQ(h0=2600000)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2 annotation (Placement(transformation(extent={{-60,20},
            {-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP(P0=100e5)
    annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1 annotation (Placement(transformation(extent={{20,20},
            {40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=2.e-3)
                          annotation (Placement(transformation(extent={{0,-20},
            {20,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sink(Q0=10)
    annotation (Placement(transformation(extent={{40,-20},{60,0}}, rotation=0)));
equation
  connect(sourceQ.C, singularPressureLoss2.C1) annotation (Line(points={{-80,30},
          {-60,30}}, color={0,0,255}));
  connect(singularPressureLoss2.C2, steamExtractionSplitter.Ce) annotation (Line(
        points={{-40,30},{-20.3,30}}, color={0,0,255}));
  connect(steamExtractionSplitter.Cs, singularPressureLoss1.C1) annotation (Line(
        points={{0.3,30},{20,30}}, color={0,0,255}));
  connect(steamExtractionSplitter.Cex, singularPressureLoss3.C1) annotation (Line(
        points={{-6,20},{-6,-10},{0,-10}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, sinkP.C)
    annotation (Line(points={{40,30},{60,30}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, sink.C)
    annotation (Line(points={{20,-10},{40,-10}}, color={0,0,255}));
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
end TestSteamExtractionSplitter;
