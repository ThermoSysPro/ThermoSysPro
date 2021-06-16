within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicCentrifugalPump

  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Pulse Pulse1(
                                          width=200, period=400)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.SynchronousMotor Motor1(Im(start=1800))
                                           annotation (Placement(transformation(
          extent={{-80,-80},{-60,-60}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.DynamicCentrifugalPump
    DynamicCentrifugalPump1(Ch(start=300))
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.Tank Tank(
    ze2=10,
    zs2=10)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Valve
    annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1(
                                                  k=0.5) annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.Shaft Shaft1
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}}, rotation=
           0)));
equation
  connect(Pulse1.yL, Motor1.marche)
    annotation (Line(points={{-79,-50},{-70,-50},{-70,-65.6}}));
  connect(DynamicCentrifugalPump1.C2, Tank.Ce2)
    annotation (Line(points={{-20,-30.2},{-60,-30.2},{-60,24},{-20,24}}, color=
          {0,0,255}));
  connect(Tank.Cs2, Valve.C1)
    annotation (Line(points={{0,24},{40,24}}, color={0,0,255}));
  connect(Valve.C2, DynamicCentrifugalPump1.C1)
    annotation (Line(points={{60,24},{80,24},{80,-30},{0,-30}}, color={0,0,255}));
  connect(Constante1.y, Valve.Ouv)
    annotation (Line(points={{21,70},{50,70},{50,41}}, color={0,0,255}));
  connect(Motor1.C, Shaft1.C1)
    annotation (Line(points={{-59.8,-70},{-41,-70}}));
  connect(DynamicCentrifugalPump1.M, Shaft1.C2)
    annotation (Line(points={{-10,-41},{-10,-70},{-19,-70}}));
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
end TestDynamicCentrifugalPump;
