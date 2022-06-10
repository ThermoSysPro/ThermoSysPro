within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDynamicTwoPhaseFlowPipe

  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowPipe
    dynamicTwoPhaseFlowPipe(L=20, advection=false,
    Q(start={378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421,378.2555714391421,
          378.2555714391421,378.2555714391421}),
    h(start={71016.12237181116,89522.1287033792,108028.13503495205,
          126534.14136650086,145040.14769798872,163546.15402957145,
          182052.16036112772,200558.16669267463,219064.17302421754,
          237570.17935577242,256076.18568728055,70825.9016030344}),
    dynamic_energy_balance=false,
    diffusion=true,
    P(start={300000,281934.94102069,263857.29519348,245762.87920492,
          227647.89301968,209508.84324089,191342.485106,173145.77779074,
          154915.84935981,136649.96881108,118345.52340716,100000}))
                            annotation (Placement(transformation(extent={{-10,30},
            {10,50}},    rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP              sourceP
    annotation (Placement(transformation(extent={{-50,30},{-30,50}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP              sinkP
    annotation (Placement(transformation(extent={{30,30},{50,50}}, rotation=0)));
  Thermal.BoundaryConditions.HeatSource              heatSource(
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    option_temperature=2,
    W0={7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6,7e6})
    annotation (Placement(transformation(extent={{-10,70},{10,90}},rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall              heatExchangerWall(Ns=10,
      dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-10,50},{10,70}},rotation=0)));
  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowPipe dynamicTwoPhaseFlowPipe1(
    L=10,
    D=0.03,
    dpfCorr(fixed=false,
      start=0.23963336533422905)=
                           1,
    inertia=true,
    P(start={2000000,1999571.7070274,1999140.9402168,1998707.6248919,
          1998271.6837223,1997833.0364983,1997391.5998908,1996715.822109,
          1995640.0182728,1994163.0145856,1992283.4952231,1990000}))
                            annotation (Placement(transformation(extent={{-40,-90},
            {40,-32}},     rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    C(Q(fixed=true, start=1)),
    option_temperature=false,
    h0=800e3,
    P0=2000000)
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}},rotation=
            0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP sinkP1(
    option_temperature=false,
    h0=2000e3,
    P0=1990000)
    annotation (Placement(transformation(extent={{70,-70},{90,-50}},rotation=0)));
  Thermal.BoundaryConditions.HeatSource heatSource1(
    option_temperature=2,
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    W0={2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4})
    annotation (Placement(transformation(extent={{-10,-11},{10,9}}, rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall1(            Ns=10,
    L=10,
    lambda=10,
    cpw=460,
    rhow=7900,
    e=0.005,
    D=0.03)
    annotation (Placement(transformation(extent={{-40,-70},{40,10}},rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Initialvalue=20e5,
    Starttime=300,
    Duration=600,
    Finalvalue=19.8e5)
                     annotation (Placement(transformation(extent={{-74,-46},{-86,
            -35}},
                 rotation=0)));
equation
  connect(sourceP.C,dynamicTwoPhaseFlowPipe. C1) annotation (Line(points={{-30,40},
          {-10,40}},     color={0,0,255}));
  connect(dynamicTwoPhaseFlowPipe.C2,sinkP. C) annotation (Line(points={{10,40},
          {30,40}}, color={0,0,255}));
  connect(heatSource.C,heatExchangerWall. WT2) annotation (Line(points={{0,70.2},
          {0,62}},         color={191,95,0}));
  connect(heatExchangerWall.WT1,dynamicTwoPhaseFlowPipe. CTh)
    annotation (Line(points={{0,58},{0,43}},     color={191,95,0}));
  connect(sourceP1.C,dynamicTwoPhaseFlowPipe1. C1) annotation (Line(points={{-70,-60},
          {-42,-60},{-42,-61},{-40,-61}},                              color={0,
          0,255}));
  connect(dynamicTwoPhaseFlowPipe1.C2,sinkP1. C) annotation (Line(points={{40,-61},
          {40,-60},{70,-60}},               color={0,0,255}));
  connect(heatSource1.C,heatExchangerWall1. WT2)
    annotation (Line(points={{0,-10.8},{0,-22}},         color={191,95,0}));
  connect(heatExchangerWall1.WT1,dynamicTwoPhaseFlowPipe1. CTh)
    annotation (Line(points={{0,-38},{0,-52.3}}, color={191,95,0}));
  connect(rampe.y,sourceP1. IPressure)
    annotation (Line(points={{-86.6,-40.5},{-92,-40.5},{-92,-60},{-85,-60}}));
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestDynamicTwoPhaseFlowPipe;
