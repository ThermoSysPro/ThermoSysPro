within ThermoSysPro.Properties.WaterSteamSimple.Validation.Bench;
model Test3_polynomial

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-98,40},{-78,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(fluid=3)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe1(fluid=3)
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve(fluid=3)
    annotation (Placement(transformation(
        origin={-46,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve1(fluid=3)
    annotation (Placement(transformation(
        origin={-46,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve2(fluid=3)
    annotation (Placement(transformation(extent={{-20,16},{0,36}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve3(fluid=3)
    annotation (Placement(transformation(extent={{20,16},{40,36}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve4(fluid=3)
    annotation (Placement(transformation(extent={{0,-44},{20,-24}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{40,-50},{60,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe2(fluid=3)
    annotation (Placement(transformation(extent={{50,10},{70,30}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP1
    annotation (Placement(transformation(extent={{80,10},{100,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe V4(Starttime=4, Duration=
       2)         annotation (Placement(transformation(extent={{-40,60},{-20,80}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe V5(Initialvalue=1)
    annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe V3(
    Initialvalue=1,
    Finalvalue=0,
    Starttime=4,
    Duration=3) annotation (Placement(transformation(extent={{-20,-20},{0,0}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe V1
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe V2
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC volumeC(V=1e-18, fluid=3)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeA volumeA(V=1e-18, fluid=3)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-50}}, rotation=
           0)));
equation
  connect(sourceP.C, lumpedStraightPipe.C1)
    annotation (Line(points={{-78,50},{-70,50}}, color={0,0,255}));
  connect(sourceP1.C, lumpedStraightPipe1.C1)
    annotation (Line(points={{-80,-90},{-70,-90}}, color={0,0,255}));
  connect(lumpedStraightPipe1.C2, controlValve1.C1) annotation (Line(points={{
          -50,-90},{-40,-90},{-40,-80}}, color={0,0,255}));
  connect(controlValve4.C2, sinkP.C)
    annotation (Line(points={{20,-40},{40,-40}}, color={0,0,255}));
  connect(controlValve2.C2, controlValve3.C1)
    annotation (Line(points={{0,20},{20,20}}, color={0,0,255}));
  connect(controlValve3.C2, lumpedStraightPipe2.C1)
    annotation (Line(points={{40,20},{50,20}}, color={0,0,255}));
  connect(lumpedStraightPipe2.C2, sinkP1.C)
    annotation (Line(points={{70,20},{80,20}}, color={0,0,255}));
  connect(V4.y, controlValve2.Ouv) annotation (Line(points={{-19,70},{-10,70},{
          -10,37}}));
  connect(V5.y, controlValve3.Ouv) annotation (Line(points={{21,70},{30,70},{30,
          37}}));
  connect(V3.y, controlValve4.Ouv) annotation (Line(points={{1,-10},{10,-10},{
          10,-23}}));
  connect(V1.y, controlValve.Ouv) annotation (Line(points={{-79,-10},{-57,-10}}));
  connect(V2.y, controlValve1.Ouv) annotation (Line(points={{-79,-70},{-57,-70}}));
  connect(volumeC.Cs, controlValve2.C1)
    annotation (Line(points={{-30,20},{-20,20}}, color={0,0,255}));
  connect(lumpedStraightPipe.C2, volumeC.Ce2) annotation (Line(points={{-50,50},
          {-40,50},{-40,29}}, color={0,0,255}));
  connect(volumeC.Ce3, controlValve.C2) annotation (Line(points={{-40,10},{-40,
          0}}));
  connect(controlValve.C1, volumeA.Cs2) annotation (Line(points={{-40,-20},{-40,
          -30}}));
  connect(volumeA.Cs1, controlValve4.C1)
    annotation (Line(points={{-30,-40},{0,-40}}, color={0,0,255}));
  connect(volumeA.Ce2, controlValve1.C2)
    annotation (Line(points={{-40,-49.8},{-40,-60}}));
  annotation (Diagram(graphics), Icon(graphics={
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end Test3_polynomial;
