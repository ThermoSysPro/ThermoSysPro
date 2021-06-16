within ThermoSysPro.Properties.WaterSteamSimple.SimpleWater;
function SurfaceTension_T
  input Modelica.SIunits.Temperature T "Temperature";

  output Modelica.SIunits.SurfaceTension sigma "Surface tension";
algorithm
  sigma :=
    ThermoSysPro.Properties.WaterSteamSimple.SurfaceTension.SurfaceTension_T(T);

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
      x=0.33,
      y=0.34,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end SurfaceTension_T;
