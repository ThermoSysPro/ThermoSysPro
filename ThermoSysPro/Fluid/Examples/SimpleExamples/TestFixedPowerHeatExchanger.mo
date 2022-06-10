within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestFixedPowerHeatExchanger

  ThermoSysPro.Fluid.HeatExchangers.FixedPowerHeatExchanger
    plateHeatExchanger(region_c=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
      region_f=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
    DW=1.e6)   annotation (Placement(transformation(extent={{-20,40},{0,60}},
          rotation=0)));
  BoundaryConditions.SourcePQ                   sourceP2(T0=340,
      option_temperature=true)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  BoundaryConditions.SourcePQ                   sourceP3(option_temperature=
        true)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}}, rotation=0)));
  BoundaryConditions.Sink                     puitsP2
                                          annotation (Placement(transformation(
          extent={{20,20},{40,40}}, rotation=0)));
  BoundaryConditions.Sink                     puitsP3
                                          annotation (Placement(transformation(
          extent={{20,40},{40,60}}, rotation=0)));
equation
  connect(sourceP3.C, plateHeatExchanger.Ef)
    annotation (Line(points={{-40,50},{-20,50}}, color={0,0,0}));
  connect(plateHeatExchanger.Sf, puitsP3.C) annotation (Line(points={{-0.2,50.1},
          {9.9,50.1},{9.9,50},{20,50}}, color={0,0,0}));
  connect(plateHeatExchanger.Sc, puitsP2.C) annotation (Line(points={{-4.2,44},
          {-4,44},{-4,30},{20,30}}, color={0,0,0}));
  connect(plateHeatExchanger.Ec, sourceP2.C) annotation (Line(points={{-15.8,44},
          {-16,44},{-16,30},{-40,30}}, color={0,0,0}));
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
end TestFixedPowerHeatExchanger;
