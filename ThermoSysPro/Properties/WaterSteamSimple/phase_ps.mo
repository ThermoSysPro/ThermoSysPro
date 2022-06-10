within ThermoSysPro.Properties.WaterSteamSimple;
function phase_ps "Returns the current phase"
  input Units.SI.Pressure p "pressure";
  input Units.SI.SpecificEntropy s "specific entropy";
 output Integer phase=0 "phase: 2 for two-phase, 1 for one phase";

protected
  Units.SI.SpecificEntropy s1sat "bubble entropy";
  Units.SI.SpecificEntropy s2sat "dew entropy";
  Boolean supercritical;

algorithm
  supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);
  s1sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s1sat_P(p);
  s2sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s2sat_P(p);
  phase := if ((s < s1sat) or (s > s2sat) or supercritical) then 1 else 2;

end phase_ps;
