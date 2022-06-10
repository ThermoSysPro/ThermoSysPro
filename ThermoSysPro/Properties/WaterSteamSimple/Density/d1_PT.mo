within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d1_PT "Density in liquid region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.Density d "Density";
protected
  d1_PT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    T);

end d1_PT;
