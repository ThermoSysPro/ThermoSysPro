within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block Pulse
  parameter Real width=0.5 "Largeur des impulsions (s)";
  parameter Real period=1 "Periode des impulsions (s)";
  parameter Real startTime=0 "Instant de départ des impulsions";

protected
  Real T0;
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
algorithm

  when sample(startTime, period) then
    T0 := time;
  end when;

  yL.signal := (if time < startTime or time >= T0 + width then false else true);

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
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},{0,-70},{40,-70},{40,
              44},{79,44}}, color={0,0,0}),
        Rectangle(
          extent={{-100,-102},{100,100}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},{0,-70},{40,-70},{40,
              44},{79,44}}, color={0,0,0}),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,-72},{-14,-90}},
          lineColor={160,160,164},
          textString=
               "startTime"),
        Text(
          extent={{-82,91},{-41,71}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Line(
          points={{-78,-70},{-40,-70},{-40,20},{20,20},{20,-70},{50,-70},{50,20},
              {100,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,61},{-40,21}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{20,44},{20,20}},
          color={160,160,164},
          pattern=LinePattern.Dash),
        Line(
          points={{50,58},{50,20}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(points={{-40,53},{50,53}}, color={192,192,192}),
        Line(points={{-40,35},{20,35}}, color={192,192,192}),
        Text(
          extent={{-30,67},{16,55}},
          lineColor={160,160,164},
          textString=
               "period"),
        Text(
          extent={{-35,49},{14,37}},
          lineColor={160,160,164},
          textString=
               "width"),
        Line(
          points={{-80,20},{-41,20}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{-40,35},{-31,37},{-31,33},{-40,35}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,35},{12,37},{12,33},{20,35}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,53},{-31,55},{-31,51},{-40,53}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,53},{42,55},{42,51},{50,53}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-109,28},{-77,14}},
          lineColor={160,160,164},
          textString=
               "true"),
        Text(
          extent={{-101,-56},{-80,-71}},
          lineColor={160,160,164},
          textString=
               "false")}),
    Window(
      x=0.09,
      y=0.3,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Pulse;
