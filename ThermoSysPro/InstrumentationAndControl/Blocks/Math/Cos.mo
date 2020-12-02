within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Cos


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Modelica.Math.cos(u.signal);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(extent={{-100,100},{100,-100}}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
              {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,
              -73.8},{-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,
              -60.6},{24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},
              {69.5,73.4},{75.2,78.6},{80,80}}, color={0,0,0}),
        Text(
          extent={{-36,82},{36,34}},
          lineColor={192,192,192},
          textString=
               "cos")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,80},{-88,80}}, color={192,192,192}),
        Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
        Line(points={{-80,-90},{-80,84}}, color={192,192,192}),
        Text(
          extent={{-75,102},{-48,82}},
          lineColor={160,160,164},
          textString=
               "y"),
        Polygon(
          points={{-80,100},{-86,84},{-74,84},{-80,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(extent={{-103,72},{-83,88}}, textString=
                                              "1"),
        Text(extent={{-79,-72},{-59,-88}}, textString=
                                               "-1"),
        Text(extent={{70,25},{90,5}}, textString=
                                          "2*pi"),
        Line(points={{-100,0},{84,0}}, color={192,192,192}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
              {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,
              -73.8},{-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,
              -60.6},{24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},
              {69.5,73.4},{75.2,78.6},{80,80}}, color={0,0,0}),
        Text(
          extent={{74,-4},{98,-24}},
          lineColor={160,160,164},
          textString=
               "u")}),
    Window(
      x=0.22,
      y=0.3,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Cos;
