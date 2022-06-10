within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du2pT_PT "Derivative of inner energy wrt. pressure at constant temperature in vapor region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";

  output Units.SI.DerEnergyByPressure dupT "Derivative of inner energy wrt. pressure at constant specific entropy";
protected
  u2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dupT := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(coef, p, T);

end du2pT_PT;
