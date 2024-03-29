within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du2hp_Ph "Derivative of specific inner energy wrt. specific enthalpy at constant pressure in vapor region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";

  output Real duhp(unit = "1") "Derivative of specific inner energy wrt. specific enthalpy at constant pressure";
protected
  u2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  duhp := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(coef, p, h);

end du2hp_Ph;
