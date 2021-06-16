within ThermoSysPro.MultiFluids.Machines;
model CHPEngineTriGenPredSystem
  parameter Modelica.SIunits.Temperature Tair=298 "Temperature inlet air";
  parameter Real RechFumEff=0.717833 "Flue gases heater efficiency";
  parameter Real RechWaterEff=0.837865 "Water heater efficiency";
  parameter Integer mechanical_efficiency_type=3 "Engine efficiency type"
                                                         annotation(choices(
    choice=1 "Fixed nominal efficiency",
    choice=2 "Efficiency computed using a linear function Coef_Rm",
    choice=3 "Efficiency computed using the Beau de Rochas Cycle"));
  parameter Real Rmeca_nom=0.40 "Engine nominal efficiency";

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_water(
    P0=3e5,
    Q0=12.2,
    h0=205e3)
          annotation (Placement(transformation(extent={{62,-42},{40,-20}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PDC1(L=0.0001)
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Sink_water
    annotation (Placement(transformation(extent={{-22,-72},{-44,-48}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PDC2(L=0.0001)
    annotation (Placement(transformation(
        origin={-80,-10},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.FlueGases.PressureLosses.SingularPressureLoss silencieux(
                                                                   K=20)
           annotation (Placement(transformation(
        origin={-39,16},
        extent={{10,-9},{-10,9}},
        rotation=270)));
  ThermoSysPro.Combustion.BoundaryConditions.FuelSourcePQ Fuel(
    rho=500,
    Hum=0,
    Xh=0.25,
    Xs=0,
    Xashes=0,
    Vol=100,
    T0=298,
    Xc=0.75,
    Xo=0,
    Xn=0,
    LHV=47.5e6,
    Q0=0.156042)
             annotation (Placement(transformation(extent={{62,-18},{40,4}},
          rotation=0)));
  ThermoSysPro.MultiFluids.Machines.AlternatingEngine Engine(
    DPe=1,
    MMg=20,
    Xref=0.3166,
    Xpth=0,
    RV=6.45,
    Kc=1.28,
    Kd=1.33,
    Tsf(fixed=false, start=657),
    exc(fixed=false, start=1.8),
    mechanical_efficiency_type=mechanical_efficiency_type,
    Rmeca_nom=Rmeca_nom) annotation (Placement(transformation(
        origin={0,0},
        extent={{-24,-24},{24,24}},
        rotation=90)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff
    ExchangerWaterWater(
    DPc(start=0.1),
    DPf(start=0.1),
    W(fixed=false, start=463.4e3),
    EffEch=RechWaterEff,
    exchanger_type=3)
               annotation (Placement(transformation(
        origin={0,-66},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.MultiFluids.HeatExchangers.StaticExchangerWaterSteamFlueGases
    ExchangerWaterFlueGases(W(fixed=false, start=1195.9e3), EffEch=RechFumEff)
             annotation (Placement(transformation(
        origin={0,68},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkG puits_fumees
    annotation (Placement(transformation(extent={{58,56},{82,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Pression(
                                       k=1e5)
    annotation (Placement(transformation(extent={{120,60},{100,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit_air(
                                        k(fixed=false) = 50)
    annotation (Placement(transformation(extent={{20,30},{40,50}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceG Air(
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Xso2=0) annotation (Placement(transformation(extent={{72,8},{48,32}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Temperature(
                                          k=Tair)
    annotation (Placement(transformation(extent={{100,0},{80,20}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI outletWaterSteamI
    annotation (Placement(transformation(extent={{180,80},{220,120}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI inletWaterSteamI
    annotation (Placement(transformation(extent={{-220,80},{-180,120}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit_eau(
                                                k=12.2)
                      annotation (Placement(transformation(extent={{96,-28},{80,
            -12}}, rotation=0)));
equation
  connect(Sink_water.C, ExchangerWaterWater.Sc)
    annotation (Line(points={{-22,-60},{-12.08,-60},{-12.08,-60.4},{-5.74,-60.4}}));
  connect(ExchangerWaterWater.Ec, PDC1.C2)
    annotation (Line(points={{-5.74,-71.6},{-60,-71.6},{-60,-20}}));
  connect(PDC2.C1, ExchangerWaterWater.Sf)
    annotation (Line(points={{-80,-20},{-80,-40},{-0.14,-40},{-0.14,-52}}));
  connect(Debit_air.y, Air.IMassFlow)
    annotation (Line(points={{41,40},{60,40},{60,26}}));
  connect(Air.ITemperature, Temperature.y)
    annotation (Line(points={{60,14},{60,10},{79,10}}));
  connect(ExchangerWaterWater.Ef, inletWaterSteamI)
                                     annotation (Line(points={{9.19104e-016,-80},
          {0,-80},{0,-100},{-140,-100},{-140,100},{-200,100}}));
  connect(Debit_eau.y, Source_water.IMassFlow)
    annotation (Line(points={{79.2,-20},{51,-20},{51,-25.5}}));
  connect(puits_fumees.IPressure, Pression.y)
    annotation (Line(points={{76,68},{90,68},{90,70},{99,70}}));
  connect(silencieux.C2, ExchangerWaterFlueGases.Cfg1) annotation (Line(
      points={{-39,26},{-39,68},{-12.6,68}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cfg2, puits_fumees.C) annotation (Line(
      points={{12.6,67.93},{36.3,67.93},{36.3,68},{58.24,68}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cws2, outletWaterSteamI) annotation (Line(
        points={{2.63361e-015,82},{2.63361e-015,100},{200,100}}, color={0,0,255}));
  connect(PDC2.C2, ExchangerWaterFlueGases.Cws1) annotation (Line(points={{-80,
          0},{-80,40},{9.19104e-016,40},{9.19104e-016,54}}, color={0,0,255}));
  connect(PDC1.C1, Engine.Cws2)
    annotation (Line(points={{-60,0},{-60,32},{1.32262e-015,32},{1.32262e-015,
          21.6}}));
  connect(Engine.Cair, Air.C) annotation (Line(
      points={{21.6,9.6},{34,9.6},{34,20},{48,20}},
      color={0,0,0},
      thickness=1));
  connect(Engine.Cws1, Source_water.C)
    annotation (Line(points={{-1.32262e-015,-21.6},{-1.32262e-015,-31},{40,-31}}));
  connect(silencieux.C1, Engine.Cfg) annotation (Line(
      points={{-39,6},{-40,6},{-40,1.32262e-015},{-21.6,1.32262e-015}},
      color={0,0,0},
      thickness=1));
  connect(Engine.Cfuel, Fuel.C) annotation (Line(points={{21.6,-9.6},{32,-9.6},
          {32,-7},{40,-7}}, color={0,0,0}));
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
          extent={{-180,-2},{-20,-162}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-110,-146},{-96,-128},{-100,-138},{-82,-136},{-98,-142},{-78,
              -148},{-94,-146},{-110,-158},{-102,-148},{-110,-146}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-146,-124},{-146,-82},{-106,-82},{-106,-24},{-100,-32},{-94,
              -24},{-94,-82},{-52,-82},{-52,-124},{-146,-124}},
          lineColor={0,0,0},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-180,-52},{-134,-52},{-134,-28},{-62,-28},{-62,-52},{-20,-52},
              {-20,-44},{-54,-44},{-54,-20},{-142,-20},{-142,-44},{-180,-44},{
              -180,-52}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,140},{180,38}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{50,142},{146,74}},
          lineColor={0,0,255},
          textString=
               "E"),
        Rectangle(
          extent={{-180,140},{-20,38}},
          lineColor={0,0,255},
          fillColor={72,143,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-160,38},{-160,116},{-100,72},{-100,72},{-100,72}},
          color={255,0,0},
          thickness=1),
        Text(
          extent={{-148,146},{-52,78}},
          lineColor={0,0,255},
          textString=
               "E"),
        Line(
          points={{38,38},{38,116},{98,72},{158,120},{158,38}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-20,98},{20,98}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-160,-2},{-160,38}},
          color={255,0,0},
          thickness=1),
        Line(
          points={{-40,-2},{-40,38}},
          color={0,0,255},
          thickness=1),
        Polygon(
          points={{-20,-52},{26,-52},{26,-52},{38,-52},{38,-52},{44,-52},{44,38},
              {36,38},{36,-44},{18,-44},{18,-44},{-20,-44},{-20,-52}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,38},{-40,116},{-100,72},{-100,72},{-100,72}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{40,38},{40,116},{100,72},{160,120},{160,38}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{42,38},{42,116},{102,72},{162,120},{162,38}},
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
end CHPEngineTriGenPredSystem;
