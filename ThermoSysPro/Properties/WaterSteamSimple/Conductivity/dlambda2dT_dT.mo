within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function dlambda2dT_dT
  "Derivative of conductivity wrt. pressure at constant specific enthalpy in vapor region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dlambdadT
    "Derivative of conductivity wrt. density at constant temperature";
  lambda2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dlambdadT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    d,
    T);

end dlambda2dT_dT;
