within ThermoSysPro.WaterSteam.PressureLosses;
model IdealSwitchValve "Ideal switch valve"
  parameter Modelica.SIunits.MassFlowRate Qmin=1.e-6
    "Mass flow when the valve is closed";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  ThermoSysPro.Units.DifferentialPressure deltaP
    "Pressure difference between the inlet and the outlet";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical Ouv
    annotation (Placement(transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -72},{-90,-52}}, rotation=0)));
  Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{90,-70},
            {110,-50}}, rotation=0)));
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

  if Ouv.signal then
    deltaP = 0;
  else
    Q - Qmin = 0;
  end if;

  annotation (
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
        Line(points={{0,60},{0,-60}}),
        Text(extent={{-104,34},{88,-22}}, textString=
                                              "DP=0")}),
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
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,60},{40,60}},
          color={0,0,255},
          thickness=1),
        Line(points={{0,60},{0,-60}}),
        Text(extent={{-104,34},{88,-22}}, textString=
                                              "DP=0")}),
    Window(
      x=0.22,
      y=0.12,
      width=0.72,
      height=0.74),
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
end IdealSwitchValve;
