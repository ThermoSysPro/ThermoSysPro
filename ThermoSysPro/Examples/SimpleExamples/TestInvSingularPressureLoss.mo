within ThermoSysPro.Examples.SimpleExamples;
model TestInvSingularPressureLoss

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourcePQ
    annotation (Placement(transformation(extent={{-80,0},{-60,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkQ
    annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.InvSingularPressureLoss
    invSingularPressureLoss annotation (Placement(transformation(extent={{-20,0},
            {0,20}}, rotation=0)));
equation
  connect(sourcePQ.C, invSingularPressureLoss.C1) annotation (Line(points={{-60,
          10},{-20,10}}, color={0,0,255}));
  connect(invSingularPressureLoss.C2, sinkQ.C) annotation (Line(points={{0,10},
          {40,10}}, color={0,0,255}));
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
end TestInvSingularPressureLoss;
