within ThermoSysPro.Properties.WaterSteamSimple;
function prop2_Ps
  "thermodynamics properties in region 2, independent variables p and h "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ps pro;

algorithm
  pro.h := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h2_Ps(p, s);
  pro.T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T2_Ph(p, pro.h);
  pro.d := ThermoSysPro.Properties.WaterSteamSimple.Density.d2_Ph(p, pro.h);
  pro.u := ThermoSysPro.Properties.WaterSteamSimple.Energy.u2_Ph(p, pro.h);
  pro.cp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp2_Ph(p, pro.h);
  pro.ddsp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2sp_Ps(p, s);
  pro.ddps := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2ps_Ps(p, s);
  pro.x :=1;
end prop2_Ps;
