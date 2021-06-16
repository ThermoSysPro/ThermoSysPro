within ThermoSysPro.Properties.WaterSteamSimple;
record ThermoProperties_ph
  Modelica.SIunits.Temperature T(
    min=InitLimits.TMIN,
    max=InitLimits.TMAX,
    nominal=InitLimits.TNOM) "Temperature";
  Modelica.SIunits.Density d(
    min=InitLimits.DMIN,
    max=InitLimits.DMAX,
    nominal=InitLimits.DNOM) "Density";
  Modelica.SIunits.SpecificEnergy u(
    min=InitLimits.SEMIN,
    max=InitLimits.SEMAX,
    nominal=InitLimits.SENOM) "Specific inner energy";
  Modelica.SIunits.SpecificEntropy s(
    min=InitLimits.SSMIN,
    max=InitLimits.SSMAX,
    nominal=InitLimits.SSNOM) "Specific entropy";
  Modelica.SIunits.SpecificHeatCapacity cp(
    min=InitLimits.CPMIN,
    max=InitLimits.CPMAX,
    nominal=InitLimits.CPNOM) "Specific heat capacity at constant presure";
  Modelica.SIunits.DerDensityByEnthalpy ddhp
    "Derivative of density wrt. specific enthalpy at constant pressure";
  Modelica.SIunits.DerDensityByPressure ddph
    "Derivative of density wrt. pressure at constant specific enthalpy";
  Real duph(unit="m3/kg")
    "Derivative of specific inner energy wrt. pressure at constant specific enthalpy";
  Real duhp(unit = "1")
    "Derivative of specific inner energy wrt. specific enthalpy at constant pressure";
  ThermoSysPro.Units.MassFraction x "Vapor mass fraction";

  annotation (
    Window(
      x=0.21,
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
end ThermoProperties_ph;
