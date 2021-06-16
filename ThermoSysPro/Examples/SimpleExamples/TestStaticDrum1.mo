within ThermoSysPro.Examples.SimpleExamples;
model TestStaticDrum1

  ThermoSysPro.WaterSteam.Junctions.StaticDrum StaticDrumTh1
    annotation (Placement(transformation(extent={{-54,0},{-34,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI1(K=1e-4)
    annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI2(K=1e-4)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkP1(Q0=10)
    annotation (Placement(transformation(extent={{40,-10},{60,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorT sensorT
    annotation (Placement(transformation(extent={{10,-82},{30,-62}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
    option_temperature=2,
    W0={2.4e8},
    T0={290})   annotation (Placement(transformation(extent={{-80,20},{-60,40}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI3(K=1e-4)
    annotation (Placement(transformation(extent={{-20,50},{0,70}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP2
    annotation (Placement(transformation(extent={{60,50},{80,70}}, rotation=0)));
  ThermoSysPro.WaterSteam.Sensors.SensorT sensorT1
    annotation (Placement(transformation(extent={{20,58},{40,78}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.RefP refP(P0=3e5)
    annotation (Placement(transformation(extent={{-26,-90},{-6,-70}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.RefQ refQ(Q0=100)
    annotation (Placement(transformation(extent={{-56,-90},{-36,-70}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.PlugA sourcePlug(C(h(fixed=true)))
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}}, rotation=
           0)));
equation
  connect(singularPressureLossVALI2.C2, StaticDrumTh1.Ce_eco)
                                                          annotation (Line(
        points={{-60,-40},{-60,0.6},{-48,0.6}}, color={0,0,255}));
  connect(singularPressureLossVALI1.C2, sinkP1.C) annotation (Line(points={{20,
          0},{40,0}}, color={0,0,255}));
  connect(sensorT.C2, singularPressureLossVALI2.C1) annotation (Line(points={{
          30.2,-80},{40,-80},{40,-60},{-80,-60},{-80,-40}}, color={0,0,255}));
  connect(heatSource.C[1], StaticDrumTh1.Cth)
                                          annotation (Line(points={{-70,20.2},{
          -70,10},{-44,10}}, color={191,95,0}));
  connect(StaticDrumTh1.Cs_purg, singularPressureLossVALI1.C1)
                                                           annotation (Line(
        points={{-34.6,6.6},{-19.3,6.6},{-19.3,0},{0,0}}, color={0,0,255}));
  connect(StaticDrumTh1.Cs_sur, singularPressureLossVALI3.C1)
                                                          annotation (Line(
        points={{-40.2,19.4},{-40.2,60},{-20,60}}, color={0,0,255}));
  connect(singularPressureLossVALI3.C2, sensorT1.C1)
    annotation (Line(points={{0,60},{20,60}}, color={0,0,255}));
  connect(sensorT1.C2, sinkP2.C)
    annotation (Line(points={{40.2,60},{60,60}}, color={0,0,255}));
  connect(refP.C2, sensorT.C1) annotation (Line(points={{-6,-80},{10,-80}},
        color={0,0,255}));
  connect(refQ.C2, refP.C1) annotation (Line(points={{-36,-80},{-26,-80}},
        color={0,0,255}));
  connect(sourcePlug.C, refQ.C1) annotation (Line(points={{-70,-80},{-56,-80}},
        color={0,0,255}));
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
end TestStaticDrum1;
