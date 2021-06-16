within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2sp_Ps
  "Derivative of specific enthalpy wrt. specific entropy at constant pressure in vapor region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Real dhsp
    "Derivative of specific enthalpy wrt. specific entropy at constant pressure";
  h2_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhsp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end dh2sp_Ps;
