within ThermoSysPro.WaterSteam.Sensors;
model SensorQ "Mass flow sensor"
  parameter Boolean continuous_flow_reversal=false
    "true : continuous flow reversal - false : discontinuous flow reversal";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Minimum mass flow for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Measure
    annotation (Placement(transformation(
        origin={0,102},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -90},{-90,-70}}, rotation=0)));
  Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{92,-90},
            {112,-70}}, rotation=0)));
equation

  C1.P = C2.P;
  C1.h = C2.h;
  C1.Q = C2.Q;

  Q = C1.Q;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  /* Sensor signal */
  Measure.signal = Q;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-28},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(extent={{-60,60},{60,0}}, textString=
                                            "Q")}),
    Window(
      x=0.25,
      y=0.19,
      width=0.6,
      height=0.6),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-28},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-60,60},{60,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={120,255,0},
          textString =                      "Q")}),
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
end SensorQ;
