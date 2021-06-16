within ThermoSysPro.FlueGases.PressureLosses;
model CheckValve "Check valve"
  parameter ThermoSysPro.Units.DifferentialPressure dPOuvert=10
    "Pressure difference when the valve opens";
  parameter ThermoSysPro.Units.DifferentialPressure dPFerme=0
    "Pressure difference when the valve closes";
  parameter ThermoSysPro.Units.PressureLossCoefficient k=1000
    "Pressure loss coefficient";
  parameter Modelica.SIunits.MassFlowRate Qmin=1.e-6
    "Mass flow when the valve is closed";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";

protected
  parameter Real eps=1.e-3 "Small number for pressure loss equation";

public
  Boolean ouvert(start=true, fixed=true) "Valve state";
  discrete Boolean touvert(start=false, fixed=true);
  discrete Boolean tferme(start=false, fixed=true);
  Modelica.SIunits.MassFlowRate Q(start=100) "Mass flow";
  ThermoSysPro.Units.DifferentialPressure deltaP(start=10)
    "Singular pressure loss";
  Modelica.SIunits.Density rho(start=1) "Fluid density";
  Modelica.SIunits.Temperature T(start=300) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure P(start=1.e5) "Fluid average pressure";

  Connectors.FlueGasesInlet C1      annotation (Placement(transformation(extent=
           {{-120,-10},{-100,10}}, rotation=0)));
  Connectors.FlueGasesOutlet C2     annotation (Placement(transformation(extent=
           {{100,-10},{120,10}}, rotation=0)));
equation

  C1.Q = C2.Q;
  C1.T = C2.T; // Because the behaviour of the flue gas is close to an ideal gas
  Q = C1.Q;
  deltaP = C1.P - C2.P;

  C2.Xco2 = C1.Xco2;
  C2.Xh2o = C1.Xh2o;
  C2.Xo2  = C1.Xo2;
  C2.Xso2 = C1.Xso2;

  /* Pressure loss */
  if ouvert then
    deltaP - k*ThermoSysPro.Functions.ThermoSquare(Q, eps)/2/rho = 0;
  else
    Q - Qmin = 0;
  end if;

  touvert = (deltaP > dPOuvert);
  tferme = (deltaP < dPFerme);

  when {pre(tferme),pre(touvert)} then
    ouvert = pre(touvert);
  end when;

  /* Fluid thermodynamic properties */
  P = (C1.P + C2.P)/2;
  T = C1.T;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.FlueGases.FlueGases_rho(P, T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={0,0,0},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={0,203,0},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={0,0,0},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={0,203,0},
          thickness=0.5)}),
    Window(
      x=0.09,
      y=0.05,
      width=0.91,
      height=0.92),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end CheckValve;
