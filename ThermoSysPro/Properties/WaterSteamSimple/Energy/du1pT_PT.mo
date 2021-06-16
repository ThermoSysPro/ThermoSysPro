within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du1pT_PT
  "Derivative of inner energy wrt. pressure at constant temperature in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "temperature";
 output Modelica.SIunits.DerEnergyByPressure dupT
    "Derivative of inner energy wrt. pressure at constant specific entropy";
  u1_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dupT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    T);

end du1pT_PT;
