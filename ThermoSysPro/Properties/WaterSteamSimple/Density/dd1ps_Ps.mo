within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd1ps_Ps
  "Derivative of density wrt. pressure at constant specific entropy in liquid region for given pressure and specific entropy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEntropy s "Specific entropy";
  output Units.SI.DerDensityByPressure ddps
    "Derivative of density wrt. pressure at constant specific entropy";
protected
  d1_Ps_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddps :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    s);

end dd1ps_Ps;
