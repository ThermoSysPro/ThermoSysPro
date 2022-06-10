within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDynamicMultiFluidHeatExchanger

  BoundaryConditions.SourceQ                    sourceP(C(h_vol_2(start=
            71016.12237181065)),
    Q0=10,
    option_temperature=true)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP(C(h_vol_1(start=
            71016.1223718086)))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  HeatExchangers.DynamicMultiFluidHeatExchanger dynamicMultiFluidHeatExchanger(
    steady_state=true,
    diffusion=true,
    dynamic_energy_balance=false,
    Cfg1(h_vol_2(start=71016.12237181155)),
    Cfg2(h_vol_1(start=71016.12237181314)),
    DynamicOnePhaseFlowPipe_1(
      P(start={300000.0,260001.59713260198,220002.3957916478,180002.39588440701,
            140001.5973181204,100000.0}),
      Q(start={2702.7912398488343,2702.7912398488343,2702.7912398488343,
            2702.7912398488343,2702.7912398488343}),
      h(start={71016.125,71016.125,71016.12237180988,71016.1223718091,71016.125,
            70825.8984375})),
    DynamicOnePhaseFlowPipe_2(
      P(start={300000.0,260001.59801114563,220002.39710936273,180002.3972020214,
            140001.59819646296,100000.0}),
      Q(start={3482.228448926616,3482.228448926616,3482.228448926616,
            3482.228448926616,3482.228448926616}),
      Tp(start={290.0310327031831,290.04018142634584,290.0493302229013,
            290.05847909283045}),
      h(start={71016.125,71016.125,71016.12237181216,71016.12237181274,
            71016.125,70825.8984375})),
    ExchangerWall(Tp(start={290.03103270324897,290.0401814264445,
            290.0493302229999,290.05847909289605}), Tp1(start={
            290.03103270331616,290.04018142654525,290.0493302231005,
            290.0584790929629})),
    Ntubes=10,
    Ns=4,
    inertia=false)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    P0=5000000,
    T0=1273.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=90,
        origin={-10,70})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP1
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
end TestDynamicMultiFluidHeatExchanger;
