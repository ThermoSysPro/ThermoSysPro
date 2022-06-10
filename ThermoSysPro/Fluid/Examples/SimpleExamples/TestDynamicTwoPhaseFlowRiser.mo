within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDynamicTwoPhaseFlowRiser

  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowRiser dynamicTwoPhaseFlowRiser(
    L=20,
    inertia=false,
    advection=false,
    dynamic_energy_balance=true,
    Q(start={0.7975821689256883,0.7975821689256898,0.7975821689256883,
          0.7975821689256885,0.7975821689256883,0.797582168925689,
          0.7975821689256886,0.7975821689256887,0.7975821689256888,
          0.7975821689256888,0.7975821689256886}),
    h(start={71016.12237181116,196401.3226637204,196412.6067675415,
          196423.89087136256,196435.17497518365,196446.45907900474,
          196457.7431828258,196469.0272866469,196480.31139046798,
          196491.59549428907,196502.87959811013,70825.9016030344}),
    diffusion=true,
    P(start={300000,281879.25838975,263692.15565175,245504.87004838,
          227317.40156239,209129.75017657,190941.91587368,172753.89863649,
          154565.69844777,136377.31529027,118188.74914676,100000})) annotation (
     Placement(transformation(extent={{-10,30},{10,48}}, rotation=0)));
  BoundaryConditions.SourceP                                 sourcePQ(ftype=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteamSimple)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}}, rotation=0)));
  BoundaryConditions.SinkP                                 sinkP
    annotation (Placement(transformation(extent={{30,30},{50,50}}, rotation=0)));
  Thermal.BoundaryConditions.HeatSource              heatSource(
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    option_temperature=2,
    W0={0,0,0,0.0,0.0,0.0,0.0,0.0,0.0,0.0})
    annotation (Placement(transformation(extent={{-10,80},{10,100}},
                                                                   rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall              heatExchangerWall(Ns=10,
      dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,60},{10,80}},rotation=0)));
  Thermal.BoundaryConditions.HeatSource              heatSource1(
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    option_temperature=2,
    W0={0,0,0,0,0,0,0,0,0,0})
    annotation (Placement(transformation(extent={{-10,0},{10,-20}},rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall              heatExchangerWall1(Ns=10,
      dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,20},{10,0}}, rotation=0)));
equation
  connect(sourcePQ.C, dynamicTwoPhaseFlowRiser.C1) annotation (Line(points={{-30,
          40},{-20,40},{-20,39.9},{-10,39.9}}, color={0,0,255}));
  connect(dynamicTwoPhaseFlowRiser.C2, sinkP.C) annotation (Line(points={{10,
          39.9},{20,39.9},{20,40},{30,40}}, color={0,0,255}));
  connect(heatSource.C,heatExchangerWall. WT2) annotation (Line(points={{0,80.2},
          {0,72}},         color={191,95,0}));
  connect(heatExchangerWall.WT1, dynamicTwoPhaseFlowRiser.CTh1)
    annotation (Line(points={{0,68},{0,45.3}}, color={0,0,0}));
  connect(dynamicTwoPhaseFlowRiser.CTh2, heatExchangerWall1.WT1)
    annotation (Line(points={{0,34.5},{0,12}}, color={0,0,0}));
  connect(heatExchangerWall1.WT2, heatSource1.C)
    annotation (Line(points={{0,8},{0,-0.2}}, color={0,0,0}));
  annotation (experiment(StopTime=1000), Icon(graphics={
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
end TestDynamicTwoPhaseFlowRiser;
