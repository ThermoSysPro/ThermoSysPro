within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPump3

  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Pulse Pulse1(
                                          width=200, period=500)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.SynchronousMotor Motor1(Im(start=2000))
                                           annotation (Placement(transformation(
          extent={{-80,-80},{-60,-60}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump1(mode_car_hn=
       1, mode_car_Cr=1,
    mode_car=1,
    dynamic_mech_equation=true,
    w_a(start=1),
    C2(P(start=300000)))
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}}, rotation=0)));
  WaterSteam.Volumes.Tank              Tank(
    ze2=10,
    zs2=10)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Valve
    annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1(
                                                  k=0.5) annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(
      continuous_flow_reversal=true, inertia=true)
    annotation (Placement(transformation(
        origin={50,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(Pulse1.yL, Motor1.marche)
    annotation (Line(points={{-79,-50},{-70,-50},{-70,-65.6}}));
  connect(centrifugalPump1.C2, Tank.Ce2)
    annotation (Line(points={{-20,-30},{-60,-30},{-60,24},{-20,24}}, color={0,0,
          255}));
  connect(Tank.Cs2, Valve.C1)
    annotation (Line(points={{0,24},{40,24}}, color={0,0,255}));
  connect(Constante1.y, Valve.Ouv)
    annotation (Line(points={{21,70},{50,70},{50,41}}, color={0,0,255}));
  connect(centrifugalPump1.C1, lumpedStraightPipe.C2)
    annotation (Line(points={{0,-30},{40,-30}}));
  connect(lumpedStraightPipe.C1, Valve.C2)
    annotation (Line(points={{60,-30},{80,-30},{80,24},{60,24}}));
  connect(Motor1.C, centrifugalPump1.M)
    annotation (Line(points={{-59.8,-70},{-10,-70},{-10,-41}}));
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
end TestCentrifugalPump3;
