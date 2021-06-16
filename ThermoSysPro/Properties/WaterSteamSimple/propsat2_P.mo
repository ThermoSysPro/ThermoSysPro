within ThermoSysPro.Properties.WaterSteamSimple;
function propsat2_P
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  output ThermoSysPro.Properties.WaterSteamSimple.PropThermoSat pro;

protected
  Modelica.SIunits.SpecificEnthalpy hv "dew enthalpy";

algorithm
  hv := Enthalpy.h2sat_P(p);

  pro.P := p;
  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.Tsat_P(p);
  pro.rho := ThermoSysPro.Properties.WaterSteamSimple.Density.d2_Ph(p, hv);
  pro.h := hv;
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp2_Ph(p, hv);
  pro.pt := 1; //NA
  pro.cv := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cv2_Ph(p, hv);
end propsat2_P;
