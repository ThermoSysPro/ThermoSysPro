within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Sign


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = sign(u.signal);
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
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{0,-80}}, color={0,0,0}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Text(
          extent={{-90,72},{-18,24}},
          lineColor={192,192,192},
          textString=
               "sign"),
        Line(points={{0,80},{80,80}}, color={0,0,0}),
        Rectangle(
          extent={{-2,2},{2,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{0,-80}}, color={0,0,0}),
        Line(points={{-0.01,0},{0.01,0}}, color={0,0,0}),
        Line(points={{0,80},{80,80}}, color={0,0,0}),
        Rectangle(
          extent={{-2,2},{2,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,100},{-6,84},{6,84},{0,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-90},{0,84}}, color={192,192,192}),
        Text(
          extent={{5,102},{30,82}},
          lineColor={160,160,164},
          textString=
               "y"),
        Text(
          extent={{70,-6},{94,-26}},
          lineColor={160,160,164},
          textString=
               "u"),
        Text(extent={{-25,86},{-5,70}}, textString=
                                            "1"),
        Text(extent={{5,-72},{25,-88}}, textString=
                                            "-1")}),
    Window(
      x=0.1,
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
end Sign;
