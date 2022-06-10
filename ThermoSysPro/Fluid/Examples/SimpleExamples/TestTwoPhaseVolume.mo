within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestTwoPhaseVolume
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
                     annotation (Placement(transformation(extent={{-120,76},{
            -100,96}}, rotation=0)));
  PressureLosses.ControlValve                         steamValve(
    Cv(start=25000),
    Q(start=0.0),
    rho(start=78.5),
    h(start=2657930),
    C1(h_vol_2(start=2655313.7785675577)),
    Cvmax(fixed=false),
    Pm(start=12998726.577779))
    annotation (Placement(transformation(extent={{-120,136},{-100,156}},
                                                                   rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon(k=0.5)
    annotation (Placement(transformation(extent={{-160,100},{-140,120}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon1(k=0.5)
    annotation (Placement(transformation(extent={{-160,160},{-140,180}},
                                                                    rotation=0)));
  BoundaryConditions.SourceP                         sourceP(h0=1400000,
    option_temperature=false,
    P0=13200000)
           annotation (Placement(transformation(extent={{-200,70},{-180,90}},
          rotation=0)));
  BoundaryConditions.SinkP                         sinkQ(P0=13200000, Q(start=
          51.00572315373906))
    annotation (Placement(transformation(extent={{-38,-40},{-18,-20}},
                                                                     rotation=0)));
  Volumes.TwoPhaseVolume twoPhaseVolume(diffusion=true,
    steady_state=true,
    Vv(start=0.5, fixed=true),
    dynamic_energy_balance=true,
    P0=13200000,
    Pfond(start=13200000))
    annotation (Placement(transformation(extent={{-80,50},{-20,110}})));
  PressureLosses.LumpedStraightPipe lumpedStraightPipe annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,10})));
  BoundaryConditions.SourceP                         sourceP1(
    P0(fixed=true) = 13200000,
    option_temperature=false,
    h0=2600000)
           annotation (Placement(transformation(extent={{-200,130},{-180,150}},
          rotation=0)));
equation
  connect(ConsigneNiveauBallon.y,feedwaterValve. Ouv)
    annotation (Line(points={{-139,110},{-110,110},{-110,97}}, smooth=Smooth.None));
  connect(sourceP.C,feedwaterValve. C1)  annotation (Line(
      points={{-180,80},{-120,80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ConsigneNiveauBallon1.y,steamValve. Ouv)
    annotation (Line(points={{-139,170},{-110,170},{-110,157}},
                                                         smooth=Smooth.None));
  connect(feedwaterValve.C2, twoPhaseVolume.Ce)
    annotation (Line(points={{-100,80},{-80,80}}, color={0,0,0}));
  connect(lumpedStraightPipe.C2, sinkQ.C)
    annotation (Line(points={{-50,0},{-50,-30},{-38,-30}}, color={0,0,0}));
  connect(sourceP1.C, steamValve.C1)
    annotation (Line(points={{-180,140},{-120,140}}, color={0,0,0}));
  connect(steamValve.C2, twoPhaseVolume.Cv)
    annotation (Line(points={{-100,140},{-50,140},{-50,110}}, color={0,0,0}));
  connect(twoPhaseVolume.Cl, lumpedStraightPipe.C1)
    annotation (Line(points={{-50,50},{-50,20}}, color={0,0,0}));
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
end TestTwoPhaseVolume;
