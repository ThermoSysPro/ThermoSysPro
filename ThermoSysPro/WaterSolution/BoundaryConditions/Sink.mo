within ThermoSysPro.WaterSolution.BoundaryConditions;
model Sink "Sink"

public
  Modelica.SIunits.AbsolutePressure P "Sink pressure";
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  Modelica.SIunits.Temperature T "Sink Temperature";
  Real Xh2o "h2o mas fraction";

  ThermoSysPro.WaterSolution.Connectors.WaterSolutionInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
equation

  Ce.Xh2o = Xh2o;
  Ce.T = T;
  Ce.Q = Q;
  Ce.P = P;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,40},{-40,-40},{40,-40},{-40,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-40,0},{-58,10}}),
        Line(points={{-40,0},{-58,-10}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-40,0},{-58,10}}),
        Line(points={{-40,0},{-58,-10}}),
        Polygon(
          points={{-40,40},{-40,-40},{40,-40},{-40,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.09,
      y=0.2,
      width=0.66,
      height=0.69),
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
end Sink;
