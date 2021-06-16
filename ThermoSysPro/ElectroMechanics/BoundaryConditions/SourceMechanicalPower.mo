within ThermoSysPro.ElectroMechanics.BoundaryConditions;
model SourceMechanicalPower "Mechanical power source"
  parameter Modelica.SIunits.Power W0=150000;

  ThermoSysPro.ElectroMechanics.Connectors.MechanichalTorque M
    annotation (Placement(transformation(
        origin={110,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPower
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
equation

  if (cardinality(IPower) == 0) then
    IPower.signal = W0;
  end if;

  M.Ctr*M.w = IPower.signal;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "W"),
        Line(points={{40,0},{100,0}}, color={0,0,255}),
        Line(points={{100,0},{80,-20}}, color={0,0,255}),
        Line(points={{100,0},{80,20}}, color={0,0,255})}),
                            Icon(graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "W"),
        Line(points={{40,0},{100,0}}, color={0,0,255}),
        Line(points={{100,0},{80,-20}}, color={0,0,255}),
        Line(points={{100,0},{80,20}}, color={0,0,255})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SourceMechanicalPower;
