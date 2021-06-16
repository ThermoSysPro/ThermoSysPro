within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function SpecificEnthalpy_PT
  input Modelica.SIunits.AbsolutePressure p "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";
  input Integer mode = 0 "IF97 region. 0:automatic";

  output Modelica.SIunits.SpecificEnthalpy H "Specific enthalpy";

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
    H := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h1_PT(p, T);
  elseif (region == 2) then
    H := ThermoSysPro.Properties.WaterSteamSimple.Enthalpy.h2_PT(p, T);
  else
    assert(false, "Water_PT: Incorrect region number");
  end if;

  annotation (
    derivative(noDerivative=mode) = SpecificEnthalpy_PT_der,
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
end SpecificEnthalpy_PT;
