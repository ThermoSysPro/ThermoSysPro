within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd1pT_PT
  "Derivative of density wrt. pressure at constant temperature in liquid region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "temperature";
  output Units.SI.DerDensityByPressure ddpT
    "Derivative of density wrt. pressure at constant specific entropy";
protected
  d1_PT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddpT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    T);

end dd1pT_PT;
