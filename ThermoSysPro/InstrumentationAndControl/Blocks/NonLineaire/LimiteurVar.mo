within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block LimiteurVar
  parameter Real maxval=1
    "Valeur maximale de la sortie si limit1 n'est pas connecté";
  parameter Real minval=-1
    "Valeur minimale de la sortie si limit2 n'est pas connecté";
protected
  Real uMax;
  Real uMin;

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal limit1
                                           annotation (Placement(transformation(
          extent={{-120,70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal limit2
                                           annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical ySMax
                                      annotation (                         layer="icon",
      Placement(transformation(extent={{100,70},{120,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical ySMin
                                      annotation (                           layer="icon",
      Placement(transformation(extent={{100,-90},{120,-70}}, rotation=0)));
equation

  if (cardinality(limit1) == 0) then
    limit1.signal = maxval;
  end if;

  if (cardinality(limit2) == 0) then
    limit2.signal = minval;
  end if;

  uMax = max(limit1.signal, limit2.signal);
  uMin = min(limit1.signal, limit2.signal);

  y.signal = if (u.signal > uMax) then uMax else if (u.signal < uMin) then uMin else
          u.signal;

  ySMax.signal = (u.signal >= uMax);
  ySMin.signal = (u.signal <= uMin);

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
        Line(points={{-100,-80},{-60,-80},{-60,-66}}),
        Line(points={{-100,80},{60,80},{60,64}}),
        Polygon(
          points={{-60,-62},{-65,-72},{-55,-72},{-60,-62}},
          lineColor={0,127,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{56,72},{64,72},{60,62},{56,72},{56,72}},
          lineColor={0,0,255},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid)}),
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
               "umax"),
        Text(
          extent={{-88,-64},{-26,-86}},
          lineColor={160,160,164},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "umin"),
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
      x=0.36,
      y=0.19,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.NonLinear library</b></p>
</HTML>
<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end LimiteurVar;
