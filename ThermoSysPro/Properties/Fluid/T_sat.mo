within ThermoSysPro.Properties.Fluid;
function T_sat
  input Modelica.SIunits.AbsolutePressure P "Pressure";
  input Integer fluid  "Fluid number - 1: IF97 - 7: SimpleWater";

  output Modelica.SIunits.Temperature T "Temperature (K)";

algorithm

  if (fluid == 1) then
    T :=  ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(P);
  elseif (fluid == 7) then
    T := ThermoSysPro.Properties.WaterSteamSimple.Temperature.Tsat_P(P);
  else
    assert(false, "(T_sat) : incorrect fluid number");
  end if;

  annotation (
    smoothOrder=2,
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
    Window(
      x=0.06,
      y=0.1,
      width=0.75,
      height=0.73),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end T_sat;
