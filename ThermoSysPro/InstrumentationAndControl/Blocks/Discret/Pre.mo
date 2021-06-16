within ThermoSysPro.InstrumentationAndControl.Blocks.Discret;
block Pre
  parameter Real Gain=1 "Gain";
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
    x := u.signal;
  end when;

  when sample(SampleOffset, SampleInterval) then
    y.signal := Gain*pre(x);
  end when;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,0},{60,0}},
          color={0,0,0},
          thickness=0.5),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Text(
          extent={{-55,55},{55,5}},
          lineColor={0,0,0},
          textString=
               "1"),
        Text(
          extent={{-55,-5},{55,-55}},
          lineColor={0,0,0},
          textString=
               "z")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(points={{40,0},{-40,0}}, color={0,0,0}),
        Text(
          extent={{-55,55},{55,5}},
          lineColor={0,0,0},
          textString=
               "1"),
        Text(
          extent={{-55,-5},{55,-55}},
          lineColor={0,0,0},
          textString=
               "z")}),
    Window(
      x=0.23,
      y=0.2,
      width=0.65,
      height=0.65),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Pre;
