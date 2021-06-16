within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function dmu2dT_dT
  "Derivative of viscosity wrt. pressure at constant specific enthalpy in vapor region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dmudT
    "Derivative of viscosity wrt. density at constant temperature";
  mu2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dmudT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    d,
    T);

end dmu2dT_dT;
