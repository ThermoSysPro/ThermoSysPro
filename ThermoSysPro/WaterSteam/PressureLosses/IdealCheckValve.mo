within ThermoSysPro.WaterSteam.PressureLosses;
model IdealCheckValve "Ideal check valve"
  parameter ThermoSysPro.Units.DifferentialPressure dPOuvert=0.01
    "Pressure difference when the valve opens";
  parameter Modelica.SIunits.MassFlowRate Qmin=1.e-6
    "Mass flow trhough the valve when the valve is closed";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Boolean ouvert(start=true, fixed=true) "Valve state";
  discrete Boolean touvert(start=false, fixed=true);
  discrete Boolean tferme(start=false, fixed=true);
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  ThermoSysPro.Units.DifferentialPressure deltaP
    "Pressure difference between the inlet and the outlet";
  Connectors.FluidOutlet C2         annotation (Placement(transformation(extent=
           {{90,-10},{110,10}}, rotation=0)));
  Connectors.FluidInlet C1          annotation (Placement(transformation(extent=
           {{-110,-10},{-90,10}}, rotation=0)));
equation

  C1.Q = C2.Q;
  C1.h = C2.h;

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
  if ouvert then
    deltaP = 0;
  else
   Q - Qmin = 0;
  end if;

  touvert = (deltaP > dPOuvert);
  tferme = (not (Q > 0));

  when {pre(tferme),pre(touvert)} then
    ouvert = pre(touvert);
  end when;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Text(extent={{-96,-56},{96,-112}}, textString=
                                               "DP=0"),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={0,203,0},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Text(extent={{-96,-56},{96,-112}}, textString=
                                               "DP=0"),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={0,203,0},
          thickness=0.5)}),
    Window(
      x=0.08,
      y=0.02,
      width=0.84,
      height=0.9),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end IdealCheckValve;
