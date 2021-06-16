within ThermoSysPro.Examples.SimpleExamples;
model TestSimpleStaticCondenser

  ThermoSysPro.WaterSteam.HeatExchangers.SimpleStaticCondenser
    simpleStaticCondenser(
    Ec(h(start=532983.7176868258)),
    Ef(h(start=71016.12237181116)),
    Qc(start=1049.6385508765125),
    Qf(start=4469.84281279143),
    Sf(h(start=64330.208038325145)))
                          annotation (Placement(transformation(extent={{-20,20},
            {0,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(T0=400)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP1
    annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));
equation
  connect(sourceP.C, simpleStaticCondenser.Ef) annotation (Line(points={{-40,30},
          {-20,30}}, color={0,0,255}));
  connect(sourceP1.C, simpleStaticCondenser.Ec) annotation (Line(points={{-40,
          -10},{-16,-10},{-16,20}}, color={0,0,255}));
  connect(simpleStaticCondenser.Sf, sinkP.C) annotation (Line(points={{0,29.9},
          {10,29.9},{10,30},{20,30}}, color={0,0,255}));
  connect(simpleStaticCondenser.Sc, sinkP1.C) annotation (Line(points={{-4,20},
          {-4,-10},{20,-10}}, color={0,0,255}));
  annotation (experiment(StopTime=1000), Diagram(graphics),
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
end TestSimpleStaticCondenser;
