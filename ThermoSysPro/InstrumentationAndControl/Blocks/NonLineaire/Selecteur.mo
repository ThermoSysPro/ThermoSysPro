within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block Selecteur
  parameter Real C1=-1 "Valeur de la sortie pour uCond=true si u1 non connecté";
  parameter Real C2=+1
    "Valeur de la sortie pour uCond=false si u2 non connecté";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uCond
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
                                       annotation (Placement(transformation(
          extent={{-120,70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
                                       annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  if (cardinality(u1) == 0) then
    u1.signal = C1;
  end if;

  if (cardinality(u2) == 0) then
    u2.signal = C2;
  end if;

  y.signal = if uCond.signal then u1.signal else u2.signal;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
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
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-40,70},{-40,80}}, color={0,0,0}),
        Line(points={{-40,80},{-30,76}}, color={0,0,0}),
        Text(
          extent={{-100,80},{-38,48}},
          lineColor={0,0,255},
          textString=
               "C1"),
        Text(
          extent={{-100,-48},{-38,-80}},
          lineColor={0,0,255},
          textString=
               "C2")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
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
        Line(points={{-40,80},{-30,76}}, color={0,0,0}),
        Text(
          extent={{-102,78},{-40,46}},
          lineColor={0,0,255},
          textString=
               "C1"),
        Text(
          extent={{-102,-50},{-40,-82}},
          lineColor={0,0,255},
          textString=
               "C2")}),
    Window(
      x=0.35,
      y=0.11,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
end Selecteur;
