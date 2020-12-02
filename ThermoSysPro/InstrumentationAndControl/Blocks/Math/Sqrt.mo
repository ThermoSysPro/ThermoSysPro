within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Sqrt

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = sqrt(u.signal);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{50,0},{100,0}}),
        Line(points={{50,0},{100,0}}),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,
              -47.9},{-67.9,-36.1},{-59.1,-22.2},{-46.2,-6.49},{-28.5,10.7},{
              -4.42,30},{27.7,51.3},{69.5,74.7},{80,80}}, color={0,0,0}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-88},{-80,68}}, color={192,192,192}),
        Text(
          extent={{-8,-4},{64,-52}},
          lineColor={192,192,192},
          textString=
               "sqrt")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-92,-80},{84,-80}}, color={192,192,192}),
        Polygon(
          points={{100,-80},{84,-74},{84,-86},{100,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-79.2,-68.7},{-78.4,-64},{-76.8,-57.3},{-73.6,
              -47.9},{-67.9,-36.1},{-59.1,-22.2},{-46.2,-6.49},{-28.5,10.7},{
              -4.42,30},{27.7,51.3},{69.5,74.7},{80,80}}, color={0,0,0}),
        Polygon(
          points={{-80,98},{-86,82},{-74,82},{-80,98}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-90},{-80,84}}, color={192,192,192}),
        Text(
          extent={{-79,100},{-52,80}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{60,-52},{84,-72}},
          lineColor={160,160,164},
          textString=
               "u")}),
    Window(
      x=0.1,
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
end Sqrt;
