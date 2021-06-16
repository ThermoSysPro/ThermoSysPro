within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Feedback "Différence entre la commande et le feedback"

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
          rotation=0)));
equation
  y.signal = u1.signal - u2.signal;
  annotation (
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.6</b></p>
</HTML>
"), Icon(graphics={
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-20,0}}),
        Line(points={{20,0},{100,0}}),
        Line(points={{0,-20},{0,-100}}),
        Text(
          extent={{-16,-18},{44,-52}},
          lineColor={0,0,255},
          textString=
               "-"),
        Text(
          extent={{-56,4},{-6,-24}},
          lineColor={0,0,255},
          textString=
               "+"),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Diagram(graphics={
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-20,0}}),
        Line(points={{20,0},{100,0}}),
        Line(points={{0,-20},{0,-100}}),
        Text(
          extent={{-54,2},{-4,-26}},
          lineColor={0,0,255},
          textString=
               "+"),
        Text(
          extent={{-14,-20},{46,-54}},
          lineColor={0,0,255},
          textString=
               "-"),
        Text(
          extent={{-100,26},{-72,10}},
          lineColor={0,0,255},
          textString=
               "u1"),
        Text(
          extent={{4,-84},{42,-94}},
          lineColor={0,0,255},
          textString=
               "u2"),
        Text(
          extent={{70,26},{98,10}},
          lineColor={0,0,255},
          textString=
               "y")}));
end Feedback;
