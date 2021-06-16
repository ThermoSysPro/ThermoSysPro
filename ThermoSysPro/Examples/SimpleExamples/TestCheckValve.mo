within ThermoSysPro.Examples.SimpleExamples;
model TestCheckValve

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
                                    annotation (Placement(transformation(extent=
           {{-104,20},{-84,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(
                                  P0=6e5) annotation (Placement(transformation(
          extent={{84,20},{104,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump1
    annotation (Placement(transformation(extent={{-30,60},{-10,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump2
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD volumeD annotation (Placement(
        transformation(extent={{-50,20},{-30,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.CheckValve checkValve1
    annotation (Placement(transformation(extent={{10,60},{30,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.CheckValve checkValve2
    annotation (Placement(transformation(extent={{8,-20},{28,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC volumeC annotation (Placement(
        transformation(extent={{30,20},{50,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP
                                        annotation (Placement(transformation(
          extent={{-80,20},{-60,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP1
                                         annotation (Placement(transformation(
          extent={{60,20},{80,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1
                                     annotation (Placement(transformation(
          extent={{-60,-80},{-40,-60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1(
                                   P0=6e5) annotation (Placement(transformation(
          extent={{20,-80},{40,-60}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Pulse pulse(
    amplitude=6e5,
    width=50,
    period=100,
    offset=3e5) annotation (Placement(transformation(extent={{-100,-80},{-80,
            -60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.CheckValve checkValve3
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}}, rotation=0)));
equation
  connect(volumeD.Cs1, staticCentrifugalPump1.C1) annotation (Line(points={{-40,
          40},{-40,70},{-30,70}}, color={0,0,255}));
  connect(volumeD.Cs2, staticCentrifugalPump2.C1) annotation (Line(points={{-40,
          20.2},{-40,-10},{-30,-10}}, color={0,0,255}));
  connect(staticCentrifugalPump1.C2, checkValve1.C1) annotation (Line(points={{
          -10,70},{-2,70},{-2,70},{9,70}}, color={0,0,255}));
  connect(checkValve1.C2, volumeC.Ce2) annotation (Line(points={{31,70},{40,70},
          {40,39}}, color={0,0,255}));
  connect(checkValve2.C2, volumeC.Ce3) annotation (Line(points={{29,-10},{40,
          -10},{40,20}}, color={0,0,255}));
  connect(staticCentrifugalPump2.C2, checkValve2.C1) annotation (Line(points={{
          -10,-10},{0,-10},{0,-10},{7,-10}}, color={0,0,255}));
  connect(perteDP.C2, volumeD.Ce)
    annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
  connect(volumeC.Cs, perteDP1.C1)
    annotation (Line(points={{50,30},{60,30}}, color={0,0,255}));
  connect(perteDP1.C2, puitsP.C)
    annotation (Line(points={{80,30},{84,30}}, color={0,0,255}));
  connect(sourceP.C, perteDP.C1)
    annotation (Line(points={{-84,30},{-80,30}}, color={0,0,255}));
  connect(sourceP1.C, checkValve3.C1)
    annotation (Line(points={{-40,-70},{-21,-70}}, color={0,0,255}));
  connect(checkValve3.C2, puitsP1.C)
    annotation (Line(points={{1,-70},{20,-70}}, color={0,0,255}));
  connect(pulse.y, sourceP1.IPressure) annotation (Line(points={{-79,-70},{-55,
          -70}}));
  annotation (experiment(StopTime=1000),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Window(
      x=0.28,
      y=0.03,
      width=0.5,
      height=0.6),
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
end TestCheckValve;
