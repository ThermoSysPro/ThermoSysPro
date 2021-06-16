within ThermoSysPro.Examples.SimpleExamples;
model TestCentrifugalPumpWaterSolution

  ThermoSysPro.WaterSolution.BoundaryConditions.RefP refP
    annotation (Placement(transformation(extent={{-100,0},{-80,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(
                                                 k=2.e5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}}, rotation=
            0)));
  ThermoSysPro.WaterSolution.Machines.StaticCentrifugalPump pump(C2(T(start=290)))
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  ThermoSysPro.WaterSolution.LoopBreakers.LoopBreakerQ loopBreakerQ
    annotation (Placement(transformation(extent={{10,0},{30,20}}, rotation=0)));
  ThermoSysPro.WaterSolution.LoopBreakers.LoopBreakerT loopBreakerH
    annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
  ThermoSysPro.WaterSolution.BoundaryConditions.RefT refT
    annotation (Placement(transformation(extent={{-70,0},{-50,20}}, rotation=0)));
  ThermoSysPro.WaterSolution.PressureLosses.SingularPressureLoss
    lumpedStraightPipe annotation (Placement(transformation(extent={{0,-40},{
            -20,-20}}, rotation=0)));
  ThermoSysPro.WaterSolution.LoopBreakers.LoopBreakerXh2o loopBreakerXh20_1
    annotation (Placement(transformation(extent={{70,0},{90,20}}, rotation=0)));
  ThermoSysPro.WaterSolution.BoundaryConditions.RefXh2o refXh2o
    annotation (Placement(transformation(extent={{-44,0},{-24,20}}, rotation=0)));
equation
  connect(loopBreakerQ.Cs, loopBreakerH.Ce) annotation (Line(points={{30,10},{
          40,10}}, color={0,0,255}));
  connect(refP.C2, refT.C1) annotation (Line(points={{-80,10},{-70,10}}, color=
          {0,0,255}));
  connect(constante.y, refP.IPressure) annotation (Line(points={{-79,70},{-60,
          70},{-60,34},{-90,34},{-90,21}}));
  connect(pump.C2, loopBreakerQ.Ce) annotation (Line(points={{0,10},{10,10}},
        color={0,0,0}));
  connect(loopBreakerH.Cs, loopBreakerXh20_1.Ce) annotation (Line(points={{60,
          10},{70,10}}, color={0,0,0}));
  connect(refT.C2, refXh2o.C1) annotation (Line(points={{-50,10},{-44,10}},
        color={0,0,0}));
  connect(refXh2o.C2, pump.C1) annotation (Line(points={{-24,10},{-20,10}},
        color={0,0,0}));
  connect(loopBreakerXh20_1.Cs, lumpedStraightPipe.C1) annotation (Line(points=
          {{90,10},{100,10},{100,-30},{-1,-30}}, color={0,0,0}));
  connect(lumpedStraightPipe.C2, refP.C1) annotation (Line(points={{-19,-30},{
          -100,-30},{-100,10}}, color={0,0,0}));
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
end TestCentrifugalPumpWaterSolution;
