within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestVolumeA1

  ThermoSysPro.Fluid.Volumes.VolumeA volumeA(ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    Ce2(Q(start=5381683.17323685)),
    Cs1(Q(start=5381683.173236847)),
    Cs2(Q(start=5381683.173236847)),
    Xo2(start=0.22),
    h(start=999999.9999999997),
    dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss(rho(start=
         164.8075648419657))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss1
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss2
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss3
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    option_temperature=false,
    h0=1e6,
    P0=600e5)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));

  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    T0=1000,
    option_temperature=false,
    h0=1e6,
    P0=600e5)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP(option_temperature=false)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP1(option_temperature=false)
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
equation
  connect(singularPressureLoss.C2, volumeA.Ce2)
    annotation (Line(points={{-40,30},{0,30},{0,10}}, color={0,0,0}));
  connect(singularPressureLoss1.C2, volumeA.Ce1) annotation (Line(points={{-40,
          -30},{-20,-30},{-20,0},{-10,0}}, color={0,0,0}));
  connect(volumeA.Cs1, singularPressureLoss2.C1) annotation (Line(points={{10,0},
          {10,0},{20,0},{20,30},{40,30},{40,30}}, color={0,0,0}));
  connect(volumeA.Cs2, singularPressureLoss3.C1) annotation (Line(points={{0,
          -10},{0,-10},{0,-30},{40,-30},{40,-30}}, color={0,0,0}));
  connect(sourceP.C, singularPressureLoss.C1)
    annotation (Line(points={{-80,30},{-60,30}}, color={0,0,0}));
  connect(sourceP1.C, singularPressureLoss1.C1)
    annotation (Line(points={{-80,-30},{-60,-30}}, color={0,0,0}));
  connect(singularPressureLoss2.C2, sinkP.C)
    annotation (Line(points={{60,30},{70,30},{70,30},{80,30}}, color={0,0,0}));
  connect(singularPressureLoss3.C2, sinkP1.C) annotation (Line(points={{60,-30},
          {70,-30},{70,-30},{80,-30}}, color={0,0,0}));
  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"), Icon(graphics={
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end TestVolumeA1;
