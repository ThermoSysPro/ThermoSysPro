within ThermoSysPro.InstrumentationAndControl.Blocks.Math;
block Gain
  parameter Real Gain=1 "Gain";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  y.signal = Gain*u.signal;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(points={{-100,100},{100,0},{-100,-100},{-100,100}}, lineColor={
              0,0,255}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Text(
          extent={{-54,20},{-6,-16}},
          lineColor={0,0,0},
          textString=
               "%Gain")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(points={{-100,100},{100,0},{-100,-100},{
              -100,100}}, lineColor={0,0,255}), Text(
          extent={{-54,20},{-6,-16}},
          lineColor={0,0,0},
          textString=
               "Gain")}),
    Window(
      x=0.24,
      y=0.2,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Math library</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Gain;
