within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicDrum
  parameter Modelica.SIunits.MassFlowRate Qin(fixed=false,start=80)
    "Mass flow rate";
  parameter ThermoSysPro.Units.Cv CvmaxWater(fixed=false,start=670)
    "Maximum CV (active if mode_caract=0)";
  parameter Real LambdaPipe(fixed=false,start=0.085)
    "Friction pressure loss coefficient (active if lambda_fixed=true)";

  ThermoSysPro.WaterSteam.Volumes.DynamicDrum Drum(
    Vv(start=39),
    Vertical=false,
    hl(start=1454400),
    hv(start=2.658e6),
    xv(start=0.01),
    rhol(start=670),
    rhov(start=78),
    P0=13000000,
    P(start=13000000, fixed=true),
    Tp(start=592.6),
    zl(fixed=true, start=1.05))
                     annotation (Placement(transformation(extent={{-61,18},{1,
            80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve FeedwaterValve(
    Cv(start=335),
    C1(
      h_vol(start=1400e3),
      h(start=1400e3),
      P(start=13300000),
      Q(start=79.5)),
    Q(start=79.5),
    rho(start=888),
    h(start=1400000),
    Cvmax=CvmaxWater,
    Pm(start=13100000))
                     annotation (Placement(transformation(extent={{-120,76},{
            -100,96}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve SteamValve(
    Cvmax(fixed=true) = 50000,
    Cv(start=25000),
    Q(start=79.5),
    rho(start=78.5),
    Pm(start=12900000),
    h(start=2657930))
    annotation (Placement(transformation(extent={{40,76},{60,96}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon(k(fixed=true) = 0.5)
    annotation (Placement(transformation(extent={{-160,122},{-140,142}},
          rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe
    TubeEcranBoucleEvaporatoire(
    T0=fill(400, 10),
    heb(start={10409,10268,10127,9985,9842,9698,9552,9406,9258,9111}),
    advection=false,
    z2=10,
    simplified_dynamic_energy_balance=false,
    P(start={13007000,13006600,13006000,13005500,13005000,13004500,13004000,13003000,
          13002000,13001000,13000000,12999990}),
    D=0.03,
    ntubes=1400,
    h(start={1400e3,1450e3,1500e3,1550e3,1600e3,1650e3,1700e3,1750e3,1800e3,1850e3,
          1900e3,1950e3}),
    L=20,
    Q(start=fill(130, 11)))
                     annotation (Placement(transformation(
        origin={6,-26},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource SourceC3(
    option_temperature=2,
    W0={1e7,1e7,1e7,1e7,1e7,1e7,1e7,1e7,1e7,1e7},
    T0={290,290,290,290,290,290,290,290,290,290})
    annotation (Placement(transformation(
        origin={36,-26},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(Ns=10, L=20,
    D=0.03,
    ntubes=1400)
    annotation (Placement(transformation(
        origin={18,-26},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(
    L=20,
    z1=20,
    C1(P(start=130e5)),
    mode=1,
    Q(fixed=true, start=130),
    lambda=LambdaPipe)
             annotation (Placement(transformation(
        origin={-66,-26},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    ConsigneNiveauBallon1(k(fixed=true) = 0.5)
    annotation (Placement(transformation(extent={{0,122},{20,142}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(h0=1400000,
    P0(fixed=true) = 13200000,
    option_temperature=2)
           annotation (Placement(transformation(extent={{-196,70},{-176,90}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkQ(Q0=75)
    annotation (Placement(transformation(extent={{126,70},{146,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    SteamMassFlowRate(k=Qin)
    annotation (Placement(transformation(extent={{100,122},{120,142}}, rotation=
           0)));
equation
  connect(Drum.Cv, SteamValve.C1)
    annotation (Line(points={{1,80},{40,80}}, color={0,0,255}));
  connect(FeedwaterValve.C2, Drum.Ce1)
    annotation (Line(points={{-100,80},{-61,80}}, color={0,0,255}));
  connect(Drum.Cd, lumpedStraightPipe.C1) annotation (Line(points={{-61,18},{
          -66,18},{-66,-16}}, color={0,0,255}));
  connect(heatExchangerWall.WT1, SourceC3.C) annotation (Line(points={{20,-26},
          {26.2,-26}}, color={191,95,0}));
  connect(Drum.Cm, TubeEcranBoucleEvaporatoire.C2)
    annotation (Line(points={{1,18},{6,18},{6,-16}}));
  connect(TubeEcranBoucleEvaporatoire.CTh, heatExchangerWall.WT2) annotation (Line(
        points={{9,-26},{16,-26}}, color={191,95,0}));
  connect(ConsigneNiveauBallon.y, FeedwaterValve.Ouv)
    annotation (Line(points={{-139,132},{-110,132},{-110,97}}, smooth=Smooth.None));
  connect(sourceP.C, FeedwaterValve.C1)  annotation (Line(
      points={{-176,80},{-120,80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(SteamValve.C2, sinkQ.C) annotation (Line(
      points={{60,80},{126,80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(TubeEcranBoucleEvaporatoire.C1, lumpedStraightPipe.C2)
    annotation (Line(points={{6,-36},{6,-68},{-66,-68},{-66,-36}}));
  connect(ConsigneNiveauBallon1.y, SteamValve.Ouv)
    annotation (Line(points={{21,132},{50,132},{50,97}}, smooth=Smooth.None));
  connect(SteamMassFlowRate.y, sinkQ.IMassFlow)
    annotation (Line(points={{121,132},{136,132},{136,85}}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.43,
      y=0,
      width=0.57,
      height=0.63),
    Diagram(graphics,
            coordinateSystem(
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
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestDynamicDrum;
