within ThermoSysPro.Examples.SimpleExamples;
model TestStaticWaterWaterExchangerDTorWorEff

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceWaterSteam_FF(
    C(P(start=219.E5)),
    Q0=481.07,
    h0=1067.9E3)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkWaterSteam_FF(
    P0=217.68E5)
    annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ sourceWaterSteam_FC(
    C(P(start=24E5)),
    Q0=23.377,
    h0=3420.3E3)
    annotation (Placement(transformation(
        origin={-30,30},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkWaterSteam_FC(
    P0=24.13E5)
    annotation (Placement(transformation(extent={{-2,20},{20,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff
    exchangerWaterSteamDTorWorEFF(
    EffEch=1,
    Kf=597.832,
    Ec(P(start=23e5)),
    Ef(P(start=219E5)),
    exchanger_type=3)   annotation (Placement(transformation(extent={{-20,-20},
            {0,0}}, rotation=0)));
equation
  connect(sourceWaterSteam_FF.C, exchangerWaterSteamDTorWorEFF.Ef)
    annotation (Line(points={{-40,-10},{-20,-10}}, color={0,0,255}));
  connect(exchangerWaterSteamDTorWorEFF.Sf, sinkWaterSteam_FF.C) annotation (Line(
        points={{0,-9.9},{10.2,-9.9},{10.2,-10},{20,-10}}, color={0,0,255}));
  connect(sourceWaterSteam_FC.C, exchangerWaterSteamDTorWorEFF.Ec) annotation (Line(
        points={{-20,30},{-14,30},{-14,-5.9}}, color={0,0,255}));
  connect(exchangerWaterSteamDTorWorEFF.Sc, sinkWaterSteam_FC.C) annotation (Line(
        points={{-6,-5.9},{-6,30},{-2,30}}, color={0,0,255}));
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
end TestStaticWaterWaterExchangerDTorWorEff;
