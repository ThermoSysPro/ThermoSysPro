within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestPostCombustionGas
  import ThermoSysPro;

  ThermoSysPro.Fluid.BoundaryConditions.Sink Puits_Fumees2
    annotation (Placement(transformation(
        origin={151,-6},
        extent={{23,-24},{-23,24}},
        rotation=180)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ Source_Fumees2(
    Xso2=0,
    Xco2=0.0,
    Xo2=0.23,
    Xh2o=0.01,
    P0=15e5,
    Q0=415,
    T0=680,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    option_temperature=true)
    annotation (Placement(transformation(extent={{-174,-30},{-128,18}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ  sourcePQ2(
    h0=300e3,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    Q0=10)
    annotation (Placement(transformation(extent={{-172,68},{-132,108}},
          rotation=0)));

  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ sourceCombustible2(
    Hum=0,
    Xo=0,
    Xn=0,
    Xs=0,
    rho=0.838,
    Xc=0.755,
    Xh=0.245,
    Cp=2255,
    T0=410,
    Q0=9.30,
    LHV=47500e3) annotation (Placement(transformation(extent={{-107,-109},{-71,
            -73}},
          rotation=0)));

  ThermoSysPro.Fluid.Combustion.CombustionChambers.PostCombustionGas
    postCombustionGas
    annotation (Placement(transformation(extent={{-52,-74},{74,50}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss1
    annotation (Placement(transformation(extent={{-102,-16},{-82,4}})));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss singularPressureLoss2
    annotation (Placement(transformation(extent={{90,-16},{110,4}})));
equation
  connect(sourceCombustible2.C, postCombustionGas.Cfuel) annotation (Line(
        points={{-71,-91},{-7.9,-91},{-7.9,-67.8}}, color={0,0,0}));
  connect(sourcePQ2.C, singularPressureLoss.C1)
    annotation (Line(points={{-132,88},{-100,88}}, color={0,0,0}));
  connect(singularPressureLoss.C2, postCombustionGas.Ca) annotation (Line(
        points={{-80,88},{-20.5,88},{-20.5,43.8}}, color={0,0,0}));
  connect(Source_Fumees2.C, singularPressureLoss1.C1)
    annotation (Line(points={{-128,-6},{-102,-6}}, color={0,0,0}));
  connect(singularPressureLoss1.C2, postCombustionGas.Cfg1) annotation (Line(
        points={{-82,-6},{-64,-6},{-64,-5.8},{-45.7,-5.8}}, color={0,0,0}));
  connect(postCombustionGas.Cfg2, singularPressureLoss2.C1) annotation (Line(
        points={{67.7,-5.8},{79.85,-5.8},{79.85,-6},{90,-6}}, color={0,0,0}));
  connect(singularPressureLoss2.C2, Puits_Fumees2.C)
    annotation (Line(points={{110,-6},{128,-6}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1)), Icon(graphics={
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
end TestPostCombustionGas;
