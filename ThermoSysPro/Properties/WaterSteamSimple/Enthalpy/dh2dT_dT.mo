within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2dT_dT
  "Derivative of specific enthalpy wrt. density at constant specific enthalpy in vapor region for given density and temperature"
input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dhdT
    "Derivative of specific enthalpy wrt. density at constant temperature";
  h2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhdT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    d,
    T);

end dh2dT_dT;
