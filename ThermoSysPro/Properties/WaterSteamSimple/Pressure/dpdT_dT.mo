within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function dpdT_dT
  "Derivative of pressure wrt. density at constant specific enthalpy in liquid region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Real dpdT "Derivative of pressure wrt. density at constant temperature";
protected
  p_dT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dpdT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    d,
    T);

end dpdT_dT;
