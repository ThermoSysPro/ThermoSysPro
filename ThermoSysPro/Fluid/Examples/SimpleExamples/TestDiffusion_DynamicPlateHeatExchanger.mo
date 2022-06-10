within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDiffusion_DynamicPlateHeatExchanger

  ThermoSysPro.Fluid.HeatExchangers.DynamicPlateHeatExchanger
    echangeurAPlaques1D(
    region_c=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
    region_f=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
    steady_state=true,
    Ns=10,
    dynamic_energy_balance=false,
    diffusion=true,
    continuous_flow_reversal=true)
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));

  BoundaryConditions.SourcePQ                   sourceP(
      option_temperature=true,
    diffusion=true,
    Q0=0,
    T0=340)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
  BoundaryConditions.SourcePQ                   sourceP1
                                            annotation (Placement(
        transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  BoundaryConditions.Sink                     puitsP(option_temperature=true,
      diffusion=true)                    annotation (Placement(transformation(
          extent={{40,40},{60,60}}, rotation=0)));
  BoundaryConditions.Sink                     puitsP1(diffusion=true, h0=200000)
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
end TestDiffusion_DynamicPlateHeatExchanger;
