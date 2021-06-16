within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block PT1
  parameter Real k=1 "Gain";
  parameter Real Ti=1 "Constante de temps (s)";
  parameter Real U0=0
    "Valeur de la sortie à l'instant initial (si non permanent et si u0 non connecté)";
  parameter Boolean permanent=false "Calcul du permanent";

protected
  Real x;

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u0
                                       annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
initial equation
  if permanent then
    der(x) = 0;
  else
    x = (u0.signal)/k;
  end if;

equation
  if (cardinality(u0) == 0) then
    u0.signal = U0;
  end if;

  der(x) = (u.signal - x)/Ti;
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
        Text(
          extent={{-60,0},{60,-60}},
          lineColor={0,0,0},
          textString=
               "T s + 1"),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{62,0},{102,0}}),
        Line(points={{-50,0},{50,0}}, color={0,0,0})}),
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
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-70,-45.11},{-60,-19.58},{-50,-0.9087},{-40,
              12.75},{-30,22.75},{-20,30.06},{-10,35.41},{0,39.33},{10,42.19},{
              20,44.29},{30,45.82},{40,46.94},{50,47.76},{60,48.36},{70,48.8},{
              80,49.12}}),
        Text(
          extent={{-64,82},{-4,22}},
          lineColor={192,192,192},
          textString=
               "PT1"),
        Text(
          extent={{-38,10},{52,-30}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Text(
          extent={{-36,-34},{54,-74}},
          lineColor={0,0,0},
          textString=
               "Ti=%Ti"),
        Polygon(
          points={{-80,94},{-88,72},{-72,72},{-80,94}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.33,
      y=0.24,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b></p>
<p><b>Version 1.7</h4>
</HTML>
"));
end PT1;
