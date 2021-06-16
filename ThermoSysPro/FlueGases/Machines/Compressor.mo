within ThermoSysPro.FlueGases.Machines;
model Compressor "Gas compressor"
  parameter Integer mass_flow_rate_comp=1
    "Ways for computing the mass flow rate - 1: Q = rho*Qv - 2: Q = rho*f(T)";
  parameter Modelica.SIunits.Temperature Tmax=284.16
    "Air transition temperature between f1 = a*x + b and f2 = c*x + d for the computation of Q (active if mass_flow_rate_comp == 2)";
  parameter Real coef1_1=0.1164 "Coefficient a for f1 = a*x + b";
   parameter Real coef2_1=38.643 "Coefficient b for f1 = a*x + b";
  parameter Real coef1_2=-0.2324 "Coefficient c for f2 = c*x + d";
  parameter Real coef2_2=137.49 "Coefficient d for f2 = c*x + d";
  parameter Real A4=-1.2362
    "Coefficient of X^4 for the computation of the isentropic efficiency";
  parameter Real A3=3.6721
    "Coefficient of X^3 for the computation of the isentropic efficiency";
  parameter Real A2=-4.2434
    "Coefficient of X^2 for the computation of the isentropic efficiency";
  parameter Real A1=2.3957
    "Coefficient of X^1 for the computation of the isentropic efficiency";
  parameter Real A0=0.4118
    "Coefficient of X^0 for the computation of the isentropic efficiency";
  parameter Real tau_n=14.149 "Nominal compression rate";
  parameter Real is_eff_n=0.84752 "Nominal isentropic efficiency";

protected
  Modelica.SIunits.VolumeFlowRate Qv_cal(start=500)
    "Intermediate variable for the computation of Qv";

public
  Real tau(start=15) "Compression rate";
  Real is_eff(start=0.85) "Isentropic efficiency";
  Modelica.SIunits.Power Wcp(start=1e9) "Compressor power";
  Modelica.SIunits.AbsolutePressure Pe( start=1e5) "Air pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Ps(start=15e5) "Air pressure at the outlet";
  Real Xtau( start=1) "Normal and nominal compression rates ratio";
  Modelica.SIunits.MassFlowRate Q(start=500) "Air mass flow rate";
  Modelica.SIunits.VolumeFlowRate Qv(start=500) "Air volumetric flow rate";
  Modelica.SIunits.Temperature Te( start=300) "Air temperature at the inlet";
  Modelica.SIunits.Temperature Ts(start=750) "Air temperature at the outlet";
  Modelica.SIunits.Temperature Tis(start=750)
    "Isentropic air temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy He(start=80e3)
    "Air specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hs(start=500e3)
    "Air specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy His(start=450e3)
    "Air specific enthalpy after the isentropic compression";
  Modelica.SIunits.SpecificEntropy Se "Air specific entropy at the inlet";
  Modelica.SIunits.Density rho_e(start=1) "Air density at the inlet";

public
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ce
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cs
                                           annotation (Placement(transformation(
          extent={{80,-10},{100,10}}, rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Power
    annotation (Placement(transformation(extent={{80,-40},{100,-20}}, rotation=
            0)));
equation
  /* Connector at the inlet */
  Pe = Ce.P;
  Q = Ce.Q;
  Te = Ce.T;

  /* Connector at the outlet */
  Ps = Cs.P;
  Q = Cs.Q;
  Ts = Cs.T;

  /* Flue gases composition */
  Cs.Xco2 = Ce.Xco2;
  Cs.Xh2o = Ce.Xh2o;
  Cs.Xo2  = Ce.Xo2;
  Cs.Xso2 = Ce.Xso2;

  /* Compression rate */
  tau = Ps/Pe;

  /* Compression rates ratio */
  Xtau = tau/tau_n;

  /* Isentropic efficiency */
  is_eff = (A4*Xtau^4 + A3*Xtau^3 + A2*Xtau^2 + A1*Xtau + A0)*is_eff_n;

  /* Compressor power */
  Wcp = Q*(He - Hs);
  Power.signal = Wcp;

  /* Volume flow rate at the inlet */
  Qv_cal = if (Te < Tmax) then coef1_1*Te + coef2_1 else coef1_2*Te + coef2_2;
  Q = if (mass_flow_rate_comp == 1) then Qv*rho_e else Qv_cal*rho_e;

  /* Specific enthalpy at the inlet */
  He = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific entropy at the inlet */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy after the isentropic compression */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  His = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Fluid density at the inlet */
  rho_e = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy at the outlet */
  Hs = (His - He + is_eff*He)/is_eff;

  /* Temperature at the outlet */
  //Ts = ThermoSysPro.Properties.FlueGases.FlueGases_T(Ps, Hs, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  // call implicitly to avoid function that can not be differentiated.
  Hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Ts, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{
            120,100}}), graphics={Polygon(
          points={{-80,80},{-80,-80},{80,-40},{80,40},{-80,80}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Backward)}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}}), graphics={Polygon(
          points={{-80,80},{-80,-80},{80,-40},{80,40},{-80,80}},
          lineColor={0,0,0},
          fillColor={0,255,0},
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
<p>This component model is documented in Sect. 11.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
"));
end Compressor;
