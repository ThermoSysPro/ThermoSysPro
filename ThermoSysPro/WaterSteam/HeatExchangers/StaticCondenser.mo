within ThermoSysPro.WaterSteam.HeatExchangers;
model StaticCondenser "Static condenser"
  parameter Modelica.SIunits.Area SCO=10000 "Heat exchange surface";
  parameter Real CPCE=0.02
    "Pressure loss coefficient for the water side (Pa.s²/(kg.m**3))";
  parameter Modelica.SIunits.Height z=0.5 "Water level in the condenser";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer KCO=1
    "Reference heat exchange coefficient";
  parameter Modelica.SIunits.MassFlowRate QC0=100 "Reference mass flow rate";
  parameter Modelica.SIunits.Temperature Tref=293 "Reference temperature";
  parameter Real COPR=1 "Reference fouling coefficient";
  parameter Real COP=1 "Actual fouling coefficient";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer mode_ee=1
    "IF97 region at the water inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_se=1
    "IF97 region at the water outlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_ex=0
    "IF97 region at the extraction point. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Qee(start=10)
    "Cooling water mass flow rate at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hee(start=250000)
    "Cooling water specific anthalpy at the inlet";
  Modelica.SIunits.AbsolutePressure Pee(start=1.e5)
    "Cooling water pressure at the inlet";
  Modelica.SIunits.MassFlowRate Qep(start=10)
    "Drain mass flow rate at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hep(start=1000000)
    "Drain specific enthalpy at the inlet";
  Modelica.SIunits.MassFlowRate Qev(start=10)
    "Vapor mass flow rate at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hev(start=2500000)
    "Vapor specific enthalpy at the inlet";
  Modelica.SIunits.MassFlowRate Qvt(start=10)
    "Vapor mass flow rate leaving the turbine";
  Modelica.SIunits.SpecificEnthalpy Hvt(start=2500000)
    "Vapor specific enthalpy leaving the turbine";
  Modelica.SIunits.MassFlowRate Qse(start=10)
    "Cooling water mass flow rate at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hse(start=500000)
    "Cooling water specific enthalpy at the outlet";
  Modelica.SIunits.AbsolutePressure Pse(start=1.e5)
    "Cooling water pressure at the outlet";
  Modelica.SIunits.MassFlowRate Qex(start=10)
    "Drain mass flow rate at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hex(start=500000)
    "Drain specific enthalpy at the outlet";
  Modelica.SIunits.AbsolutePressure Pex(start=1.e5)
    "Drain pressure at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hsate(start=200000)
    "Water specific enthalpy at the saturation point";
  Modelica.SIunits.AbsolutePressure Pcond( start=17000)
    "Vapor pressure inside the condenser";
  Modelica.SIunits.Temperature Tsat(start=500)
    "Water temperature at the saturation point";
  Modelica.SIunits.Temperature Tee(start=300)
    "Cooling water temperature at the inlet";
  Modelica.SIunits.Temperature Tse(start=400)
    "Cooling water temperature at the outlet";
   Modelica.SIunits.Density rho_ee(start=900)
    "Cooling water density at the inlet";
  Modelica.SIunits.Density rho_ex(start=900)
    "Water density at the extraction point";
  Modelica.SIunits.CoefficientOfHeatTransfer KT1(start=50)
    "First reference value for the exchange coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer KT2(start=50)
    "Second reference value for the exchange coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer XKCO(start=200)
    "Heat transfer coefficient";
  Modelica.SIunits.SpecificEnthalpy Hmv(start=2500000)
    "Fluid input average specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hml(start=250000)
    "Extraction water average specific enthalpy";
  Modelica.SIunits.Power W "Heat power released to the cold source";
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cee "Cooling water inlet"
    annotation (Placement(transformation(extent={{-112,-72},{-88,-50}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cse "Cooling water outlet"
    annotation (Placement(transformation(extent={{90,-72},{114,-50}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cex "Extraction water"
    annotation (Placement(transformation(extent={{-12,-114},{14,-90}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cvt "Turbine outlet"
    annotation (Placement(transformation(extent={{-13,88},{13,114}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proex
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prose
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat1
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat1
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cep "Drain inlet"
    annotation (Placement(transformation(extent={{-112,8},{-88,30}}, rotation=0)));
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cev "Vapor inlet"
    annotation (Placement(transformation(extent={{-112,50},{-88,72}}, rotation=
            0)));
equation

  /* Unconnected connectors */
  if (cardinality(Cev) == 0) then
    Cev.Q = 0;
    Cev.h = 1.e5;
    Cev.b = true;
  end if;

  if (cardinality(Cep) == 0) then
    Cep.Q = 0;
    Cep.h = 1.e5;
    Cep.b = true;
  end if;

  Qep = Cep.Q;
  Hep = Cep.h;

  Qev = Cev.Q;
  Hev = Cev.h;

  Qvt = Cvt.Q;
  Hvt = Cvt.h;

  Qee = Cee.Q;
  Hee = Cee.h;
  Pee = Cee.P;

  Qse = Cse.Q;
  Hse = Cse.h;
  Pse = Cse.P;

  Qex = Cex.Q;
  Pex = Cex.P;

  // Cooling pipe
  //-------------

  /* Flow reversal for the cooling water pipe */
  if continuous_flow_reversal then
    0 = noEvent(if (Qee > Qeps) then Cee.h - Cee.h_vol else if (Qee < -Qeps) then
      Cse.h - Cse.h_vol else Cee.h - 0.5*((Cee.h_vol - Cse.h_vol)*Modelica.Math.sin(pi
      *Qee/2/Qeps) + Cee.h_vol + Cse.h_vol));
  else
    0 = if (Qee > 0) then Cee.h - Cee.h_vol else Cse.h - Cse.h_vol;
  end if;

  /* Mass balance equation for the water pipe */
  Qee = Qse;

  /* Pressure loss equation in the water pipe */
  Pse = noEvent(if (rho_ee > 0) then Pee - (CPCE * ThermoSysPro.Functions.ThermoSquare(Qee, eps)/ rho_ee) else Pee);

  /* Heating power released to the cooling pipe */
  W = Qee*(Hse - Hee);

  // Water/steam cavity
  //-------------------

  /* Fluid pressure */
  Pcond = Cep.P;
  Pcond = Cev.P;
  Pcond = Cvt.P;

  /* Extraction water pressure */
  Pex = Pcond + rho_ex*g*z;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Hmv = Cvt.h_vol;
  Hmv = Cep.h_vol;
  Hmv = Cev.h_vol;
  Hex = Cex.h_vol;

  /* Mass balance equation */
  Qex = Qvt + Qep + Qev;

  /* Energy balance equations */

  /* Input heating power */
  W = Qvt*(Hvt - Hsate) + Qep*(Hep - Hsate) + Qev*(Hev - Hsate);

  /* Fluid input average specific enthalpy */
  Hmv = (Hvt*Qvt + Hev*Qev + Hep*Qep) / Qex;

  /* Extraction water average specific enthalpy */
  Hml = (Hsate + Hex)/2;

  /* Extraction water specific enthalpy */
  Hex = noEvent(if (rho_ex > 0) then Hsate + ((Pex - Pcond)/rho_ex) else Hsate);

  /* First reference value for the exchange coefficient */
  KT1 = -0.05*(Tref - 273.16)^2 + 3.3*(Tref - 273.16) + 52;

  /* Second reference value for the exchange coefficient */
  KT2 = -0.05*(Tee - 273.16)^2 + 3.3*(Tee - 273.16) + 52;

  /* Heat exchange coefficient */
  XKCO = KCO*(COP/COPR)*(KT2/KT1)*ThermoSysPro.Functions.ThermoRoot(Qee/QC0, Modelica.Constants.eps);

  /* Fluid saturation teperature */
  0 = Tsat - Tse - (Tsat - Tee)*exp(XKCO*SCO*((Tee - Tse)/W));

  /* Fluid thermodynamic properties */
  proee = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pee, Hee, mode_ee);
  proex = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pex, Hex, mode_ex);
  prose = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode_se);

  rho_ee = proee.d;
  rho_ex = proex.d;

  Tee = proee.T;
  Tse = prose.T;

  /* Vapor pressure inside the condenser */
  Pcond = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.psat(Tsat);

  /* Fluid thermodynamic properties at the saturation point*/
  (lsat1,vsat1) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Pcond);

  Hsate = lsat1.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-82},{100,80},{-100,80},{-100,-82},{100,-82}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,88},{20,70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Turbine outlet"),
        Text(
          extent={{-82,24},{-52,16}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Drain inlet"),
        Text(
          extent={{-24,-52},{26,-72}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Extraction water"),
        Text(
          extent={{38,-58},{86,-66}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water outlet"),
        Text(
          extent={{-86,-52},{-32,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water inlet"),
        Text(
          extent={{-86,66},{-50,54}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Vapor inlet"),
        Line(
          points={{0,8},{0,-70}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{0,-90},{-11,-70},{11,-70},{0,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={0,0,255},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-86},{100,80},{-100,80},{-100,-86},{100,-86}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{0,-90},{-11,-70},{11,-70},{0,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{0,8},{0,-70}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0.5)}),
    Window(
      x=0.09,
      y=0.08,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
<p>This component model is documented in Sect. 9.7.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StaticCondenser;
