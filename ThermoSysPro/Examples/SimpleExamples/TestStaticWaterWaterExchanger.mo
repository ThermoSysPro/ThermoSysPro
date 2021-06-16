within ThermoSysPro.Examples.SimpleExamples;
model TestStaticWaterWaterExchanger

  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchanger
    plateHeatExchanger(modec=1, modef=1)
               annotation (Placement(transformation(extent={{-20,44},{0,64}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP2(
                                            T0=340)
    annotation (Placement(transformation(extent={{-80,44},{-60,64}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP3
    annotation (Placement(transformation(extent={{-60,24},{-40,44}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP2
                                          annotation (Placement(transformation(
          extent={{40,44},{60,64}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP3
                                          annotation (Placement(transformation(
          extent={{20,24},{40,44}}, rotation=0)));
equation
  connect(sourceP2.C, plateHeatExchanger.Ec)
    annotation (Line(points={{-60,54},{-20,54}}, color={0,0,255}));
  connect(sourceP3.C, plateHeatExchanger.Ef)
                                            annotation (Line(points={{-40,34},{
          -15,34},{-15,48}}, color={0,0,255}));
  connect(plateHeatExchanger.Sc, puitsP2.C)
                                           annotation (Line(points={{0,54.2},{
          20,54.2},{20,54},{40,54}}, color={0,0,255}));
  connect(plateHeatExchanger.Sf, puitsP3.C)
                                           annotation (Line(points={{-5,48},{-6,
          48},{-6,34},{20,34}}, color={0,0,255}));
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
end TestStaticWaterWaterExchanger;
