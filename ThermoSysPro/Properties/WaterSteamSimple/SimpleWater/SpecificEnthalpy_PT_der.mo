within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function SpecificEnthalpy_PT_der
  input Modelica.SIunits.AbsolutePressure p "pressure";
  input Modelica.SIunits.Temperature   T "Temperature";
  input Integer mode = 0 "Région IF97 - 0:calcul automatique";

  input Real p_der "Pression";
  input Real T_der "Température";

  output Real h_der "specific enthalpy";
protected
  Integer region;
  Boolean supercritical;
  Real dhp;
  Real dhT;

algorithm
  supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);

  region := ThermoSysPro.Properties.WaterSteamSimple.region_pT(
    p,
    T,
    mode);

  // Partial derivatives
  if (region == 1) then
    dhp := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh1pT_PT(p, T);
    dhT := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh1Tp_PT(p, T);
  elseif (region == 2) then
    dhp := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh2pT_PT(p, T);
    dhT := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.dh2Tp_PT(p, T);
  else
    assert(false, "Water_PT: Incorrect region number");
  end if;

  // Temporal derivative
  h_der:=dhp*p_der + dhT*T_der;

  annotation (
    Icon(graphics={
        Text(extent={{-134,104},{142,44}}, textString=
                                               "%name"),
        Ellipse(
          extent={{-100,40},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,-4},{84,-52}},
          lineColor={255,127,0},
          textString=
               "fonction")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end SpecificEnthalpy_PT_der;
