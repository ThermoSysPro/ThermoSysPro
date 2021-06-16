within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block Integrateur
  parameter Real k=1 "Gain";
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
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical reset
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ureset
                                           annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
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
    x0 = ureset.signal/k;
    reinit(x, x0);
  end when;

  der(x) = if reset.signal then 0 else u.signal;
  y.signal = if reset.signal then ureset.signal else k*x;
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
          extent={{-60,-6},{60,-52}},
          lineColor={0,0,0},
          textString=
               "s")}),
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
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,84},{6,24}},
          lineColor={192,192,192},
          textString=
               "I"),
        Line(points={{-80,-80},{80,80}}),
        Text(
          extent={{-36,-34},{54,-74}},
          lineColor={0,0,0},
          textString=
               "K=%k")}),
    Window(
      x=0.23,
      y=0.15,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b></p>
</HTML>
<html>
<p><b>Version 1.7</b></p>
</HTML>
"));
end Integrateur;
