within ThermoSysPro.WaterSteam.BoundaryConditions;
model RefH "Fixed specific enthalpy reference"
  parameter Modelica.SIunits.SpecificEnthalpy h0=1.e5
    "Fixed fluid specific enthalpy";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FluidOutlet C2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ISpecificEnthalpy
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));

equation
  if (cardinality(ISpecificEnthalpy) == 0) then
    ISpecificEnthalpy.signal = h0;
  end if;

  C1.P = C2.P;
  C1.h = C2.h;
  C1.Q = C2.Q;

  Q = C1.Q;
  C1.h = ISpecificEnthalpy.signal;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "H")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "H")}),
    Window(
      x=0.06,
      y=0.08,
      width=0.82,
      height=0.65),
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
</html>"),
    DymolaStoredErrors);
end RefH;
