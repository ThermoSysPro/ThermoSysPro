within ThermoSysPro.Examples.Book.SimpleExamples.Volume;
model TestSplitter3

  ThermoSysPro.WaterSteam.Junctions.Splitter3 splitter3
    annotation (Placement(transformation(extent={{-16,-10},{4,10}},  rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceP1(Q0=100)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3 annotation (Placement(transformation(extent={{-56,-10},
            {-36,10}},  rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP2
    annotation (Placement(transformation(extent={{84,30},{104,50}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP3
    annotation (Placement(transformation(extent={{84,-50},{104,-30}},  rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4 annotation (Placement(transformation(extent={{44,30},
            {64,50}},rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5 annotation (Placement(transformation(extent={{44,-50},
            {64,-30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante1(k=
        0) annotation (Placement(transformation(extent={{-36,10},{-16,30}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP4
    annotation (Placement(transformation(extent={{84,-10},{104,10}},  rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante2(k=
        0) annotation (Placement(transformation(extent={{-36,-30},{-16,-10}},
          rotation=0)));
equation
  connect(sourceP1.C, singularPressureLoss3.C1)
    annotation (Line(points={{-76,0},{-56,0}},     color={0,0,255}));
  connect(singularPressureLoss3.C2, splitter3.Ce) annotation (Line(points={{-36,0},
          {-15.8,0}},        color={0,0,255}));
  connect(splitter3.Cs1, singularPressureLoss4.C1) annotation (Line(points={{-2,10},
          {-2,40},{44,40}},        color={0,0,255}));
  connect(singularPressureLoss4.C2, sinkP2.C)
    annotation (Line(points={{64,40},{84,40}},   color={0,0,255}));
  connect(splitter3.Cs2, singularPressureLoss5.C1) annotation (Line(points={{-2,-10},
          {-2,-40},{44,-40}},      color={0,0,255}));
  connect(singularPressureLoss5.C2, sinkP3.C)
    annotation (Line(points={{64,-40},{84,-40}}, color={0,0,255}));
  connect(constante1.y, splitter3.Ialpha1)
    annotation (Line(points={{-15,20},{-10,20},{-10,6},{-5,6}}));
  connect(splitter3.Cs3, sinkP4.C)
    annotation (Line(points={{4,0},{84,0}},     color={0,0,255}));
  connect(splitter3.Ialpha2, constante2.y)
    annotation (Line(points={{-5,-6},{-10,-6},{-10,-20},{-15,-20}}));
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
<p>This model is documented in Sect. 14.8.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestSplitter3;
