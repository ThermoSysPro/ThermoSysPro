within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2sat_P "specific enthalpy at vapor saturation for given pressure"

  input Modelica.SIunits.Pressure p "pressure";
  output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
protected
  h2sat_P_coef1 coef1;
  h2sat_P_coef2 coef2;
  h2sat_P_coef3 coef3;

algorithm
   if p < 8.7075e5 then
     h := coef1.a0 + coef1.a*abs(p)^coef1.b;
    else
      if p < 93.285e5 then
      h :=
        ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order5(
        coef2, p);
      else
      h :=
        ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
        coef3, p);
      end if;
   end if;

 //h:=ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hv_p(p);
end h2sat_P;
