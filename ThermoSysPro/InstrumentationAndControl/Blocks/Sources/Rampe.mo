within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Rampe
  parameter Real Starttime=1 "Instant de départ de la rampe (s)";
  parameter Real Duration=2 "Durée de la rampe (s)";
  parameter Real Initialvalue=0 "Valeur initiale de la sortie";
  parameter Real Finalvalue=1 "Valeur finale de la sortie";
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = if time < Starttime then (Initialvalue) else if time > (Starttime
     + Duration) then (Finalvalue) else (Initialvalue + (Finalvalue -
    Initialvalue)*(time - Starttime)/Duration);
  annotation (
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
          points={{-80,-20},{-20,-20},{50,50}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-20},{-32,-30},{-27,-30},{-30,-20}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,-20},{-30,-70}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{-30,-70},{-33,-60},{-28,-60},{-30,-70},{-30,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,-33},{-30,-50}},
          lineColor={160,160,164},
          textString=
               "initialValue"),
        Text(
          extent={{-40,-70},{6,-88}},
          lineColor={160,160,164},
          textString=
               "startTime"),
        Text(
          extent={{-80,92},{-39,72}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Line(
          points={{-20,-20},{-20,-70}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{-19,-20},{50,-20}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{50,50},{101,50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{50,50},{50,-62}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{50,-20},{42,-18},{42,-22},{50,-20}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,50},{48,40},{53,40},{50,50}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,-72},{47,-62},{52,-62},{50,-72},{50,-72}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{53,25},{100,8}},
          lineColor={160,160,164},
          textString=
               "finalValue"),
        Text(
          extent={{0,-17},{35,-37}},
          lineColor={160,160,164},
          textString=
               "duration")}),
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
        Line(points={{-80,-70},{-40,-70},{31,38}}, color={0,0,0}),
        Line(points={{31,38},{86,38}}, color={0,0,0}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Window(
      x=0.2,
      y=0.15,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Rampe;
