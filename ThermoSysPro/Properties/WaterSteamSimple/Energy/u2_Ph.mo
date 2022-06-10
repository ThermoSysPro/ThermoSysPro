within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function u2_Ph "Specific inner energy in vapor region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";

  output Units.SI.SpecificEnergy u "Specific inner energy";
protected
  u2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  u := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(coef, p, h);

end u2_Ph;
