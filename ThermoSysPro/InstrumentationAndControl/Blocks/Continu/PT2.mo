within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block PT2
  parameter Real k=1 "Gain";
  parameter Real w=1 "Fréquence angulaire";
  parameter Real D=1 "Amortissement";
  parameter Boolean permanent=false "Calcul du permanent";

protected
  Real x(start=0);
  Real xd(start=0);

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
initial equation
  if permanent then
    der(x) = 0;
    der(xd) = 0;
  end if;

equation
  der(x) = xd;
  der(xd) = w*(w*(u.signal - x) - 2*D*xd);
  y.signal = k*x;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,52},{60,6}},
          lineColor={0,0,0},
          textString=
               "k"),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{62,0},{102,0}}),
        Line(points={{-50,0},{50,0}}, color={0,0,0}),
        Text(
          extent={{-60,0},{-32,-28}},
          lineColor={0,0,0},
          textString=
               "s"),
        Line(points={{-54,-28},{-38,-28}}, color={0,0,0}),
        Text(
          extent={{-52,-34},{-36,-56}},
          lineColor={0,0,0},
          textString=
               "w"),
        Line(points={{-40,-6},{-34,-18},{-34,-38},{-38,-54}}, color={0,0,0}),
        Text(
          extent={{-34,0},{-22,-18}},
          lineColor={0,0,0},
          textString=
               "2"),
        Text(
          extent={{-34,-14},{6,-44}},
          lineColor={0,0,0},
          textString=
               "+2D"),
        Text(
          extent={{2,0},{30,-28}},
          lineColor={0,0,0},
          textString=
               "s"),
        Line(points={{8,-28},{24,-28}}, color={0,0,0}),
        Text(
          extent={{10,-34},{26,-56}},
          lineColor={0,0,0},
          textString=
               "w"),
        Line(points={{12,-6},{6,-16},{6,-36},{10,-54}}, color={0,0,0}),
        Line(points={{22,-6},{28,-18},{28,-38},{24,-54}}, color={0,0,0}),
        Text(
          extent={{30,-6},{58,-50}},
          lineColor={0,0,0},
          textString=
               "+1"),
        Line(points={{-50,-6},{-56,-16},{-56,-36},{-52,-54}}, color={0,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-72,-68.53},{-64,-39.5},{-56,-2.522},{-48,32.75},
              {-40,58.8},{-32,71.51},{-24,70.49},{-16,58.45},{-8,40.06},{0,
              20.55},{8,4.459},{16,-5.271},{24,-7.629},{32,-3.428},{40,5.21},{
              48,15.56},{56,25.03},{64,31.66},{72,34.5},{80,33.61}}),
        Text(
          extent={{-2,90},{58,30}},
          lineColor={192,192,192},
          textString=
               "PT2"),
        Text(
          extent={{-150,-150},{150,-110}},
          lineColor={0,0,0},
          textString=
               "w=%w"),
        Text(
          extent={{-64,4},{26,-36}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Text(
          extent={{-62,-40},{28,-80}},
          lineColor={0,0,0},
          textString=
               "D=%D"),
        Polygon(
          points={{-80,94},{-88,72},{-72,72},{-80,94}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.09,
      y=0.34,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b></p>
<p><b>Version 1.7</h4>
</HTML>
"));
end PT2;
