within ThermoSysPro.WaterSolution.BoundaryConditions;
model RefXh2o "Fixed Xh20 reference"
  parameter Real Xh2o0=0.5 "Fixed Xh2o";

  Connectors.WaterSolutionInlet C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.WaterSolutionOutlet C2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IXh2o
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));

equation
  if (cardinality(IXh2o) == 0) then
    IXh2o.signal = Xh2o0;
  end if;

  C1.P = C2.P;
  C1.T = C2.T;
  C1.Q = C2.Q;
  C1.Xh2o = C2.Xh2o;

  C1.Xh2o = IXh2o.signal;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Xh2o")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Xh2o")}),
    Window(
      x=0.06,
      y=0.08,
      width=0.82,
      height=0.65),
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
</html>"),
    DymolaStoredErrors);
end RefXh2o;
