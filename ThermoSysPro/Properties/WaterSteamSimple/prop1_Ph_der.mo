within ThermoSysPro.Properties.WaterSteamSimple;
function prop1_Ph_der
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

  input Real p_der "derivative of Pressure";
  input Real h_der "derivative of Specific enthalpy";

  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ph der_pro
    "Derivative";

protected
  Real dTp "Derivative of temperature wrt. pressure";
  Real dTh "Derivative of temperature wrt. enthalpy";
  Real ddp "Derivative of density wrt. pressure";
  Real ddh "Derivative of density wrt. enthalpy";
  Real dup "Derivative of specific inner energy wrt. pressure";
  Real duh "Derivative of specific inner energy wrt. enthalpy";
  Real dsp "Derivative of specific entropy wrt. pressure";
  Real dsh "Derivative of specific entropy wrt. enthalpy";
  Real dcp "Derivative of specific heat capacity wrt. pressure";
  Real dch "Derivative of specific heat capacity wrt. enthalpy";
  Real d2dhp "Second derivative of density wrt. enthalpy and pressure";
  Real d2dhh "Second derivative of density wrt. enthalpy";
  Real d2dpp "Second derivative of density wrt. pressure";
  Real d2uhp
    "Second derivative of specific inner energy wrt. enthalpy and pressure";
  Real d2uhh "Second derivative of specific inner energy wrt. enthalpy";
  Real d2upp "Second derivative of specific inner energy wrt. pressure";

algorithm
  //First derivatives
  dTp := ThermoSysPro.Properties.WaterSteamSimple.Temperature.dT1ph_Ph(p, h);
  dTh := ThermoSysPro.Properties.WaterSteamSimple.Temperature.dT1ph_Ph(p, h);
  ddp := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ph_Ph(p, h);
  ddh := ThermoSysPro.Properties.WaterSteamSimple.Density.dd1ph_Ph(p, h);
  dup := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1ph_Ph(p, h);
  duh := ThermoSysPro.Properties.WaterSteamSimple.Energy.du1ph_Ph(p, h);
  dsp := ThermoSysPro.Properties.WaterSteamSimple.Entropy.ds1ph_Ph(p, h);
  dsh := ThermoSysPro.Properties.WaterSteamSimple.Entropy.ds1ph_Ph(p, h);
  dcp := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcp1ph_Ph(p, h);
  dch := ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity.dcp1ph_Ph(p, h);

  der_pro.T := dTp*p_der + dTh*h_der;
  der_pro.d := ddp*p_der + ddh*h_der;
  der_pro.u := dup*p_der + duh*h_der;
  der_pro.s := dsp*p_der + dsh*h_der;
  der_pro.cp := dcp*p_der + dch*h_der;
  der_pro.x :=0;

  //Second derivatives
  d2dhp := ThermoSysPro.Properties.WaterSteamSimple.Density.d2d1hp_Ph(p, h);
  d2dhh := ThermoSysPro.Properties.WaterSteamSimple.Density.d2d1hh_Ph(p, h);
  d2dpp := ThermoSysPro.Properties.WaterSteamSimple.Density.d2d1pp_Ph(p, h);
  d2uhp := ThermoSysPro.Properties.WaterSteamSimple.Energy.d2u1hp_Ph(p, h);
  d2uhh := ThermoSysPro.Properties.WaterSteamSimple.Energy.d2u1hh_Ph(p, h);
  d2upp := ThermoSysPro.Properties.WaterSteamSimple.Energy.d2u1pp_Ph(p, h);

  der_pro.ddhp := d2dhp*p_der + d2dhh*h_der;
  der_pro.ddph := d2dpp*p_der + d2dhp*h_der;
  der_pro.duph := d2uhp*p_der + d2uhh*h_der;
  der_pro.duhp := d2upp*p_der + d2uhp*h_der;

end prop1_Ph_der;
