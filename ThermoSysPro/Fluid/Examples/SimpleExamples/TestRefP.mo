within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestRefP

  ThermoSysPro.Fluid.BoundaryConditions.RefP refP
    annotation (Placement(transformation(extent={{-90,0},{-70,20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(
                                                 k=2.e5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}}, rotation=
            0)));
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump pump
    annotation (Placement(transformation(extent={{-30,0},{-10,20}}, rotation=0)));
  ThermoSysPro.Fluid.LoopBreakers.LoopBreakerQ loopBreakerQ
    annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
  ThermoSysPro.Fluid.LoopBreakers.LoopBreakerH loopBreakerH
    annotation (Placement(transformation(extent={{30,0},{50,20}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.RefT refT
    annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe lumpedStraightPipe
    annotation (Placement(transformation(extent={{60,0},{80,20}}, rotation=0)));
  Volumes.VolumeA volumeA(dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
equation
  connect(refP.C2, refT.C1) annotation (Line(points={{-70,10},{-60,10}}, color=
          {0,0,255}));
  connect(refT.C2, pump.C1) annotation (Line(points={{-40,10},{-30,10}}, color=
          {0,0,255}));
  connect(constante.y, refP.IPressure) annotation (Line(points={{-79,70},{-60,
          70},{-60,34},{-80,34},{-80,21}}));
  connect(pump.C2, loopBreakerQ.C1)
    annotation (Line(points={{-10,10},{0,10}}, color={0,0,255}));
  connect(loopBreakerQ.C2, loopBreakerH.C1)
    annotation (Line(points={{20,10},{30,10}}, color={0,0,255}));
  connect(loopBreakerH.C2, lumpedStraightPipe.C1)
    annotation (Line(points={{50,10},{60,10}}, color={0,0,255}));
  connect(lumpedStraightPipe.C2, volumeA.Ce1) annotation (Line(points={{80,10},
          {100,10},{100,-20},{10,-20}}, color={0,0,0}));
  connect(volumeA.Cs1, refP.C1) annotation (Line(points={{-10,-20},{-100,-20},{
          -100,10},{-90,10}}, color={0,0,0}));
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
end TestRefP;
