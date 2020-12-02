within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block Selecteur

  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL
                                           annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uCond
                                             annotation (Placement(
        transformation(extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL1
                                           annotation (Placement(transformation(
          extent={{-120,70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL2
                                           annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
algorithm

  yL.signal := if uCond.signal then uL1.signal else uL2.signal;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{12,0},{100,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-98,-80},{-40,-80}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(points={{-40,10},{-40,-10}}, color={0,0,0}),
        Line(points={{-98,80},{-40,80}}, color={0,0,0}),
        Line(points={{-40,80},{10,0}}, color={0,0,0}),
        Ellipse(
          extent={{2,8},{18,-8}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,70},{-40,80}}, color={0,0,0}),
        Line(points={{-40,80},{-30,76}}, color={0,0,0})}),
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
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(
          points={{12,0},{100,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-98,-80},{-40,-80}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Line(points={{-40,10},{-40,-10}}, color={0,0,0}),
        Line(points={{-98,80},{-40,80}}, color={0,0,0}),
        Line(points={{-40,80},{10,0}}, color={0,0,0}),
        Ellipse(
          extent={{2,8},{18,-8}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,70},{-40,80}}, color={0,0,0}),
        Line(points={{-40,80},{-30,76}}, color={0,0,0})}),
    Window(
      x=0.23,
      y=0.22,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Selecteur;
