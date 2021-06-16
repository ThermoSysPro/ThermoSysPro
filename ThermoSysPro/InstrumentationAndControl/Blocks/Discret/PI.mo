within ThermoSysPro.InstrumentationAndControl.Blocks.Discret;
block PI
  parameter Real k=1 "Gain";
  parameter Real Ti=1 "Constante de temps";
  parameter Real initialCond=0 "Condition initiale";
  parameter Real SampleOffset=0 "Instant de départ de l'échantillonnage (s)";
  parameter Real SampleInterval=0.01 "Période d'échantillonnage (s)";

protected
  Real x(start=initialCond);

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
algorithm

  when sample(SampleOffset, SampleInterval) then
    x := pre(x) + SampleInterval/Ti*pre(u.signal);
    y.signal := k*(x + u.signal);
  end when;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={0,0,0}),
        Line(points={{-74,-80},{70,-80}}, color={0,0,0}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{66,58}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={160,160,164},
          textString=
               "PI"),
        Text(extent={{-154,142},{146,102}}, textString=
                                                "%name"),
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
          points={{-74,86},{-82,64},{-66,64},{-74,86}},
          lineColor={192,192,192},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.26,
      y=0.13,
      width=0.78,
      height=0.7),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
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
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end PI;
