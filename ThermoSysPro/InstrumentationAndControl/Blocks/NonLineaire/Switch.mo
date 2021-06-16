within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block Switch
  parameter Real C1=1 "Valeur de la sortie pour sel=1 si u1 non connecté";
  parameter Real C2=1 "Valeur de la sortie pour sel=2 si u2 non connecté";
  parameter Real C3=1 "Valeur de la sortie pour sel=3 si u3 non connecté";
  parameter Real C4=1 "Valeur de la sortie pour sel=4 si u4 non connecté";
  parameter Real C5=1
    "Valeur de la sortie pour des autres valeur de sel si u5 non connecté";
  parameter Integer Sel0=1 "Valeur de sel s'il n'est pas connecté";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
                                    annotation (Placement(transformation(extent=
           {{-120,70},{-100,90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
                                    annotation (Placement(transformation(extent=
           {{-120,30},{-100,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                   annotation (Placement(transformation(extent=
            {{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u3
                                    annotation (Placement(transformation(extent=
           {{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u4
                                    annotation (Placement(transformation(extent=
           {{-120,-50},{-100,-30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u5
                                    annotation (Placement(transformation(extent=
           {{-120,-90},{-100,-70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputInteger sel
                                           annotation (Placement(transformation(
        origin={10,-90},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation

  if (cardinality(u1) == 0) then
    u1.signal = C1;
  end if;

  if (cardinality(u2) == 0) then
    u2.signal = C2;
  end if;

  if (cardinality(u3) == 0) then
    u3.signal = C3;
  end if;

  if (cardinality(u4) == 0) then
    u4.signal = C4;
  end if;

  if (cardinality(u5) == 0) then
    u5.signal = C5;
  end if;

  if (cardinality(sel) == 0) then
    sel.signal = Sel0;
  end if;

  y.signal = if (sel.signal == 1) then u1.signal else
             if (sel.signal == 2) then u2.signal else
             if (sel.signal == 3) then u3.signal else
             if (sel.signal == 4) then u4.signal else
                                   u5.signal;

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
          points={{-98,-80},{-40,-80}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(
          points={{-100,80},{-40,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,40},{-40,40}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,-40},{-40,-40}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,-80},{-40,-80}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-40,70},{-40,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,80},{-30,76}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,80},{10,0}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{2,8},{18,-8}},
          lineColor={95,95,95},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,0},{100,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{10,-8},{10,-84}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-68,98},{-30,76}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C1"),
        Text(
          extent={{-68,60},{-30,38}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C2"),
        Text(
          extent={{-68,20},{-30,-2}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C3"),
        Text(
          extent={{-68,-20},{-30,-42}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C4"),
        Text(
          extent={{-68,-60},{-30,-82}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C5"),
        Text(
          extent={{12,-60},{50,-82}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "sel")}),
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
          points={{18,0},{100,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,-80},{-40,-80}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,80},{-40,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,80},{10,0}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{2,8},{18,-8}},
          lineColor={95,95,95},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,70},{-40,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,80},{-30,76}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,40},{-40,40}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{-100,-40},{-40,-40}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.5,
          arrow={Arrow.None,Arrow.None}),
        Line(
          points={{10,-8},{10,-84}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-70,60},{-32,38}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C2"),
        Text(
          extent={{-70,20},{-32,-2}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C3"),
        Text(
          extent={{-70,-20},{-32,-42}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C4"),
        Text(
          extent={{-70,-60},{-32,-82}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C5"),
        Text(
          extent={{10,-60},{48,-82}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "sel"),
        Text(
          extent={{-70,98},{-32,76}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          textString=
               "C1")}),
    Window(
      x=0.35,
      y=0.11,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.6</b></p>
<par>
Selection entre plusieurs valeurs :
<ul>
<li>   y==u1 (ou C1 si u1 n'est pas connecté) si Sel == 1; <\\li>
<li>   y==u2 (ou C2 si u2 n'est pas connecté) si Sel == 2; <\\li>
<li>   y==u3 (ou C3 si u3 n'est pas connecté) si Sel == 3; <\\li>
<li>   y==u4 (ou C4 si u4 n'est pas connecté) si Sel == 4; <\\li>
<li>   y==u5 (ou C5 si u5 n'est pas connecté) dans tous les autres cas; <\\li>
<\\ul>
<\\par>
</HTML>
"));
end Switch;
