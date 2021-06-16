within ThermoSysPro.Properties.WaterSteamSimple;
function prop2_PT
  "thermodynamics properties in region 2, independent variables p and T "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.Temperature T "temperature";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_pT pro;

algorithm
  pro.h := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h2_PT(p, T);
  pro.s := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s2_Ph(p, pro.h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d2_Ph(p, pro.h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u2_Ph(p, pro.h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp2_Ph(p, pro.h);
  pro.ddTp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2Tp_PT(p, T);
  pro.ddpT := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2pT_PT(p, T);
  pro.duTp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du2Tp_PT(p, T);
  pro.dupT := ThermoSysPro.Properties.WaterSteamSimple.Energy.du2pT_PT(p, T);
  pro.x :=0;
end prop2_PT;
