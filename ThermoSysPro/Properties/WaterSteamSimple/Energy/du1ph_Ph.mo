within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du1ph_Ph "Derivative of specific inner energy wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";

  output Real duph(unit="m3/kg") "Derivative of specific inner energy wrt. pressure at constant specific enthalpy";
protected
  u1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  duph := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(coef, p, h);

end du1ph_Ph;
