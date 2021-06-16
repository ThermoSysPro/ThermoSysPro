within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block RetardFixe
  parameter Real retard=1 "Retard de la sortie sur l'entrée (s)";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = delay(u.signal, retard);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-92,0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},
              {-55.8,79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},
              {-26.9,44.1},{-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},
              {17.3,-73.1},{23,-78.4},{28.6,-80},{34.2,-77.6},{39.9,-71.5},{
              45.5,-61.9},{51.9,-47.2},{60,-24.8},{68,0}}, color={0,0,255}),
        Line(points={{-62,0},{-50.7,34.2},{-43.5,53.1},{-37.1,66.4},{-31.4,74.6},
              {-25.8,79.1},{-20.2,79.8},{-14.6,76.6},{-8.9,69.7},{-3.3,59.4},{
              3.1,44.1},{11.17,21.2},{28.1,-30.8},{35.3,-50.2},{41.7,-64.2},{
              47.3,-73.1},{53,-78.4},{58.6,-80},{64.2,-77.6},{69.9,-71.5},{75.5,
              -61.9},{81.9,-47.2},{90,-24.8},{98,0}}, color={160,160,164})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,80},{-88,80}}, color={192,192,192}),
        Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
        Line(points={{-80,-88},{-80,86}}, color={192,192,192}),
        Text(
          extent={{-75,98},{-46,78}},
          lineColor={0,0,255},
          textString=
               "y"),
        Polygon(
          points={{-80,96},{-86,80},{-74,80},{-80,96}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{84,0}}, color={192,192,192}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
              {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
              {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
              {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
              57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,255}),
        Text(
          extent={{-24,98},{-2,78}},
          lineColor={0,0,0},
          textString=
               "u"),
        Line(points={{-64,0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,74.6},
              {-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,59.4},{
              1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},{
              45.3,-73.1},{51,-78.4},{56.6,-80},{62.2,-77.6},{67.9,-71.5},{73.5,
              -61.9},{79.9,-47.2},{88,-24.8},{96,0}}, color={0,0,0}),
        Text(
          extent={{67,22},{96,6}},
          lineColor={160,160,164},
          textString=
               "temps"),
        Line(points={{-64,-30},{-64,0}}, color={192,192,192}),
        Line(points={{-94,-26},{-80,-26}}, color={192,192,192}),
        Line(points={{-64,-26},{-50,-26}}, color={192,192,192}),
        Polygon(
          points={{-80,-26},{-88,-24},{-88,-28},{-80,-26}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,-24},{-64,-26},{-56,-28},{-56,-24}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(extent={{-72,-38},{-72,-28}}, textString=
                                               "retard")}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.NonLinear library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end RetardFixe;
