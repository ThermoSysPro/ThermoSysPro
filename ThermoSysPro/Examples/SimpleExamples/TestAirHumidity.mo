within ThermoSysPro.Examples.SimpleExamples;
model TestAirHumidity

  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ sourceFlueGasesPQ(P0=1.e5,
      T0=293) annotation (Placement(transformation(extent={{-80,0},{-60,20}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.AirHumidity airHumidity(hum0=0.9)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss
    singularPressureLoss(K=1.e-5) annotation (Placement(transformation(extent={
            {0,0},{20,20}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink sinkFlueGases
    annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
equation
  connect(sourceFlueGasesPQ.C, airHumidity.C1) annotation (Line(
      points={{-60,10},{-40,10}},
      color={0,0,0},
      thickness=1));
  connect(airHumidity.C2, singularPressureLoss.C1) annotation (Line(
      points={{-20,10},{0,10}},
      color={0,0,0},
      thickness=1));
  connect(singularPressureLoss.C2, sinkFlueGases.C) annotation (Line(
      points={{20,10},{40.2,10}},
      color={0,0,0},
      thickness=1));
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
end TestAirHumidity;
