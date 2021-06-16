within ThermoSysPro.Examples.Book.SimpleExamples.CentrifugalPump.TestCentrifugalPump;
model Scenario_2

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(mode_car_hn=
        1, mode_car_Cr=1,
    mode_car=1)      annotation (Placement(transformation(extent={{-20,20},{0,
            40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourcePQ(Q0=100)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{40,20},{60,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Starttime=10,
    Duration=100,
    Initialvalue=1400,
    Finalvalue=0) annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
          rotation=0)));
  ThermoSysPro.ElectroMechanics.BoundaryConditions.SourceAngularVelocity
    sourceAngularVelocity annotation (Placement(transformation(extent={{-40,-20},
            {-20,0}}, rotation=0)));
equation
  connect(sourcePQ.C, centrifugalPump.C1)
    annotation (Line(points={{-60,30},{-20,30}}, color={0,0,255}));
  connect(centrifugalPump.C2, sink.C)
    annotation (Line(points={{0,30},{40,30}}, color={0,0,255}));
  connect(rampe.y, sourceAngularVelocity.IAngularVelocity)
    annotation (Line(points={{-59,-10},{-35,-10}}));
  connect(sourceAngularVelocity.M, centrifugalPump.M)
    annotation (Line(points={{-19,-10},{-10,-10},{-10,19}}));
  annotation (experiment(StopTime=1000),
    Diagram(graphics={
        Text(
          extent={{-96,98},{-58,82}},
          lineColor={0,0,255},
          textString=
               "w=1 ==> w=0"),
        Text(
          extent={{-100,74},{-78,68}},
          lineColor={0,0,255},
          textString="q=0.21"),
        Text(
          extent={{-96,60},{-56,40}},
          lineColor={0,0,255},
          textString="theta=12 ==> theta=90")}),
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 12.3.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.  It corresponds to scenario n&deg;2.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end Scenario_2;
