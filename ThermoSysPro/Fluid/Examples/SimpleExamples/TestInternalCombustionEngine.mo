within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestInternalCombustionEngine
  import ThermoSysPro;

  parameter Integer NCEL = 7;

  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    Hum=0,
    Xh=0.25,
    Xs=0,
    Xashes=0,
    Xc=0.75,
    Xo=0,
    Xn=0,
    Q0=0.0676,
    rho=0.744,
    LHV=50e6,
    T0(displayUnit="K") = 299,
    P0=210300,
    Vol=100) annotation (Placement(transformation(extent={{-106,-81},{-72,-43}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourceAir(
    Xso2=0,
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Q0=1.9627,
    T0=30 + 273.16,
    option_temperature=true,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    P0=191000)
    annotation (Placement(transformation(extent={{111,-79},{73,-45}},rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sink(option_temperature=true)
                                                  annotation (Placement(transformation(
          extent={{0,44},{44,86}},  rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ SourcePQ_Water(
    Q0=15.3,
    h0=334.41e3,
    P0=410000)
    annotation (Placement(transformation(extent={{-107,-19},{-71,15}},rotation=
            0)));
  ThermoSysPro.Fluid.Machines.InternalCombustionEngine alternatingEngine(
    mechanical_efficiency_type=2,
    Rmeca_nom=0.41,
    Coef_Rm_a=-5.4727e-9,
    Coef_Rm_b=4.9359e-5,
    Coef_Rm_c=0.30814,
    Xpth=0.05,
    MMg=20,
    DPe=1,
    RV=6.45,
    Kc=1.28,
    Kd=1.33,
    Wmeca(start=1400e3),
    Welec(start=1358e3),
    Wcomb(start=3.4942e6),
    exc(start=1.8),
    Gamma=1.2085,
    Tsf(start=1088.15))
    annotation (Placement(transformation(extent={{-44,-46},{44,42}})));
  ThermoSysPro.Fluid.BoundaryConditions.Sink Sink_Water1 annotation (Placement(
        transformation(extent={{75,-19},{111,15}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss
    annotation (Placement(transformation(extent={{-63,-8},{-51,4}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss1
    annotation (Placement(transformation(extent={{51,-9},{65,5}})));
equation
  connect(alternatingEngine.Cair, sourceAir.C) annotation (Line(
      points={{0,-41.6},{0,-62},{73,-62}},
      color={0,0,0},
      thickness=1));
  connect(alternatingEngine.Cfuel, fuelSourcePQ.C) annotation (Line(points={{-30.8,
          -41.6},{-30.8,-62},{-72,-62}}, color={0,0,0}));
  connect(SourcePQ_Water.C, singularPressureLoss.C1)
    annotation (Line(points={{-71,-2},{-63,-2}},
                                               color={0,0,255}));
  connect(alternatingEngine.Cws1, singularPressureLoss.C2) annotation (Line(
        points={{-39.6,-2},{-51,-2}},                     color={0,0,255}));
  connect(alternatingEngine.Cws2, singularPressureLoss1.C1)
    annotation (Line(points={{39.6,-2},{48,-2},{51,-2}}, color={0,0,255}));
  connect(Sink_Water1.C, singularPressureLoss1.C2)
    annotation (Line(points={{75,-2},{75,-2},{65,-2}}, color={0,0,255}));
  connect(alternatingEngine.Cfg, sink.C) annotation (Line(
      points={{0,37.6},{0,65},{0,65}},
      color={0,0,0},
      thickness=1));
  annotation (         Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>", info="<html>
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
end TestInternalCombustionEngine;
