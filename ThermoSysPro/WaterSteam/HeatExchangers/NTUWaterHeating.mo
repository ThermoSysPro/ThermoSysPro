within ThermoSysPro.WaterSteam.HeatExchangers;
model NTUWaterHeating "NTU water heater"
  parameter Real lambdaE=0 "Pressure loss coefficient on the water side";
  parameter Modelica.SIunits.Area SCondDes=3000
    "Exchange surface for the condensation and deheating";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer KCond=1
    "Heat transfer coefficient for the condensation";
  parameter Modelica.SIunits.Area SPurge=0
    "Drain surface - if > 0: with drain cooling";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer KPurge=1
    "Heat transfer coefficient for the drain cooling";
  parameter Integer mode_eeF=0
    "IF97 region at the inlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_seF=0
    "IF97 region at the outlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_evC=0
    "IF97 region at the inlet of the vapor side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_mF=0
    "IF97 region in the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_epC=0
    "IF97 region at the inlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_spC=0
    "IF97 region at the outlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_flash=0
    "IF97 region in the flash zone of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Real eps=1.e-3 "Small number for pressure loss equation";

public
  Modelica.SIunits.AbsolutePressure P(start=10e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy HsateC(start=300e3,min=0)
    "Saturation specific enthalpy of the water at the pressure of the vapor inlet";
  Modelica.SIunits.SpecificEnthalpy HsatvC(start=2500e3,min=0)
    "Saturation specific enthalpy of the vapor at the pressure of the vapor inlet";
  Modelica.SIunits.Area SDes(start=0) "Heat exchange surface for deheating";
  Modelica.SIunits.SpecificEnthalpy HeiF(start=200e3)
    "Fluid specific enthalpy after drain cooling";
  Modelica.SIunits.SpecificEnthalpy HDesF(start=200e3)
    "Fluid specific enthalpy after deheating";
  Modelica.SIunits.Temperature TeiF(start=400,min=0)
    "Fluid temperature after drain cooling";
  Modelica.SIunits.Temperature TsatC(start=400,min=0) "Saturation temperature";
  Modelica.SIunits.Power W(start=1)
    "Total heat power transfered to the cooling water";
  Modelica.SIunits.Power Wdes(start=1) "Energy transfer during deheating";
  Modelica.SIunits.Power Wcond(start=1) "Energy transfer during condensation";
  Modelica.SIunits.Power Wflash(start=1)
    "Energy transfer during partial vaporisation in the drain";
  Modelica.SIunits.Power Wpurge(start=1) "Energy transfer during drain cooling";
  Modelica.SIunits.SpecificEnthalpy Hep(start=3e5)
    "Mixing specific enthalpy of the drain and the condensate";
  Modelica.SIunits.Density rho(start=1e3,min=0) "Average water density";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proeeF
    "Water inlet fluid properties (4F)"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proseF
    "Water outlet fluid properties (1F)"
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prospC
    "Drain outlet fluid properties (4C)"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Connectors.FluidInlet Ee(h_vol(start=200e3)) "Water inlet"
                          annotation (Placement(transformation(extent={{-92,-10},
            {-112,10}}, rotation=0)));
  Connectors.FluidOutlet Se "Water outlet"
                          annotation (Placement(transformation(extent={{110,-10},
            {90,10}}, rotation=0)));
  Connectors.FluidInlet Ep(h_vol(start=200e3)) "Drain inlet"
                          annotation (Placement(transformation(extent={{-50,24},
            {-70,44}}, rotation=0)));
  Connectors.FluidOutlet Sp "Drain outlet"
                          annotation (Placement(transformation(extent={{-50,-43},
            {-70,-23}}, rotation=0)));
  Connectors.FluidInlet Ev(h_vol(start=200e3)) "Vapor inlet"
                          annotation (Placement(transformation(extent={{70,22},
            {50,42}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proevC
    "Vapor inlet fluid properties (1C)"
    annotation (Placement(transformation(extent={{-70,80},{-50,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsatC
    "Saturation conditions for the liquid phase"
    annotation (Placement(transformation(extent={{10,40},{30,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsatC
    "Saturation conditions for the vapor phase"
    annotation (Placement(transformation(extent={{-30,40},{-10,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promeF
    "Average water fluid properties (between 4F and 3F)"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmC
    "Deheating average fluid properties (between 1C and 2C)"
    annotation (Placement(transformation(extent={{50,80},{70,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promcF
    "Average deheating fluid properties (between 3F and 2F)"
    annotation (Placement(transformation(extent={{50,-100},{70,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesF
    "Deheating inlet fluid properties (2F)"
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmF
    "Average deheating fluid properties (between 2F and 1F)"
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prosp
    "Drain outlet fluid properties before cooling (near 3C)"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompC
    "Average fluid properties in the drain (between 3C and 4C)"
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompF
    "Average water fluid properties (between 4F and 3F)"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proecF
    "Water fluid properties (3F)"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph flashepC
    "Flash fluid properties (near 4C)"
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation

  /* Unconnected connectors */
  if cardinality(Ep) == 0 then
    Ep.Q = 1e-6;
    Ep.h = 100e3;
    Ep.P = 1e5;
    Ep.b = true;
  end if;

  // Cooling pipe
  //-------------

  /* Flow reversal for the cooling water pipe */
  0 = if noEvent(Ee.Q > 0) then Ee.h - Ee.h_vol else Se.h - Se.h_vol;

  /* Mass balance equation for the water pipe */
  Se.Q = Ee.Q;

  /* Pressure loss equation in the water pipe */
  Ee.P - Se.P = lambdaE*ThermoSysPro.Functions.ThermoSquare(Ee.Q, eps)/rho;

  /* Heating power released to the cooling pipe */
  W = Se.Q*(Se.h - Ee.h);

  // Water/steam cavity
  //-------------------

  /* Fluid pressure */
  P = Ev.P;
  P = Sp.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Sp.h_vol = h;
  Ev.h_vol = h;
  Ep.h_vol = h;

  /* Mass balance equation */
  Sp.Q = Ev.Q + Ep.Q;

  /* Energy balance equations */

  // Deheating zone
  //---------------

  /* Heat power, fluid specific enthalpy on the cold side and deheating surface */
  /* If deheating is present */
  if noEvent(HsatvC < Ev.h) then
    Wdes = Ev.Q*(Ev.h - HsatvC);
    Wdes = Ee.Q*(Se.h - HDesF);
    Wdes = noEvent(min(Ev.Q*prodesmC.cp, Ee.Q*prodesmF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, prodesmC.cp, prodesmF.cp,
           KCond/2, SDes, 1) *(proevC.T - prodesF.T));
  /* If deheating is absent */
  else
    Wdes = 1e-9;
    HDesF = Se.h;
    SDes = 1e-9;
  end if;

  // Condensation zone
  //------------------

  /* Heat power, fluid specific enthalpy at the outlet of the condensation zone and vapor mass flow rate at the inlet */
  if noEvent(Ev.h < HsatvC) then
    Wcond = Ev.Q*(Ev.h - HsateC) + Wflash;
  else
    Wcond = Ev.Q*(HsatvC - HsateC) + Wflash;
  end if;

  Wcond = Ee.Q*(HDesF - HeiF);
  Wcond = Ee.Q*promcF.cp*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, 1.e20, promcF.cp, KCond, (SCondDes-SDes), 0.5)*(TsatC - TeiF);

  // Flash zone
  //-----------

  /* Heat power in case of partial vaporization in the drain */
  if (flashepC.x > 0) then
    Wflash = Ep.Q*(Ep.h - HsateC);
  else
    Wflash = 0;
  end if;

  /* Condition for partial vaporisation in the drain (flash) */
  if (flashepC.x > 0) then
    Hep = HsateC;
  else
    Sp.Q*Hep = HsateC*Ev.Q + Ep.h*Ep.Q;
  end if;

  // Drain cooling zone
  //-------------------

  /* Power, fluid specific enthalpy at the cold outlet and temperature of the drain outlet */
  if noEvent(SPurge > 0) then
    Wpurge = Sp.Q*(Hep - Sp.h);
    Wpurge = Ee.Q*(HeiF - Ee.h);
    Wpurge = noEvent(min(Sp.Q*prompC.cp, Ee.Q*prompF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Sp.Q, Ee.Q, prompC.cp, prompF.cp,
              KPurge, SPurge, 0)*(prosp.T - proeeF.T));
    TeiF = proecF.T;
  else
    HeiF = Ee.h;
    Wpurge = 0;
    Hep = Sp.h;
    TeiF = proeeF.T;
  end if;

  /* Fluid thermodynamic properties */
  proeeF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, Ee.h, mode_eeF);
  proseF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, Se.h, mode_seF);
  promeF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ee.P + Se.P)/2,(Ee.h + Se.h)/2, mode_eeF);
  proevC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Ev.h, mode_evC);
  prospC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sp.P, Sp.h, mode_spC);
  prosp  = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Hep, mode_spC);
  prodesF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, HDesF, mode_seF);
  prompC  = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, (Hep + Sp.h)/2, mode_spC);
  prodesmC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, (vsatC.h + Ev.h)/2, mode_evC);
  prompF  = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, (Ee.h + HeiF)/2, mode_eeF);
  promcF  = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ee.P + Se.P)/2, (HeiF + HDesF)/2, mode_mF);
  prodesmF = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Se.P, (HDesF + Se.h)/2, mode_seF);
  proecF  = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ee.P, HeiF, mode_eeF);
  flashepC = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ev.P, Ep.h, mode_flash);

  /* Fluid density */
  rho = promeF.d;

  /* Saturation point at the vapor inlet pressure */
  (lsatC,vsatC) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Ev.P);

  TsatC  = lsatC.T;
  HsateC = lsatC.h;
  HsatvC = vsatC.h;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.01), graphics={
        Ellipse(
          extent={{-100,-30},{-36,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-30},{102,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,32},{72,-30}},
          lineColor={85,255,85},
          lineThickness=0.5,
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,32},{74,32},{74,32}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,-30},{74,-30},{74,-30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{74,32},{74,-30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{74,0},{102,0}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-58,-14},{74,-16}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,16},{74,14}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,-16},{-44,16}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-14},{-48,14}},
          lineColor={0,255,0},
          lineThickness=1,
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,14},{72,-14}},
          lineColor={85,255,85},
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-94,-12},{74,-12}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-94,-18},{74,-18}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-86,-24},{74,-24}},
          color={0,0,255},
          pattern=LinePattern.Dash)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.01), graphics={
        Line(
          points={{-40,-40},{20,-24}},
          color={0,0,255},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-40,-20},{-20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-20,0},{20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{60,0},{80,20}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{76,28},{84,20}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString=
               "1C"),
        Text(
          extent={{56,10},{64,2}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString=
               "2C"),
        Text(
          extent={{-24,8},{-16,0}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString=
               "3C"),
        Text(
          extent={{-44,-10},{-36,-18}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString=
               "4C"),
        Text(
          extent={{76,-10},{82,-16}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "1F"),
        Text(
          extent={{58,-18},{64,-24}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "2F"),
        Text(
          extent={{-22,-38},{-16,-44}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "3F"),
        Text(
          extent={{-42,-44},{-36,-50}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "4F"),
        Line(
          points={{20,0},{60,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{20,-24},{80,-8}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-40,8},{-24,2}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Drain"),
        Text(
          extent={{66,-18},{82,-24}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Deheating"),
        Text(
          extent={{-36,-18},{-16,-24}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Drain cooling"),
        Line(
          points={{-26,4},{-22,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-40,-20},{-40,-40}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{-20,0},{-20,-34}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{60,0},{60,-14}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{80,20},{80,-8}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{48,50},{74,44}},
          lineColor={0,0,255},
          textString=
               "Vapor inlet"),
        Text(
          extent={{-74,52},{-48,46}},
          lineColor={0,0,255},
          textString=
               "Drain inlet"),
        Text(
          extent={{-74,-16},{-48,-22}},
          lineColor={0,0,255},
          textString=
               "Drain outlet"),
        Text(
          extent={{-114,18},{-88,12}},
          lineColor={0,0,255},
          textString=
               "Water inlet"),
        Text(
          extent={{86,18},{112,12}},
          lineColor={0,0,255},
          textString=
               "Water outlet"),
        Text(
          extent={{12,-10},{34,-18}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Condensation"),
        Text(
          extent={{-26,-4},{-12,-8}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString=
               "Flash")}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
<p>This component model is documented in Sect. 9.5.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end NTUWaterHeating;
