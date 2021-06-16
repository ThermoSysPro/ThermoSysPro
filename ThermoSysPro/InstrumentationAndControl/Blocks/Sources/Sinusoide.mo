within ThermoSysPro.InstrumentationAndControl.Blocks.Sources;
block Sinusoide
  parameter Real amplitude=1 "Amplitude";
  parameter Real period=1 "Periode (s)";
  parameter Real phase=0 "Phase (rad)";
  parameter Real offset=0 "Décalage de la sortie";
  parameter Real startTime=0 "Instant de départ de la sinusoide (s)";

protected
  constant Real pi=Modelica.Constants.pi;
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = offset + (if time < startTime then 0 else amplitude*
    Modelica.Math.sin(2*pi*(time - startTime)/period + phase));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,-90},{-80,84}}, color={192,192,192}),
        Polygon(
          points={{-80,100},{-86,84},{-74,84},{-80,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-99,-40},{85,-40}}, color={192,192,192}),
        Polygon(
          points={{101,-40},{85,-34},{85,-46},{101,-40}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,0},{-31.6,34.2},{-26.1,53.1},{-21.3,66.4},{-17.1,74.6},{
              -12.9,79.1},{-8.64,79.8},{-4.42,76.6},{-0.201,69.7},{4.02,59.4},{
              8.84,44.1},{14.9,21.2},{27.5,-30.8},{33,-50.2},{37.8,-64.2},{42,
              -73.1},{46.2,-78.4},{50.5,-80},{54.7,-77.6},{58.9,-71.5},{63.1,
              -61.9},{67.9,-47.2},{74,-24.8},{80,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-41,-2},{-80,-2}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-128,7},{-82,-11}},
          lineColor={160,160,164},
          textString=
               "offset"),
        Line(
          points={{-41,-2},{-41,-40}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,-43},{-14,-61}},
          lineColor={160,160,164},
          textString=
               "startTime"),
        Text(
          extent={{84,-52},{108,-72}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Text(
          extent={{-84,106},{-43,86}},
          lineColor={160,160,164},
          textString=
               "y"),
        Line(
          points={{-9,79},{43,79}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{-42,-1},{50,0}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{33,80},{30,67},{37,67},{33,80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{37,57},{83,39}},
          lineColor={160,160,164},
          textString=
               "amplitude"),
        Polygon(
          points={{33,1},{30,14},{36,14},{33,1},{33,1}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{33,79},{33,0}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-41,-2},{-80,-2}}, color={0,0,0}),
        Line(points={{-40,0},{-31.6,34.2},{-26.1,53.1},{-21.3,66.4},{-17.1,74.6},
              {-12.9,79.1},{-8.64,79.8},{-4.42,76.6},{-0.201,69.7},{4.02,59.4},
              {8.84,44.1},{14.9,21.2},{27.5,-30.8},{33,-50.2},{37.8,-64.2},{42,
              -73.1},{46.2,-78.4},{50.5,-80},{54.7,-77.6},{58.9,-71.5},{63.1,
              -61.9},{67.9,-47.2},{74,-24.8},{80,0}}, color={0,0,0}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,-100},{100,100}}, lineColor={0,0,255}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Window(
      x=0.35,
      y=0.28,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Sources library</b></p>
</HTML>
<html>
<p><b>Version 1.7</b></p>
</HTML>
"));
end Sinusoide;
