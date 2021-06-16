within ThermoSysPro.InstrumentationAndControl.Blocks.Discret;
block FctTrans
  parameter Real b[:]={1}
    "Coefficients numérateurs de la fonction de transfert";
  parameter Real a[:]={1,1}
    "Coefficients dénominateurs de la fonction de transfert";
  parameter Real SampleOffset=0 "Instant de départ de l'échantillonnage (s)";
  parameter Real SampleInterval=0.01 "Période d'échantillonnage (s)";

protected
  Real x[size(a, 1) - 1];
  parameter Integer na=size(a, 1);
  parameter Integer nb(max=na) = size(b, 1);
  Real x1;
  Real xn;
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  when sample(SampleOffset, SampleInterval) then
    [x; xn] = [x1; pre(x)];
    [u.signal] = transpose([a])*[x1; pre(x)];
    [y.signal] = transpose([zeros(na - nb, 1); b])*[x1; pre(x)];
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
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{82,0},{-84,0}}, color={0,0,255}),
        Text(
          extent={{-92,92},{86,12}},
          lineColor={0,0,255},
          textString=
               "b(z)"),
        Text(
          extent={{-90,-12},{90,-90}},
          lineColor={0,0,255},
          textString=
               "a(z)")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(
          points={{40,0},{-44,0}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-54,54},{54,4}},
          lineColor={0,0,0},
          textString=
               "b(z)"),
        Text(
          extent={{-54,-6},{56,-56}},
          lineColor={0,0,0},
          textString=
               "a(z)"),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}})}),
    Window(
      x=0.24,
      y=0.15,
      width=0.65,
      height=0.65),
    Documentation(info="<html>
<p><b>Adapted from the ModelicaAdditions.Blocks.Discrete library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end FctTrans;
