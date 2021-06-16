within ThermoSysPro.Examples.SimpleExamples;
model TestStaticCentrifugalPump2

  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump StaticCentrifugalPump1(
      fixed_rot_or_power=2)
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.Tank Bache1(
                                        ze2=10, zs2=10)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VanneReglante1
    annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1(
                                                  k=0.5) annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Pulse pulse(
    width=200,
    period=500,
    amplitude=0.5e5,
    startTime=0,
    offset=1000)
                annotation (Placement(transformation(extent={{-80,-70},{-60,-50}},
          rotation=0)));
equation
  connect(StaticCentrifugalPump1.C2, Bache1.Ce2)
    annotation (Line(points={{-20,-30},{-60,-30},{-60,24},{-20,24}}, color={0,0,
          255}));
  connect(Bache1.Cs2, VanneReglante1.C1)
    annotation (Line(points={{0,24},{40,24}}, color={0,0,255}));
  connect(VanneReglante1.C2, StaticCentrifugalPump1.C1)
    annotation (Line(points={{60,24},{80,24},{80,-30},{0,-30}}, color={0,0,255}));
  connect(Constante1.y, VanneReglante1.Ouv)
    annotation (Line(points={{21,70},{50,70},{50,41}}, color={0,0,255}));
  connect(pulse.y, StaticCentrifugalPump1.rpm_or_mpower)
    annotation (Line(points={{-59,-60},{-10,-60},{-10,-41}}, smooth=Smooth.None));
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
end TestStaticCentrifugalPump2;
