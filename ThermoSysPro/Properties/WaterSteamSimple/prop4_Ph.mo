within ThermoSysPro.Properties.WaterSteamSimple;
function prop4_Ph
  "thermodynamics properties in region 4, independent variables p and h "
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph pro;

protected
  Modelica.SIunits.SpecificEnthalpy h1sat
    "Specific enthalpy at liquid saturation";
  Modelica.SIunits.SpecificEnthalpy h2sat
    "Specific enthalpy at vapor saturation";
  Modelica.SIunits.Temperature T1sat "Temperature at liquid saturation";
  Modelica.SIunits.Temperature T2sat "Temperature at vapor saturation";
  Modelica.SIunits.Density d1sat "Density at liquid saturation";
  Modelica.SIunits.Density d2sat "Density at vapor saturation";
  Modelica.SIunits.SpecificEnergy u1sat
    "Specific inner energy at liquid saturation";
  Modelica.SIunits.SpecificEnergy u2sat
    "Specific inner energy at vapor saturation";
  Modelica.SIunits.SpecificEntropy s1sat
    "Specific entropy at liquid saturation";
  Modelica.SIunits.SpecificEntropy s2sat "Specific entropy at vapor saturation";
  Modelica.SIunits.SpecificHeatCapacity cp1sat
    "Specific heat capacity at liquid saturation";
  Modelica.SIunits.SpecificHeatCapacity cp2sat
    "Specific heat capacity at vapor saturation";
  Modelica.SIunits.DerDensityByPressure dd1satp
    "Derivate of density at liquid saturation wrt. pressure";
  Modelica.SIunits.DerDensityByPressure dd2satp
    "Derivative of density at vapor saturation wrt. pressure";
  Real du1satp(unit="m3/kg")
    "Derivative of specific inner energy at liquid saturation wrt. pressure";
  Real du2satp(unit="m3/kg")
    "Derivative of specific inner energy at vapor saturation wrt. pressure";
  Real dxh(unit="kg/J") "Derivative of quality wrt. enthalpy";
  Real dxp(unit="1/Pa") "Derivative of quality wrt. pressure";
  Real dh1satp(unit="m3/kg")
    "Derivative of specific enthalpy at liquid saturation wrt. pressure";
  Real dh2satp(unit="m3/kg")
    "Derivative of specific enthalpy at vapor saturation wrt. pressure";
  ThermoSysPro.Units.MassFraction x "Vapor mass fraction";

algorithm
  h1sat := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1sat_P(p);
  h2sat := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h2sat_P(p);

  T1sat := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T1_Ph(p, h1sat);
  d1sat := ThermoSysPro.Properties.WaterSteamSimple.Density.d1_Ph(p, h1sat);
  u1sat := ThermoSysPro.Properties.WaterSteamSimple.Energy.u1_Ph(p, h1sat);
  s1sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s1_Ph(p, h1sat);
  cp1sat := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp1_Ph(p,
    h1sat);
  T2sat := ThermoSysPro.Properties.WaterSteamSimple.Temperature.T2_Ph(p, h2sat);
  d2sat := ThermoSysPro.Properties.WaterSteamSimple.Density.d2_Ph(p, h2sat);
  u2sat := ThermoSysPro.Properties.WaterSteamSimple.Energy.u2_Ph(p, h2sat);
  s2sat := ThermoSysPro.Properties.WaterSteamSimple.Entropy.s2_Ph(p, h2sat);
  cp2sat := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.cp2_Ph(p,
    h2sat);

  x :=(h - h1sat)/(h2sat - h1sat);
  pro.x := x;
  pro.T := (1-x)*T1sat + x*T2sat;

  pro.d := 1/((1-x)/d1sat + x/d2sat);

  pro.u := (1-x)*u1sat + x*u2sat;

  pro.s := (1-x)*s1sat + x*s2sat;

  pro.cp := (1-x)*cp1sat + x*cp2sat;

  // Derivatives
  dxh :=1/(h2sat - h1sat);
  dxp := -(dh1satp + x*(dh2satp - dh1satp))/(h2sat - h1sat);

  dd1satp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ph_Ph(p, h1sat);
  du1satp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1ph_Ph(p, h1sat);
  dd2satp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd2ph_Ph(p, h2sat);
  du2satp := ThermoSysPro.Properties.WaterSteamSimple.Energy.du2ph_Ph(p, h2sat);

  dh1satp := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh1satp_P(p);
  dh2satp := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh2satp_P(p);

  pro.ddhp := - pro.d^2*(-dxh/d1sat + dxh/d2sat);

  pro.ddph := - pro.d^2*(-dxp/d1sat + (1-x)*(-1/d1sat^2)*dd1satp + dxp/d2sat + x*(-1/d2sat^2)*dd2satp);

  pro.duph := -dxp*u1sat + (1-x)*du1satp + dxp*u2sat + x*du2satp;

  pro.duhp := -dxh*u1sat + dxh*u2sat;

end prop4_Ph;
