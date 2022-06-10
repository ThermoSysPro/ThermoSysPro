within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestBoilerSystem
  import ThermoSysPro;
  ThermoSysPro.Fluid.Boilers.BoilerSystem BoilerSystem(
    Wloss=0,
    Ke=1.e6,
    Tsf=386.16)
    annotation (Placement(transformation(extent={{-45,-51},{45,51}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourceQ(
    Xco2=0,
    Xh2o=0.01,
    Q0=27.,
    Xo2=0.233,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    T0=298.16,
    option_temperature=true)
               annotation (Placement(transformation(extent={{-102,-92},{-63,-55}},
          rotation=0)));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP annotation (Placement(transformation(
          extent={{-56,51},{-98,90}},  rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ(
    Q0=24.,
    h0=600e3,
    P0=14000000)
    annotation (Placement(transformation(extent={{105,-88},{69,-54}}, rotation=
            0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{70,53},{106,89}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss(K=1e-3)
    annotation (Placement(transformation(extent={{60,-77},{52,-65}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss1(K=1e-3)
    annotation (Placement(transformation(extent={{53,65},{61,77}}, rotation=0)));
equation
  connect(singularPressureLoss1.C2, sink.C)
    annotation (Line(points={{61,71},{70,71}}, color={0,0,255}));
  connect(BoilerSystem.OutletWaterSteam, singularPressureLoss1.C1) annotation (
      Line(points={{38.5714,51},{38.5714,71},{53,71}}, color={0,0,0}));
  connect(BoilerSystem.InletWaterSteam, singularPressureLoss.C2) annotation (
      Line(points={{38.5714,-51},{38.5714,-71},{52,-71}}, color={0,0,0}));
  connect(singularPressureLoss.C1, sourcePQ.C) annotation (Line(points={{60,-71},
          {66,-71},{66,-71},{69,-71}}, color={0,0,0}));
  connect(sinkP.C, BoilerSystem.OutletFlueGases) annotation (Line(points={{-56,
          70.5},{-38.5714,70.5},{-38.5714,51}}, color={0,0,0}));
  connect(sourceQ.C, BoilerSystem.InletFlueGases) annotation (Line(points={{-63,
          -73.5},{-38.5714,-73.5},{-38.5714,-51}}, color={0,0,0}));
  annotation (                   Icon(graphics={
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
end TestBoilerSystem;
