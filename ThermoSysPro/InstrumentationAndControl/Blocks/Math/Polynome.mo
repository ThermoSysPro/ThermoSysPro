within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Polynome
  parameter Real a[:]={1,1} "Vecteur des coefficients du polynome";

protected
  parameter Integer n=size(a, 1) - 1;
  Real xp[n + 1];
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  xp[1] = 1;

  for i in 1:n loop
    xp[i + 1] = xp[i]*u.signal;
  end for;

  y.signal = a*xp;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{66,58}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={192,192,192},
          textString=
               "PI"),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Text(
          extent={{-138,-72},{162,-32}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,
              1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{
              -39,-64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},
              {23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{
              59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{
              77.6,61.1},{80,80}}, color={0,0,0}),
        Text(
          extent={{-36,14},{36,-34}},
          lineColor={192,192,192},
          textString=
               "pol")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{66,58}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={192,192,192},
          textString=
               "PI"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,
              1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{
              -39,-64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},
              {23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{
              59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{
              77.6,61.1},{80,80}}, color={0,0,0}),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{66,58}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={192,192,192},
          textString=
               "PI"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Polygon(
          points={{-72,86},{-80,64},{-64,64},{-72,84},{-72,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,
              1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{
              -39,-64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},
              {23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{
              59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{
              77.6,61.1},{80,80}}, color={0,0,0}),
        Text(
          extent={{-69,86},{-42,66}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{68,-46},{92,-66}},
          lineColor={160,160,164},
          textString=
               "u")}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Polynome;
