within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function lambda2_dT
  "Conductivity in vapor region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.ThermalConductivity lambda "Thermal conductivity";
protected
  lambda2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  lambda :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    d,
    T);

end lambda2_dT;
