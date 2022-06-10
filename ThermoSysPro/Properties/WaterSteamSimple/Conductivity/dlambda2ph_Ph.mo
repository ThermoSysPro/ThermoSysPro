within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function dlambda2ph_Ph
  "Derivative of conductivity wrt. pressure at constant specific enthalpy in vapor region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Real dlambdaph
    "Derivative of conductivity wrt. pressure at constant specific enthalpy";
protected
  lambda2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dlambdaph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    h);

end dlambda2ph_Ph;
