within ThermoSysPro.Examples.SimpleExamples;
model TestSensors

  ThermoSysPro.WaterSteam.Sensors.SensorH specificEnthalpySensor
    annotation (Placement(transformation(extent={{-60,8},{-40,28}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQ massFlowSensor
    annotation (Placement(transformation(extent={{-20,8},{0,28}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorQv volumetricFlowSensor
    annotation (Placement(transformation(extent={{20,8},{40,28}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorP pressureSensor
    annotation (Placement(transformation(extent={{-60,-32},{-40,-12}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Sensors.SensorT temperatureSensor
    annotation (Placement(transformation(extent={{-20,-32},{0,-12}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP
                                         annotation (Placement(transformation(
          extent={{60,-40},{80,-20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
                                           annotation (Placement(transformation(
          extent={{-100,0},{-80,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP
    annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
equation
  connect(sourceP.C, specificEnthalpySensor.C1)
    annotation (Line(points={{-80,10},{-60,10}}, color={0,0,255}));
  connect(specificEnthalpySensor.C2, massFlowSensor.C1)
    annotation (Line(points={{-39.8,10},{-20,10}}, color={0,0,255}));
  connect(massFlowSensor.C2, volumetricFlowSensor.C1)
    annotation (Line(points={{0.2,10},{20,10}}, color={0,0,255}));
  connect(volumetricFlowSensor.C2, pressureSensor.C1) annotation (Line(points={
          {40.2,10},{60,10},{60,0},{-80,0},{-80,-30},{-60,-30}}, color={0,0,255}));
  connect(pressureSensor.C2, temperatureSensor.C1) annotation (Line(points={{
          -39.8,-30},{-20,-30}}, color={0,0,255}));
  connect(temperatureSensor.C2, perteDP.C1)
    annotation (Line(points={{0.2,-30},{20,-30}}, color={0,0,255}));
  connect(perteDP.C2, puitsP.C)
    annotation (Line(points={{40,-30},{60,-30}}, color={0,0,255}));
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
end TestSensors;
