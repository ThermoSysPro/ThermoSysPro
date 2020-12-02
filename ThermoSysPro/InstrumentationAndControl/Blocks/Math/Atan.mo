within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Atan


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Modelica.Math.atan(u.signal);
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
        Line(points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,
              -55.2},{-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{
              5.23,21},{9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,
              67.6},{47,73.6},{69.5,78.6},{80,80}}, color={0,0,0}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,68},{-14,20}},
          lineColor={192,192,192},
          textString=
               "atan")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,80},{-8,80}}, color={192,192,192}),
        Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
        Line(points={{0,-90},{0,84}}, color={192,192,192}),
        Text(
          extent={{13,102},{42,82}},
          lineColor={160,160,164},
          textString=
               "outPort"),
        Polygon(
          points={{0,100},{-6,84},{6,84},{0,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{84,0}}, color={192,192,192}),
        Polygon(
          points={{100,0},{84,6},{84,-6},{100,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,
              -55.2},{-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{
              5.23,21},{9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,
              67.6},{47,73.6},{69.5,78.6},{80,80}}, color={0,0,0}),
        Text(extent={{-32,91},{-12,71}}, textString=
                                             "1.4"),
        Text(extent={{-32,-71},{-12,-91}}, textString=
                                               "-1.4"),
        Text(extent={{73,26},{93,10}}, textString=
                                           " 5.8"),
        Text(extent={{-103,20},{-83,4}}, textString=
                                             "-5.8"),
        Text(
          extent={{66,-8},{94,-28}},
          lineColor={160,160,164},
          textString=
               "inPort")}),
    Window(
      x=0.03,
      y=0.35,
      width=0.35,
      height=0.49),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Atan;
