within ThermoSysPro.Examples.SimpleExamples;
model TestStaticCondenser

  parameter Modelica.SIunits.AbsolutePressure Pin_1(fixed=false,start=20000)
    "Flow pressure at inlet 1 (sourceP)";
  parameter Modelica.SIunits.AbsolutePressure Pin_2(fixed=false,start=20000)
    "Flow pressure at inlet 2 (sourceP1)";
  parameter Modelica.SIunits.AbsolutePressure Pin_3(fixed=false,start=20000)
    "Flow pressure at inlet 3 (sourceP2)";

  WaterSteam.BoundaryConditions.SourceQ Source_condenseur(
    h0=60e3, Q0(fixed=true) = 4000)
          annotation (Placement(transformation(extent={{-180,0},{-160,20}},
          rotation=0)));
  WaterSteam.BoundaryConditions.SinkP Puit_condenseur
             annotation (Placement(transformation(extent={{160,0},{180,20}},
          rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticCondenser condenseur(
    CPCE=0,
    KCO=100,
    QC0=200,
    z=5,
    SCO=15e3,
    Qee(start=4000, fixed=false),
    Pcond(fixed=false, start=2154.77))     annotation (Placement(transformation(
          extent={{-20,-16},{72,82}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    mode=0,
    h0=2.5817e6,
    C(Q(fixed=true, start=100)),
    P0=Pin_1)
            annotation (Placement(transformation(extent={{-100,140},{-80,160}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(
    option_temperature=2,
    mode=0,
    h0=2.5481e6,
    C(Q(fixed=true, start=1e-5)),
    P0=Pin_2)                     annotation (Placement(transformation(extent={
            {-182,80},{-162,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP2(
    option_temperature=2,
    mode=0,
    h0=2.5055e6,
    C(Q(fixed=true, start=1e-5)),
    P0=Pin_3)                      annotation (Placement(transformation(extent=
            {{-180,40},{-160,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss(K=10)
                         annotation (Placement(transformation(extent={{-100,80},
            {-80,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1(K=10)
                          annotation (Placement(transformation(extent={{-100,40},
            {-80,60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2(K=1e-4)
                          annotation (Placement(transformation(extent={{-100,0},
            {-80,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=10)
                          annotation (Placement(transformation(extent={{-40,140},
            {-20,160}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur1
             annotation (Placement(transformation(extent={{100,-100},{120,-80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4(K=1e-4)
                          annotation (Placement(transformation(extent={{100,0},
            {120,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4)
                          annotation (Placement(transformation(extent={{40,-100},
            {60,-80}}, rotation=0)));

equation
  connect(sourceP1.C, singularPressureLoss.C1)
    annotation (Line(points={{-162,90},{-100,90}}, color={0,0,255}));
  connect(singularPressureLoss.C2, condenseur.Cev) annotation (Line(points={{
          -80,90},{-50,90},{-50,62.89},{-20,62.89}}, color={0,0,255}));
  connect(sourceP2.C, singularPressureLoss1.C1)
    annotation (Line(points={{-160,50},{-100,50}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, condenseur.Cep) annotation (Line(points={{
          -80,50},{-52,50},{-52,42.31},{-20,42.31}}, color={0,0,255}));
  connect(Source_condenseur.C, singularPressureLoss2.C1)
    annotation (Line(points={{-160,10},{-100,10}}, color={0,0,255}));
  connect(singularPressureLoss2.C2, condenseur.Cee) annotation (Line(points={{
          -80,10},{-52,10},{-52,3.11},{-20,3.11}}, color={0,0,255}));
  connect(sourceP.C, singularPressureLoss3.C1)
    annotation (Line(points={{-80,150},{-40,150}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, condenseur.Cvt) annotation (Line(points={{
          -20,150},{26,150},{26,82.49}}, color={0,0,255}));
  connect(singularPressureLoss4.C2, Puit_condenseur.C)
    annotation (Line(points={{120,10},{160,10}}, color={0,0,255}));
  connect(condenseur.Cse, singularPressureLoss4.C1) annotation (Line(points={{
          72.92,3.11},{86,3.11},{86,10},{100,10}}, color={0,0,255}));
  connect(singularPressureLoss5.C2, Puit_condenseur1.C)
    annotation (Line(points={{60,-90},{100,-90}}, color={0,0,255}));
  connect(singularPressureLoss5.C1, condenseur.Cex)
    annotation (Line(points={{40,-90},{26.46,-90},{26.46,-16.98}}));
  annotation (experiment(StopTime=1000), Diagram(graphics,
                                                 coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
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
end TestStaticCondenser;
