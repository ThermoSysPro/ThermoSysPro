within ThermoSysPro.Properties.WaterSteamSimple;
function prop2_Ph
  "thermodynamics properties in region 2, independent variables p and h "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph pro;

algorithm
  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T2_Ph(p, h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d2_Ph(p, h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u2_Ph(p, h);
  pro.s := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s2_Ph(p, h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp2_Ph(p, h);
  pro.ddhp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2hp_Ph(p, h);
  pro.ddph := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2ph_Ph(p, h);
  pro.duph := ThermoSysPro.Properties.WaterSteamSimple.Energy.du2ph_Ph(p, h);
  pro.duhp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du2hp_Ph(p, h);
  pro.x :=1;
end prop2_Ph;
