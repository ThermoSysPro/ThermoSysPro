within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestStaticAerocondenser

  parameter Units.SI.AbsolutePressure Pin_1=20000
    "Flow pressure at inlet 1 (sourceP)";
  parameter Units.SI.AbsolutePressure Pin_2=20000
    "Flow pressure at inlet 3 (sourceP2)";

  BoundaryConditions.SourcePQ                   Source_condenseur(
             Q0(fixed=true) = 4000,
    h0=15e3,
    option_temperature=true,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    P0=100000,
    T0=287.15)
          annotation (Placement(transformation(extent={{190,-90},{170,-70}},
          rotation=0)));

  BoundaryConditions.Sink                     Puit_condenseur
             annotation (Placement(transformation(extent={{170,90},{190,110}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP(
    option_temperature=false,
    h0=2.5817e6,
    C(Q(fixed=false, start=100)),
    P0=Pin_1)
            annotation (Placement(transformation(extent={{-100,90},{-80,110}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP2(
    option_temperature=false,
    h0=2.5055e6,
    C(Q(fixed=false, start=1e-5)),
    P0=Pin_2)                      annotation (Placement(transformation(extent={{-182,
            -40},{-162,-20}},      rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss1(K=10)
                          annotation (Placement(transformation(extent={{-120,-40},
            {-100,-20}},
                       rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=10)
                          annotation (Placement(transformation(extent={{-38,90},
            {-18,110}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink Puit_condenseur1
             annotation (Placement(transformation(extent={{-100,-90},{-120,-70}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss5(K=1e-4)
                          annotation (Placement(transformation(extent={{-40,-90},
            {-60,-70}},rotation=0)));

  Fluid.HeatExchangers.StaticAerocondenser staticAerocondenser
    annotation (Placement(transformation(extent={{-64,-44},{66,70}})));
equation
  connect(sourceP2.C, singularPressureLoss1.C1)
    annotation (Line(points={{-162,-30},{-120,-30}},
                                                   color={0,0,255}));
  connect(sourceP.C, singularPressureLoss3.C1)
    annotation (Line(points={{-80,100},{-38,100}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, staticAerocondenser.Cw) annotation (Line(
        points={{-100,-30},{-70,-30},{-70,-29.75},{-58.5833,-29.75}},color={0,0,
          0}));
  connect(singularPressureLoss3.C2, staticAerocondenser.Cws1)
    annotation (Line(points={{-18,100},{1,100},{1,65.25}}, color={0,0,0}));
  connect(Puit_condenseur1.C, singularPressureLoss5.C2)
    annotation (Line(points={{-100,-80},{-60,-80}},color={0,0,0}));
  connect(singularPressureLoss5.C1, staticAerocondenser.Cws2)
    annotation (Line(points={{-40,-80},{1,-80},{1,-39.25}}, color={0,0,0}));
  connect(Source_condenseur.C, staticAerocondenser.Cair1) annotation (Line(
        points={{170,-80},{60.5833,-80},{60.5833,-38.775}}, color={0,0,0}));
  connect(Puit_condenseur.C, staticAerocondenser.Cair2) annotation (Line(points={{170,100},
          {60.5833,100},{60.5833,65.25}},           color={0,0,0}));
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
end TestStaticAerocondenser;
