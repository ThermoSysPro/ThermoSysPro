within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Trapezoide
  parameter Real amplitude=1 "Amplitude du trapèze";
  parameter Real rising(final min=0) = 0.5 "Durée du front montant (s)";
  parameter Real largeur(final min=0) = 2 "Largeur du trapèze (s)";
  parameter Real falling(final min=0) = 0.5 "Durée du front descendant (s)";
  parameter Real periode(final min=Modelica.Constants.small) = 4 "Période (s)";
  parameter Integer n=-1 "Nombre de périodes (< 0 nombre de périodes infini)";
  parameter Real offset=0 "Décalage de la sortie";
  parameter Real startTime=0 "Instant de départ de l'échelon";

protected
  Real T0(final start=startTime) "Instant de départ de la période courante";
  Integer counter(start=n);
  Integer counter2(start=n);
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  when ((pre(counter2) <> 0) and sample(startTime, periode)) then
    T0 = time;
    counter2 = pre(counter);
    counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
  end when;

  y.signal = offset + (if (time < startTime or (counter2 == 0) or (time >= T0
     + rising + largeur + falling)) then 0 else if (time < T0 + rising) then (
    time - T0)*amplitude/rising else if (time < T0 + rising + largeur) then
    amplitude else (T0 + rising + largeur - time)*amplitude/falling + amplitude);
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
        Line(points={{-81,-70},{-60,-70},{-30,40},{9,40},{39,-70},{61,-70},{90,
              40}}, color={0,0,0})}),
    Window(
      x=0.16,
      y=0.11,
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
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-45,-30},{-47,-41},{-43,-41},{-45,-30}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-45,-31},{-45,-70}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Polygon(
          points={{-45,-70},{-47,-60},{-43,-60},{-45,-70},{-45,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,-43},{-43,-55}},
          lineColor={160,160,164},
          textString=
               "offset"),
        Text(
          extent={{-47,-69},{-1,-87}},
          lineColor={160,160,164},
          textString=
               "startTime"),
        Text(
          extent={{-84,91},{-43,71}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Line(
          points={{-29,82},{-30,-70}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{-10,59},{-10,40}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{20,59},{20,39}},
          color={160,160,164},
          pattern=LinePattern.Dash),
        Line(
          points={{40,59},{40,-30}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(points={{-20,76},{61,76}}, color={192,192,192}),
        Line(points={{-29,56},{40,56}}, color={192,192,192}),
        Text(
          extent={{-2,86},{25,77}},
          lineColor={160,160,164},
          textString=
               "periode"),
        Text(
          extent={{-8,70},{21,60}},
          lineColor={160,160,164},
          textString=
               "largeur"),
        Line(
          points={{-42,40},{-10,40}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{-39,40},{-39,-19}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Text(
          extent={{-77,14},{-40,0}},
          lineColor={160,160,164},
          textString=
               "amplitude"),
        Polygon(
          points={{-29,56},{-22,58},{-22,54},{-29,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,56},{-17,58},{-17,54},{-10,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-29,76},{-20,78},{-20,74},{-29,76}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{61,76},{53,78},{53,74},{61,76}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-30},{-30,-30},{-10,40},{20,40},{40,-30},{60,-30},{80,40},
              {100,40}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{-39,40},{-41,29},{-37,29},{-39,40}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-39,-29},{-41,-19},{-37,-19},{-39,-29},{-39,-29}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{61,84},{60,-30}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{39,56},{32,58},{32,54},{39,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,56},{27,58},{27,54},{20,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,56},{13,58},{13,54},{20,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,56},{-5,58},{-5,54},{-12,56}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,70},{-5,60}},
          lineColor={160,160,164},
          textString=
               "rising"),
        Text(
          extent={{16,70},{45,60}},
          lineColor={160,160,164},
          textString=
               "falling")}),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Trapezoide;
