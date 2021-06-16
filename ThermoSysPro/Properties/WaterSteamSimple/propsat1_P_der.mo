within ThermoSysPro.Properties.WaterSteamSimple;
function propsat1_P_der
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Real p_der "derivative of Pressure";
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat der_pro;

protected
  Modelica.SIunits.SpecificEnthalpy hl "bubble enthalpy";

algorithm
  hl := Enthalpy.h1sat_P(p);

  der_pro.P := 1;
  der_pro.T := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Temperature.dTsatp_P(p);
  der_pro.rho := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ph_Ph(p, hl);
  der_pro.h := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh1satp_P(p);
  der_pro.cp := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcp1ph_Ph(p, hl);
  der_pro.pt := 1; //NA
  der_pro.cv := p_der*
    ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcv1ph_Ph(p, hl);
end propsat1_P_der;
