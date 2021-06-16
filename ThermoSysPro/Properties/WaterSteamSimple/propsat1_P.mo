within ThermoSysPro.Properties.WaterSteamSimple;
function propsat1_P
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat pro;

protected
  Modelica.SIunits.SpecificEnthalpy hl "bubble enthalpy";

algorithm
  hl := Enthalpy.h1sat_P(p);

  pro.P := p;
  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.Tsat_P(p);
  pro.rho := ThermoSysPro.Properties.WaterSteamSimple.Density.d1_Ph(p, hl);
  pro.h := hl;
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp1_Ph(p, hl);
  pro.pt := 1; //NA
  pro.cv := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cv1_Ph(p, hl);
end propsat1_P;
