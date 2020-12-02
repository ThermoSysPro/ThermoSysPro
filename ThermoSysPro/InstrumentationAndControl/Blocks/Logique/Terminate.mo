within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block Terminate

  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL
                                          annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
algorithm

  when uL.signal then
    terminate("Fin de la simulation");
  end when;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-80,0},{40,0}}),
        Line(points={{40,40},{40,-40}}),
        Rectangle(
          extent={{-100,-100},{100,102}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25,
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-70,-20},{-70,40},{-30,80},{30,80},{70,40},{70,-20},{
              30,-60},{-30,-60},{-70,-20}}, lineColor={0,0,0}),
        Text(
          extent={{-48,40},{50,-20}},
          lineColor={0,0,0},
          textString=
               "STOP")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(points={{-70,-20},{-70,40},{-30,80},{30,
              80},{70,40},{70,-20},{30,-60},{-30,-60},{-70,-20}}, lineColor={0,
              0,0}), Text(
          extent={{-48,40},{50,-20}},
          lineColor={0,0,0},
          textString=
               "STOP")}),
    Window(
      x=0.25,
      y=0.16,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
end Terminate;
