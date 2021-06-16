within ThermoSysPro.WaterSolution.BoundaryConditions;
model SourcePQ "Pressure and mass flow source"

  parameter Modelica.SIunits.AbsolutePressure P=1.e5 "Source presure";
  parameter Modelica.SIunits.MassFlowRate Q=10 "Mass flow rate";
  parameter Modelica.SIunits.Temperature T=300 "Source temperature";
  parameter Real Xh2o=0.05 "h2o mass fraction";

  ThermoSysPro.WaterSolution.Connectors.WaterSolutionOutlet Cs
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation

  Cs.Xh2o = Xh2o;
  Cs.T = T;
  Cs.Q = Q;
  Cs.P = P;

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
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Polygon(
          points={{-40,-40},{-40,40},{40,-40},{-40,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Polygon(
          points={{-40,-40},{-40,40},{40,-40},{-40,-40}},
          lineColor={0,0,255},
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
end SourcePQ;
