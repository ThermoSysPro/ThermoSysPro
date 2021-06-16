within ThermoSysPro.Properties.WaterSteamSimple;
record PropThermoSat
  Modelica.SIunits.AbsolutePressure P "Pressure";
  Modelica.SIunits.Temperature T "Temperature";
  Modelica.SIunits.Density rho "Density";
  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  Modelica.SIunits.SpecificHeatCapacity cp
    "Specific heat capacity at constant pressure";
  Real pt "Derivative of pressure wrt. temperature";
  Modelica.SIunits.SpecificHeatCapacity cv
    "Specific heat capacity at constant volume";
  annotation (
    Window(
      x=0.15,
      y=0.32,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,50},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,127},
          fillPattern=FillPattern.Solid),
        Text(extent={{-127,115},{127,55}}, textString=
                                               "%name"),
        Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{0,50},{0,-100}}, color={0,0,0})}),
    Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end PropThermoSat;
