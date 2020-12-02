within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block XOR

  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL1
                                           annotation (Placement(transformation(
          extent={{-120,50},{-100,70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL2
                                           annotation (Placement(transformation(
          extent={{-120,-70},{-100,-50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
algorithm

  yL.signal := if (uL1.signal and uL2.signal) or (not uL1.signal and not uL2.
    signal) then false else true;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,20},{50,-20}},
          lineColor={0,0,0},
          textString=
               "= 1"),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Window(
      x=0.1,
      y=0.2,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end XOR;
