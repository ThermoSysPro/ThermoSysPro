within ThermoSysPro.Examples.Book.SimpleExamples.CentrifugalPump.TestCentrifugalPump;
model Scenario_4

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(
    J=5.685,
    dynamic_mech_equation=true,
    hn_coef={-165.23,774.95},
    rh_coef={-0.704,1.46},
    N_nom=4809,
    hn_nom_p=662,
    Qv_nom_p=0.921,
    mode_car_Cr=1,
    w_a(start=0.003569900907740773),
    mode=0,
    C1(h(start=650000.0)),
    Qv(start=0.010949905982587188),
    pro(d(start=913.2498503550851)))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourceP(
    Q0=10,
    h0=650e3,
    P0=100000)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP
    annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe3(
    Duration=1000,
    Starttime=0,
    Initialvalue=7.2e5,
    Finalvalue=2.0e5)                          annotation (Placement(
        transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.ElectroMechanics.BoundaryConditions.SourceTorque sourceTorque
    annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
equation
  connect(sourceP.C, centrifugalPump.C1)
    annotation (Line(points={{0,30},{20,30}}, color={0,0,255}));
  connect(centrifugalPump.C2, sinkP.C)
    annotation (Line(points={{40,30},{60,30}}, color={0,0,255}));
  connect(sourceTorque.M, centrifugalPump.M)
    annotation (Line(points={{1,-10},{30,-10},{30,19}}));
  connect(rampe3.y, sourceP.IPressure)
    annotation (Line(points={{-39,30},{-15,30}}));
  annotation (Diagram(graphics={
        Text(
          extent={{-100,94},{-80,86}},
          lineColor={0,0,255},
          textString="w=0 "),
        Text(
          extent={{-96,74},{-82,66}},
          lineColor={0,0,255},
          textString="q=0.57"),
        Text(
          extent={{-96,60},{-54,40}},
          lineColor={0,0,255},
          textString="theta=71 ==> theta=74")}),
                                 experiment(StopTime=1000),
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
<p>This model is documented in Sect. 12.3.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.  It corresponds to scenario n&deg;4.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end Scenario_4;
