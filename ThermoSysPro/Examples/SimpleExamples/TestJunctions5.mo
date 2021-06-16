within ThermoSysPro.Examples.SimpleExamples;
model TestJunctions5

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
                                           annotation (Placement(transformation(
          extent={{-104,0},{-84,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(
                                            P0=2e5)
    annotation (Placement(transformation(extent={{-104,-60},{-84,-40}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve valve1(C1(h_vol(start=
            71016.12237181116)), Q(start=1358.2069351216692))
    annotation (Placement(transformation(extent={{-10,66},{10,86}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP
                                         annotation (Placement(transformation(
          extent={{20,60},{40,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve valve4(
    C1(h_vol(start=70921.0263406355)),
    Pm(start=150000.0),
    Q(start=960.3769597153787))
    annotation (Placement(transformation(extent={{-10,-94},{10,-74}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP1
                                          annotation (Placement(transformation(
          extent={{20,-100},{40,-80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
      Initialvalue=0.5)            annotation (Placement(transformation(extent=
            {{-30,80},{-10,100}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe1(
      Initialvalue=0.5)             annotation (Placement(transformation(extent=
           {{-30,-80},{-10,-60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve valve2(Pm(start=
          250000.00130815947), Q(start=1920.8429304679091))
    annotation (Placement(transformation(extent={{-10,6},{10,26}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve valve3(Pm(start=
          200000.00130815947), Q(start=-0.0965278352866084))
    annotation (Placement(transformation(extent={{-10,-54},{10,-34}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeB volumeB1(dynamic_mass_balance=true, h(start=
          71016.12237180525))
    annotation (Placement(transformation(
        origin={30,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve valve5
    annotation (Placement(transformation(extent={{50,-24},{70,-4}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP2
                                          annotation (Placement(transformation(
          extent={{82,-30},{102,-10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2(
    Duration=1,
    Initialvalue=1,
    Finalvalue=0) annotation (Placement(transformation(extent={{32,20},{52,40}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe3(Initialvalue=1, Finalvalue=0)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe4(Initialvalue=1, Finalvalue=0)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe pipe1(lambda=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe pipe2(lambda=0)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Junctions.Splitter2 splitter2_1
    annotation (Placement(transformation(extent={{-50,0},{-30,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Junctions.Splitter2 splitter2_2
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}}, rotation=
           0)));
equation
  connect(valve4.C2, puitsP1.C)         annotation (Line(points={{10,-90},{20,
          -90}}, color={0,0,255}));
  connect(rampe.y, valve1.Ouv)        annotation (Line(points={{-9,90},{0,90},{
          0,87}}));
  connect(rampe1.y, valve4.Ouv)
    annotation (Line(points={{-9,-70},{0,-70},{0,-73}}));
  connect(valve5.C2, puitsP2.C)         annotation (Line(points={{70,-20},{82,
          -20}}, color={0,0,255}));
  connect(rampe2.y, valve5.Ouv)
    annotation (Line(points={{53,30},{60,30},{60,-3}}));
  connect(rampe3.y, valve2.Ouv)         annotation (Line(points={{-9,40},{0,40},
          {0,27}}));
  connect(rampe4.y, valve3.Ouv)         annotation (Line(points={{-9,-20},{0,
          -20},{0,-33}}));
  connect(sourceP.C, pipe1.C1)
    annotation (Line(points={{-84,10},{-80,10}}, color={0,0,255}));
  connect(sourceP1.C, pipe2.C1)
    annotation (Line(points={{-84,-50},{-80,-50}}, color={0,0,255}));
  connect(valve2.C2, volumeB1.Ce2)         annotation (Line(points={{10,10},{30,
          10},{30,-10}}, color={0,0,255}));
  connect(valve3.C2, volumeB1.Ce1)         annotation (Line(points={{10,-50},{
          30,-50},{30,-30}}, color={0,0,255}));
  connect(volumeB1.Cs2, valve5.C1)
    annotation (Line(points={{39.8,-20},{50,-20}}, color={0,0,255}));
  connect(valve1.C2, puitsP.C)        annotation (Line(points={{10,70},{20,70}},
        color={0,0,255}));
  connect(pipe1.C2, splitter2_1.Ce)
    annotation (Line(points={{-60,10},{-50,10}}, color={0,0,255}));
  connect(splitter2_1.Cs1, valve1.C1) annotation (Line(points={{-36,20},{-36,70},
          {-10,70}}, color={0,0,255}));
  connect(splitter2_1.Cs2, valve2.C1) annotation (Line(points={{-36,0},{-36,-4},
          {-20,-4},{-20,10},{-10,10}}, color={0,0,255}));
  connect(pipe2.C2, splitter2_2.Ce)
    annotation (Line(points={{-60,-50},{-50,-50}}, color={0,0,255}));
  connect(splitter2_2.Cs1, valve3.C1) annotation (Line(points={{-36,-40},{-36,
          -36},{-20,-36},{-20,-50},{-10,-50}}, color={0,0,255}));
  connect(splitter2_2.Cs2, valve4.C1) annotation (Line(points={{-36,-60},{-36,
          -90},{-10,-90}}, color={0,0,255}));
  annotation (experiment(StopTime=10), Diagram(graphics),
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
end TestJunctions5;
