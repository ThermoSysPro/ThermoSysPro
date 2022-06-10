within ThermoSysPro.Properties.WaterSteamSimple;
record ThermoProperties_pT
  Units.SI.Density d(
    min=WaterSteam.InitLimits.DMIN,
    max=WaterSteam.InitLimits.DMAX,
    nominal=WaterSteam.InitLimits.DNOM) "Density";
  Units.SI.SpecificEnthalpy h(
    min=WaterSteam.InitLimits.SHMIN,
    max=WaterSteam.InitLimits.SHMAX,
    nominal=WaterSteam.InitLimits.SHNOM) "Specific enthalpy";
  Units.SI.SpecificEnergy u(
    min=WaterSteam.InitLimits.SEMIN,
    max=WaterSteam.InitLimits.SEMAX,
    nominal=WaterSteam.InitLimits.SENOM) "Specific inner energy";
  Units.SI.SpecificEntropy s(
    min=WaterSteam.InitLimits.SSMIN,
    max=WaterSteam.InitLimits.SSMAX,
    nominal=WaterSteam.InitLimits.SSNOM) "Specific entropy";
  Units.SI.SpecificHeatCapacity cp(
    min=WaterSteam.InitLimits.CPMIN,
    max=WaterSteam.InitLimits.CPMAX,
    nominal=WaterSteam.InitLimits.CPNOM)
    "Specific heat capacity at constant presure";
  Units.SI.DerDensityByTemperature ddTp
    "Derivative of the density wrt. temperature at constant pressure";
  Units.SI.DerDensityByPressure ddpT
    "Derivative of the density wrt. presure at constant temperature";
  Units.SI.DerEnergyByPressure dupT
    "Derivative of the inner energy wrt. pressure at constant temperature";
  Units.SI.SpecificHeatCapacity duTp
    "Derivative of the inner energy wrt. temperature at constant pressure";
  ThermoSysPro.Units.SI.MassFraction x "Vapor mass fraction";
  annotation (
    Window(
      x=0.23,
      y=0.19,
      width=0.68,
      height=0.71),
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
end ThermoProperties_pT;
