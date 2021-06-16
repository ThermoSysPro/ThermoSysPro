within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function dmu2Td_dT
  "Derivative of viscosity wrt. specific enthalpy at constant pressure in vapor region for given density and temperature"
input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dmuTd
    "Derivative of viscosity wrt. temperature at constant density";
  mu2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dmuTd :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    T,
    d);

end dmu2Td_dT;
