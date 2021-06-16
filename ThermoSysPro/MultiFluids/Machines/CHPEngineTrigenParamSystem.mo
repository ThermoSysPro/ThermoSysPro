within ThermoSysPro.MultiFluids.Machines;
model CHPEngineTrigenParamSystem
  parameter Modelica.SIunits.Temperature Tair=298 "Temperature inlet air";
  parameter Real RechFumEff=0.725576 "Flue gases heater efficiency";
  parameter Real RechWaterEff=0.910767 "Water heater efficiency";
  parameter Integer mechanical_efficiency_type=3 "Engine efficiency type"
                                                         annotation(choices(
    choice=1 "Fixed nominal efficiency",
    choice=2 "Efficiency computed using a linear function Coef_Rm",
    choice=3 "Efficiency computed using the Beau de Rochas Cycle"));
  parameter Real Rmeca_nom=0.40 "Engine nominal efficiency ";

  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ Source_water(
    P0=3e5,
    Q0=12.2,
    h0=215e3)
          annotation (Placement(transformation(extent={{62,-42},{40,-20}},
          rotation=0)));
  WaterSteam.PressureLosses.LumpedStraightPipe PDC1(  L=0.0001)
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  WaterSteam.BoundaryConditions.SinkPQ Sink_water
    annotation (Placement(transformation(extent={{-18,-72},{-40,-48}}, rotation=
           0)));
  WaterSteam.PressureLosses.LumpedStraightPipe PDC2(  L=0.0001)
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
             annotation (Placement(transformation(extent={{62,-20},{40,2}},
          rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.StaticExchangerWaterSteamFlueGases
    ExchangerWaterFlueGases(
    W(fixed=false, start=1195.9e3),
    EffEch=RechFumEff)
             annotation (Placement(transformation(
        origin={0,68},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff
    ExchangerWaterWater(
    DPc(start=0.1),
    DPf(start=0.1),
    W(fixed=false, start=463.4e3),
    Tsf(fixed=false, start=364.186),
    exchanger_type=3,
    EffEch=RechWaterEff)
               annotation (Placement(transformation(
        origin={0,-66},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.MultiFluids.Machines.AlternatingEngine Engine(
    MMg=20,
    Xref=0.3166,
    Xpth=0,
    RV=6.45,
    Kc=1.28,
    Kd=1.33,
    Tsf(fixed=false, start=657),
    exc(fixed=false, start=1.8),
    DPe=1,
    mechanical_efficiency_type=mechanical_efficiency_type,
    Rmeca_nom=Rmeca_nom) annotation (Placement(transformation(
        origin={0,0},
        extent={{-24,-24},{24,24}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit_eau(
                                                k=12.2)
                      annotation (Placement(transformation(extent={{96,-28},{80,
            -12}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SinkG M_puits_fumees
    annotation (Placement(transformation(extent={{38,56},{62,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Pression(
                                       k=1e5)
    annotation (Placement(transformation(extent={{100,58},{80,78}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit_air(
                                                k=50)
    annotation (Placement(transformation(extent={{20,30},{40,50}}, rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.SourceG Air(
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Xso2=0) annotation (Placement(transformation(extent={{64,8},{40,32}},
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
equation
  connect(ExchangerWaterWater.Ef, inletWaterSteamI)
                                         annotation (Line(points={{9.19104e-016,
          -80},{9.19104e-016,-100},{-140,-100},{-140,100},{-200,100}}));
  connect(Sink_water.C, ExchangerWaterWater.Sc)
                                       annotation (Line(points={{-18,-60},{
          -14.08,-60},{-14.08,-60.4},{-5.74,-60.4}}));
  connect(PDC1.C2, ExchangerWaterWater.Ec)
                                   annotation (Line(points={{-60,-20},{-60,
          -71.6},{-5.74,-71.6}}, color={0,0,255}));
  connect(PDC2.C1, ExchangerWaterWater.Sf)
                                   annotation (Line(points={{-80,-20},{-80,-40},
          {-0.14,-40},{-0.14,-52}}));
  connect(Debit_air.y, Air.IMassFlow)
    annotation (Line(points={{41,40},{52,40},{52,26}}));
  connect(Air.ITemperature, Temperature.y)
    annotation (Line(points={{52,14},{52,10},{79,10}}));
  connect(M_puits_fumees.IPressure, Pression.y)
    annotation (Line(points={{56,68},{68,68},{68,68},{79,68}}));
  connect(Source_water.IMassFlow, Debit_eau.y)
    annotation (Line(points={{51,-25.5},{51,-20},{79.2,-20}}));
  connect(silencieux.C2, ExchangerWaterFlueGases.Cfg1) annotation (Line(
      points={{-39,26},{-40,26},{-40,68},{-12.6,68}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cfg2, M_puits_fumees.C) annotation (Line(
      points={{12.6,67.93},{26.3,67.93},{26.3,68},{38.24,68}},
      color={0,0,0},
      thickness=1));
  connect(ExchangerWaterFlueGases.Cws2, outletWaterSteamI) annotation (Line(
        points={{2.63361e-015,82},{0,82},{0,100},{200,100}}, color={0,0,255}));
  connect(PDC2.C2, ExchangerWaterFlueGases.Cws1) annotation (Line(points={{-80,
          0},{-80,40},{9.19104e-016,40},{9.19104e-016,54}}, color={0,0,255}));
  connect(Engine.Cair, Air.C) annotation (Line(
      points={{21.6,9.6},{30,9.6},{30,20},{40,20}},
      color={0,0,0},
      thickness=1));
  connect(Engine.Cws1, Source_water.C)
    annotation (Line(points={{-1.32262e-015,-21.6},{-1.32262e-015,-31},{40,-31}}));
  connect(silencieux.C1, Engine.Cfg) annotation (Line(
      points={{-39,6},{-40,6},{-40,1.32262e-015},{-21.6,1.32262e-015}},
      color={0,0,0},
      thickness=1));
  connect(PDC1.C1, Engine.Cws2)
    annotation (Line(points={{-60,0},{-60,30},{1.32262e-015,30},{1.32262e-015,
          21.6}}));
  connect(Engine.Cfuel, Fuel.C) annotation (Line(points={{21.6,-9.6},{30.8,-9.6},
          {30.8,-9},{40,-9}}, color={0,0,0}));
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
end CHPEngineTrigenParamSystem;
