within ThermoSysPro.Examples.Book.SimpleExamples.CentrifugalPump.TestCentrifugalPump;
model Scenario_3

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(
    continuous_flow_reversal=false,
    hn_nom_p=10,
    mode_car=1,
    V=0.01,
    dynamic_energy_balance=false,
    mode_car_Cr=1,
    mode_car_hn=1)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(P0=300000)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2(
    Duration=100,
    Starttime=100,
    Finalvalue=4800000,
    Initialvalue=400000)                       annotation (Placement(
        transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(
      lambda=0, inertia=true)
              annotation (Placement(transformation(extent={{20,20},{40,40}},
          rotation=0)));
equation
  connect(sourceP.C, centrifugalPump.C1)
    annotation (Line(points={{-40,30},{-20,30}}, color={0,0,255}));
  connect(rampe2.y, sinkP.IPressure)
    annotation (Line(points={{21,70},{80,70},{80,30},{75,30}}));
  connect(lumpedStraightPipe.C2, sinkP.C)
    annotation (Line(points={{40,30},{60,30}}, color={0,0,255}));
  connect(centrifugalPump.C2, lumpedStraightPipe.C1)
    annotation (Line(points={{0,30},{20,30}}, color={0,0,255}));
  annotation (experiment(StopTime=1000),
    Diagram(graphics={
        Text(
          extent={{-100,94},{-80,86}},
          lineColor={0,0,255},
          textString=
               "w=1"),
        Text(
          extent={{-96,80},{-56,60}},
          lineColor={0,0,255},
          textString="q=0.95 ==> q=-7.77"),
        Text(
          extent={{-96,60},{-54,40}},
          lineColor={0,0,255},
          textString="theta=44 ==> theta=-83")}),
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
<p>This model is documented in Sect. 12.3.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.  It corresponds to scenario n&deg;3.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end Scenario_3;
