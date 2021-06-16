within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPump6

  ThermoSysPro.ElectroMechanics.Machines.SynchronousMotor synchronousMotor(Im(start=
          1500))
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Constante constante
    annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(
    continuous_flow_reversal=false,
    hn_nom_p=10,
    mode_car_hn=1,
    mode_car_Cr=1,
    mode_car=1,
    w_a(start=1))
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(P0=300000)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2(
    Duration=100,
    Starttime=100,
    Finalvalue=4800000,
    Initialvalue=200000)                       annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(inertia=
        true) annotation (Placement(transformation(extent={{20,20},{40,40}},
          rotation=0)));
equation
  connect(constante.yL, synchronousMotor.marche)
    annotation (Line(points={{-39,10},{-30,10},{-30,-5.6}}));
  connect(sourceP.C, centrifugalPump.C1)
    annotation (Line(points={{-40,30},{-20,30}}, color={0,0,255}));
  connect(rampe2.y,sinkP. IPressure)
    annotation (Line(points={{21,70},{80,70},{80,30},{75,30}}));
  connect(lumpedStraightPipe.C2,sinkP. C)
    annotation (Line(points={{40,30},{60,30}}, color={0,0,255}));
  connect(synchronousMotor.C, centrifugalPump.M)
    annotation (Line(points={{-19.8,-10},{-10,-10},{-10,19}}));
  connect(centrifugalPump.C2, lumpedStraightPipe.C1)
    annotation (Line(points={{0,30},{20,30}}, color={0,0,255}));
  annotation (experiment(StopTime=1000),
    Diagram(graphics={
        Text(
          extent={{-100,100},{-60,80}},
          lineColor={0,0,255},
          textString=
               "w=1"),
        Text(
          extent={{-100,80},{-60,60}},
          lineColor={0,0,255},
          textString=
               "q=0.8 ==> q=-3.5"),
        Text(
          extent={{-100,60},{-60,40}},
          lineColor={0,0,255},
          textString=
               "theta=38 ==> theta=-74")}),
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
end TestCentrifugalPump6;
