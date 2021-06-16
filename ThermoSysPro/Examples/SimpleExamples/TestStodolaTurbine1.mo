within ThermoSysPro.Examples.SimpleExamples;
model TestStodolaTurbine1
   parameter Modelica.SIunits.AbsolutePressure PoutPump(fixed=false,start=13e5)
    "Flow pressure at the outlet of the pump";
  ThermoSysPro.WaterSteam.Machines.StodolaTurbine stodolaTurbine(pros1(x(start=
            1)), Hrs(start=2931e3),
    pros(d(start=19.715136086827403)))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(                 mode=0, P0=45e5,
    C(h_vol(start=75002)))
    annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    h0=3.e6,
    option_temperature=2,
    mode=2,
    P0=65e5) annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Machines.DynamicCentrifugalPump
    DynamicCentrifugalPump1(
                        Q(fixed=true, start=50),
    R(start=3.1196162550258855),
    Qv(start=0.03654547625832159),
    Ch(start=9001.678648281353),
    Pm(start=3816357.071499178),
    h(start=3041170.0441966015),
    C1(P(start=10e5)),
    C2(P(start=3.e6), h(start=3082340.088393203)))
    annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.Shaft Shaft1
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1(                 mode=0, P0=13e5)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(
    h0=3.e6,
    option_temperature=2,
    mode=2,
    P0=10e5) annotation (Placement(transformation(extent={{-20,-40},{0,-20}},
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
  connect(DynamicCentrifugalPump1.C2, puitsP1.C) annotation (Line(points={{40,
          -30.2},{50,-30.2},{50,-30},{60,-30}}, color={0,0,255}));
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
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestStodolaTurbine1;
