within ThermoSysPro.Examples.Book.SimpleExamples.PressureLoss;
model TestDynamicReliefValve
  import ThermoSysPro;

  ThermoSysPro.WaterSteam.PressureLosses.DynamicReliefValve ReliefValve(
    mech_steady_state=false,
    caract=[0,0; 0.1,2745; 0.2,4915; 0.3,6391; 0.4,7339; 0.5,7949; 0.6,8351;
        0.7,8625; 0.8,8818; 0.9,8958; 1,9063],
    Cvmax=9063,
    mode_caract=1,
    A1=0.125,
    A2=0.125,
    z_max=0.6,
    m=100,
    Popen=2000000,
    Q(start=1.4404060369658185E-32))
    annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe Pipe2(
                   continuous_flow_reversal=true, Pm(start=199283),
    Q(start=1335.993983016864))          annotation (Placement(transformation(
          extent={{40,-20},{60,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP Sink2
                                   annotation (Placement(transformation(extent=
            {{80,-20},{100,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe Pipe1(
                   continuous_flow_reversal=true,
    D=0.4,
    Pm(start=1478795.1075221882))        annotation (Placement(transformation(
          extent={{-40,-20},{-20,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD VolumeD1(P(start=298566), h(start=
          72156.6431966866))         annotation (Placement(transformation(
          extent={{0,-20},{20,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP Sink1
                                   annotation (Placement(transformation(extent=
            {{40,20},{60,40}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  InstrumentationAndControl.Blocks.Sources.Rampe ramp(
    Duration=200,
    Finalvalue=30e5,
    Initialvalue=15e5)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
equation
  connect(Pipe2.C2, Sink2.C)
    annotation (Line(points={{60,-10},{80,-10}}, color={0,0,255}));
  connect(Pipe1.C2, VolumeD1.Ce)
    annotation (Line(points={{-20,-10},{0,-10}}, color={0,0,255}));
  connect(VolumeD1.Cs3, Pipe2.C1)
    annotation (Line(points={{20,-10},{40,-10}}, color={0,0,255}));
  connect(ReliefValve.C1, VolumeD1.Cs1)
                                     annotation (Line(points={{10,20.2},{10,0}}));
  connect(ReliefValve.C2, Sink1.C)
    annotation (Line(points={{20,30},{30,30},{30,30},{40,30}},     color={0,0,
          255}));
  connect(sourceP.C, Pipe1.C1)
    annotation (Line(points={{-60,-10},{-40,-10}}, color={0,0,255}));
  connect(ramp.y, sourceP.IPressure) annotation (Line(points={{-79,30},{-60,30},
          {-60,8},{-80,8},{-80,-10},{-75,-10}}, color={28,108,200}));
  annotation (
    Diagram(graphics,
            coordinateSystem(
        preserveAspectRatio=false, initialScale=0.1)),
    Window(
      x=0.1,
      y=0.08,
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})},
         coordinateSystem(preserveAspectRatio=false, initialScale=0.1)),
    experiment(StopTime=300),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 13.13.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestDynamicReliefValve;
