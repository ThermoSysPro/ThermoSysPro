within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block PI
  parameter Real k=1 "Gain";
  parameter Real Ti=1 "Constante de temps (s)";
  parameter Real ureset0=0
    "Valeur de la sortie sur reset (si ureset non connecté)";
  parameter Boolean permanent=false "Calcul du permanent";

protected
  Real x;
  Real x0;

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ureset
                                           annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical reset
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
initial equation
  if permanent then
    der(x) = 0;
  else
    x = (1/k - 1) * ureset.signal/k;
  end if;

equation
  if (cardinality(reset) == 0) then
    reset.signal = false;
  end if;

  if (cardinality(ureset) == 0) then
    ureset.signal = ureset0;
  end if;

  when not (reset.signal) then
    x0 = ureset.signal/k - u.signal;
    reinit(x, x0);
  end when;

  der(x) = if reset.signal then 0 else u.signal/Ti;
  y.signal = if reset.signal then ureset.signal else k*(x + u.signal);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{66,58}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={192,192,192},
          textString=
               "PI"),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Text(
          extent={{-36,-34},{54,-74}},
          lineColor={0,0,0},
          textString=
               "Ti=%Ti"),
        Text(
          extent={{-38,10},{52,-30}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Polygon(
          points={{-74,86},{-82,64},{-66,64},{-74,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-60,0}}),
        Line(points={{62,0},{100,0}}),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-68,24},{-24,-18}},
          lineColor={0,0,0},
          textString=
               "k"),
        Text(
          extent={{-32,48},{60,0}},
          lineColor={0,0,0},
          textString=
               "T s + 1"),
        Text(
          extent={{-30,-8},{52,-40}},
          lineColor={0,0,0},
          textString=
               "T s"),
        Line(points={{-24,0},{54,0}}, color={0,0,0})}),
    Window(
      x=0.19,
      y=0.2,
      width=0.58,
      height=0.65),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b></p>
</HTML>
<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end PI;
