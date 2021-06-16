within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Water_Ps
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.SpecificEntropy s "Specific entropy";
  input Integer mode = 0 "IF97 region. 0:automatic";
  output ThermoSysPro.Properties.WaterSteamSimple.ThermoProperties_ps pro;

//  Integer phase;
protected
  Integer region;

algorithm
  //phase := ThermoSysPro.Properties.WaterSteamSimple.phase_ps(p, s);
  region := ThermoSysPro.Properties.WaterSteamSimple.region_ps(
    p,
    s,
    mode);

  if (region == 1) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop1_Ps(p, s);
  elseif (region == 2) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop2_Ps(p, s);
  elseif (region == 4) then
    pro := ThermoSysPro.Properties.WaterSteamSimple.prop4_Ps(p, s);
  else
    assert(false, "Water_Ps: Incorrect region number (" + String(region) + ")");
  end if;
  annotation (
    Window(
      x=0.22,
      y=0.2,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
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
end Water_Ps;
