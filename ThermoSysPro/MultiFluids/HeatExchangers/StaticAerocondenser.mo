within ThermoSysPro.MultiFluids.HeatExchangers;
model StaticAerocondenser "Static aerocondenser"
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uref=50
    "Reference heat transfer coefficient between the air and the condenser external wall";
  parameter Real UCOR=1. "Heat transfer corrective coefficient";
  parameter Modelica.SIunits.Area Se=1.e4 "Condenser external wall area";
  parameter Modelica.SIunits.Height z=0 "Water level in the condenser";
  parameter Real K=0.02
    "Pressure loss coefficient for the water/steam pipe (Pa.s²/(kg.m**3))";
  parameter Real Ka=0.00
    "Pressure loss coefficient for the air (Pa.s²/(kg.m**3))";
  parameter Integer mode_e=0
    "Région IAPWS en entrée. 1:liquide - 2:vapeur - 4:saturation - 0:calcul automatique";
  parameter Integer mode_s=0
    "Région IAPWS en entrée. 1:liquide - 2:vapeur - 4:saturation - 0:calcul automatique";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";

public
  Modelica.SIunits.SpecificEnthalpy hv(start=2500000)
    "Fluid specific enthalpy at the inlet of the condenser";
  Modelica.SIunits.SpecificEnthalpy he(start=370000)
    "Fluid specific enthalpy at the outlet of the condenser";
  Modelica.SIunits.SpecificEnthalpy hae(start=75000)
    "Air specific enthalpy at the inlet of the condenser";
  Modelica.SIunits.SpecificEnthalpy has(start=100000)
    "Air specific enthalpy at the outlet of the condenser";
  Modelica.SIunits.MassFlowRate Q(start=1.5e2)
    "Fluid mass flow rate in the water/steam pipe";
  Modelica.SIunits.MassFlowRate Qa(start=1.4e3)
    "Air mass flow rate in the condenser";
  Modelica.SIunits.Temperature Tae(start=290)
    "Air temperature at the inlet of the condenser";
  Modelica.SIunits.Temperature Tas(start=360)
    "Air temperature at the outlet of the condenser";
  Modelica.SIunits.AbsolutePressure Pae(start=1.e5)
    "Air pressure at the inlet of the condenser";
  Modelica.SIunits.AbsolutePressure Pas(start=1.e5)
    "Air pressure at the outlet of the condenser";
  Modelica.SIunits.AbsolutePressure Pv(start=30000)
    "Fluid pressure at the inlet of the condenser";
  Modelica.SIunits.AbsolutePressure Pe(start=30000)
    "Fluid pressure at the outlet of the condenser";
  Modelica.SIunits.AbsolutePressure Pcond(start=17000)
    "Condensation pressure (vacuum)";
  Modelica.SIunits.Temperature Tcond(start=360) "Condensation temperature";
  Modelica.SIunits.CoefficientOfHeatTransfer U(start=50)
    "Heat transfer coefficient";
  Modelica.SIunits.SpecificHeatCapacity cp_a(start=1000)
    "Air specific heat capacity at constant pressure";
  Real Nut(start=2.) "Number of transfer units";
  Real Ef(start=0.8) "Efficiency in two-phase flow regime";
  Modelica.SIunits.Power W "Heat power transfered to the cooling air";
  Modelica.SIunits.Density rho_v(start=500)
    "Fluid density at the inlet of the condenser";
  Modelica.SIunits.Density rho_e(start=998)
    "Fluid density at the outlet of the condenser";
  Modelica.SIunits.Density rho_a(start=1) "Air density";
public
  WaterSteam.Connectors.FluidInlet Cws1
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}},
          rotation=0)));
  WaterSteam.Connectors.FluidOutlet Cws2
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}, rotation=
            0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cair1
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cair2
    annotation (Placement(transformation(extent={{-10,88},{10,108}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Steam properties"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    "Water properties"
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation

  Pv = Cws1.P;
  Pe = Cws2.P;
  hv = Cws1.h;
  he = Cws2.h;
  Q = Cws1.Q;
  Q = Cws2.Q;

  Pae = Cair1.P;
  Pas = Cair2.P;
  Tae = Cair1.T;
  Tas = Cair2.T;
  Qa = Cair1.Q;
  Qa = Cair2.Q;

  /* Flow reversal in the water/steam pipe */
  0 = if (Q > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;

  /* Air composition */
  Cair2.Xco2 = Cair1.Xco2;
  Cair2.Xh2o = Cair1.Xh2o;
  Cair2.Xo2 = Cair1.Xo2;
  Cair2.Xso2 = Cair1.Xso2;

  /* Condensation temperature */
  Tcond = ((Tas + Tae*(Ef - 1.))/Ef);

  /* Condensation pressure */
  Pcond = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.psat(Tcond);

  /* Pressure losses in the water steam pipe */
  Pv = Pcond + K*(Q*abs(Q))/rho_v;
  Pe = Pcond + rho_e*g*z;

  /* Air pressure losses */
  Pae = Pas + Ka*(Qa*abs(Qa))/rho_a;

  /* Heat exchange coefficient */
  U = UCOR*Uref*(-2.e-4*(Tae - 273.16)^2 + 0.0187*(Tae - 273.16) + 0.5007);

  /* Energy balance equation for the air */
  if noEvent(Qa > 0) then
    (has - hae)*Qa - ((hv - he)*Q) = 0;
  else
    (has - hae)*1.e-6 - ((hv - he)*Q) = 0;
  end if;

  /* Number of transfer units */
  Nut = if noEvent(Qa*cp_a > 0) then Se*U/(Qa*cp_a) else 2.;

  /* Efficiency in the two-phase flow regime */
  Ef = 1 - exp(-Nut);

  /* Heat power transferred to the cooling water */
  W = Qa*(has - hae);

  /* Water/steam thermodynamic properties */
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pv + Pcond)/2., hv, mode_e);
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pe + Pcond)/2., he, mode_s);

  rho_v = prov.d;
  rho_e = proe.d;

  /* Water specific enthalpy at the saturation point with pressure Pcond */

  he = ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hl_p(Pcond);

  /* Air thermodynamic properties */
  hae = ThermoSysPro.Properties.FlueGases.FlueGases_h( Pae, Tae, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  has = ThermoSysPro.Properties.FlueGases.FlueGases_h( Pas, Tas, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  rho_a = ThermoSysPro.Properties.FlueGases.FlueGases_rho( Pae, Tae,  Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  cp_a = ThermoSysPro.Properties.FlueGases.FlueGases_cp( (Pae + Pas)/2., (Tae + Tas)/2., Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-100},{100,48},{-100,48},{-100,-100},{100,-100}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,48},{-100,48},{-40,100},{40,100},{100,48}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,86},{-10,66},{12,66},{0,86}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{1,66},{1,10}},
          color={0,0,0},
          thickness=1),
        Text(
          extent={{-28,102},{-16,92}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Air"),
        Text(
          extent={{-24,-88},{-12,-98}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Air"),
        Text(
          extent={{90,-20},{114,-28}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Water"),
        Text(
          extent={{-112,-18},{-86,-26}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Steam"),
        Line(
          points={{-100,-28},{86,-28},{86,-34},{-84,-34},{-84,-40},{86,-40},{86,
              -46},{-84,-46},{-84,-52},{100,-52}},
          color={28,108,200},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-100},{100,48},{-100,48},{-100,-100},{100,-100}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,48},{-100,48},{-40,100},{40,100},{100,48}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-28},{86,-28},{86,-34},{-84,-34},{-84,-40},{86,-40},{86,
              -46},{-84,-46},{-84,-52},{100,-52}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{0,78},{-10,58},{12,58},{0,78}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{0,58},{0,42}},
          color={0,0,0},
          thickness=1)}),
    Window(
      x=0.09,
      y=0.08,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StaticAerocondenser;
