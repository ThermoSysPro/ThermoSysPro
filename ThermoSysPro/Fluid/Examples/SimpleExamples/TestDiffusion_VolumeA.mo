within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDiffusion_VolumeA

  BoundaryConditions.SourcePQ sourcePQ1(
    C(h_vol_2(start=63269.22110794237)),
    Q(start=0),
    continuous_flow_reversal=false,
    Q0=0,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam,
    option_temperature=true,
    T0=293.15,
    diffusion=true)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  BoundaryConditions.Sink                     sink1(
    option_temperature=true,
    T0=333.15,
    diffusion=true)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  PressureLosses.SwitchValve switchValve(Qmin=0)
    annotation (Placement(transformation(extent={{-60,-4},{-40,16}})));
  InstrumentationAndControl.Blocks.Logique.Constante constante(K=true)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Volumes.VolumeA volumeA(
    continuous_flow_reversal=false,
    diffusion=true,
    dynamic_energy_balance=false,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.WaterSteam)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  PressureLosses.SwitchValve switchValve1(Qmin=0, k=2000)
    annotation (Placement(transformation(extent={{40,-4},{60,16}})));
  InstrumentationAndControl.Blocks.Logique.Constante constante1(K=true)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
  connect(constante.yL, switchValve.Ouv)
    annotation (Line(points={{-59,30},{-50,30},{-50,13.2}}, color={0,0,255}));
  connect(sourcePQ1.C, switchValve.C1)
    annotation (Line(points={{-80,0},{-60,0}}, color={0,0,0}));
  connect(volumeA.Cs1, switchValve1.C1)
    annotation (Line(points={{10,0},{40,0}}, color={0,0,0}));
  connect(switchValve1.C2,sink1. C)
    annotation (Line(points={{60,0},{80,0}}, color={0,0,0}));
  connect(constante1.yL, switchValve1.Ouv)
    annotation (Line(points={{41,30},{50,30},{50,13.2}}, color={0,0,255}));
  connect(switchValve.C2, volumeA.Ce1)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,0,0}));
  annotation (Icon(graphics={
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
      experiment(StopTime=12),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestDiffusion_VolumeA;
