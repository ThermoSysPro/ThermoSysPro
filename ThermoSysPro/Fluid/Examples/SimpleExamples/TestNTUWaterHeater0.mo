within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestNTUWaterHeater0

  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ Source_condenseur(
    P0=80.0e5,
    Q0=1780,
    h0=872.0e3)
          annotation (Placement(transformation(extent={{-182,-10},{-162,10}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink Puit_condenseur(C(h(start=
            980281.0129225359)))
             annotation (Placement(transformation(extent={{152,-10},{172,10}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP(
    option_temperature=false,
    P0=27.e5,
    h0=2.6e6,
    C(h_vol_2(start=883556.9736276601)),
    Q(start=112.29047515166533))
            annotation (Placement(transformation(extent={{-182,90},{-162,110}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss2(K=1e-4, C2(P(start=7999999.633732218)))
                          annotation (Placement(transformation(extent={{-106,
            -10},{-86,10}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=1e-4)
                          annotation (Placement(transformation(extent={{-106,90},
            {-86,110}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink Puit_condenseur1
             annotation (Placement(transformation(extent={{152,-106},{172,-86}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss4(K=1e-4,
    C1(P(start=7618062.482445708)),
    rho(start=834.862478836879))
                          annotation (Placement(transformation(extent={{92,-10},
            {112,10}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4, rho(start=857.3159873035071))
                          annotation (Placement(transformation(extent={{34,-106},
            {54,-86}}, rotation=0)));

  ThermoSysPro.Fluid.HeatExchangers.NTUWaterHeater nTUWaterHeating(
    lambdaE=102.5,
    SCondDes=6314,
    KCond=5024,
    SPurge=656,
    KPurge=1767,
    HeiF(start=878162.3337936474),
    HDesF(start=980281.0129225359),
    Hep(start=981240.7187349163),
    Ee(h_vol_2(start=880000), Q(start=1800), h(start=880000), P(start=80e5)),
    Ev(h_vol_1(start=3500000), P(start=27e5)),
    Ep(Q(start=10)),
    Se(P(start=80e5)),
    SDes(start=1E-09),
    continuous_flow_reversal=true)
                        annotation (Placement(transformation(extent={{-44,-52},
            {64,54}}, rotation=0)));
equation
  connect(Source_condenseur.C, singularPressureLoss2.C1)
    annotation (Line(points={{-162,0},{-106,0}}, color={0,0,255}));
  connect(sourceP.C, singularPressureLoss3.C1)
    annotation (Line(points={{-162,100},{-106,100}},
                                                   color={0,0,255}));
  connect(singularPressureLoss4.C2, Puit_condenseur.C)
    annotation (Line(points={{112,0},{152,0}}, color={0,0,255}));
  connect(singularPressureLoss5.C2, Puit_condenseur1.C)
    annotation (Line(points={{54,-96},{152,-96}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, nTUWaterHeating.Ev) annotation (Line(points={{-86,100},
          {42.4,100},{42.4,19.02}},         color={0,0,255}));
  connect(nTUWaterHeating.Se, singularPressureLoss4.C1)
    annotation (Line(points={{64,1},{68,1},{68,0},{92,0}},
                                             color={0,0,255}));
  connect(singularPressureLoss2.C2, nTUWaterHeating.Ee)
    annotation (Line(points={{-86,0},{-44,0},{-44,1}},
                                                  color={0,0,255}));
  connect(singularPressureLoss5.C1, nTUWaterHeating.Sp)
    annotation (Line(points={{34,-96},{-18,-96},{-18,-16.49},{-22.4,-16.49}}));
    annotation (experiment(StopTime=1000), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestNTUWaterHeater0;
