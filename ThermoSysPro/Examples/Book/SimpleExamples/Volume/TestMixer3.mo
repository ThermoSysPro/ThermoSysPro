within ThermoSysPro.Examples.Book.SimpleExamples.Volume;
model TestMixer3

  ThermoSysPro.WaterSteam.Junctions.Mixer3 mixer2_2
    annotation (Placement(transformation(extent={{-6,-10},{14,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3 annotation (Placement(transformation(extent={{34,-10},
            {54,10}},  rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4 annotation (Placement(transformation(extent={{-46,10},
            {-26,30}},  rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5 annotation (Placement(transformation(extent={{-46,-30},
            {-26,-10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Source sourceP2
    annotation (Placement(transformation(extent={{-86,10},{-66,30}},   rotation=
           0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP3
    annotation (Placement(transformation(extent={{-86,-30},{-66,-10}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkP1
    annotation (Placement(transformation(extent={{74,-10},{94,10}},   rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante1(k=
        0.5) annotation (Placement(transformation(extent={{-46,30},{-26,50}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceQ
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}},  rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss6 annotation (Placement(transformation(extent={{-46,-10},
            {-26,10}},  rotation=0)));
equation
  connect(singularPressureLoss4.C2, mixer2_2.Ce1) annotation (Line(points={{-26,20},
          {0,20},{0,10}},        color={0,0,255}));
  connect(singularPressureLoss5.C2, mixer2_2.Ce2) annotation (Line(points={{-26,-20},
          {0,-20},{0,-10}},      color={0,0,255}));
  connect(mixer2_2.Cs, singularPressureLoss3.C1)
    annotation (Line(points={{14,0},{34,0}},     color={0,0,255}));
  connect(sourceP2.C, singularPressureLoss4.C1)
    annotation (Line(points={{-66,20},{-46,20}},   color={0,0,255}));
  connect(sourceP3.C, singularPressureLoss5.C1)
    annotation (Line(points={{-66,-20},{-46,-20}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, sinkP1.C)
    annotation (Line(points={{54,0},{74,0}},     color={0,0,255}));
  connect(sourceQ.C, singularPressureLoss6.C1)
    annotation (Line(points={{-66,0},{-46,0}},     color={0,0,255}));
  connect(singularPressureLoss6.C2, mixer2_2.Ce3) annotation (Line(points={{-26,0},
          {-16,0},{-6,0}},                   color={0,0,255}));
  connect(constante1.y, mixer2_2.Ialpha1)
    annotation (Line(points={{-25,40},{-14,40},{-14,6},{-3,6}}));
  annotation (experiment(StopTime=10), Diagram(graphics),
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
<p>This model is documented in Sect. 14.7.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestMixer3;
