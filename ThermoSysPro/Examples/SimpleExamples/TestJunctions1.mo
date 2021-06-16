within ThermoSysPro.Examples.SimpleExamples;
model TestJunctions1

  ThermoSysPro.WaterSteam.Junctions.Splitter2 splitter2
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceP(Q0=200)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss annotation (Placement(transformation(extent={{-60,40},
            {-40,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP1
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1 annotation (Placement(transformation(extent={{40,80},
            {60,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2 annotation (Placement(transformation(extent={{40,0},{
            60,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=
        0.5) annotation (Placement(transformation(extent={{-40,60},{-20,80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.Splitter3 splitter3
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceP1(Q0=400)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3 annotation (Placement(transformation(extent={{-60,-60},
            {-40,-40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP2
    annotation (Placement(transformation(extent={{80,-20},{100,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP3
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4 annotation (Placement(transformation(extent={{40,-20},
            {60,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5 annotation (Placement(transformation(extent={{40,-100},
            {60,-80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante1(k=
        0) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP4
    annotation (Placement(transformation(extent={{80,-60},{100,-40}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante2(k=
        0) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}},
          rotation=0)));
equation
  connect(sourceP.C, singularPressureLoss.C1)
    annotation (Line(points={{-80,50},{-60,50}}, color={0,0,255}));
  connect(singularPressureLoss.C2, splitter2.Ce)
    annotation (Line(points={{-40,50},{-20,50}}, color={0,0,255}));
  connect(splitter2.Cs1, singularPressureLoss1.C1) annotation (Line(points={{-6,
          60},{-6,90},{40,90}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, sinkP.C)
    annotation (Line(points={{60,90},{80,90}}, color={0,0,255}));
  connect(splitter2.Cs2, singularPressureLoss2.C1) annotation (Line(points={{-6,
          40},{-6,10},{40,10}}, color={0,0,255}));
  connect(singularPressureLoss2.C2, sinkP1.C)
    annotation (Line(points={{60,10},{80,10}}, color={0,0,255}));
  connect(constante.y, splitter2.Ialpha1)
    annotation (Line(points={{-19,70},{-14,70},{-14,56},{-9,56}}));
  connect(sourceP1.C, singularPressureLoss3.C1)
    annotation (Line(points={{-80,-50},{-60,-50}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, splitter3.Ce) annotation (Line(points={{-40,
          -50},{-19.8,-50}}, color={0,0,255}));
  connect(splitter3.Cs1, singularPressureLoss4.C1) annotation (Line(points={{-6,
          -40},{-6,-10},{40,-10}}, color={0,0,255}));
  connect(singularPressureLoss4.C2, sinkP2.C)
    annotation (Line(points={{60,-10},{80,-10}}, color={0,0,255}));
  connect(splitter3.Cs2, singularPressureLoss5.C1) annotation (Line(points={{-6,
          -60},{-6,-90},{40,-90}}, color={0,0,255}));
  connect(singularPressureLoss5.C2, sinkP3.C)
    annotation (Line(points={{60,-90},{80,-90}}, color={0,0,255}));
  connect(constante1.y, splitter3.Ialpha1)
    annotation (Line(points={{-19,-30},{-14,-30},{-14,-44},{-9,-44}}));
  connect(splitter3.Cs3, sinkP4.C)
    annotation (Line(points={{0,-50},{80,-50}}, color={0,0,255}));
  connect(splitter3.Ialpha2, constante2.y)
    annotation (Line(points={{-9,-56},{-14,-56},{-14,-70},{-19,-70}}));
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
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestJunctions1;
