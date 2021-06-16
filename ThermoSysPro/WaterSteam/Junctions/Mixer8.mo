within ThermoSysPro.WaterSteam.Junctions;
model Mixer8 "Mixer with eight inlets"
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.AbsolutePressure P(start=10e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Modelica.SIunits.Temperature T "Fluid temperature";

  Connectors.FluidInlet Ce5
    annotation (                             layer="icon", Placement(
        transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
  Connectors.FluidInlet Ce6
    annotation (                              layer="icon", Placement(
        transformation(extent={{-112,-109},{-92,-89}}, rotation=0)));
  Connectors.FluidInlet Ce7
    annotation (                             layer="icon", Placement(
        transformation(extent={{-40,-109},{-20,-89}}, rotation=0)));
  Connectors.FluidInlet Ce3
                           annotation (                            layer="icon",
      Placement(transformation(extent={{-112,90},{-92,110}}, rotation=0)));
  Connectors.FluidInlet Ce2
                           annotation (                           layer="icon",
      Placement(transformation(extent={{-40,90},{-20,110}}, rotation=0)));
  Connectors.FluidInlet Ce1
                           annotation (                          layer="icon",
      Placement(transformation(extent={{20,92},{40,112}}, rotation=0)));
  Connectors.FluidOutlet Cs
                           annotation (                           layer="icon",
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Connectors.FluidInlet Ce8
                           annotation (                            layer="icon",
      Placement(transformation(extent={{20,-109},{40,-89}}, rotation=0)));

  Connectors.FluidInlet Ce4
    annotation (                             layer="icon", Placement(
        transformation(extent={{-112,30},{-92,50}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}}, rotation=
            0)));
equation
  /* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.b = true;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.b = true;
  end if;

  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.h = 1.e5;
    Ce3.b = true;
  end if;

  if (cardinality(Ce4) == 0) then
    Ce4.Q = 0;
    Ce4.h = 1.e5;
    Ce4.b = true;
  end if;

  if (cardinality(Ce5) == 0) then
    Ce5.Q = 0;
    Ce5.h = 1.e5;
    Ce5.b = true;
  end if;

  if (cardinality(Ce6) == 0) then
    Ce6.Q = 0;
    Ce6.h = 1.e5;
    Ce6.b = true;
  end if;

  if (cardinality(Ce7) == 0) then
    Ce7.Q = 0;
    Ce7.h = 1.e5;
    Ce7.b = true;
  end if;

  if (cardinality(Ce8) == 0) then
    Ce8.Q = 0;
    Ce8.h = 1.e5;
    Ce8.b = true;
  end if;

  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h = 1.e5;
    Cs.a = true;
  end if;

  /* Fluid pressure */
  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Ce4.P;
  P = Ce5.P;
  P = Ce6.P;
  P = Ce7.P;
  P = Ce8.P;
  P = Cs.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Ce1.h_vol = h;
  Ce2.h_vol = h;
  Ce3.h_vol = h;
  Ce4.h_vol = h;
  Ce5.h_vol = h;
  Ce6.h_vol = h;
  Ce7.h_vol = h;
  Ce8.h_vol = h;
  Cs.h_vol = h;

  /* Mass balance equation */
  0 = Ce1.Q + Ce2.Q + Ce3.Q + Ce4.Q + Ce5.Q + Ce6.Q + Ce7.Q + Ce8.Q - Cs.Q;

  /* Energy balance equation */
  0 = Ce1.Q*Ce1.h + Ce2.Q*Ce2.h + Ce3.Q*Ce3.h + Ce4.Q*Ce4.h + Ce5.Q*Ce5.h + Ce6.Q*Ce6.h + Ce7.Q*Ce7.h + Ce8.Q*Ce8.h - Cs.Q*Cs.h;

  /* Fluid thermodynamic properties */
  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);

  T = pro.T;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,2},{40,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{40,0},{92,0}}),
        Line(points={{-92,-40},{-40,-40}}),
        Line(points={{-30,90},{-30,66}}, color={0,0,255}),
        Line(points={{30,92},{30,66}}, color={0,0,255}),
        Line(points={{-30,-66},{-30,-90}}, color={0,0,255}),
        Line(points={{30,-66},{30,-90}}, color={0,0,255}),
        Line(points={{-92,40},{-40,40}}),
        Line(points={{-38,-52},{-92,-90}}, color={0,0,255}),
        Line(points={{-38,54},{-92,90}}, color={0,0,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,0},{40,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-30,90},{-30,66}}, color={0,0,255}),
        Line(points={{-30,-66},{-30,-90}}, color={0,0,255}),
        Line(points={{30,92},{30,66}}, color={0,0,255}),
        Line(points={{30,-66},{30,-90}}, color={0,0,255}),
        Line(points={{-92,40},{-40,40}}),
        Line(points={{-92,-40},{-40,-40}}),
        Line(points={{40,0},{92,0}}),
        Line(points={{-38,-52},{-92,-90}}, color={0,0,255}),
        Line(points={{-38,54},{-92,90}}, color={0,0,255})}),
    Window(
      x=0.05,
      y=0.07,
      width=0.74,
      height=0.85),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 14.7 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Mixer8;
