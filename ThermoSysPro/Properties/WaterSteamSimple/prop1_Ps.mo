within ThermoSysPro.Properties.WaterSteamSimple;
function prop1_Ps
  "thermodynamics properties in region 1, independent variables p and s "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ps pro;

algorithm
  pro.h := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1_Ps(p, s);
  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T1_Ph(p, pro.h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d1_Ph(p, pro.h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u1_Ph(p, pro.h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp1_Ph(p, pro.h);
  pro.ddsp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1sp_Ps(p, s);
  pro.ddps := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ps_Ps(p, s);
  pro.x :=0;
end prop1_Ps;
