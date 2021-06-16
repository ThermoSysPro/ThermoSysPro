within ThermoSysPro.HeatNetworksCooling;
model AbsorptionRefrigeratorSystem "Refrigeration system by absorption"

  parameter Real DesEff=0.362979 "Desorber efficiency";
  parameter Real Pth=0.33 "Desorber thermal losses (0-1 %W)";
  parameter Real ExchEff=0.99 "Exchanger water LiBr efficiency";
  parameter Real EvapEff=0.99 "Evaporator efficiency";
  parameter Modelica.SIunits.MassFlowRate Qsol=8.856 "Solution mass flow rate";
  parameter Modelica.SIunits.MassFlowRate Qnom=8.856
    "Pump solution nominal mass flow rate";
  parameter ThermoSysPro.Units.DifferentialPressure DPnom=3386.05
    "Pump solution nominal delta pressure";

  ThermoSysPro.WaterSteam.Connectors.FluidOutletI outletWaterSteamI
    annotation (Placement(transformation(extent={{-200,160},{-180,180}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI inletWaterSteamI
    annotation (Placement(transformation(extent={{-200,40},{-180,60}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI ColdNeedOutlet
    annotation (Placement(transformation(extent={{10,-180},{30,-160}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI ColdNeedInlet
    annotation (Placement(transformation(extent={{130,-180},{150,-160}},
          rotation=0)));
  DesorberWaterLiBr desorber(
    W(fixed=false, start=4.16e6),
    DPc=0.2,
    DTm(fixed=false, start=9.648),
    Pth=Pth,
    Ec(h(start=432e3, fixed=false)),
    Eff=DesEff)
              annotation (Placement(transformation(extent={{-100,20},{-80,40}},
          rotation=0)));
  ThermoSysPro.WaterSolution.HeatExchangers.ExchangerEfficiency
    solutionHeatExchanger(
    Ef(P(fixed=false, start=900)),
    Qf(fixed=false, start=13),
    Tsf(fixed=false, start=343.15),
    DPc=0.2,
    DPf=0.2,
    Hsf(fixed=false, start=102586),
    Xf(fixed=false, start=0.5633),
    Eff=ExchEff)
    annotation (Placement(transformation(
        origin={-70,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSolution.PressureLosses.SingularPressureLoss solutionExp(C2(
       P(fixed=false, start=870)), K=10)
    annotation (Placement(transformation(
        origin={-110,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  WaterSolution.Machines.StaticCentrifugalPumpNom solutionPump(Qnom=Qnom, DPnom=
       DPnom)
    annotation (Placement(transformation(
        origin={-30,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ ambientSource(
    P0=1e5,
    Q0=313,
    h0=100e3) annotation (Placement(transformation(extent={{60,-140},{40,-120}},
          rotation=0)));
  AbsorberWaterLiBr absorber(
    DPf=0.2,
    Sc(T(fixed=false, start=290.98)),
    DPc(fixed=false, start=0.2))
    annotation (Placement(transformation(extent={{0,-120},{-20,-100}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink ambientSink
    annotation (Placement(transformation(
        origin={30,90},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.WaterSteam.PressureLosses.PipePressureLoss waterExp(K=2749.77)
                                   annotation (Placement(transformation(extent=
            {{20,120},{40,140}}, rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchangerDTorWorEff
    evaporator(EffEch=EvapEff)
    annotation (Placement(transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.WaterSolution.LoopBreakers.LoopBreakerQ loopBreakerQ
    annotation (Placement(transformation(
        origin={-30,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  WaterSolution.BoundaryConditions.RefQ solutionMassFlowRate
    annotation (Placement(transformation(
        origin={-30,0},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante
    solutionMassFlowRateValue(k=Qsol)
                      annotation (Placement(transformation(extent={{6,-6},{-6,6}},
          rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.SimpleStaticCondenser condensor
    annotation (Placement(transformation(
        origin={30,50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation
  connect(desorber.Sf, solutionHeatExchanger.Ec)
                                         annotation (Line(points={{-89.8,21},{
          -89.8,-24},{-76,-24},{-76,-24.2}}, color={0,0,0}));
  connect(solutionHeatExchanger.Sf, desorber.Ef)
                                         annotation (Line(points={{-69.8,-40},{
          -70,-40},{-70,-60},{-50,-60},{-50,36},{-82.6,36}}, color={0,0,0}));
  connect(ambientSource.C, absorber.Ef)      annotation (Line(points={{40,-130},
          {6.4,-130},{6.4,-116.2},{-2.6,-116.2}}, color={0,0,255}));
  connect(solutionExp.C2, absorber.Ec)         annotation (Line(points={{-110,
          -59},{-110,-104},{-17.4,-104}}, color={0,0,0}));
  connect(solutionPump.Ce, absorber.Sc)    annotation (Line(points={{-30,-79},{
          -30,-130},{-10,-130},{-10,-119}}, color={0,0,0}));
  connect(waterExp.C2, evaporator.Ef)       annotation (Line(points={{40,130},{
          70,130},{70,0}}, color={0,0,255}));
  connect(evaporator.Sf, absorber.Evap)   annotation (Line(points={{70.1,-20},{
          70.1,-44},{-10,-44},{-10,-101}}, color={0,0,255}));
  connect(desorber.Svap, condensor.Ec)   annotation (Line(points={{-90,39.05},{
          -90,44},{20,44}}, color={0,0,255}));
  connect(condensor.Sc, waterExp.C1)       annotation (Line(points={{20,56},{
          -10,56},{-10,130},{20,130}}, color={0,0,255}));
  connect(ambientSink.C, condensor.Sf)
    annotation (Line(points={{30,80},{30,60},{29.9,60}}));
  connect(condensor.Ef, absorber.Sf)
    annotation (Line(points={{30,40},{30,-104},{-2.8,-104}}));
  connect(outletWaterSteamI, desorber.Sc)  annotation (Line(points={{-190,170},
          {-106,170},{-106,36},{-97.2,36}}, color={255,0,0}));
  connect(inletWaterSteamI, desorber.Ec)  annotation (Line(points={{-190,50},{
          -110,50},{-110,23.8},{-97.4,23.8}}));
  connect(evaporator.Ec, ColdNeedInlet)
    annotation (Line(points={{74.1,-6},{160,-6},{160,-170},{140,-170}}));
  connect(ColdNeedOutlet, evaporator.Sc)  annotation (Line(points={{20,-170},{
          100,-170},{100,-14},{74.1,-14}}, color={255,0,0}));
  connect(solutionHeatExchanger.Ef, solutionMassFlowRate.C2)
                                           annotation (Line(points={{-69.8,-20},
          {-70,-20},{-70,20},{-30,20},{-30,10}}, color={0,0,0}));
  connect(solutionMassFlowRate.C1, loopBreakerQ.Cs)
                                                 annotation (Line(points={{-30,
          -10},{-30,-20}}, color={0,0,0}));
  connect(solutionExp.C1, solutionHeatExchanger.Sc) annotation (Line(points={{
          -110,-41},{-110,-35.8},{-76,-35.8}}, color={0,0,0}));
  connect(loopBreakerQ.Ce, solutionPump.Cs) annotation (Line(points={{-30,-40},
          {-30,-50},{-35,-50},{-35,-61}}, color={0,0,0}));
  connect(solutionMassFlowRate.IMassFlow, solutionMassFlowRateValue.y)
    annotation (Line(points={{-19,6.73556e-016},{-12.5,6.73556e-016},{-12.5,0},
          {-6.6,0}}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={
        Text(
          extent={{-22,-94},{4,-98}},
          lineColor={0,0,255},
          textString=
               "Absorber"),
        Text(
          extent={{14,-48},{84,-54}},
          lineColor={0,0,255},
          textString=
               "Water at ambient temperature"),
        Text(
          extent={{-44,52},{10,46}},
          lineColor={0,0,255},
          textString=
               "Water outlet (ambient)"),
        Text(
          extent={{-100,50},{-74,46}},
          lineColor={0,0,255},
          textString=
               "Desorber"),
        Text(
          extent={{-122,-4},{-92,-8}},
          lineColor={0,0,255},
          textString=
               "Heat source"),
        Text(
          extent={{-140,-24},{-82,-36}},
          lineColor={0,0,255},
          textString=
               "Solution heat exchanger"),
        Text(
          extent={{-130,-60},{-86,-74}},
          lineColor={0,0,255},
          textString=
               "Solution expansion"),
        Text(
          extent={{-62,-82},{-24,-90}},
          lineColor={0,0,255},
          textString=
               "Solution pump"),
        Text(
          extent={{-2,34},{20,30}},
          lineColor={0,0,255},
          textString=
               "Condensor"),
        Text(
          extent={{46,8},{72,4}},
          lineColor={0,0,255},
          textString=
               "Evaporator"),
        Text(
          extent={{46,-24},{76,-28}},
          lineColor={0,0,255},
          textString=
               "Cold supply"),
        Text(
          extent={{16,126},{58,114}},
          lineColor={0,0,255},
          textString=
               "Water expansion")}),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,127,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Polygon(
          points={{-180,190},{-170,200},{-42,200},{-32,190},{-32,30},{-42,20},{
              -170,20},{-180,30},{-180,190}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,100},{-32,30},{-42,20},{-170,20},{-180,30},{-180,100},{
              -132,100},{-110,176},{-42,176},{-42,164},{-98,164},{-80,100},{-32,
              100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-180,170},{-106,170},{-106,94},{-106,48},{-180,48}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-118,178},{-106,188},{-92,178}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{-180,-10},{-170,0},{-42,0},{-32,-10},{-32,-170},{-42,-180},{
              -170,-180},{-180,-170},{-180,-10}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-100},{-32,-170},{-42,-180},{-170,-180},{-180,-170},{
              -180,-100},{-132,-100},{-110,-24},{-42,-24},{-42,-36},{-98,-36},{
              -80,-100},{-32,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-170,-30},{-106,-30},{-106,-106},{-106,-152},{-170,-152}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-120,-12},{-106,-22},{-92,-12}},
          color={0,0,255},
          thickness=0.5),
        Rectangle(
          extent={{0,140},{160,40}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{24,50},{24,128},{82,84},{140,132},{140,50}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{46,82},{114,40}},
          lineColor={0,0,0},
          textString=
               "Cond"),
        Rectangle(
          extent={{0,-40},{160,-160}},
          lineColor={0,0,255},
          fillColor={72,143,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,-160},{20,-82},{80,-128},{140,-78},{140,-160}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{38,-46},{120,-104}},
          lineColor={0,0,255},
          textString=
               "Evap"),
        Text(
          extent={{-104,68},{-34,22}},
          lineColor={0,0,255},
          textString=
               "Des"),
        Text(
          extent={{-102,-130},{-32,-176}},
          lineColor={0,0,255},
          textString=
               "Abs")}),
    DymolaStoredErrors,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>"));
end AbsorptionRefrigeratorSystem;
