within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestStaticExchangerKS

  ThermoSysPro.Fluid.HeatExchangers.StaticExchangerKS
    plateHeatExchanger(region_c=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
      region_f=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
               annotation (Placement(transformation(extent={{-20,34},{20,66}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP2(
                                            T0=340)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP3
    annotation (Placement(transformation(extent={{-80,60},{-60,80}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsP2
                                          annotation (Placement(transformation(
          extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsP3
                                          annotation (Placement(transformation(
          extent={{60,60},{80,80}}, rotation=0)));
equation
  connect(sourceP2.C, plateHeatExchanger.Ec)
    annotation (Line(points={{-60,30},{-40,30},{-40,45.2},{-20,45.2}},
                                                 color={0,0,255}));
  connect(sourceP3.C, plateHeatExchanger.Ef) annotation (Line(points={{-60,70},
          {-40,70},{-40,54.8},{-20,54.8}}, color={0,0,0}));
  connect(plateHeatExchanger.Sc, puitsP2.C) annotation (Line(points={{20,45.2},
          {26,45.2},{26,46},{40,46},{40,30},{60,30}}, color={0,0,0}));
  connect(plateHeatExchanger.Sf, puitsP3.C) annotation (Line(points={{20,54.8},
          {40,54.8},{40,70},{60,70}}, color={0,0,0}));
  annotation (experiment(StopTime=1000),
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestStaticExchangerKS;
