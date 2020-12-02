within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Exp


  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Modelica.Math.exp(u.signal);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(extent={{-100,100},{100,-100}}),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,50},{-14,2}},
          lineColor={192,192,192},
          textString=
               "exp"),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),
        Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
        Polygon(
          points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,80},{-8,80}}, color={192,192,192}),
        Line(points={{0,-80},{-8,-80}}, color={192,192,192}),
        Line(points={{0,-90},{0,84}}, color={192,192,192}),
        Text(
          extent={{3,100},{34,80}},
          lineColor={160,160,164},
          textString=
               "y"),
        Polygon(
          points={{0,100},{-6,84},{6,84},{0,100}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,-80.3976},{84,-80.3976}}, color={192,192,192}),
        Polygon(
          points={{100,-80.3976},{84,-74.3976},{84,-86.3976},{100,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),
        Text(extent={{-31,72},{-11,88}}, textString=
                                             "20"),
        Text(extent={{-92,-83},{-72,-103}}, textString=
                                                "-3"),
        Text(extent={{70,-83},{90,-103}}, textString=
                                              "3"),
        Text(extent={{-18,-53},{2,-73}}, textString=
                                             "1"),
        Text(
          extent={{66,-52},{96,-72}},
          lineColor={160,160,164},
          textString=
               "u")}),
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
end Exp;
