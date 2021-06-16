within ThermoSysPro.WaterSolution.BoundaryConditions;
model SourceP "Pressure source"
  parameter Modelica.SIunits.AbsolutePressure P0=300000 "Source pressure";
  parameter Modelica.SIunits.Temperature T0=290 "Source temperature";
  parameter Real Xh2o0=0.5 "Source water mass fraction";

public
  Modelica.SIunits.AbsolutePressure P "Fluid pressure";
  Modelica.SIunits.MassFlowRate Q "Mass flow";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Modelica.SIunits.SpecificEnthalpy Xh2o "Water mass fraction";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ITemperature
    annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPressure
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IXh2o
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Connectors.WaterSolutionOutlet C
                                annotation (Placement(transformation(extent={{
            90,-10},{110,10}}, rotation=0)));
equation

  C.P = P;
  C.Q = Q;
  C.T = T;
  C.Xh2o = Xh2o;

  if (cardinality(IPressure) == 0) then
    IPressure.signal = P0;
  end if;

  P = IPressure.signal;

  if (cardinality(ITemperature) == 0) then
    ITemperature.signal = T0;
  end if;

  T = ITemperature.signal;

  if (cardinality(IXh2o) == 0) then
    IXh2o.signal = Xh2o0;
  end if;

  Xh2o = IXh2o.signal;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(extent={{-58,30},{-40,10}}, textString=
                                             "P"),
        Text(extent={{-28,60},{-10,40}}, textString=
                                             "T"),
        Text(extent={{-28,-40},{-10,-60}}, textString=
                                               "Xh20"),
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
        Text(extent={{-96,28},{96,-28}}, textString=
                                             "S")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(extent={{-28,60},{-10,40}}, textString=
                                             "T"),
        Text(extent={{-58,30},{-40,10}}, textString=
                                             "P"),
        Text(extent={{-28,-40},{-10,-60}}, textString=
                                               "h"),
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
        Text(extent={{-96,28},{96,-28}}, textString=
                                             "S")}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
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
end SourceP;
