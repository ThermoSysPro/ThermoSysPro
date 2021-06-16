within ThermoSysPro.WaterSteam.Sensors;
model SensorQv "Volumetric flow sensor"
  parameter Integer output_unit=1 "Sensor outpu unit - 1: m3/h, other: m3/s";
  parameter Boolean continuous_flow_reversal=false
    "true : continuous flow reversal - false : discontinuous flow reversal";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Minimum mass flow rate for continuous flow reversal";

public
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  Modelica.SIunits.VolumeFlowRate Qv(start=0.5) "Volume flow rate";
  Modelica.SIunits.AbsolutePressure Pm "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h "Fluid specific enthalpy";

protected
  Modelica.SIunits.Time facteur=if (output_unit == 1) then 3600 else 1
    "Unit factor";
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Measure
    annotation (Placement(transformation(
        origin={0,102},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}},
          rotation=0)));
  Connectors.FluidOutlet C2
    annotation (Placement(transformation(extent={{92,-90},{112,-70}}, rotation=
            0)));
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
  Qv = Q/pro.d;
  Measure.signal = Qv*facteur;

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  h = C1.h;

  pro = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pm, h, mode);

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
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-60,64},{60,4}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString =                      "Qv")}),
    Window(
      x=0.3,
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
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-60,64},{60,4}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString =                      "Qv")}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El hefni </li>
</ul>
</html>"));
end SensorQv;
