within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Log10


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Modelica.Math.log10(u.signal);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(extent={{-100,100},{100,-100}}),
        Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,
              -21.3},{-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{
              -57.5,28},{-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},
              {80,80}}, color={0,0,0}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-6,-24},{66,-72}},
          lineColor={192,192,192},
          textString=
               "log10")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,80},{-88,80}}, color={192,192,192}),
        Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
        Line(points={{-80,-90},{-80,84}}, color={192,192,192}),
        Text(
          extent={{-79,98},{-52,80}},
          lineColor={160,160,164},
          textString=
               "y"),
        Polygon(
          points={{-80,100},{-86,84},{-74,84},{-80,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{84,0}}, color={192,192,192}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,
              -21.3},{-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{
              -57.5,28},{-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},
              {80,80}}, color={0,0,0}),
        Text(extent={{-105,72},{-85,88}}, textString=
                                              "1.3"),
        Text(extent={{-109,-88},{-89,-72}}, textString=
                                                "-1.3"),
        Text(extent={{70,-3},{90,-23}}, textString=
                                            "20"),
        Text(extent={{-78,-1},{-58,-21}}, textString=
                                              "1"),
        Text(
          extent={{68,28},{94,8}},
          lineColor={160,160,164},
          textString=
               "u")}),
    Window(
      x=0.36,
      y=0.23,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Log10;
