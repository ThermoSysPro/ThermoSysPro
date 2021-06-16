within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Supeg
  parameter Real C1=0 "Valeur de u1 si u1 non connecté";
  parameter Real C2=0 "Valeur de u2 si u2 non connecté";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
                                       annotation (Placement(transformation(
          extent={{-120,50},{-100,70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
                                       annotation (Placement(transformation(
          extent={{-120,-70},{-100,-50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

   if (cardinality(u1) == 0) then
    u1.signal = C1;
  end if;

  if (cardinality(u2) == 0) then
    u2.signal = C2;
  end if;

  yL.signal = (u1.signal >= u2.signal);
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
        Line(points={{50,0},{100,0}}),
        Line(points={{50,0},{100,0}}),
        Line(points={{80,0},{100,0}}),
        Ellipse(extent={{-80,80},{80,-80}}),
        Line(points={{-100,60},{-52,60}}),
        Line(points={{-100,-60},{-52,-60}}),
        Text(
          extent={{-36,34},{40,-34}},
          lineColor={0,0,0},
          textString=
               ">="),
        Text(
          extent={{-100,100},{-38,68}},
          lineColor={0,0,255},
          textString=
               "C1"),
        Text(
          extent={{-100,-68},{-38,-100}},
          lineColor={0,0,255},
          textString=
               "C2")}),
    Window(
      x=0.27,
      y=0.17,
      width=0.6,
      height=0.6),
    Diagram(coordinateSystem(
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
        Line(points={{80,0},{100,0}}),
        Ellipse(extent={{-80,80},{80,-80}}),
        Line(points={{-100,60},{-52,60}}),
        Line(points={{-100,-60},{-52,-60}}),
        Text(
          extent={{-36,34},{40,-34}},
          lineColor={0,0,0},
          textString=
               ">="),
        Text(
          extent={{-100,100},{-38,68}},
          lineColor={0,0,255},
          textString=
               "C1"),
        Text(
          extent={{-100,-68},{-38,-100}},
          lineColor={0,0,255},
          textString=
               "C2")}),
    Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end Supeg;
