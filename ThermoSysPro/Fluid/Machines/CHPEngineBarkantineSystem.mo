within ThermoSysPro.Fluid.Machines;
model CHPEngineBarkantineSystem
  parameter Units.SI.Temperature Tair=300 "Inlet air temperature";
  parameter Real RechFumEff=0.73 "Flue gases heater efficiency";
  parameter Real RechWaterEff=0.9 "Water heater efficiency";
  parameter Integer mechanical_efficiency_type=3 "Engine efficiency type"
                                                         annotation(choices(
    choice=1 "Fixed nominal efficiency",
    choice=2 "Efficiency computed using a linear function Coef_Rm",
    choice=3 "Efficiency computed using the Beau de Rochas Cycle"));
  parameter Real Rmeca_nom=0.40 "Engine nominal efficiency";
  parameter Units.SI.Power Pnom=1.4e6 "Engine nominal power";

  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ FuelSource(
    Hum=0,
    Xh=0.25,
    Xs=0,
    Xashes=0,
    Xc=0.75,
    Xo=0,
    Xn=0,
    rho=0.72,
    LHV=48e6,
    Q0=0.0727958,
    P0=225000,
    T0=299,
    Vol=1)  annotation (Placement(transformation(extent={{62,-26},{38,-2}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ WaterSource(
    h0=293e3,
    Q0=11.8,
    P0=300000) annotation (Placement(transformation(extent={{62,-46},{40,-24}},
          rotation=0)));
  ThermoSysPro.Fluid.Machines.InternalCombustionEngine Engine(
    DPe=1,
    MMg=20,
    Kd=1.33,
    Wcomb(fixed=false, start=3.4942e6),
    exc(fixed=false, start=1.8),
    RV=6.45,
    Kc=1.28,
    Xpth=0.01,
    Xref=0.2896,
    Wmeca(fixed=false, start=1400e3),
    mechanical_efficiency_type=mechanical_efficiency_type,
    Rmeca_nom=Rmeca_nom,
    Tsf(fixed=false, start=815)) annotation (Placement(transformation(
        origin={0,0},
        extent={{-24,-24},{24,24}},
        rotation=90)));
  ThermoSysPro.Fluid.HeatExchangers.StaticExchangerDTorWorEff
    ExchangerWaterWater(
    EffEch=RechWaterEff, exchanger_type=3,
    Kf=50)     annotation (Placement(transformation(
        origin={0,-66},
        extent={{14,14},{-14,-14}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PDC1(L=0.0001)
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink WaterSteamSink annotation (
      Placement(transformation(extent={{-22,-72},{-44,-48}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PDC2(L=0.0001)
    annotation (Placement(transformation(
        origin={-80,-10},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.HeatExchangers.StaticExchangerDTorWorEff
    ExchangerWaterFlueGases(                             EffEch=RechFumEff,
    exchanger_type=3,
    Kf=50,
    DTfroid=283.15,
    Tsf(fixed=false, start=363))
             annotation (Placement(transformation(
        origin={0,68},
        extent={{-14,-14},{14,14}},
        rotation=90)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss silencieux(K=20)
           annotation (Placement(transformation(
        origin={-39,16},
        extent={{10,-9},{-10,9}},
        rotation=270)));
  Interfaces.Connectors.FluidOutlet outletWaterSteam annotation (Placement(
        transformation(extent={{180,80},{220,120}}, rotation=0)));
  Interfaces.Connectors.FluidInlet inletWaterSteam annotation (Placement(
        transformation(extent={{-220,80},{-180,120}}, rotation=0)));
  BoundaryConditions.Sink FlueGasesSink annotation (Placement(transformation(
          extent={{-56,86},{-80,110}}, rotation=0)));
  BoundaryConditions.SourcePQ AirSource(
    Xco2=0,
    Xh2o=0.005,
    Xo2=0.23,
    Xso2=0,
    h0=40000,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    option_temperature=true,
    P0=160000)
    annotation (Placement(transformation(extent={{64,2},{40,26}}, rotation=0)));

  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante AirTemperature(k=Tair)
    "Air temperature" annotation (Placement(transformation(extent={{100,-10},{80,
            10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante AirMassFlowRate(k=3)
    "Air mass flow rate" annotation (Placement(transformation(extent={{20,30},{40,
            50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante WaterMassFlowRate(k=11.8)
    annotation (Placement(transformation(extent={{96,-34},{80,-18}}, rotation=0)));
equation
  connect(ExchangerWaterWater.Ef, inletWaterSteam) annotation (Line(points={{-9.19104e-016,
          -80},{0,-80},{0,-100},{-140,-100},{-140,100},{-200,100}}));
  connect(PDC2.C1, ExchangerWaterWater.Sf)
    annotation (Line(points={{-80,-20},{-80,-40},{-0.14,-40},{-0.14,-52}}));
  connect(PDC1.C2, ExchangerWaterWater.Ec)
                                   annotation (Line(points={{-60,-20},{-60,-71.6},
          {-5.74,-71.6}},        color={0,0,0}));
  connect(AirMassFlowRate.y, AirSource.IMassFlow)
    annotation (Line(points={{41,40},{52,40},{52,20}}));
  connect(WaterSource.IMassFlow, WaterMassFlowRate.y)
    annotation (Line(points={{51,-29.5},{51,-26},{79.2,-26}}));
  connect(silencieux.C1, Engine.Cfg) annotation (Line(
      points={{-39,6},{-40,6},{-40,1.32262e-015},{-21.6,1.32262e-015}},
      color={0,0,0},
      thickness=0.5));
  connect(Engine.Cws1, WaterSource.C) annotation (Line(points={{-1.32262e-015,-21.6},
          {-1.32262e-015,-35},{40,-35}}));
  connect(Engine.Cair, AirSource.C) annotation (Line(
      points={{21.6,-1.77636e-015},{32,-1.77636e-015},{32,14},{40,14}},
      color={0,0,0},
      thickness=0.5));
  connect(PDC1.C1, Engine.Cws2)
    annotation (Line(points={{-60,0},{-60,32},{1.32262e-015,32},{1.32262e-015,
          21.6}}));
  connect(Engine.Cfuel, FuelSource.C) annotation (Line(points={{21.6,-16.8},{32,
          -16.8},{32,-14},{38,-14}}, color={0,0,0}));
  connect(silencieux.C2, ExchangerWaterFlueGases.Ec) annotation (Line(points={{-39,26},
          {-40,26},{-40,58},{-40,62.4},{-5.74,62.4}},         color={0,0,0},
      thickness=0.5));
  connect(AirTemperature.y, AirSource.ISpecificEnthalpyOrTemperature)
    annotation (Line(points={{79,0},{64,0},{52,0},{52,8}}, color={0,0,255}));
  connect(ExchangerWaterFlueGases.Sf, outletWaterSteam) annotation (Line(points=
         {{-0.14,82},{-0.14,100},{200,100}}, color={0,0,0}));
  connect(PDC2.C2, ExchangerWaterFlueGases.Ef) annotation (Line(points={{-80,0},
          {-80,44},{8.88178e-016,44},{8.88178e-016,54}}, color={0,0,0}));
  connect(ExchangerWaterFlueGases.Sc, FlueGasesSink.C) annotation (Line(
      points={{-5.74,73.6},{-40,73.6},{-40,98},{-56,98}},
      color={0,0,0},
      thickness=0.5));
  connect(WaterSteamSink.C, ExchangerWaterWater.Sc) annotation (Line(points={{-22,
          -60},{-14,-60},{-14,-60.4},{-5.74,-60.4}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1)),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end CHPEngineBarkantineSystem;
