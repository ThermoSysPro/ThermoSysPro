within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDynamicFlueGasesMultiFluidHeatExchanger

  BoundaryConditions.SourceP                    sourceP(C(h_vol_2(start=
            71016.12237181065)),
    option_temperature=true,
    P0=10000000,
    Q(start=190407.49090838886))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  BoundaryConditions.SinkP                    sinkP(C(h_vol_1(start=
            71016.1223718086)))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  HeatExchangers.DynamicFlueGasesMultiFluidHeatExchanger dynamicMultiFluidHeatExchanger(
    steady_state=true,
    Cfg1(h_vol_2(start=1999458.3239137873)),
    Cfg2(h_vol_1(start=1997835.1051783948)),
    ExchangerFlueGasesMetal(
      P(start={5000000.0,5000000.0,5000000.0,5000000.0,5000000.0,5000000.0}),
      Q(start={2702.7912398488343,2702.7912398488343,2702.7912398488343,
            2702.7912398488343,2702.7912398488343}),
      Tp(start={293.20684981473266,293.655268073503,294.1038710234491,
            294.55265602776745}),
      h(start={2000000.0,1999458.375,1998916.9494222174,1998375.8765143699,
            1997835.125,100000.0}),
      rho2(start={9.227614370571606,9.229671002969678,9.231727464730685,
            9.23378375498367,9.235839872860517})),
    TwoPhaseFlowPipe(
      P(start={10000000.0,8023904.042494878,6045867.025005122,
            4065878.0712931687,2083926.1359166082,100000.0}),
      Q(start={3482.228448926616,3482.228448926616,3482.228448926616,
            3482.228448926616,3482.228448926616}),
      h(start={80196.484375,80197.90894929563,80199.3305700632,
            80200.75139888813,80202.17143579095,70825.8984375})),
    ExchangerWall(Tp(start={291.91912560937857,292.368260847782,
            292.81758075140095,293.26708268122}),   Tp1(start={
            290.60590026437563,291.055766680952,291.5058177362657,
            291.9560507892685})),
    Ns=4,
    inertia=false,
    Ntubes=100,
    diffusion=true,
    dynamic_energy_balance=true)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  BoundaryConditions.SourcePQ                   sourceP1(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    h0=2e6,
    P0=5000000,
    Q0=500,
    T0=1273.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=90,
        origin={-10,70})));

  BoundaryConditions.Sink                     sinkP1
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                   rotation=90,
        origin={-10,-10})));
equation
  connect(sourceP.C, dynamicMultiFluidHeatExchanger.Cws1)
    annotation (Line(points={{-40,30},{-20,30}}, color={0,0,0}));
  connect(dynamicMultiFluidHeatExchanger.Cws2, sinkP.C)
    annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
  connect(sourceP1.C, dynamicMultiFluidHeatExchanger.Cfg1)
    annotation (Line(points={{-10,60},{-10,35}}, color={0,0,0}));
  connect(dynamicMultiFluidHeatExchanger.Cfg2, sinkP1.C)
    annotation (Line(points={{-10,25},{-10,0}}, color={0,0,0}));
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
end TestDynamicFlueGasesMultiFluidHeatExchanger;
