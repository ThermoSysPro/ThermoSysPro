within ThermoSysPro.Solar.Junctions;
model MassFlowMultiplier "Mass flow multipliier"
  parameter Real alpha=2 "Flow multiplier";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.AbsolutePressure P(start=10e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Modelica.SIunits.Temperature T "Fluid temperature";

public
  WaterSteam.Connectors.FluidInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  WaterSteam.Connectors.FluidOutlet Cs                annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
equation

  /* Fluid pressure */
  P = Ce.P;
  P = Cs.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Ce.h_vol = h;
  Cs.h_vol = h;

  /* Mass balance equation */
  0 = alpha*Ce.Q - Cs.Q;

  /* Energy balance equation */
  0 = alpha*Ce.Q*Ce.h - Cs.Q*Cs.h;

  /* Fluid thermodynamic properties */
  T = ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,60},{-100,-60},{90,0},{-100,60}},
          lineColor={0,0,255},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-60,24},{-20,-16}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%alpha")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,60},{-100,-60},{90,0},{-100,60}},
          lineColor={0,0,255},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-60,24},{-20,-16}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%alpha")}),
    Window(
      x=0.33,
      y=0.09,
      width=0.71,
      height=0.88),
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
end MassFlowMultiplier;
