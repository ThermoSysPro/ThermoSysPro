within ThermoSysPro.WaterSolution.LoopBreakers;
model LoopBreakerXh2o "Xh20 loop breaker for the water solution connector"


  ThermoSysPro.WaterSolution.Connectors.WaterSolutionInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionOutlet Cs
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation

  Cs.Q = Ce.Q;
  Cs.T = Ce.T;
  Cs.P = Ce.P;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
          lineColor={127,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,-100}}, color={0,0,255}),
        Text(
          extent={{-42,38},{38,-42}},
          lineColor={0,0,255},
          textString=
               "Xh2o")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
          lineColor={127,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,-100}}, color={0,0,255}),
        Text(
          extent={{-40,38},{40,-42}},
          lineColor={0,0,255},
          textString=
               "Xh2o")}),
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
<li>Beno&icirc;t Bride</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end LoopBreakerXh2o;
