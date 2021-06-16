within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh1Td_dT
  "Derivative of specific enthalpy wrt. specific entropy at constant density in liquid region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dhTd
    "Derivative of specific enthalpy wrt. temperature at constant density";
  h1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhTd :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    d,
    T);

end dh1Td_dT;
