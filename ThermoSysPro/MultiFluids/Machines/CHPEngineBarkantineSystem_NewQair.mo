within ThermoSysPro.MultiFluids.Machines;
model CHPEngineBarkantineSystem_NewQair
  parameter Modelica.SIunits.Temperature Tair=300 "Temperature inlet air";
  parameter Real RechFumEff=0.73 "Flue gases heater efficiency";
  parameter Real RechWaterEff=0.9 "Water heater efficiency";
  parameter Integer mechanical_efficiency_type=3 "Engine efficiency type"
                                                         annotation(choices(
    choice=1 "Fixed nominal efficiency",
    choice=2 "Efficiency computed using a linear function Coef_Rm",
    choice=3 "Efficiency computed using the Beau de Rochas Cycle"));
  parameter Real Rmeca_nom=0.40 "Engine nominal efficiency";

  ThermoSysPro.Combustion.BoundaryConditions.FuelSourcePQ Fuel(
    Hum=0,
    Xh=0.25,
    Xs=0,
    Xashes=0,
    Vol=100,
    Xc=0.75,
    Xo=0,
    Xn=0,
    T0=299,
    P0=2.25e5,
    rho=0.72,
    LHV=48e6,
    Q0=0.0727958)
             annotation (Placement(transformation(extent={{62,-26},{38,-2}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_water(
    P0=3e5,
    h0=293e3,
    Q0=11.8)
          annotation (Placement(transformation(extent={{62,-46},{40,-24}},
          rotation=0)));
  ThermoSysPro.MultiFluids.Machines.AlternatingEngine Engine(
    DPe=1,
    MMg=20,
    Kd=1.33,
    Wcomb(fixed=false, start=3.4942e6),
    exc(fixed=false, start=1.8),
    RV=6.45,
    Kc=1.28,
    Xpth=0.01,
    Xref=0.2896,
    Tsf(fixed=false, start=815),
    Wmeca(fixed=false, start=1400e3),
    mechanical_efficiency_type=mechanical_efficiency_type,
    Rmeca_nom=Rmeca_nom) annotation (Placement(transformation(
        origin={0,0},
        extent={{-24,-24},{24,24}},
        rotation=90)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff
    ExchangerWaterWater(
    EffEch=RechWaterEff, exchanger_type=3)
               annotation (Placement(transformation(
        origin={0,-66},
        extent={{14,-14},{-14,14}},
        rotation=270)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PDC1(L=0.0001)
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink M1_puits_eau
    annotation (Placement(transformation(extent={{-20,-72},{-42,-48}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PDC2(L=0.0001)
    annotation (Placement(transformation(
        origin={-80,-10},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.MultiFluids.HeatExchangers.StaticExchangerWaterSteamFlueGases
    ExchangerWaterFlueGases(Tsf(fixed=false, start=363), EffEch=RechFumEff)
             annotation (Placement(transformation(
        origin={0,70},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss silencieux(
                                                                   K=20)
           annotation (Placement(transformation(
        origin={-39,16},
        extent={{10,-9},{-10,9}},
        rotation=270)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI outletWaterSteamI
    annotation (Placement(transformation(extent={{180,80},{220,120}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI inletWaterSteamI
    annotation (Placement(transformation(extent={{-220,80},{-180,120}},
          rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkG M_puits_fumees
    annotation (Placement(transformation(extent={{58,58},{82,82}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Pression(
                                       k=1e5)
    annotation (Placement(transformation(extent={{120,60},{100,80}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceG M_Air(
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Xso2=0) annotation (Placement(transformation(extent={{64,2},{40,26}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Temperature(
                                          k=Tair)
    annotation (Placement(transformation(extent={{100,-10},{80,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante DebitAir(k=3)
    annotation (Placement(transformation(extent={{22,30},{42,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit_eau(
                                   k=11.8)
                      annotation (Placement(transformation(extent={{96,-34},{80,
            -18}}, rotation=0)));
equation
  connect(ExchangerWaterWater.Ef, inletWaterSteamI)
    annotation (Line(points={{-9.19104e-016,-80},{0,-80},{0,-100},{-140,-100},{
          -140,100},{-200,100}}));
  connect(M1_puits_eau.C, ExchangerWaterWater.Sc)
    annotation (Line(points={{-20,-60},{-13.04,-60},{-13.04,-60.4},{5.74,-60.4}}));
  connect(PDC2.C1, ExchangerWaterWater.Sf)
    annotation (Line(points={{-80,-20},{-80,-40},{0.14,-40},{0.14,-52}}));
  connect(PDC1.C2, ExchangerWaterWater.Ec)
                                   annotation (Line(points={{-60,-20},{-60,
          -71.6},{5.74,-71.6}},  color={0,0,255}));
  connect(Pression.y, M_puits_fumees.IPressure)
    annotation (Line(points={{99,70},{76,70}}));
  connect(DebitAir.y, M_Air.IMassFlow)
    annotation (Line(points={{43,40},{52,40},{52,20}}));
  connect(M_Air.ITemperature, Temperature.y)
    annotation (Line(points={{52,8},{52,0},{79,0}}));
  connect(Source_water.IMassFlow, Debit_eau.y)
    annotation (Line(points={{51,-29.5},{51,-26},{79.2,-26}}));
  connect(silencieux.C2, ExchangerWaterFlueGases.Cfg1) annotation (Line(
      points={{-39,26},{-39,70},{-12.6,70}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cfg2, M_puits_fumees.C) annotation (Line(
      points={{12.6,69.93},{35.3,69.93},{35.3,70},{58.24,70}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cws2, outletWaterSteamI) annotation (Line(
        points={{-7.95401e-016,84},{0,84},{0,100},{200,100}}, color={0,0,255}));
  connect(PDC2.C2, ExchangerWaterFlueGases.Cws1) annotation (Line(points={{-80,
          0},{-80,48},{4.34812e-015,48},{4.34812e-015,56}}, color={0,0,255}));
  connect(silencieux.C1, Engine.Cfg) annotation (Line(
      points={{-39,6},{-40,6},{-40,1.32262e-015},{-21.6,1.32262e-015}},
      color={0,0,0},
      thickness=1));
  connect(Engine.Cws1, Source_water.C)
    annotation (Line(points={{-1.32262e-015,-21.6},{-1.32262e-015,-35},{40,-35}}));
  connect(Engine.Cair, M_Air.C) annotation (Line(
      points={{21.6,9.6},{32,9.6},{32,14},{40,14}},
      color={0,0,0},
      thickness=1));
  connect(PDC1.C1, Engine.Cws2)
    annotation (Line(points={{-60,0},{-60,32},{1.32262e-015,32},{1.32262e-015,
          21.6}}));
  connect(Engine.Cfuel, Fuel.C) annotation (Line(points={{21.6,-9.6},{32,-9.6},
          {32,-14},{38,-14}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(
          extent={{-180,0},{-20,-160}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-110,-144},{-96,-126},{-100,-136},{-82,-134},{-98,-140},{-78,
              -146},{-94,-144},{-110,-156},{-102,-146},{-110,-144}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-146,-122},{-146,-80},{-106,-80},{-106,-22},{-100,-30},{-94,
              -22},{-94,-80},{-52,-80},{-52,-122},{-146,-122}},
          lineColor={0,0,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-180,-50},{-134,-50},{-134,-26},{-62,-26},{-62,-50},{-20,-50},
              {-20,-42},{-54,-42},{-54,-18},{-142,-18},{-142,-42},{-180,-42},{
              -180,-50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,142},{180,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{50,144},{146,76}},
          lineColor={0,0,255},
          textString=
               "E"),
        Rectangle(
          extent={{-180,142},{-20,40}},
          lineColor={0,0,255},
          fillColor={72,143,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-160,40},{-160,118},{-100,74},{-100,74},{-100,74}},
          color={255,0,0},
          thickness=1),
        Text(
          extent={{-148,148},{-52,80}},
          lineColor={0,0,255},
          textString=
               "E"),
        Line(
          points={{38,40},{38,118},{98,74},{158,122},{158,40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,100},{20,100}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-160,0},{-160,40}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{-40,0},{-40,40}},
          color={0,0,255},
          thickness=1),
        Polygon(
          points={{-20,-50},{26,-50},{26,-50},{38,-50},{38,-50},{44,-50},{44,40},
              {36,40},{36,-42},{18,-42},{18,-42},{-20,-42},{-20,-50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,40},{-40,118},{-100,74},{-100,74},{-100,74}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{40,40},{40,118},{100,74},{160,122},{160,40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{42,40},{42,118},{102,74},{162,122},{162,40}},
          color={0,0,0},
          thickness=1)}),
    DymolaStoredErrors,
    Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Guillaume Larrignon</li>
<li>Bruno P&eacute;chin&eacute; </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</h4>
<p><b>ThermoSysPro Version 3.2</h4>
</html>"));
end CHPEngineBarkantineSystem_NewQair;
