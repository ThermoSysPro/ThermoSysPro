within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Mul3

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
                                       annotation (Placement(transformation(
          extent={{-120,70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
                                       annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u3
                                       annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
equation

  y.signal = u1.signal*u2.signal*u3.signal;
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
        Line(points={{80,0},{100,0}}),
        Line(points={{80,0},{100,0}}),
        Line(points={{80,0},{100,0}}),
        Ellipse(extent={{-80,80},{80,-80}}),
        Line(points={{80,0},{100,0}}),
        Line(points={{-98,80},{0,80}}),
        Line(points={{-98,-80},{0,-80}}),
        Text(
          extent={{-38,20},{38,-48}},
          lineColor={0,0,0},
          textString=
               "*"),
        Line(points={{-100,0},{-80,0}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{80,0},{100,0}}),
        Line(points={{80,0},{100,0}}),
        Line(points={{80,0},{100,0}}),
        Ellipse(extent={{-80,80},{80,-80}}),
        Line(points={{80,0},{100,0}}),
        Line(points={{-98,80},{0,80}}),
        Line(points={{-98,-80},{0,-80}}),
        Text(
          extent={{-38,20},{38,-48}},
          lineColor={0,0,0},
          textString=
               "*"),
        Line(points={{-100,0},{-80,0}})}),
    Window(
      x=0.26,
      y=0.2,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Mul3;
