within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicWaterWaterExchanger

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger
    echangeurAPlaques1D(
    modec=1,
    modef=1,
    N=5) annotation (Placement(transformation(extent={{-20,40},{0,60}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
                                           T0=340)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1
                                            annotation (Placement(
        transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP
                                         annotation (Placement(transformation(
          extent={{40,40},{60,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1
                                          annotation (Placement(transformation(
          extent={{20,20},{40,40}}, rotation=0)));
equation
  connect(sourceP.C, echangeurAPlaques1D.Ec)
    annotation (Line(points={{-60,50},{-20,50}}, color={0,0,255}));
  connect(sourceP1.C, echangeurAPlaques1D.Ef) annotation (Line(points={{-40,30},
          {-15,30},{-15,44}}, color={0,0,255}));
  connect(echangeurAPlaques1D.Sc, puitsP.C) annotation (Line(points={{0,50},{20,
          50},{20,50},{40,50}},      color={0,0,255}));
  connect(echangeurAPlaques1D.Sf, puitsP1.C) annotation (Line(points={{-5,44},{
          -6,44},{-6,30},{20,30}}, color={0,0,255}));
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
end TestDynamicWaterWaterExchanger;
