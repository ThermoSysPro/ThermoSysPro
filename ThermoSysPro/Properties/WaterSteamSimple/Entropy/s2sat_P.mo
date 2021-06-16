within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function s2sat_P "specificentropy at vapor saturation for given pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Modelica.SIunits.SpecificEntropy s "specific entropy";
protected
  s2sat_P_coef1 coef1;
  s2sat_P_coef2 coef2;
algorithm
  if p < 15.85e5 then
    s := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5(coef1, ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p));
  else
    s := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(coef2, p);
  end if;
end s2sat_P;
