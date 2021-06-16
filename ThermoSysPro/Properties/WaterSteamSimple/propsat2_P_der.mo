within ThermoSysPro.Properties.WaterSteamSimple;
function propsat2_P_der
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Real p_der "derivative of Pressure";
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat der_pro;

protected
  Modelica.SIunits.SpecificEnthalpy hv "dew enthalpy";

algorithm
  hv := Enthalpy.h2sat_P(p);

  der_pro.P := 1;
  der_pro.T := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Temperature.dTsatp_P(p);
  der_pro.rho := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Density.dd2ph_Ph(p, hv);
  der_pro.h := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh2satp_P(p);
  der_pro.cp := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcp2ph_Ph(p, hv);
  der_pro.pt := 1; //NA
  der_pro.cv := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcv2ph_Ph(p, hv);
end propsat2_P_der;
