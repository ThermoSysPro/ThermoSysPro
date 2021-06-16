within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd1pT_PT
  "Derivative of density wrt. pressure at constant temperature in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "temperature";
 output Modelica.SIunits.DerDensityByPressure ddpT
    "Derivative of density wrt. pressure at constant specific entropy";
  d1_PT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddpT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    T);

end dd1pT_PT;
