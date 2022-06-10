within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function u2_PT "Specific inner energy in vapor region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";

  output Units.SI.SpecificEnergy u "Specific inner energy";
protected
  u2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  u := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(coef, p, T);

end u2_PT;
