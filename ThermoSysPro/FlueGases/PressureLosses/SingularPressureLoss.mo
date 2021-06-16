within ThermoSysPro.FlueGases.PressureLosses;
model SingularPressureLoss "Singular pressure loss for flue gases"
  parameter Real K=1.e-3 "Friction pressure loss coefficient";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";

protected
  parameter Real eps=1.e-3 "Small number for pressure loss equation";

public
  ThermoSysPro.Units.DifferentialPressure deltaPf(start=1.e2)
    "Friction pressure loss";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow";
  Modelica.SIunits.Density rho(start=1) "Fluid density";
  Modelica.SIunits.Temperature T(start=290) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure P(start=1.e5) "Average fluid pressure";

public
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet C2
                          annotation (Placement(transformation(extent={{90,-10},
            {110,10}}, rotation=0)));

equation
  C1.P - C2.P = deltaPf;
  C1.T = C2.T; // Because the behaviour of the flue gas is close to an ideal gas
  C1.Q = C2.Q;

  C2.Xco2 = C1.Xco2;
  C2.Xh2o = C1.Xh2o;
  C2.Xo2  = C1.Xo2;
  C2.Xso2 = C1.Xso2;

  Q = C1.Q;

  /* Pressure loss */
  deltaPf = K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho;

  /* Fluid thermodynamic properties */
  P = (C1.P + C2.P)/2;
  T = C2.T;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.FlueGases.FlueGases_rho(P, T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-60,40},{-40,20},{-20,10},{0,8},{20,10},{40,20},{60,40},{-60,
              40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward), Polygon(
          points={{-60,-40},{-40,-20},{-20,-12},{0,-10},{20,-12},{40,-20},{60,
              -40},{-60,-40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-60,40},{-40,20},{-20,10},{0,8},{20,10},{40,20},{60,40},{-60,
              40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward), Polygon(
          points={{-60,-40},{-40,-20},{-20,-12},{0,-10},{20,-12},{40,-20},{60,
              -40},{-60,-40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Window(
      x=0.11,
      y=0.04,
      width=0.71,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end SingularPressureLoss;
