within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestVolumeI

  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    continuous_flow_reversal=true,
    T0=288.15,
    diffusion=true)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP(
    Q(start=356.3142593657128),
    P0=300000,
    T0=369.15,
    diffusion=true)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Volumes.VolumeI                    volumeA(
    dynamic_composition_balance=false,
    steady_state=true,
    V=1.e-6,
    Ce2(Q(start=-1.2064107019298721E-33)),
    continuous_flow_reversal=true,
    dynamic_mass_balance=false,
    diffusion=false,
    dynamic_energy_balance=true,
    P(start=200002.5108577),
    h(start=63269.22110794238))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Duration=10,
    Initialvalue=1e5,
    Finalvalue=5e5)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe1(gamma_diff(
        start=4.4340701734837724E-07))
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe3
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe2(inertia=
        false)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP2(
    continuous_flow_reversal=false,
    T0=288.15,
    diffusion=true)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  PressureLosses.ControlValve controlValve1(Pm(start=201722.05301761828))
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  PressureLosses.ControlValve controlValve2(C2(Q(start=0)), Pm(start=
          250001.25542885027))
    annotation (Placement(transformation(extent={{-40,46},{-20,66}})));
  PressureLosses.ControlValve controlValve3(Pm(start=198282.96276544))
    annotation (Placement(transformation(extent={{20,-4},{40,16}})));
  InstrumentationAndControl.Blocks.Sources.Constante constante1(k=1)
    annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
  InstrumentationAndControl.Blocks.Sources.Constante constante2(k=0)
    annotation (Placement(transformation(extent={{-56,74},{-44,86}})));
  InstrumentationAndControl.Blocks.Sources.Constante constante3
    annotation (Placement(transformation(extent={{4,22},{16,34}})));
equation
  connect(rampe.y, sinkP.IPressure) annotation (Line(points={{81,-30},{100,-30},
          {100,0},{95,0}}, color={0,0,255}));
  connect(sourceP1.C, lumpedStraightPipe1.C1)
    annotation (Line(points={{-80,0},{-70,0}}, color={0,0,0}));
  connect(lumpedStraightPipe3.C2, sinkP.C)
    annotation (Line(points={{70,0},{80,0}}, color={0,0,0}));
  connect(sourceP2.C, lumpedStraightPipe2.C1)
    annotation (Line(points={{-80,50},{-70,50}}, color={0,0,0}));
  connect(lumpedStraightPipe1.C2, controlValve1.C1)
    annotation (Line(points={{-50,0},{-40,0}}, color={0,0,0}));
  connect(lumpedStraightPipe2.C2, controlValve2.C1)
    annotation (Line(points={{-50,50},{-40,50}}, color={0,0,0}));
  connect(controlValve3.C2, lumpedStraightPipe3.C1)
    annotation (Line(points={{40,0},{50,0}}, color={0,0,0}));
  connect(constante1.y, controlValve1.Ouv)
    annotation (Line(points={{-43.4,30},{-30,30},{-30,17}}, color={0,0,255}));
  connect(constante2.y, controlValve2.Ouv)
    annotation (Line(points={{-43.4,80},{-30,80},{-30,67}}, color={0,0,255}));
  connect(constante3.y, controlValve3.Ouv)
    annotation (Line(points={{16.6,28},{30,28},{30,17}}, color={0,0,255}));
  connect(controlValve1.C2, volumeA.Ce2)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,0,0}));
  connect(controlValve2.C2, volumeA.Ce1) annotation (Line(points={{-20,50},{-14,
          50},{-14,8},{-10,8}}, color={0,0,0}));
  connect(volumeA.Cs2, controlValve3.C1)
    annotation (Line(points={{10,0},{20,0}}, color={0,0,0}));
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
end TestVolumeI;
