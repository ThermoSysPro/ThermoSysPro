within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds2satp_P "Derivative of specific entropy wrt. pressure at vapor saturation for given pressure"
  input Units.SI.Pressure p "pressure";
  output Real dsp(unit="m3/(kg.K)") "derivative of entropy";

protected
  s2sat_P_coef1 coef1;
  s2sat_P_coef2 coef2;

algorithm
  if p < 15.85e5 then
    dsp := 1/log(10)/p*ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5_derivative(coef1, ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p));
  else
    dsp := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative(coef2, p);
  end if;

end ds2satp_P;
