within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2Tp_PT
  "Derivative of specific enthalpy wrt. specific entropy at constant pressure in vapor region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";
  output Real dhTp
    "Derivative of specific enthalpy wrt. temperature at constant pressure";
protected
  h2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhTp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    T);

end dh2Tp_PT;
