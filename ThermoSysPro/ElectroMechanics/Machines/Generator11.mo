within ThermoSysPro.ElectroMechanics.Machines;
model Generator11 "Electrical generator with eleven inputs"
  parameter Real eta = 99.8 "Efficiency (percent)";

public
  Units.SI.Power Welec "Electrical power produced by the generator";

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
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal MechPower
                              annotation (Placement(transformation(
        origin={88,134},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec9
    annotation (Placement(transformation(
        origin={-20,-142},
        extent={{-14,-16},{14,16}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec10
    annotation (Placement(transformation(
        origin={34,-142},
        extent={{-14,-16},{14,16}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec11
    annotation (Placement(transformation(
        origin={98,-144},
        extent={{-14,-16},{14,16}},
        rotation=90)));
equation

  /* Handling of unconnected connectors */
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
   Wmec6.signal = 0;
  end if;
  if (cardinality(Wmec7) == 0) then
   Wmec7.signal = 0;
  end if;
  if (cardinality(Wmec8) == 0) then
   Wmec8.signal = 0;
  end if;
  if (cardinality(Wmec9) == 0) then
   Wmec9.signal = 0;
  end if;
  if (cardinality(Wmec10) == 0) then
   Wmec10.signal = 0;
  end if;
  if (cardinality(Wmec11) == 0) then
   Wmec11.signal = 0;
  end if;

  assert(eta <= 100, "Generator : efficiency over 100%");
  assert(eta >= 0, "Generator : efficiency below 0%");

  /* Electrical power produced by the generator */
  Welec = (Wmec1.signal + Wmec2.signal + Wmec3.signal + Wmec4.signal + Wmec5.signal + Wmec6.signal + Wmec7.signal + Wmec8.signal + Wmec9.signal+ Wmec10.signal+ Wmec11.signal)*eta/100;

  MechPower.signal = Welec;

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-130},{100,130}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-56,33},{66,-33}},
          lineColor={28,108,200},
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
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,13},{-56,-11}},
          lineColor={28,108,200},
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
          lineColor={28,108,200},
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
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,13},{-56,-11}},
          lineColor={28,108,200},
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
        Line(points={{-82,0},{-68,0}}, color={0,0,255}),
        Line(
          points={{-83,130},{-83,-130}},
          color={0,0,255},
          thickness=0.5)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Generator11;
