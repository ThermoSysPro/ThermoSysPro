within ThermoSysPro.Correlations.Misc;
record Pro_TwoPhaseWaterSteam
  "Water/steam properties for the computation of correlations"
  Units.SI.Density rhol "Density of the liquid phase";
  Units.SI.Density rhov "Density of the vapor phase";
  Units.SI.SpecificEnthalpy hl "Specific enthalpy of the liquid phase";
  Units.SI.SpecificEnthalpy hv "Specific enthalpy of the vapor phase";
  Units.SI.SpecificEnergy lv "Phase transition energy";
  Units.SI.SpecificHeatCapacity cpl
    "Specific heat capacity of the liquid phase";
  Units.SI.SpecificHeatCapacity cpv "Specific heat capacity of the vapor phase";
  Units.SI.DynamicViscosity mul "Dynamic viscosity of the liquid phase";
  Units.SI.DynamicViscosity muv "Dynamic viscosity of the vapor phase";
  Units.SI.ThermalConductivity kl "Thermal conductivity of the liquid phase";
  Units.SI.ThermalConductivity kv "Thermal conductivity of the vapor phase";
  Units.SI.SurfaceTension tsl "Surface tension of the liquid phase";
  Units.SI.Density rholv "Density of the water/steam mixture";
  Units.SI.SpecificEnthalpy hlv "Specific enthalpy of the water/steam mixture";

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,50},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,127},
          fillPattern=FillPattern.Solid),
        Text(extent={{-127,115},{127,55}}, textString=
                                               "%name"),
        Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Line(points={{0,50},{0,-100}}, color={0,0,0})}),
                                                      Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</h4>
</HTML>
"));
end Pro_TwoPhaseWaterSteam;
