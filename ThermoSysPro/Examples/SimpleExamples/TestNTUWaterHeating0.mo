within ThermoSysPro.Examples.SimpleExamples;
model TestNTUWaterHeating0

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_condenseur(
    P0=80.0e5,
    Q0=1780,
    h0=872.0e3)
          annotation (Placement(transformation(extent={{-182,-10},{-162,10}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur
             annotation (Placement(transformation(extent={{152,-10},{172,10}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    mode=0,
    P0=27.e5,
    h0=2.6e6)
            annotation (Placement(transformation(extent={{-182,88},{-162,108}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2(K=1e-4)
                          annotation (Placement(transformation(extent={{-106,
            -10},{-86,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=1e-4)
                          annotation (Placement(transformation(extent={{-106,88},
            {-86,108}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur1
             annotation (Placement(transformation(extent={{152,-106},{172,-86}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4(K=1e-4)
                          annotation (Placement(transformation(extent={{92,-10},
            {112,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4)
                          annotation (Placement(transformation(extent={{34,-106},
            {54,-86}}, rotation=0)));

  ThermoSysPro.WaterSteam.HeatExchangers.NTUWaterHeating nTUWaterHeating(
    lambdaE=102.5,
    SCondDes=6314,
    KCond=5024,
    SPurge=656,
    KPurge=1767,
    HeiF(start=900000),
    HDesF(start=900000),
    Hep(start=500000),
    Ee(h_vol(start=880000), Q(start=1800), h(start=880000), P(start=80e5)),
    Ev(h_vol(start=3500000), P(start=27e5)),
    Ep(Q(start=10)),
    Se(P(start=80e5)))  annotation (Placement(transformation(extent={{-34,-42},
            {44,42}}, rotation=0)));
equation
  connect(Source_condenseur.C, singularPressureLoss2.C1)
    annotation (Line(points={{-162,0},{-106,0}}, color={0,0,255}));
  connect(sourceP.C, singularPressureLoss3.C1)
    annotation (Line(points={{-162,98},{-106,98}}, color={0,0,255}));
  connect(singularPressureLoss4.C2, Puit_condenseur.C)
    annotation (Line(points={{112,0},{152,0}}, color={0,0,255}));
  connect(singularPressureLoss5.C2, Puit_condenseur1.C)
    annotation (Line(points={{54,-96},{152,-96}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, nTUWaterHeating.Ev) annotation (Line(points=
         {{-86,98},{28.4,98},{28.4,13.44}}, color={0,0,255}));
  connect(nTUWaterHeating.Se, singularPressureLoss4.C1)
    annotation (Line(points={{44,0},{92,0}}, color={0,0,255}));
  connect(singularPressureLoss2.C2, nTUWaterHeating.Ee)
    annotation (Line(points={{-86,0},{-34.78,0}}, color={0,0,255}));
  connect(singularPressureLoss5.C1, nTUWaterHeating.Sp)
    annotation (Line(points={{34,-96},{-14,-96},{-14,-13.86},{-18.4,-13.86}}));
    annotation (experiment(StopTime=1000), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics),
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
end TestNTUWaterHeating0;
