within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicReliefValve
  import ThermoSysPro;
  parameter Modelica.SIunits.AbsolutePressure Pinitial=18e5 "Initial pressure";
  parameter Modelica.SIunits.AbsolutePressure Pfinal=Pinitial "Final pressure";
  parameter Modelica.SIunits.AbsolutePressure Pmax=21e5 "Maximum pressure";

  ThermoSysPro.WaterSteam.PressureLosses.DynamicReliefValve reliefValve(
    mech_steady_state=false,
    caract=[0,0; 0.1,2745; 0.2,4915; 0.3,6391; 0.4,7339; 0.5,7949; 0.6,8351;
        0.7,8625; 0.8,8818; 0.9,8958; 1,9063],
    Cvmax=9063,
    Q(start=0),
    Pm(start=Pinitial),
    Pout=sinkP.P0,
    mode_caract=2,
    A2=1.1*reliefValve.A1,
    A1=1.3*Modelica.Constants.pi*pipe.D^2/4,
    m=50,
    Cd=0.44,
    Popen=2000000,
    z_max=0.05)
    annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe pipe(
    Q(start=0),
    Pm(start=Pinitial),
    L=2,
    D=0.2) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP(mode=0)
                                   annotation (Placement(transformation(extent={{80,0},{
            100,20}},          rotation=0)));
  WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  InstrumentationAndControl.Blocks.Sources.Rampe ramp1(
    Duration=200,
    Finalvalue=Pmax,
    Initialvalue=Pinitial)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  InstrumentationAndControl.Blocks.Sources.Rampe ramp2(
    Duration=200,
    Starttime=300,
    Finalvalue=Pmax - Pfinal)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  InstrumentationAndControl.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  WaterSteam.PressureLosses.Bend bend(R0=0.2, D=pipe.D)
    annotation (Placement(transformation(extent={{0,-20},{20,-40}})));
  WaterSteam.PressureLosses.Diaphragm diaphragm(Ouv=1, D=0.5)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(sourceP.C, pipe.C1)
    annotation (Line(points={{-60,-30},{-40,-30}}, color={0,0,255}));
  connect(ramp1.y, add.u1) annotation (Line(points={{-79,50},{-70,50},{-70,36},{
          -61,36}}, color={0,0,255}));
  connect(ramp2.y, add.u2) annotation (Line(points={{-79,10},{-70,10},{-70,24},{
          -61,24}}, color={0,0,255}));
  connect(add.y, sourceP.IPressure) annotation (Line(points={{-39,30},{-20,30},{
          -20,-10},{-90,-10},{-90,-30},{-75,-30}},
                                                 color={0,0,255}));
  connect(pipe.C2, bend.C1)
    annotation (Line(points={{-20,-30},{0,-30}}, color={0,0,255}));
  connect(bend.C2,reliefValve. C1)
    annotation (Line(points={{10,-20},{10,0.2}},color={0,0,255}));
  connect(reliefValve.C2, diaphragm.C1)
    annotation (Line(points={{20,10},{40,10}}, color={0,0,255}));
  connect(diaphragm.C2,sinkP. C)
    annotation (Line(points={{60,10},{80,10}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
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
    experiment(StopTime=600, Interval=1),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestDynamicReliefValve;
