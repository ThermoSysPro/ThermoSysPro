within ThermoSysPro.Examples.SimpleExamples;
model TestFossilFuelBoiler
  MultiFluids.Boilers.FossilFuelBoiler FossilFuelBoiler(
    Wloss=0,
    Ke=1.e6,
    Tsf=386.16)
    annotation (Placement(transformation(extent={{-45,-51},{45,51}}, rotation=0)));
  Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    T0=338.16,
    Cp=1282,
    Xh=0.24403,
    Xc=0.75323,
    Q0=1.45)
    annotation (Placement(transformation(extent={{-36,-78},{0,-41}}, rotation=0)));
  FlueGases.BoundaryConditions.SourceQ sourceQ(
    Xco2=0,
    Xh2o=0.01,
    Q0=27.,
    T0=298.16,
    Xo2=0.233) annotation (Placement(transformation(extent={{-110,-50},{-71,-13}},
          rotation=0)));
  FlueGases.BoundaryConditions.SinkP sinkP annotation (Placement(transformation(
          extent={{68,-51},{110,-12}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourcePQ sourcePQ(
    P0=140e5,
    Q0=24.,
    h0=600e3)
    annotation (Placement(transformation(extent={{-107,14},{-71,48}}, rotation=
            0)));
  WaterSteam.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{74,13},{110,49}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss(K=1e-3)
    annotation (Placement(transformation(extent={{-64,25},{-56,37}}, rotation=0)));
  WaterSteam.PressureLosses.SingularPressureLoss singularPressureLoss1(K=1e-3)
    annotation (Placement(transformation(extent={{57,25},{65,37}}, rotation=0)));
equation
  connect(sourceQ.C, FossilFuelBoiler.Cair)     annotation (Line(
      points={{-71,-31.5},{-63.5,-31.5},{-63.5,-31.62},{-45,-31.62}},
      color={0,0,0},
      thickness=1));
  connect(FossilFuelBoiler.Cfg, sinkP.C)     annotation (Line(
      points={{45,-31.62},{62,-31.62},{62,-31.5},{68.42,-31.5}},
      color={0,0,0},
      thickness=1));
  connect(fuelSourcePQ.C, FossilFuelBoiler.Cfuel)     annotation (Line(points={
          {0,-59.5},{0,-40.8}}, color={0,0,0}));
  connect(sourcePQ.C, singularPressureLoss.C1)
    annotation (Line(points={{-71,31},{-64,31}}, color={0,0,255}));
  connect(singularPressureLoss.C2, FossilFuelBoiler.Cws1) annotation (Line(
        points={{-56,31},{-50,31},{-50,30.6},{-45,30.6}}, color={0,0,255}));
  connect(singularPressureLoss1.C2, sink.C)
    annotation (Line(points={{65,31},{74,31}}, color={0,0,255}));
  connect(FossilFuelBoiler.Cws2, singularPressureLoss1.C1) annotation (Line(
        points={{45,30.6},{51,30.6},{51,31},{57,31}}, color={0,0,255}));
  annotation (Diagram(graphics), Icon(graphics={
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
end TestFossilFuelBoiler;
