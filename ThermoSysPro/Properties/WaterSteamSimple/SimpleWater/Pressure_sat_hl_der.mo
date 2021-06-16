within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function Pressure_sat_hl_der
  input Modelica.SIunits.SpecificEnthalpy hl
    "Liquid specific enthalpy on the saturation line";
  input Real hl_der;

  output Real p_der;

algorithm
  assert(hl > ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1sat_P(
    ThermoSysPro.Properties.WaterSteamSimple.triple.ptriple),
    "Pressure_sat_hl_der called with too low specific enthalpy (below triple point)");
  assert(hl < ThermoSysPro.Properties.WaterSteamSimple.critical.HCRIT,
    "Pressure_sat_hl_der called with too high specific enthalpy (above critical point)");

  p_der := hl_der*ThermoSysPro.Properties.WaterSteamSimple.Pressure.dpsat1h_h(
    hl);
annotation (
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
<p>Needs to be redone. Iterative functions don&apos;t work for Analytic Jacobian</p>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro_AJ Version 2.0</b></p>
</HTML>
"));
end Pressure_sat_hl_der;
