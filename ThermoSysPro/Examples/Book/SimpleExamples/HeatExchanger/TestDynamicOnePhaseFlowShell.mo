within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger;
model TestDynamicOnePhaseFlowShell

  WaterSteam.HeatExchangers.DynamicOnePhaseFlowShell
    dynamicOnePhaseFlowPipeShell(
    Q(start={30,30,30,30,30,30,30,30,30,30,30}),
    Ds=1,
    ntubes=520,
    L=12,
    P(start={2000000,1996000,1993000,1990000,1986000,1983000,1980000,1976000,
          1973000,1965000,1955000,1950000})) annotation (Placement(
        transformation(extent={{-48,-36},{48,36}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sinkP(option_temperature=2, P0(fixed=
         false) = 1900000)
                 annotation (Placement(transformation(extent={{74,-15},{102,15}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    h0=600e3,
    Q(start=500, fixed=true),
    P0=2000000)
             annotation (Placement(transformation(extent={{-103,-15},{-75,15}},
          rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(
    lambda=10,
    Ns=10,
    cpw=460,
    rhow=7900,
    D=0.017,
    e=0.002,
    ntubes=520,
    L=12) annotation (Placement(transformation(extent={{-54,30},{54,58}},
          rotation=0)));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource heatSource(
    option_temperature=2,
    W0={-2e6,-2e6,-2e6,-2e6,-2e6,-2e6,-2e6,-2e6,-2e6,-2e6},
    T0={300,300,300,300,300,300,300,300,300,300})
                  annotation (Placement(transformation(extent={{-12,76},{12,98}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Initialvalue=20e5,
    Starttime=300,
    Duration=600,
    Finalvalue=19.8e5)
                     annotation (Placement(transformation(extent={{-100,32},{
            -80,52}}, rotation=0)));
equation
  connect(sourceP.C, dynamicOnePhaseFlowPipeShell.C1)
    annotation (Line(points={{-75,0},{-48,0}}, color={0,0,255}));
  connect(dynamicOnePhaseFlowPipeShell.C2, sinkP.C)
    annotation (Line(points={{48,0},{74,0}}, color={0,0,255}));
  connect(heatExchangerWall.WT1, dynamicOnePhaseFlowPipeShell.CTh)
    annotation (Line(points={{0,41.2},{0,10.8}}, color={191,95,0}));
  connect(heatSource.C, heatExchangerWall.WT2) annotation (Line(points={{0,
          76.22},{0,46.8}}, color={191,95,0}));
  connect(rampe.y, sourceP.IPressure)
    annotation (Line(points={{-79,42},{-70,42},{-70,24},{-98,24},{-98,0},{-96,0}}));
  annotation (Icon(graphics={
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
<p>This model is documented in Sect. 9.4.3.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"),
    experiment(StopTime=2000));
end TestDynamicOnePhaseFlowShell;
