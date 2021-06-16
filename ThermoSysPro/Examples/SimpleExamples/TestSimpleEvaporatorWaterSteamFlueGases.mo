within ThermoSysPro.Examples.SimpleExamples;
model TestSimpleEvaporatorWaterSteamFlueGases

  ThermoSysPro.WaterSteam.BoundaryConditions.Sink puits_Eau
                                          annotation (Placement(transformation(
          extent={{64,-17},{84,3}}, rotation=0)));

  ThermoSysPro.MultiFluids.HeatExchangers.SimpleEvaporatorWaterSteamFlueGases
    EchangeurEfficacite(Kdpf=1, Kdpe=1)
                annotation (Placement(transformation(extent={{-44,-35},{44,21}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ source_Eau(
    P0=65.27e5,
    Q0=38.92/3.6,
    h0=1242080)
              annotation (Placement(transformation(extent={{-84,-17},{-64,3}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees(
    Xso2=0,
    P0=1.01e5,
    Q0=86.7429,
    T0=750.54,
    Xco2=0.04725,
    Xh2o=0.051874,
    Xo2=0.15011)
    annotation (Placement(transformation(extent={{-34,45},{0,75}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees
    annotation (Placement(transformation(
        origin={16,-70},
        extent={{16,-15},{-16,15}},
        rotation=180)));
equation
  connect(Source_Fumees.C, EchangeurEfficacite.Cfg1) annotation (Line(
      points={{0,60},{0,18.2}},
      color={0,0,0},
      thickness=1));
  connect(EchangeurEfficacite.Cfg2, Puits_Fumees.C) annotation (Line(
      points={{0,-32.2},{0,-70},{0.32,-70}},
      color={0,0,0},
      thickness=1));
  connect(EchangeurEfficacite.Cws2, puits_Eau.C) annotation (Line(points={{44,
          -7},{54,-7},{54,-7},{64,-7}}, color={0,0,255}));
  connect(EchangeurEfficacite.Cws1, source_Eau.C)
    annotation (Line(points={{-44,-7},{-54,-7},{-54,-7},{-64,-7}}));
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
end TestSimpleEvaporatorWaterSteamFlueGases;
