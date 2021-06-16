within ThermoSysPro.Examples.Book.SimpleExamples.InternalCombustionEngine;
model TestInternalCombustionEngine
  import ThermoSysPro;

  parameter Integer NCEL = 7;

  ThermoSysPro.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
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
    Vol=100) annotation (Placement(transformation(extent={{-106,-79},{-72,-41}},
          rotation=0)));
  FlueGases.BoundaryConditions.SourcePQ sourceAir(
    Xso2=0,
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Q0=1.9627,
    P0=191000,
    T0=30 + 273.16)
    annotation (Placement(transformation(extent={{111,-77},{73,-43}},rotation=0)));
  FlueGases.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{0,46},{44,88}},  rotation=0)));
  WaterSteam.BoundaryConditions.SourcePQ SourcePQ_Water(
    Q0=15.3,
    h0=334.41e3,
    P0=410000)
    annotation (Placement(transformation(extent={{-107,-17},{-71,17}},rotation=
            0)));
  MultiFluids.Machines.AlternatingEngine alternatingEngine(
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
    annotation (Placement(transformation(extent={{-44,-44},{44,44}})));
  WaterSteam.BoundaryConditions.Sink Sink_Water1 annotation (Placement(
        transformation(extent={{75,-17},{111,17}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss
    annotation (Placement(transformation(extent={{-63,-6},{-51,6}})));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss1
    annotation (Placement(transformation(extent={{51,-7},{65,7}})));
equation
  connect(alternatingEngine.Cair, sourceAir.C) annotation (Line(
      points={{17.6,-39.6},{17.6,-60},{73,-60}},
      color={0,0,0},
      thickness=1));
  connect(alternatingEngine.Cfuel, fuelSourcePQ.C) annotation (Line(points={{-17.6,
          -39.6},{-17.6,-60},{-72,-60}}, color={0,0,0}));
  connect(SourcePQ_Water.C, singularPressureLoss.C1)
    annotation (Line(points={{-71,0},{-63,0}}, color={0,0,255}));
  connect(alternatingEngine.Cws1, singularPressureLoss.C2) annotation (Line(
        points={{-39.6,0},{-51,0}},                       color={0,0,255}));
  connect(alternatingEngine.Cws2, singularPressureLoss1.C1)
    annotation (Line(points={{39.6,0},{51,0}},           color={0,0,255}));
  connect(Sink_Water1.C, singularPressureLoss1.C2)
    annotation (Line(points={{75,0},{65,0}},           color={0,0,255}));
  connect(alternatingEngine.Cfg, sink.C) annotation (Line(
      points={{0,39.6},{0,67},{0.44,67}},
      color={0,0,0},
      thickness=1));
  annotation (         Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 15.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
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
