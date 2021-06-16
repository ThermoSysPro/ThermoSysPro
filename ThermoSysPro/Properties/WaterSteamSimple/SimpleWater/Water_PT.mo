within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_PT
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Integer mode=0 "IF97 region. 0:automatic";
  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_pT pro;

protected
  Integer region;
  Boolean supercritical;

algorithm
  supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);

  region := ThermoSysPro.Properties.WaterSteamSimple.region_pT(
    p,
    T,
    mode);

  if (region == 1) then
    ThermoSysPro.Properties.WaterSteamSimple.prop1_PT(p, T);
  elseif (region == 2) then
    ThermoSysPro.Properties.WaterSteamSimple.prop2_PT(p, T);
  else
    assert(false, "Water_PT: Incorrect region number");
  end if;

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
end Water_PT;
