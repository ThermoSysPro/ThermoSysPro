within ThermoSysPro.Examples.Book.SimpleExamples.CombustionChamber;
model TestGTCombustionChamber

  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees2
    annotation (Placement(transformation(
        origin={149,-2},
        extent={{23,-24},{-23,24}},
        rotation=180)));
  Combustion.CombustionChambers.GTCombustionChamber GTCombustionChamber2(
                          Cfg(P(fixed=true, start=14.1e5)), kcham(fixed=false,
        start=1))
               annotation (Placement(transformation(extent={{-67,-68},{67,64}},
          rotation=0)));
  WaterSteam.BoundaryConditions.SourcePQ sourcePQ2(
    Q0=0,
    P0=15e5,
    h0=300e3)
    annotation (Placement(transformation(extent={{-112,48},{-72,88}},
          rotation=0)));
  Combustion.BoundaryConditions.FuelSourcePQ sourceCombustible2(
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
    LHV=47500e3)
          annotation (Placement(transformation(extent={{-107,-93},{-71,-57}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees2(
    Xso2=0,
    Xco2=0.0,
    Xo2=0.23,
    Xh2o=0.01,
    P0=15e5,
    Q0=415,
    T0=680)
    annotation (Placement(transformation(extent={{-174,-26},{-128,22}},
          rotation=0)));
equation
  connect(GTCombustionChamber2.Cws, sourcePQ2.C)
    annotation (Line(points={{-40.2,57.4},{-40.2,68},{-72,68}}));
  connect(GTCombustionChamber2.Cfuel, sourceCombustible2.C) annotation (Line(
        points={{0,-61.4},{0,-75},{-71,-75}},    color={0,0,0}));
  connect(GTCombustionChamber2.Cfg, Puits_Fumees2.C) annotation (Line(
      points={{60.3,-2},{126.46,-2}},
      color={0,0,0},
      thickness=1));
  connect(Source_Fumees2.C, GTCombustionChamber2.Ca) annotation (Line(
      points={{-128,-2},{-60.3,-2}},
      color={0,0,0},
      thickness=1));
  annotation (Diagram(graphics,
                      coordinateSystem(
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
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 8.1.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestGTCombustionChamber;
