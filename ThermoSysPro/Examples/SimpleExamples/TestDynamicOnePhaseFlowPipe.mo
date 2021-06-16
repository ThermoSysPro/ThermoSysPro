within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicOnePhaseFlowPipe

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe
    dynamicOnePhaseFlowPipe(
    P(start={300000.0,281833.41863536794,263664.3047317458,245492.47958308208,
          227317.76827098028,209139.99948381615,190959.00534677133,
          172774.6212620022,154586.68575822545,136395.04034905753,
          118199.52939949898,100000.0}),
    Q(start={536.5750641592207,536.5750641592207,536.5750641592207,
          536.5750641592207,536.5750641592207,536.5750641592207,
          536.5750641592207,536.5750641592207,536.5750641592207,
          536.5750641592207,536.5750641592207}),
    h(start={71016.12237181116,74743.46665892199,78470.81094603281,
          82198.15523314364,85925.49952025448,89652.84380736532,
          93380.18809447614,97107.53238158698,100834.8766686978,
          104562.22095580865,108289.56524291947,70825.9016030344}))
                            annotation (Placement(transformation(extent={{-20,
            20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    option_temperature=2,
    W0={2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6})
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(Ns=10)
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
equation
  connect(sourceP.C, dynamicOnePhaseFlowPipe.C1) annotation (Line(points={{-40,
          30},{-20,30}}, color={0,0,255}));
  connect(dynamicOnePhaseFlowPipe.C2, sinkP.C) annotation (Line(points={{0,30},
          {20,30}}, color={0,0,255}));
  connect(heatSource.C, heatExchangerWall.WT2) annotation (Line(points={{-10,
          60.2},{-10,52}}, color={191,95,0}));
  connect(heatExchangerWall.WT1, dynamicOnePhaseFlowPipe.CTh)
    annotation (Line(points={{-10,48},{-10,33}}, color={191,95,0}));
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
end TestDynamicOnePhaseFlowPipe;
