within ThermoSysPro.Correlations.Misc;
record Pro_WaterSteam
  "Water/steam properties for the computation of correlations"
  Modelica.SIunits.Temperature TEE
    "Water/steam temperature at the inlet of the exchanger";
  Modelica.SIunits.Temperature TME "Average water/steam temperature";
  Modelica.SIunits.Density rhoME "Average water/steam density";
  Modelica.SIunits.Density rhoSE
    "Water/steam density at the outlet of the exchanger";
  Modelica.SIunits.AbsolutePressure PME(start=100e5)
    "Average water/steam pressure";
  Modelica.SIunits.SpecificEntropy SME "Average water/steam specific entropy";
  Real xm "Average steam mass fraction";
  Modelica.SIunits.SpecificHeatCapacity cpME
    "Water/steam specific heat capacity";
  Modelica.SIunits.DynamicViscosity muME "Water/steam dynamic viscosity";
  Modelica.SIunits.ThermalConductivity kME "Water/steam thermal conductivity";

  annotation (
    Window(
      x=0.11,
      y=0.17,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
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

end Pro_WaterSteam;
