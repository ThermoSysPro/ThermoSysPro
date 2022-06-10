within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd2ph_Ph
  "Derivative of density wrt. pressure at constant specific enthalpy in steam region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Units.SI.DerDensityByPressure ddph
    "Derivative of density wrt. pressure at constant specific enthalpy";
protected
  d2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    h);

end dd2ph_Ph;
