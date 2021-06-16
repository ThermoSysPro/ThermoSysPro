within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2pT_PT
  "Derivative of specific enthalpy wrt. pressure at constant specific enthalpy in vapor region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dhpT
    "Derivative of specific enthalpy wrt. pressure at constant specific entropy";
  h2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhpT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    T);

end dh2pT_PT;
