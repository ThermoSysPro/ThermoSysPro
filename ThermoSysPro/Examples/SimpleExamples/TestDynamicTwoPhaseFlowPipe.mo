within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicTwoPhaseFlowPipe

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe
    dynamicTwoPhaseFlowPipe(L=20, advection=false,
    P(start={300000.0,281934.9410206863,263857.2951934783,245762.87920491621,
          227647.89301968267,209508.84324088524,191342.48510599748,
          173145.77779073696,154915.84935981245,136649.96881108306,
          118345.52340716157,100000.0}),
    Q(start={378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421}),
    h(start={71016.12237181116,89522.1287033792,108028.13503495205,
          126534.14136650086,145040.14769798872,163546.15402957145,
          182052.16036112772,200558.16669267463,219064.17302421754,
          237570.17935577242,256076.18568728055,70825.9016030344}))
                            annotation (Placement(transformation(extent={{-10,20},
            {10,40}},    rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP
    annotation (Placement(transformation(extent={{-50,20},{-30,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP
    annotation (Placement(transformation(extent={{30,20},{50,40}}, rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    option_temperature=2,
    W0={7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6})
    annotation (Placement(transformation(extent={{-10,60},{10,80}},rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(Ns=10)
    annotation (Placement(transformation(extent={{-10,40},{10,60}},rotation=0)));
  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe dynamicTwoPhaseFlowPipe1(
    L=10,
    D=0.03,
    dpfCorr(fixed=false,
      start=0.23963336533422905)=
                           1,
    P(start={2000000.0,1999571.707027408,1999140.94021676,1998707.6248918818,
          1998271.6837222823,1997833.0364982954,1997391.599890757,
          1996715.8221090273,1995640.018272837,1994163.014585635,
          1992283.4952231126,1990000.0}))
                            annotation (Placement(transformation(extent={{-40,-94},
            {40,-36}},     rotation=0)));
  WaterSteam.BoundaryConditions.SourceP sourceP1(
    C(Q(fixed=true, start=1)),
    option_temperature=2,
    mode=0,
    h0=800e3,
    P0=2000000)
    annotation (Placement(transformation(extent={{-90,-74},{-70,-54}},rotation=
            0)));
  WaterSteam.BoundaryConditions.SinkP sinkP1(
    option_temperature=2,
    h0=2000e3,
    mode=0,
    P0=19.9e5)
    annotation (Placement(transformation(extent={{70,-74},{90,-54}},rotation=0)));
  Thermal.BoundaryConditions.HeatSource heatSource1(
    option_temperature=2,
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    W0={2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4})
    annotation (Placement(transformation(extent={{-10,-15},{10,5}}, rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall1(            Ns=10,
    L=10,
    lambda=10,
    cpw=460,
    rhow=7900,
    e=0.005,
    D=0.03)
    annotation (Placement(transformation(extent={{-40,-74},{40,6}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Initialvalue=20e5,
    Starttime=300,
    Duration=600,
    Finalvalue=19.8e5)
                     annotation (Placement(transformation(extent={{-74,-50},{
            -86,-39}},
                 rotation=0)));
equation
  connect(sourceP.C,dynamicTwoPhaseFlowPipe. C1) annotation (Line(points={{-30,30},
          {-10,30}},     color={0,0,255}));
  connect(dynamicTwoPhaseFlowPipe.C2, sinkP.C) annotation (Line(points={{10,30},
          {30,30}}, color={0,0,255}));
  connect(heatSource.C, heatExchangerWall.WT2) annotation (Line(points={{0,60.2},
          {0,52}},         color={191,95,0}));
  connect(heatExchangerWall.WT1, dynamicTwoPhaseFlowPipe.CTh)
    annotation (Line(points={{0,48},{0,33}},     color={191,95,0}));
  connect(sourceP1.C, dynamicTwoPhaseFlowPipe1.C1) annotation (Line(points={{
          -70,-64},{-42,-64},{-42,-68},{-42,-66},{-42,-65},{-40,-65}}, color={0,
          0,255}));
  connect(dynamicTwoPhaseFlowPipe1.C2, sinkP1.C) annotation (Line(points={{40,
          -65},{40,-65},{40,-64},{70,-64}}, color={0,0,255}));
  connect(heatSource1.C, heatExchangerWall1.WT2)
    annotation (Line(points={{0,-14.8},{0,-28},{0,-26}}, color={191,95,0}));
  connect(heatExchangerWall1.WT1, dynamicTwoPhaseFlowPipe1.CTh)
    annotation (Line(points={{0,-42},{0,-56.3}}, color={191,95,0}));
  connect(rampe.y, sourceP1.IPressure)
    annotation (Line(points={{-86.6,-44.5},{-92,-44.5},{-92,-64},{-85,-64}}));
  annotation (experiment(StopTime=1000), Icon(graphics={
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
end TestDynamicTwoPhaseFlowPipe;
