within ThermoSysPro.Thermal.BoundaryConditions;
model HeatSink "Heat sink"

  parameter Integer N=1;

public
  Modelica.SIunits.Temperature T[N] "Sink temperature";
  Modelica.SIunits.Power W[N] "Heat power received by the sink";

public
  input ThermoSysPro.Thermal.Connectors.ThermalPort C[N]
                                                       annotation (Placement(
        transformation(extent={{-10,-108},{10,-88}}, rotation=0)));
equation

  T = C.T;
  W = C.W;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,40},{40,-38}},
          lineColor={0,0,255},
          textString =                       "C"),
        Line(points={{0,-40},{0,-88}}),
        Line(points={{-12,-60},{0,-40}}),
        Line(points={{12,-60},{0,-40}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-40},{0,-88}}),
        Line(points={{-12,-60},{0,-40}}),
        Text(
          extent={{-40,40},{40,-38}},
          lineColor={0,0,255},
          textString =                       "C"),
        Line(points={{12,-60},{0,-40}})}),
    Window(
      x=0.33,
      y=0.21,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 3.0</b></p>
</HTML>
"));
end HeatSink;
