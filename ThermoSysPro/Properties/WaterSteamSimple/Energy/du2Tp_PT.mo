within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du2Tp_PT "Derivative of inner energy wrt. temperature at constant pressure in vapor region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";

  output Units.SI.SpecificHeatCapacity duTp "Derivative of density wrt. temperature at constant pressure";
protected
  u2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  duTp := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(coef, p, T);

end du2Tp_PT;
