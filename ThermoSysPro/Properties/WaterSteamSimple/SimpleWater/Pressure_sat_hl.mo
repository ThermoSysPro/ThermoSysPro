within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Pressure_sat_hl
  input Modelica.SIunits.SpecificEnthalpy hl
    "Liquid specific enthalpy on the saturation line";

  output Modelica.SIunits.AbsolutePressure p
    "Liquid pressure on the saturation line";

algorithm
  assert(hl > ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1sat_P(
    ThermoSysPro.Properties.WaterSteamSimple.triple.ptriple),
    "Pressure_sat_hl called with too low specific enthalpy (below triple point)");
  assert(hl < ThermoSysPro.Properties.WaterSteamSimple.critical.HCRIT,
    "Pressure_sat_hl called with too high specific enthalpy (above critical point)");

  p := ThermoSysPro.Properties.WaterSteamSimple.Pressure.psat1_h(hl);
  annotation (
    derivative = Pressure_sat_hl_der,
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
<p><b>Version 1.2</b> </p>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro_AJ Version 2.0</b></p>
</HTML>
"));
end Pressure_sat_hl;
