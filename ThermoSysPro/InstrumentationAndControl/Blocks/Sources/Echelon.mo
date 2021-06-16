within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Echelon
  parameter Real hauteur=1 "Hauteur de l'échelon";
  parameter Real offset=0 "Décalage de la sortie";
  parameter Real startTime=0 "Instant de départ de l'échelon";

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = offset + (if time < startTime then 0 else hauteur);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
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
        Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={0,0,0})}),
    Window(
      x=0.18,
      y=0.17,
      width=0.6,
      height=0.6),
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
        Line(
          points={{-80,-18},{0,-18},{0,50},{80,50}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Text(
          extent={{-21,-72},{25,-90}},
          lineColor={160,160,164},
          textString=
               "startTime"),
        Line(
          points={{0,-17},{0,-71}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Text(
          extent={{-68,-36},{-22,-54}},
          lineColor={160,160,164},
          textString=
               "offset"),
        Line(
          points={{-13,50},{-13,-17}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{2,50},{-19,50},{2,50}},
          lineColor={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-13,50},{-16,37},{-9,37},{-13,50}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-68,26},{-22,8}},
          lineColor={160,160,164},
          textString=
               "hauteur"),
        Polygon(
          points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-13,-18},{-13,-70}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,90},{-37,70}},
          lineColor={160,160,164},
          textString=
               "y")}),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Echelon;
