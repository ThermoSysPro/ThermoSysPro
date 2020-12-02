within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Tan


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Modelica.Math.tan(u.signal);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(extent={{-100,100},{100,-100}}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,
              -40.9},{-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{
              -4.42,-1.07},{33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{
              70.4,39.1},{73.6,47.4},{76,56.1},{77.6,63.8},{80,80}}, color={0,0,
              0}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-90,72},{-18,24}},
          lineColor={192,192,192},
          textString=
               "tan")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,80},{-8,80}}, color={192,192,192}),
        Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
        Line(points={{0,-88},{0,86}}, color={192,192,192}),
        Text(
          extent={{1,104},{28,84}},
          lineColor={160,160,164},
          textString=
               "y"),
        Polygon(
          points={{0,102},{-6,86},{6,86},{0,102}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(extent={{-37,-72},{-17,-88}}, textString=
                                               "-5.8"),
        Text(extent={{-33,86},{-13,70}}, textString=
                                             " 5.8"),
        Text(extent={{70,25},{90,5}}, textString=
                                          "1.4"),
        Line(points={{-100,0},{84,0}}, color={192,192,192}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,
              -40.9},{-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{
              -4.42,-1.07},{33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{
              70.4,39.1},{73.6,47.4},{76,56.1},{77.6,63.8},{80,80}}, color={0,0,
              0}),
        Text(
          extent={{70,-6},{94,-26}},
          lineColor={160,160,164},
          textString=
               "u")}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Tan;
