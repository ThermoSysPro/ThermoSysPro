within ThermoSysPro.Examples.Book.SimpleExamples.Volume;
model TestStaticDrum3

  ThermoSysPro.WaterSteam.Junctions.StaticDrum StaticDrumTh1
    annotation (Placement(transformation(extent={{-30,1},{20,51}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI1(K=1e-4)
    annotation (Placement(transformation(extent={{38,7},{58,27}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI2(K=1e-4)
    annotation (Placement(transformation(extent={{-58,-8},{-38,12}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ sinkQ(Q0=10)
    annotation (Placement(transformation(extent={{74,7},{94,27}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourcePQ(
    Q0=100,
    h0=1400e3,
    P0=10000000)
    annotation (Placement(transformation(extent={{-86,-8},{-66,12}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSink heatSource
                                    annotation (Placement(transformation(
        origin={-76,26},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossVALI3(K=1e-4)
    annotation (Placement(transformation(extent={{38,52},{58,72}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{74,52},{94,72}}, rotation=0)));
  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe dynamicTwoPhaseFlowPipe(
    z1=0,
    rugosrel=0.0001,
    D=0.05,
    ntubes=10,
    L=10,
    z2=10)           annotation (Placement(transformation(
        origin={-28.5,-45.5},
        extent={{13.5,11.5},{-13.5,-11.5}},
        rotation=270)));
  WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe(
    lambda(fixed=false) = 0.03,
    D=0.05,
    ntubes=10,
    L=10,
    z1=10,
    Q(fixed=true, start=30)) annotation (Placement(transformation(
        origin={20,-45},
        extent={{-14,-12},{14,12}},
        rotation=270)));
  WaterSteam.Volumes.VolumeA volumeA annotation (Placement(transformation(
          extent={{1,-72},{-9,-62}}, rotation=0)));
  Thermal.BoundaryConditions.HeatSource heatSource1(
    option_temperature=2,
    W0={2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6,2e6},
    T0={300,300,300,300,300,300,300,300,300,300})
    annotation (Placement(transformation(
        origin={-76,-45},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(singularPressureLossVALI2.C2, StaticDrumTh1.Ce_eco)
                                                          annotation (Line(
        points={{-38,2},{-15,2},{-15,2.5}}, color={0,0,255}));
  connect(singularPressureLossVALI1.C2, sinkQ.C)  annotation (Line(points={{58,
          17},{74,17}}, color={0,0,255}));
  connect(heatSource.C[1], StaticDrumTh1.Cth)
                                          annotation (Line(points={{-66.2,26},{
          -5,26}}, color={191,95,0}));
  connect(StaticDrumTh1.Cs_sur, singularPressureLossVALI3.C1)
                                                          annotation (Line(
        points={{4.5,49.5},{4.5,62},{38,62}}, color={0,0,255}));
  connect(singularPressureLossVALI3.C2, sink.C)
    annotation (Line(points={{58,62},{74,62}}, color={0,0,255}));
  connect(StaticDrumTh1.Cs_purg, singularPressureLossVALI1.C1) annotation (Line(
        points={{18.5,17.5},{38,17.5},{38,17}}, color={0,0,255}));
  connect(sourcePQ.C, singularPressureLossVALI2.C1)
    annotation (Line(points={{-66,2},{-58,2}}, color={0,0,255}));
  connect(dynamicTwoPhaseFlowPipe.C2, StaticDrumTh1.Ce_eva) annotation (Line(
        points={{-28.5,-32},{-28.5,-6},{-28.5,17.5}},
                                           color={0,0,255}));
  connect(StaticDrumTh1.Cs_eva, lumpedStraightPipe.C1) annotation (Line(points=
          {{5,2.5},{20,2.5},{20,-31}}, color={0,0,255}));
  connect(dynamicTwoPhaseFlowPipe.C1, volumeA.Cs1)
    annotation (Line(points={{-28.5,-59},{-28,-59},{-28,-67},{-9,-67}}));
  connect(lumpedStraightPipe.C2, volumeA.Ce1) annotation (Line(points={{20,-59},
          {20,-67},{1,-67}}, color={0,0,255}));
  connect(heatSource1.C, dynamicTwoPhaseFlowPipe.CTh) annotation (Line(points={{-66.2,
          -45},{-31.95,-45},{-31.95,-45.5}},
                                     color={191,95,0}));
  annotation (experiment(StopTime=20), Icon(graphics={
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
<p>This model is documented in Sect. 14.6.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestStaticDrum3;
