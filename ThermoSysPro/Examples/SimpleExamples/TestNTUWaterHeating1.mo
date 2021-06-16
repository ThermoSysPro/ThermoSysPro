within ThermoSysPro.Examples.SimpleExamples;
model TestNTUWaterHeating1

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_condenseur(
    P0=80.0e5,
    Q0=1780,
    h0=872.0e3)
          annotation (Placement(transformation(extent={{-201,-10},{-181,10}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur
             annotation (Placement(transformation(extent={{182,-10},{202,10}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    mode=0,
    P0=27.0e5,
    h0=2.60e6)
            annotation (Placement(transformation(extent={{-201,90},{-181,110}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2(K=1e-4)
                          annotation (Placement(transformation(extent={{-101,
            -10},{-81,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=1e-4)
                          annotation (Placement(transformation(extent={{-100,90},
            {-80,110}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur1
             annotation (Placement(transformation(extent={{178,-100},{198,-80}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss4(K=1e-4)
                          annotation (Placement(transformation(extent={{142,-10},
            {162,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4)
                          annotation (Placement(transformation(extent={{140,
            -100},{160,-80}}, rotation=0)));

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
    Se(P(start=80e5)))
                      annotation (Placement(transformation(extent={{-36,-42},{
            42,42}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1(K=1e-4)
                          annotation (Placement(transformation(extent={{-100,50},
            {-80,70}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_condenseur1(
    Q0=1,
    h0=1000e3,
    P0=80e5)
          annotation (Placement(transformation(extent={{-201,50},{-181,70}},
          rotation=0)));
equation
  connect(Source_condenseur.C, singularPressureLoss2.C1)
    annotation (Line(points={{-181,0},{-101,0}}, color={0,0,255}));
  connect(sourceP.C, singularPressureLoss3.C1)
    annotation (Line(points={{-181,100},{-100,100}}, color={0,0,255}));
  connect(singularPressureLoss4.C2, Puit_condenseur.C)
    annotation (Line(points={{162,0},{182,0}}, color={0,0,255}));
  connect(singularPressureLoss5.C2, Puit_condenseur1.C)
    annotation (Line(points={{160,-90},{178,-90}}, color={0,0,255}));
  connect(singularPressureLoss3.C2, nTUWaterHeating.Ev) annotation (Line(points=
         {{-80,100},{26.4,100},{26.4,13.44}}, color={0,0,255}));
  connect(nTUWaterHeating.Se, singularPressureLoss4.C1)
    annotation (Line(points={{42,0},{142,0}}, color={0,0,255}));
  connect(singularPressureLoss5.C1, nTUWaterHeating.Sp)
    annotation (Line(points={{140,-90},{-20,-90},{-20,-13.86},{-20.4,-13.86}}));
  connect(singularPressureLoss2.C2, nTUWaterHeating.Ee)
    annotation (Line(points={{-81,0},{-36.78,0}}, color={0,0,255}));
  connect(Source_condenseur1.C, singularPressureLoss1.C1)
    annotation (Line(points={{-181,60},{-100,60}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, nTUWaterHeating.Ep) annotation (Line(points=
         {{-80,60},{-20.4,60},{-20.4,14.28}}, color={0,0,255}));
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
end TestNTUWaterHeating1;
