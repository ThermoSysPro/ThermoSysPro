within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestTwoPhaseCavity
  parameter ThermoSysPro.Units.xSI.Cv CvmaxWater=670
    "Maximum CV (active if mode_caract=0)";
  PressureLosses.ControlValve                         feedwaterValve(
    Cv(start=335),
    C1(
      h_vol_1(start=1400e3),
      h(start=1400e3),
      P(start=13300000),
      h_vol_2(start=1975433.4222685455)),
    rho(start=888),
    h(start=1400000),
    Cvmax=CvmaxWater,
    Q(start=10),
    Pm(start=13200000.029884))
                     annotation (Placement(transformation(extent={{-98,96},{-78,
            116}},     rotation=0)));
  PressureLosses.ControlValve                         steamValve(
    Cv(start=25000),
    Q(start=0.0),
    rho(start=78.5),
    h(start=2657930),
    C1(h_vol_2(start=2655313.7785675577)),
    Cvmax(fixed=false),
    Pm(start=12998726.577779))
    annotation (Placement(transformation(extent={{-60,136},{-40,156}},
                                                                   rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon(k=0.5)
    annotation (Placement(transformation(extent={{-138,120},{-118,140}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon1(k=0.5)
    annotation (Placement(transformation(extent={{-100,160},{-80,180}},
                                                                    rotation=0)));
  BoundaryConditions.SourceP                         sourceP(h0=1400000,
    option_temperature=false,
    P0=13200000)
           annotation (Placement(transformation(extent={{-138,90},{-118,110}},
          rotation=0)));
  BoundaryConditions.SinkP                         sinkQ(P0=13200000, Q(start=
          51.00572315373906))
    annotation (Placement(transformation(extent={{0,-60},{20,-40}},  rotation=0)));
  Volumes.TwoPhaseCavity twoPhaseVolume(
    Vv(start=0.5, fixed=true),
    diffusion=true,
    dynamic_energy_balance=false,
    P0=13200000,
    Pfond(start=13200000))
    annotation (Placement(transformation(extent={{-60,20},{20,100}})));
  PressureLosses.LumpedStraightPipe lumpedStraightPipe annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-10})));
  BoundaryConditions.SourceP                         sourceP1(
    P0(fixed=true) = 13200000,
    option_temperature=false,
    h0=2600000)
           annotation (Placement(transformation(extent={{-100,130},{-80,150}},
          rotation=0)));
equation
  connect(ConsigneNiveauBallon.y,feedwaterValve. Ouv)
    annotation (Line(points={{-117,130},{-88,130},{-88,117}},  smooth=Smooth.None));
  connect(sourceP.C,feedwaterValve. C1)  annotation (Line(
      points={{-118,100},{-98,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ConsigneNiveauBallon1.y,steamValve. Ouv)
    annotation (Line(points={{-79,170},{-50,170},{-50,157}},
                                                         smooth=Smooth.None));
  connect(lumpedStraightPipe.C2, sinkQ.C)
    annotation (Line(points={{-20,-20},{-20,-50},{0,-50}}, color={0,0,0}));
  connect(sourceP1.C, steamValve.C1)
    annotation (Line(points={{-80,140},{-60,140}},   color={0,0,0}));
  connect(twoPhaseVolume.Cl, lumpedStraightPipe.C1) annotation (Line(points={{
          -19.5556,30.6667},{-19.5556,15.3333},{-20,15.3333},{-20,0}}, color={0,
          0,0}));
  connect(steamValve.C2, twoPhaseVolume.Cv) annotation (Line(points={{-40,140},
          {-19.5556,140},{-19.5556,89.3333}}, color={0,0,0}));
  connect(feedwaterValve.C2, twoPhaseVolume.Ce) annotation (Line(points={{-78,100},
          {-35.5556,100},{-35.5556,89.3333}},      color={0,0,0}));
  annotation (experiment(__Dymola_Algorithm="Dassl"),
    Window(
      x=0.43,
      y=0,
      width=0.57,
      height=0.63),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-100},{140,200}},
        grid={2,2})),
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestTwoPhaseCavity;
