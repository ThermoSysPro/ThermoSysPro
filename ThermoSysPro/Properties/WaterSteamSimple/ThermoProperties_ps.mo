within ThermoSysPro.Properties.WaterSteamSimple;
record ThermoProperties_ps
  Modelica.SIunits.Temperature T(
    min=WaterSteam.InitLimits.TMIN,
    max=WaterSteam.InitLimits.TMAX,
    nominal=WaterSteam.InitLimits.TNOM) "Temperature";
  Modelica.SIunits.Density d(
    min=WaterSteam.InitLimits.DMIN,
    max=WaterSteam.InitLimits.DMAX,
    nominal=WaterSteam.InitLimits.DNOM) "Density";
  Modelica.SIunits.SpecificEnergy u(
    min=WaterSteam.InitLimits.SEMIN,
    max=WaterSteam.InitLimits.SEMAX,
    nominal=WaterSteam.InitLimits.SENOM) "Specific inner energy";
  Modelica.SIunits.SpecificEnthalpy h(
    min=WaterSteam.InitLimits.SHMIN,
    max=WaterSteam.InitLimits.SHMAX,
    nominal=WaterSteam.InitLimits.SHNOM) "Specific enthalpy";
  Modelica.SIunits.SpecificHeatCapacity cp(
    min=WaterSteam.InitLimits.CPMIN,
    max=WaterSteam.InitLimits.CPMAX,
    nominal=WaterSteam.InitLimits.CPNOM)
    "Specific heat capacity at constant pressure";
  ThermoSysPro.Units.DerDensityByEntropy ddsp
    "Derivative of the density wrt. specific entropy at constant pressure";
  Modelica.SIunits.DerDensityByPressure ddps
    "Derivative of the density wrt. pressure at constant specific entropy";
  ThermoSysPro.Units.MassFraction x "Vapor mass fraction";
  annotation (
    Window(
      x=0.31,
      y=0.2,
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
<p><b>Version 1.5</b></p>
</HTML>
"));
end ThermoProperties_ps;
