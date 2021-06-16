within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2ps_Ps
  "Derivative of specific enthalpy wrt. pressure at constant specific enthalpy in vapor region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Real dhps
    "Derivative of specific enthalpy wrt. pressure at constant specific entropy";
  h2_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhps := 1/log(10)/p*
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end dh2ps_Ps;
