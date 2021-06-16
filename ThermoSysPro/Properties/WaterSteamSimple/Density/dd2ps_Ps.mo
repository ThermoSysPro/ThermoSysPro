within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd2ps_Ps
  "Derivative of density wrt. pressure at constant specific entropy in liquid region for given pressure and specific entropy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEntropy s "Specific entropy";
 output Modelica.SIunits.DerDensityByPressure ddps
    "Derivative of density wrt. pressure at constant specific entropy";
protected
  d2_Ps_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddps := 1/log(10)/p*
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end dd2ps_Ps;
