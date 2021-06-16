within ThermoSysPro.MultiFluids.Boilers;
model BoilerSystem
  parameter Modelica.SIunits.Temperature Tair=300 "Source air temperature";
  parameter Modelica.SIunits.Temperature Tsf=423.16
    "Flue gases temperature at the outlet";
  parameter Modelica.SIunits.Power Wloss=1e5 "Thermal losses";

  ThermoSysPro.Combustion.BoundaryConditions.FuelSourcePQ Fuel(
    Xashes=0.011,
    rho=1000,
    T0=294.45,
    Hum=0.50,
    Xc=0.2479,
    Xh=0.0297,
    Xo=0.2088,
    Xn=0.0017,
    Xs=0.0003,
    LHV=1.5e7,
    Q0=0.0407331)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}}, rotation=
            0)));
  ThermoSysPro.MultiFluids.Boilers.FossilFuelBoiler Boiler(
    Qsf(start=45.8744, fixed=false),
    mode=1,
    Pee(fixed=false),
    Tf(fixed=false, start=1600),
    Qe(fixed=false, start=6),
    Pse(fixed=false, start=2e5),
    Hee(fixed=false, start=293.1e3),
    Hse(fixed=false, start=377e3),
    Tsf=Tsf,
    Tse(fixed=false, start=363.16),
    exc_air(fixed=false, start=10),
    Wloss=Wloss,
    Wboil(start=1600e3, fixed=false))
    annotation (Placement(transformation(
        origin={6,0},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI inletWaterSteamI
    annotation (Placement(transformation(extent={{-20,-108},{0,-88}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI outletWaterSteamI
    annotation (Placement(transformation(extent={{-20,90},{0,110}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkG SinkFlueGases
    annotation (Placement(transformation(extent={{-20,10},{-40,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante FlueGas_P(
                                        k=1e5)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Air_Q(
                                    k=1)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceG SourceAir(
    Xco2=0,
    Xh2o=0.01,
    Xo2=0.233) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Air_T(
                                    k=Tair)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}}, rotation=
           0)));
equation
  connect(FlueGas_P.y, SinkFlueGases.IPressure)
    annotation (Line(points={{-59,20},{-35,20}}));
  connect(SourceAir.IMassFlow, Air_Q.y)
    annotation (Line(points={{-30,-15},{-30,-10},{-59,-10}}));
  connect(Air_T.y, SourceAir.ITemperature)
    annotation (Line(points={{-59,-40},{-30,-40},{-30,-25}}));
  connect(outletWaterSteamI, Boiler.Cws2) annotation (Line(points={{-10,100},{
          -10,40},{18,40},{18,20}}, color={255,0,0}));
  connect(Boiler.Cws1, inletWaterSteamI)
    annotation (Line(points={{18,-20},{18,-60},{-10,-60},{-10,-98}}));
  connect(SinkFlueGases.C, Boiler.Cfg) annotation (Line(
      points={{-20.2,20},{-6.4,20}},
      color={0,0,0},
      thickness=1));
  connect(SourceAir.C, Boiler.Cair) annotation (Line(
      points={{-20,-20},{-6.4,-20}},
      color={0,0,0},
      thickness=1));
  connect(Boiler.Cfuel, Fuel.C) annotation (Line(points={{-10,9.79717e-016},{
          -16,9.79717e-016},{-16,0},{-20,0}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-100},{60,100}},
        initialScale=0.01), graphics),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-100},{60,100}},
        initialScale=0.01), graphics={
        Rectangle(
          extent={{-80,100},{60,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,80},{40,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,-46},{0,-50},{10,-38},{14,-24},{12,-10},{10,-2},{6,8},{2,
              18},{0,26},{-2,32},{-6,50},{-10,40},{-14,32},{-18,20},{-18,16},{
              -20,12},{-22,20},{-24,22},{-26,18},{-30,10},{-32,4},{-36,-4},{-38,
              -14},{-40,-24},{-40,-32},{-34,-40},{-30,-46},{-20,-52},{-12,-46}},
          lineColor={255,0,128},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-28},{-18,-24},{-14,-22},{-10,-22},{-6,-24},{-4,-26},{-2,
              -32},{-2,-36},{-4,-34},{-6,-30},{-8,-26},{-14,-26},{-16,-28},{-20,
              -32},{-22,-34},{-22,-34},{-20,-28}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end BoilerSystem;
