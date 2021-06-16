within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2satp_P
  "derivative of specific enthalpy at vapor saturation wrt. pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Real dhp(unit="m3/kg") "derivative of enthalpy";
protected
  h2sat_P_coef1 coef1;
  h2sat_P_coef2 coef2;
  h2sat_P_coef2 coef3;

algorithm
  if p < 8.7075e5 then
     dhp := coef1.a*coef1.b*abs(p)^(coef1.b-1);
    else
      if p < 93.285e5 then
      dhp :=
        ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5_derivative(
        coef2, p);
      else
      dhp :=
        ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative(
        coef3, p);
      end if;
   end if;

end dh2satp_P;
