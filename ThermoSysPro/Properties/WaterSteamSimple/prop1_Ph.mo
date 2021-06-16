within ThermoSysPro.Properties.WaterSteamSimple;
function prop1_Ph
  "thermodynamics properties in region 1, independent variables p and h "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

 output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph pro;
algorithm

  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T1_Ph(p, h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d1_Ph(p, h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u1_Ph(p, h);
  pro.s := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s1_Ph(p, h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp1_Ph(p, h);
  pro.ddhp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1hp_Ph(p, h);
  pro.ddph := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ph_Ph(p, h);
  pro.duph := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1ph_Ph(p, h);
  pro.duhp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1hp_Ph(p, h);
  pro.x :=0;
end prop1_Ph;
