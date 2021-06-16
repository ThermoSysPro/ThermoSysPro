within ThermoSysPro.Examples.SimpleExamples;
model TestFlueGasesJunctions

  ThermoSysPro.FlueGases.Junctions.Splitter2 splitter2
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceQ sourceP( Q0=200)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}}, rotation=
            0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss annotation (Placement(transformation(extent={{-60,40},
            {-40,60}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink sinkP
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkP sinkP1
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss1 annotation (Placement(transformation(extent={{40,80},
            {60,100}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss2 annotation (Placement(transformation(extent={{40,0},{
            60,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=0)
             annotation (Placement(transformation(extent={{-40,60},{-20,80}},
          rotation=0)));
  ThermoSysPro.FlueGases.Junctions.Mixer2 mixer2_1
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss3
                         annotation (Placement(transformation(extent={{20,-60},
            {40,-40}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss4 annotation (Placement(transformation(extent={{-60,-40},
            {-40,-20}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss5 annotation (Placement(transformation(extent={{-60,-80},
            {-40,-60}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Source sourceP1
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceP sourceP2
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkQ sinkP2
    annotation (Placement(transformation(extent={{60,-60},{80,-40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante1(k=0.5)
             annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
          rotation=0)));
equation
  connect(constante.y, splitter2.Ialpha1)
    annotation (Line(points={{-19,70},{-14,70},{-14,56},{-9,56}}));
  connect(constante1.y, mixer2_1.Ialpha1)
    annotation (Line(points={{-39,-50},{-28,-50},{-28,-44},{-17,-44}}));
  connect(sourceP.C, singularPressureLoss.C1) annotation (Line(
      points={{-80,50},{-60,50}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss.C2, splitter2.Ce) annotation (Line(
      points={{-40,50},{-20,50}},
      color={0,0,0},
      thickness=1));
  connect(splitter2.Cs1, singularPressureLoss1.C1) annotation (Line(
      points={{-6,60},{-6,90},{40,90}},
      color={0,0,0},
      thickness=1));
  connect(splitter2.Cs2, singularPressureLoss2.C1) annotation (Line(
      points={{-6,40},{-6,10},{40,10}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss1.C2, sinkP.C) annotation (Line(
      points={{60,90},{80.2,90}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss2.C2, sinkP1.C) annotation (Line(
      points={{60,10},{80.2,10}},
      color={0,0,0},
      thickness=1));
  connect(sourceP1.C, singularPressureLoss4.C1) annotation (Line(
      points={{-80,-30},{-60,-30}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss4.C2, mixer2_1.Ce1) annotation (Line(
      points={{-40,-30},{-14,-30},{-14,-40}},
      color={0,0,0},
      thickness=1));
  connect(mixer2_1.Ce2, singularPressureLoss5.C2) annotation (Line(
      points={{-14,-60},{-14,-70},{-40,-70}},
      color={0,0,0},
      thickness=1));
  connect(mixer2_1.Cs, singularPressureLoss3.C1) annotation (Line(
      points={{0,-50},{20,-50}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss3.C2, sinkP2.C) annotation (Line(
      points={{40,-50},{60.2,-50}},
      color={0,0,0},
      thickness=1));
  connect(sourceP2.C, singularPressureLoss5.C1) annotation (Line(
      points={{-80,-70},{-60,-70}},
      color={0,0,0},
      thickness=1));
  annotation (experiment(StopTime=200), Diagram(graphics),
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
end TestFlueGasesJunctions;
