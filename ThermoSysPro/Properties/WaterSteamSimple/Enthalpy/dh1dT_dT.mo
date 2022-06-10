within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh1dT_dT
  "Derivative of specific enthalpy wrt. density at constant specific enthalpy in liquid region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Real dhdT
    "Derivative of specific enthalpy wrt. density at constant temperature";
protected
  h1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhdT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    d,
    T);

end dh1dT_dT;
