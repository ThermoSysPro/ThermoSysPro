within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd2Tp_PT
  "Derivative of density wrt. temperature at constant pressure in vapor region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "temperature";
  output Units.SI.DerDensityByTemperature ddTp
    "Derivative of density wrt. temperature at constant pressure";
protected
  d1_PT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddTp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    T);

end dd2Tp_PT;
