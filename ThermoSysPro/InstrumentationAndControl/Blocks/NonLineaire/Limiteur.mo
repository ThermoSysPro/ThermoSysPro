within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block Limiteur
  parameter Real maxval=1 "Valeur maximale de la sortie";
  parameter Real minval=-1 "Valeur minimale de la sortie";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  assert(maxval > minval,
    "Limiteur : Le paramètre maxval doit être supérieur au paramètre minval");

  y.signal = if u.signal > maxval then maxval else if u.signal < minval then
    minval else u.signal;
  annotation (
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
        Line(points={{78,60},{40,60},{-40,-60},{-80,-60}}, color={0,0,0}),
        Text(
          extent={{26,90},{88,68}},
          lineColor={0,0,0},
          textString=
               "%maxval"),
        Text(
          extent={{-88,-64},{-26,-86}},
          lineColor={0,0,0},
          textString=
               "%minval"),
        Line(points={{-86,0},{88,0}}, color={192,192,192}),
        Polygon(
          points={{96,0},{86,-5},{86,5},{96,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,84},{-5,74},{5,74},{0,84}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,74}}, color={192,192,192})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{26,90},{88,68}},
          lineColor={160,160,164},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "maxval"),
        Text(
          extent={{-88,-64},{-26,-86}},
          lineColor={160,160,164},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "minval"),
        Line(points={{-86,0},{88,0}}, color={192,192,192}),
        Polygon(
          points={{96,0},{86,-5},{86,5},{96,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,84},{-5,74},{5,74},{0,84}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,74}}, color={192,192,192}),
        Line(points={{78,60},{40,60},{-40,-60},{-80,-60}}, color={0,0,0})}),
    Window(
      x=0.27,
      y=0.23,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.NonLinear library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Limiteur;
