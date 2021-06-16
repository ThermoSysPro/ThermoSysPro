within ThermoSysPro.Properties.WaterSteamSimple;
function prop1_PT
  "thermodynamics properties in region 1, independent variables p and T "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.Temperature T "temperature";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_pT pro;

algorithm
  pro.h := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1_PT(p, T);
  pro.s := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s1_Ph(p, pro.h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d1_Ph(p, pro.h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u1_Ph(p, pro.h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp1_Ph(p, pro.h);
  pro.ddTp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1Tp_PT(p, T);
  pro.ddpT := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1pT_PT(p, T);
  pro.duTp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1Tp_PT(p, T);
  pro.dupT := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1pT_PT(p, T);
  pro.x :=0;
end prop1_PT;
