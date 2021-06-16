within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPump5

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(mode_car_hn=
        1, mode_car_Cr=1,
    mode_car=1,
    w_a(start=1))
           annotation (Placement(transformation(extent={{20,20},{40,40}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourcePQ(Q0=0)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{80,20},{100,40}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.Shaft shaft
    annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.Machines.SynchronousMotor synchronousMotor(D=
        100, Im(start=1500))
             annotation (Placement(transformation(extent={{-40,-20},{-20,0}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Echelon echelon(
      startTime=10) annotation (Placement(transformation(extent={{-100,0},{-80,
            20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.NONL nONL
    annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
equation
  connect(sourcePQ.C, centrifugalPump.C1)
    annotation (Line(points={{-20,30},{20,30}}, color={0,0,255}));
  connect(centrifugalPump.C2, sink.C)        annotation (Line(points={{40,30},{
          80,30}}, color={0,0,255}));
  connect(synchronousMotor.C, shaft.C1) annotation (Line(points={{-19.8,-10},{
          -1,-10}}));
  connect(shaft.C2, centrifugalPump.M)
    annotation (Line(points={{21,-10},{30,-10},{30,19}}));
  connect(echelon.yL, nONL.uL) annotation (Line(points={{-79,10},{-61,10}}));
  connect(nONL.yL, synchronousMotor.marche)
    annotation (Line(points={{-39,10},{-30,10},{-30,-5.6}}));
  annotation (experiment(StopTime=1000),
    Diagram(graphics={
        Text(
          extent={{-100,100},{-60,80}},
          lineColor={0,0,255},
          textString=
               "w=1 ==> w=0"),
        Text(
          extent={{-100,80},{-60,60}},
          lineColor={0,0,255},
          textString=
               "q=0"),
        Text(
          extent={{-100,60},{-60,40}},
          lineColor={0,0,255},
          textString=
               "theta=0 ==> theta=-180")}),
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
end TestCentrifugalPump5;
