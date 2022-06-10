within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function s1sat_P "Specific entropy at liquid saturation for given pressure"
  input Units.SI.Pressure p "pressure";
  output Units.SI.SpecificEntropy s "specific entropy";
protected
  s1sat_P_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm
  s := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
    coef, ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p));
end s1sat_P;
