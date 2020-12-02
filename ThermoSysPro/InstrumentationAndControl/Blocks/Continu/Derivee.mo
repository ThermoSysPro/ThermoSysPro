within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block Derivee
  parameter Real k=1 "Gain";
  parameter Real Ti(min=Modelica.Constants.small) = 0.001
    "Constante de temps (s)";

protected
  Real x;


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
equation

initial equation
  x = u.signal - Ti/k*ureset.signal;

equation
  if (cardinality(ureset) == 0) then
    ureset.signal = 0;
  end if;

  der(x) = if noEvent(abs(k) >= Modelica.Constants.eps) then (u.signal - x)/Ti else
          0;

  y.signal = if noEvent(abs(k) >= Modelica.Constants.eps) then (k/Ti)*(u.signal
     - x) else 0;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-60,0}}),
        Line(points={{62,0},{102,0}}),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,0},{50,0}}, color={0,0,0}),
        Text(
          extent={{-54,52},{50,10}},
          lineColor={0,0,0},
          textString=
               "k s"),
        Text(
          extent={{-54,-6},{52,-52}},
          lineColor={0,0,0},
          textString=
               "T s + 1")}),
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
        Line(points={{-80,-80},{-80,60},{-70,17.95},{-60,-11.46},{-50,-32.05},{
              -40,-46.45},{-30,-56.53},{-20,-63.58},{-10,-68.51},{0,-71.96},{10,
              -74.37},{20,-76.06},{30,-77.25},{40,-78.07},{50,-78.65},{60,
              -79.06}}),
        Text(
          extent={{-30,30},{30,90}},
          lineColor={192,192,192},
          textString=
               "DT1"),
        Text(
          extent={{-36,32},{54,-8}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Text(
          extent={{-34,-12},{56,-52}},
          lineColor={0,0,0},
          textString=
               "Ti=%Ti")}),
    Window(
      x=0.36,
      y=0.21,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b></p>
</HTML>
<html>
<p><b>Version 1.7</b></p>
</HTML>
"));
end Derivee;
