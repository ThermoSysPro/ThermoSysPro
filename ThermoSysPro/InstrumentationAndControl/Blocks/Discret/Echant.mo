within ThermoSysPro.InstrumentationAndControl.Blocks.Discret;
block Echant
  parameter Real Gain=1 "Gain";
  parameter Real SampleOffset=0 "Instant de départ de l'échantillonnage (s)";
  parameter Real SampleInterval=0.01 "Période d'échantillonnage (s)";

protected
  Real uc;
  Real ud;
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical continu
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  if (cardinality(continu) == 0) then
    continu.signal = false;
  end if;

algorithm
  when {sample(SampleOffset, SampleInterval),not (continu.signal)} then
    ud := u.signal;
  end when;

  uc := u.signal;

  y.signal := Gain*(if continu.signal then uc else ud);
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
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Ellipse(
          extent={{-25,-10},{-45,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,-10},{25,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-45,0}}, color={0,0,255}),
        Line(points={{45,0},{100,0}}, color={0,0,255}),
        Line(points={{-35,0},{30,35}}, color={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-25,-10},{-45,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{45,-10},{25,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-45,0}}, color={0,0,255}),
        Line(points={{45,0},{100,0}}, color={0,0,255}),
        Line(points={{-35,0},{30,35}}, color={0,0,255}),
        Line(
          points={{0,-20},{0,-100}},
          color={0,0,255},
          pattern=LinePattern.Dot)}),
    Window(
      x=0.17,
      y=0.12,
      width=0.65,
      height=0.65),
    Documentation(info="<html>
<p><b>Adapted from the ModelicaAdditions.Blocks.Discrete library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Echant;
