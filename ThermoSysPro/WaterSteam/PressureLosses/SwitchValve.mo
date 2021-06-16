within ThermoSysPro.WaterSteam.PressureLosses;
model SwitchValve "Switch valve"
  parameter ThermoSysPro.Units.PressureLossCoefficient k=1000
    "Pressure loss coefficient";
  parameter Modelica.SIunits.MassFlowRate Qmin=1.e-6
    "Mass flow when the valve is closed";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Real eps=1.e-3 "Small number for pressure loss equation";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.DifferentialPressure deltaP "Singular pressure loss";
  Modelica.SIunits.Density rho(start=998) "Fluid density";
  Modelica.SIunits.Temperature T(start=290) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure Pm(start=1.e5) "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical Ouv
    annotation (Placement(transformation(
        origin={0,72},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -70},{-90,-50}}, rotation=0)));
  Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{90,-68},
            {110,-48}}, rotation=0)));
equation

  C1.Q = C2.Q;
  C1.h = C2.h;

  h = C1.h;
  Q = C1.Q;

  deltaP = C1.P - C2.P;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  /* Pressure loss */
  if Ouv.signal then
    deltaP - k*ThermoSysPro.Functions.ThermoSquare(Q, eps)/2/rho = 0;
  else
    Q - Qmin = 0;
  end if;

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;

  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);

  T = pro.T;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-100},{-100,-100}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-100},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,60},{40,60}},
          color={0,0,255},
          thickness=1),
        Line(points={{0,60},{0,-60}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-100},{-100,-100}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-100},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,60},{40,60}},
          color={0,0,255},
          thickness=1),
        Line(points={{0,60},{0,-60}})}),
    Window(
      x=0.1,
      y=0.04,
      width=0.79,
      height=0.84),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 13.10 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SwitchValve;
