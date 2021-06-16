within ThermoSysPro.WaterSteam.LoopBreakers;
model LoopBreakerP "Pressure loop breaker for the water/steam connector"


public
  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FluidOutlet C2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation

  C1.Q = C2.Q;
  C1.h = C2.h;

  /* Flow reversal */
  0 = if (C1.Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,0}),
        Line(points={{0,100},{0,-100}}, color={0,0,255}),
        Text(
          extent={{-40,38},{40,-42}},
          lineColor={0,0,255},
          textString=
               "P")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,0}),
        Line(points={{0,100},{0,-100}}, color={0,0,255}),
        Text(
          extent={{-38,38},{42,-42}},
          lineColor={0,0,255},
          textString=
               "P")}),
    Window(
      x=0.33,
      y=0.09,
      width=0.71,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end LoopBreakerP;
