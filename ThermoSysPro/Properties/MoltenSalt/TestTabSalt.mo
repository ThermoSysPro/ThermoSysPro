within ThermoSysPro.Properties.MoltenSalt;
model TestTabSalt "TestTabSalt"

  parameter Modelica.SIunits.Temperature T0=800
    "initial temperature of the fluid";

public
  Modelica.SIunits.Density rho1(start=1800) "Fluid density ";

  Modelica.SIunits.ThermalConductivity k(start=0.3)
    "Fluid thermal conductivity";
  Modelica.SIunits.DynamicViscosity mu1(start=6.e-3) "Fluid dynamic viscosity ";

  Modelica.SIunits.SpecificHeatCapacity cp(start=1571)
    "Fluid specific heat capacity";

  Modelica.SIunits.Density rho11(start=1800) "Fluid density ";

  Modelica.SIunits.ThermalConductivity k1(start=0.3)
    "Fluid thermal conductivity";
  Modelica.SIunits.DynamicViscosity mu11(start=6.e-3)
    "Fluid dynamic viscosity ";

  Modelica.SIunits.SpecificHeatCapacity cp1(start=1571)
    "Fluid specific heat capacity";

  Properties.MoltenSalt.ThermoProperties_T pro1
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Properties.MoltenSalt.ThermoProperties_T pro11
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));

equation
    /* Fluid thermodynamic properties */
    pro1 = ThermoSysPro.Properties.MoltenSalt.ThermoPropertiesFunction_T_1(T0);

    rho1 = pro1.d;

    cp = pro1.cp;

    mu1 = pro1.mu;

    k = pro1.k;

  pro11 = ThermoSysPro.Properties.MoltenSalt.ThermoPropertiesFunction_T_2(T0);

    rho11 = pro11.d;

    cp1 = pro11.cp;

    mu11 = pro11.mu;

    k1 = pro11.k;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}}),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}}),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{60,20},{60,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{-60,20},{-60,-20}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,20},{-60,-20}}),
        Line(points={{-20,20},{-20,-20}}),
        Line(points={{20,20},{20,-20}}),
        Line(points={{60,20},{60,-20}})}),
    Window(
      x=0.18,
      y=0.05,
      width=0.68,
      height=0.94),
    Documentation(info="<html>
<p><h4>Copyright &copy; EDF 2002 - 2012</h4></p>
<p><b>ThermoSysPro Version 3.1</b> </p>
</html>",
   revisions="<html>
<u><p><b>Authors</u> : </p></b>
<ul style='margin-top:0cm' type=disc>
<li>
    Baligh El Hefni</li>
<li>
    Daniel Bouskela</li>
<li>
    QiangQiang Zhang </li>
</ul>
</html>
"));
end TestTabSalt;
