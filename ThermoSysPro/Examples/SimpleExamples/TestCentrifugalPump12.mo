within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPump12

  ThermoSysPro.WaterSteam.Machines.CentrifugalPump centrifugalPump(
    J=5.685,
    dynamic_mech_equation=true,
    hn_coef={-165.23,774.95},
    rh_coef={-0.704,1.46},
    N_nom=4809,
    hn_nom_p=662,
    Qv_nom_p=0.921,
    mode_car_Cr=1,
    w_a(start=0.003569902151486508),
    C1(h(start=650000.0)),
    Pm(start=719510.5112740289),
    Qv(start=0.010949909796284268))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourceP(
                                                             P0=100000,
    Q0=10,
    h0=650e3)
    annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP
    annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe3(
    Duration=1000,
    Initialvalue=7.19555e5,
    Finalvalue=2.0657e5,
    Starttime=0)                               annotation (Placement(
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
  annotation (experiment(StopTime=1000), Diagram(graphics),
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
end TestCentrifugalPump12;
