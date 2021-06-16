within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block SampleTrigger
  parameter Real period=1 "Periode des impulsions (s)";
  parameter Real startTime=0 "Instant de départ des impulsions";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
algorithm

  yL.signal := sample(startTime, period);

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
                                                "%name"),
        Line(points={{-60,-70},{-60,70}}, color={0,0,0}),
        Line(points={{-20,-70},{-20,70}}, color={0,0,0}),
        Line(points={{20,-70},{20,70}}, color={0,0,0}),
        Line(points={{60,-70},{60,70}}, color={0,0,0})}),
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
          extent={{-53,-71},{-7,-89}},
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
          points={{-30,47},{-30,19}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{0,47},{0,18}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(points={{-30,41},{0,41}}, color={192,192,192}),
        Text(
          extent={{-37,61},{9,49}},
          lineColor={160,160,164},
          textString=
               "period"),
        Line(
          points={{-80,19},{-30,19}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{-30,41},{-21,43},{-21,39},{-30,41}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,41},{-8,43},{-8,39},{0,41}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,28},{-80,13}},
          lineColor={160,160,164},
          textString=
               "true"),
        Text(
          extent={{-100,-56},{-80,-71}},
          lineColor={160,160,164},
          textString=
               "false"),
        Line(
          points={{0,-70},{0,19}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,-70},{-30,19}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,-70},{30,19}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-70},{60,19}},
          color={0,0,0},
          thickness=0.5)}),
    Window(
      x=0.05,
      y=0.32,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end SampleTrigger;
