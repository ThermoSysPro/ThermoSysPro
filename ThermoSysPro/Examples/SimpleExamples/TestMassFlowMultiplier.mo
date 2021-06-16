within ThermoSysPro.Examples.SimpleExamples;
model TestMassFlowMultiplier

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourcePQ
    annotation (Placement(transformation(extent={{-100,0},{-80,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{60,0},{80,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss annotation (Placement(transformation(extent={{-60,0},{
            -40,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1 annotation (Placement(transformation(extent={{20,0},{
            40,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.MassFlowMultiplier massFlowMultiplier
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
equation
  connect(sourcePQ.C, singularPressureLoss.C1) annotation (Line(points={{-80,10},
          {-60,10}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, sink.C) annotation (Line(points={{40,10},{
          60,10}}, color={0,0,255}));
  connect(singularPressureLoss.C2, massFlowMultiplier.Ce) annotation (Line(
        points={{-40,10},{-20,10}}, color={0,0,255}));
  connect(massFlowMultiplier.Cs, singularPressureLoss1.C1) annotation (Line(
        points={{0,10},{20,10}}, color={0,0,255}));
annotation(experiment(StopTime=1000), Icon(graphics={
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
end TestMassFlowMultiplier;
