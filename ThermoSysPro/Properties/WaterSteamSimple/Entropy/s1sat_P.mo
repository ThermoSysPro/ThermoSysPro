within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function s1sat_P "specificentropy at liquid saturation for given pressure"
  input Modelica.SIunits.Pressure p "pressure";
  output Modelica.SIunits.SpecificEntropy s "specific entropy";
protected
  s1sat_P_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm
  s := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
    coef, ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p));
end s1sat_P;
