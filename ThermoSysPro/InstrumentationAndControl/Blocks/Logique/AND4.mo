within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block AND4

  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL1
                                           annotation (Placement(transformation(
          extent={{-120,80},{-100,100}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL2
                                           annotation (Placement(transformation(
          extent={{-120,20},{-100,40}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL3
                                           annotation (Placement(transformation(
          extent={{-120,-40},{-100,-20}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL4
                                           annotation (Placement(transformation(
          extent={{-120,-100},{-100,-80}}, rotation=0)));
algorithm

  yL.signal := uL1.signal and uL2.signal and uL3.signal and uL4.signal;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,102}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,20},{50,-20}},
          lineColor={0,0,0},
          textString=
               "&"),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{-54,20},{50,-20}},
          lineColor={0,0,0},
          textString=
               "&")}),
    Window(
      x=0.16,
      y=0.18,
      width=0.76,
      height=0.65),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end AND4;
