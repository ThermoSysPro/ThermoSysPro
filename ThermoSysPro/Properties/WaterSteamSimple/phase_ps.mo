within ThermoSysPro.Properties.WaterSteamSimple;
function phase_ps "return the current phase"
 input Modelica.SIunits.Pressure p "pressure";
 input Modelica.SIunits.SpecificEntropy s "specific entropy";
 output Integer phase=0 "phase: 2 for two-phase, 1 for one phase";

protected
  Modelica.SIunits.SpecificEntropy s1sat "bubble entropy";
  Modelica.SIunits.SpecificEntropy s2sat "dew entropy";
  Boolean supercritical;

algorithm
  supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);
  s1sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s1sat_P(p);
  s2sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s2sat_P(p);
  phase := if ((s < s1sat) or (s > s2sat) or supercritical) then 1 else 2;

end phase_ps;
