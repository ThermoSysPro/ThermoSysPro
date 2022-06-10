within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestRefP1

  ThermoSysPro.Fluid.BoundaryConditions.RefP refP
    annotation (Placement(transformation(extent={{-70,0},{-50,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(
                                                 k=2.e5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}}, rotation=
            0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump pump
    annotation (Placement(transformation(extent={{0,0},{20,20}},    rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe
    annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
  BoundaryConditions.Source source
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  BoundaryConditions.RefQ refQ
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
equation
  connect(constante.y, refP.IPressure) annotation (Line(points={{-79,70},{-60,
          70},{-60,21}}));
  connect(source.C, refP.C1)
    annotation (Line(points={{-80,10},{-70,10}}, color={0,0,0}));
  connect(lumpedStraightPipe.C2, sink.C)
    annotation (Line(points={{60,10},{80,10}}, color={0,0,0}));
  connect(pump.C2, lumpedStraightPipe.C1)
    annotation (Line(points={{20,10},{40,10}}, color={0,0,0}));
  connect(refP.C2, refQ.C1)
    annotation (Line(points={{-50,10},{-40,10}}, color={0,0,0}));
  connect(pump.C1, refQ.C2)
    annotation (Line(points={{0,10},{-20,10}}, color={0,0,0}));
  annotation (experiment(StopTime=1000),
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
end TestRefP1;
