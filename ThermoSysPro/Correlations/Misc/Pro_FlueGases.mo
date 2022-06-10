within ThermoSysPro.Correlations.Misc;
record Pro_FlueGases
  "Flue gases properties for the computation of correlations"
  Units.SI.Density rhoMF(start=0.5) "Flue gases average density";
  Units.SI.SpecificHeatCapacity cpMF(start=500)
    "Flue gases average specific heat capacity";
  Units.SI.DynamicViscosity muMF(start=1.e-5)
    "Flue gases average dynamic viscosity";
  Units.SI.ThermalConductivity kMF(start=0.10)
    "Flue gases average thermal conductivity";
  Units.SI.SpecificHeatCapacity cpMFF(start=500) "Film specific heat capacity";
  Units.SI.DynamicViscosity muMFF(start=1.e-5) "Film dynamic viscosity";
  Units.SI.ThermalConductivity kMFF(start=0.10) "Film thermal conductivity";
  Real Xtot " ";

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

end Pro_FlueGases;
