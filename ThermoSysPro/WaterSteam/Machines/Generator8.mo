within ThermoSysPro.WaterSteam.Machines;
model Generator8 "Eletrical generator"
  parameter Real eta = 99.8 "Efficiency (percent)";

public
  Modelica.SIunits.Power Welec "Electrical power produced by the generator";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec2
    annotation (Placement(transformation(extent={{-116,78},{-84,106}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec1
    annotation (Placement(transformation(extent={{-116,116},{-84,144}},
          rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec3
    annotation (Placement(transformation(extent={{-116,40},{-84,68}}, rotation=
            0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec4
    annotation (Placement(transformation(extent={{-116,3},{-84,31}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec5
    annotation (Placement(transformation(extent={{-116,-34},{-84,-6}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec6
    annotation (Placement(transformation(extent={{-116,-71},{-84,-43}},
          rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec7
    annotation (Placement(transformation(extent={{-116,-108},{-84,-80}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec8
    annotation (Placement(transformation(extent={{-116,-144},{-84,-116}},
          rotation=0)));
equation
  /* Hnadling of unconnected connectors */
  if (cardinality(Wmec1) == 0) then
    Wmec1.signal = 0;
  end if;
  if (cardinality(Wmec2) == 0) then
   Wmec2.signal = 0;
  end if;
  if (cardinality(Wmec3) == 0) then
   Wmec3.signal = 0;
  end if;
  if (cardinality(Wmec4) == 0) then
   Wmec4.signal = 0;
  end if;
  if (cardinality(Wmec5) == 0) then
   Wmec5.signal = 0;
  end if;
  if (cardinality(Wmec6) == 0) then
   Wmec3.signal = 0;
  end if;
  if (cardinality(Wmec7) == 0) then
   Wmec4.signal = 0;
  end if;
  if (cardinality(Wmec8) == 0) then
   Wmec5.signal = 0;
  end if;

  assert(eta <= 100, "Generator : efficiency over 100%");
  assert(eta >= 0, "Generator : efficiency below 0%");

  /* Electrical power produced by the generator */
  Welec = (Wmec1.signal + Wmec2.signal + Wmec3.signal + Wmec4.signal + Wmec5.signal + Wmec6.signal + Wmec7.signal + Wmec8.signal)*eta/100;

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-130},{100,130}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-56,33},{66,-33}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-3},{66,1}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,17},{66,21}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,-21},{66,-17}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{66,13},{78,-11}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,13},{-56,-11}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-42,-23},{-44,-27},{-46,-29},{-50,-31},{-54,-31},{-58,-29},
              {-62,-23},{-64,-15},{-64,-7},{-64,15},{-62,21},{-60,25},{-58,27},
              {-54,29},{-52,29},{-48,27},{-46,25},{-44,21},{-44,27},{-48,23},{
              -44,21}}),
        Rectangle(
          extent={{-56,31},{66,35}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,-35},{66,-31}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Line(points={{-26,-11},{-4,13},{16,-15},{42,13}}, color={0,0,255}),
        Polygon(
          points={{42,13},{28,7},{36,-1},{42,13}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-84,130},{-84,-130}},
          color={0,0,255},
          thickness=0.5)}),     Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-130},{100,130}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-56,33},{66,-33}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-3},{66,1}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,17},{66,21}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,-21},{66,-17}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{66,13},{78,-11}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,13},{-56,-11}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-42,-23},{-44,-27},{-46,-29},{-50,-31},{-54,-31},{-58,-29},
              {-62,-23},{-64,-15},{-64,-7},{-64,15},{-62,21},{-60,25},{-58,27},
              {-54,29},{-52,29},{-48,27},{-46,25},{-44,21},{-44,27},{-48,23},{
              -44,21}}),
        Rectangle(
          extent={{-56,31},{66,35}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-56,-35},{66,-31}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Line(points={{-26,-11},{-4,13},{16,-15},{42,13}}, color={0,0,255}),
        Polygon(
          points={{42,13},{28,7},{36,-1},{42,13}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,0},{-68,0}}, color={0,128,255}),
        Line(points={{-80,80},{-80,-80}}, color={0,0,255}),
        Line(points={{-82,0},{-68,0}}, color={0,0,255}),
        Line(points={{-96,0},{-82,0}}, color={0,0,255}),
        Line(points={{-96,-80},{-80,-80}}, color={0,0,255}),
        Line(points={{-96,80},{-80,80}}, color={0,0,255}),
        Line(points={{-96,40},{-80,40}}, color={0,0,255}),
        Line(points={{-96,-40},{-80,-40}}, color={0,0,255})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Generator8;
