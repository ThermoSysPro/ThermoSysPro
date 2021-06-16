within ThermoSysPro.Examples.SimpleExamples;
model TestStaticExchangerWaterSteamFlueGases

  ThermoSysPro.WaterSteam.BoundaryConditions.Sink puits_Eau
                                          annotation (Placement(transformation(
          extent={{60,-10},{80,10}}, rotation=0)));

  ThermoSysPro.MultiFluids.HeatExchangers.StaticExchangerWaterSteamFlueGases
    EchangeurEfficacite(                                                                   EffEch=0.9,
    Kdpf=10,
    Kdpe=100,
    W0=1e6,
    exchanger_conf=1,
    exchanger_type=1)
                annotation (Placement(transformation(extent={{-40,-20},{40,20}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ source_Eau(
    P0=4e5,
    h0=170000,
    Q0=15)    annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees(
    Xco2=0,
    Xo2=0.233,
    Xso2=0,
    Xh2o=0.01,
    Q0=20,
    T0=700,
    P0=13e5)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees
    annotation (Placement(transformation(
        origin={30,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
equation
  connect(source_Eau.C, EchangeurEfficacite.Cws1) annotation (Line(points={{-60,
          0},{-40,0}}, color={0,0,255}));
  connect(EchangeurEfficacite.Cws2, puits_Eau.C) annotation (Line(points={{40,0},
          {60,0}}, color={0,0,255}));
  connect(Source_Fumees.C, EchangeurEfficacite.Cfg1) annotation (Line(
      points={{-20,50},{0,50},{0,18}},
      color={0,0,0},
      thickness=1));
  connect(Puits_Fumees.C, EchangeurEfficacite.Cfg2) annotation (Line(
      points={{20.2,-50},{-0.2,-50},{-0.2,-18}},
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
end TestStaticExchangerWaterSteamFlueGases;
