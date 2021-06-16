within ThermoSysPro.FlueGases.Machines;
model CombustionTurbine "Combustion turbine"
  parameter Real A3=0 "X^3 coefficient of the efficiency curve";
  parameter Real A2=-0.04778 "X^2 coefficient of the efficiency curve";
  parameter Real A1=0.09555 "X^1 coefficient of the efficiency curve";
  parameter Real A0=0.95223 "X^0 coefficient of the efficiency curve";
  parameter Real tau_n=0.07 "Nominal expansion rate";
  parameter Real is_eff_n=0.8600 "Nominal isentropic efficiency";
  parameter Real Qred=0.01 "Reduced mass flow rate";

public
  Real tau(start=0.07) "Expansion rate";
  Real is_eff(start=0.85) "Isentropic efficiency";
  Modelica.SIunits.Power Wcp(start=1e9) "Compressor power";
  Modelica.SIunits.Power Wturb(start=2e9) "Turbine power";
  Modelica.SIunits.Power Wmech(start=1e9) "Mechanical power";
  Modelica.SIunits.AbsolutePressure Pe( start=1e5)
    "Flue gases pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Ps(start=1e5)
    "Flue gases pressure at the outlet";
  Real Xtau(start=1) "Ratio between the actual and nominal expansion rate";
  Modelica.SIunits.MassFlowRate Q(start=500) "Flue gases mass flow rate";
  Modelica.SIunits.Temperature Te(start=1.4e3)
    "Flue gases temperature at the inlet";
  Modelica.SIunits.Temperature Ts(start=900)
    "Flue gases temperature at the outlet";
  Modelica.SIunits.Temperature Tis(start=750)
    "Isentropic air temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy He(start=1.2e6)
    "Flue gases specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hs(start=6e5)
    "Flue gases specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy His(start=6e5)
    "Flue gases specific enthalpy after the isentropic expansion";
  Modelica.SIunits.SpecificEntropy Se
    "Flue gases specific entropy at the inlet";
public
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cs
                                           annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal CompressorPower
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}},
          rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal MechPower
    annotation (Placement(transformation(extent={{100,-100},{120,-80}},
          rotation=0)));
equation
  /* Connector at the inlet */
  Pe = Ce.P;
  Q = Ce.Q;
  Te = Ce.T;

  /* Connector at the outlet */
  Ps = Cs.P;
  Q = Cs.Q;
  Ts = Cs.T;

  /* Input compressor power (negative value) */
  Wcp = CompressorPower.signal;

  /* Flue gases composition */
  Cs.Xco2 = Ce.Xco2;
  Cs.Xh2o = Ce.Xh2o;
  Cs.Xo2  = Ce.Xo2;
  Cs.Xso2 = Ce.Xso2;

  /* Expansion rate */
  tau = Ps/Pe;

  /* Expansion rates ratio */
  Xtau = tau/tau_n;

  /* Isentropic efficiency */
  is_eff = (A3*Xtau^3 + A2*Xtau^2 + A1*Xtau + A0)*is_eff_n;

  /* Reduced mass flow rate */
  Qred = (Q*sqrt(Te))/Pe;

  /* Turbine power */
  Wturb = Q*(He - Hs);

  /* Mechanical power */
  Wmech = Wturb + Wcp;
  MechPower.signal = Wmech;

  /* Specific enthalpy at the inlet */
  He =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific entropy at the inlet */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy after the isentropic expansion */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  His = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy at the outlet */
  Hs = is_eff*(His - He) +  He;

  /* Temperature at the outlet */
//  Ts = ThermoSysPro.Properties.FlueGases.FlueGases_T(Ps, Hs, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  // replace by a function that can be differentiated and call with unknown variable on right-hand side
  Hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Ts, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={Polygon(
          points={{-100,40},{-100,-40},{100,-100},{100,100},{-100,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={Polygon(
          points={{-100,40},{-100,-40},{100,-100},{100,100},{-100,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 11.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
"));
end CombustionTurbine;
