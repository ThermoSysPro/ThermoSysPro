within ThermoSysPro.Examples.SimpleExamples;
model TestLoopBreaker

  WaterSteam.BoundaryConditions.SourcePQ sourcePQ
    annotation (Placement(transformation(extent={{-100,0},{-80,20}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss1
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss2
    annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
  WaterSteam.Junctions.Splitter2 splitter2_1 annotation (Placement(
        transformation(extent={{-56,0},{-36,20}}, rotation=0)));
  WaterSteam.Junctions.Mixer2 mixer2_1 annotation (Placement(transformation(
          extent={{40,0},{60,20}}, rotation=0)));
  WaterSteam.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{80,0},{100,20}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante constante(k=0.5)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
  WaterSteam.LoopBreakers.LoopBreakerP loopBreakerP
    annotation (Placement(transformation(extent={{10,-20},{30,0}}, rotation=0)));
equation
  connect(sourcePQ.C, splitter2_1.Ce) annotation (Line(
      points={{-80,10},{-56,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(splitter2_1.Cs1, singularPressureLoss1.C1) annotation (Line(
      points={{-42,20},{-42,30},{-20,30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(splitter2_1.Cs2, singularPressureLoss2.C1) annotation (Line(
      points={{-42,0},{-42,-10},{-20,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mixer2_1.Ce1, singularPressureLoss1.C2)
    annotation (Line(points={{46,20},{46,30},{0,30}}, smooth=Smooth.None));
  connect(mixer2_1.Cs, sink.C) annotation (Line(
      points={{60,10},{80,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constante.y, splitter2_1.Ialpha1)
    annotation (Line(points={{-59,50},{-52,50},{-52,16},{-45,16}}, smooth=
          Smooth.None));
  connect(singularPressureLoss2.C2, loopBreakerP.C1) annotation (Line(
      points={{0,-10},{10,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(loopBreakerP.C2, mixer2_1.Ce2) annotation (Line(
      points={{30,-10},{46,-10},{46,0}},
      color={0,0,255},
      smooth=Smooth.None));
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
end TestLoopBreaker;
