within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestStodolaTurbine1
  parameter Units.SI.AbsolutePressure PoutPump(fixed=false, start=13e5)
    "Flow pressure at the outlet of the pump";
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine(pros1(x(start=
            1)), Hrs(start=2931e3),
    pros(d(start=19.715136086827403)),
    Ce(h(start=3000000.0)),
    proe(T(start=613.0), x(start=1.0)))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsP(P0=45e5,
    C(h_vol_1(start=75002)))
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP(
    h0=3.e6,
    option_temperature=false,
    P0=6500000,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_2)
             annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.CentrifugalPump
    DynamicCentrifugalPump1(
                        Q(fixed=true, start=50),
    Qv(start=23.0),
    Pm(start=1158163.6),
    h(start=3041170.0441966015),
    C1(P(start=10e5)),
    C2(P(start=3.e6), h(start=3082340.088393203)),
    hn(start=7119.0),
    w_a(start=20.0))
    annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.Shaft Shaft1
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsP1(P0=13e5)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    h0=3.e6,
    option_temperature=false,
    P0=1000000,
    region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_2)
             annotation (Placement(transformation(extent={{-20,-40},{0,-20}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante Pout(k=PoutPump)
    annotation (Placement(transformation(extent={{56,-12},{68,0}}, rotation=0)));
equation
  connect(Shaft1.C2, DynamicCentrifugalPump1.M)
    annotation (Line(points={{1,-80},{30,-80},{30,-41}}));
  connect(stodolaTurbine.M, Shaft1.C1)
    annotation (Line(points={{-50,60},{-50,-80},{-21,-80}}));
  connect(sourceP1.C, DynamicCentrifugalPump1.C1)
    annotation (Line(points={{0,-30},{20,-30}}, color={0,0,255}));
  connect(DynamicCentrifugalPump1.C2, puitsP1.C) annotation (Line(points={{40,-30},
          {50,-30},{50,-30},{60,-30}},          color={0,0,255}));
  connect(sourceP.C, stodolaTurbine.Ce)
    annotation (Line(points={{-80,70},{-60.1,70}}, color={0,0,255}));
  connect(stodolaTurbine.Cs, puitsP.C)
    annotation (Line(points={{-39.9,70},{-20,70}}, color={0,0,255}));
  connect(Pout.y, puitsP1.IPressure)
    annotation (Line(points={{68.6,-6},{88,-6},{88,-30},{75,-30}}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.32,
      y=0.02,
      width=0.39,
      height=0.47),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
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
end TestStodolaTurbine1;
