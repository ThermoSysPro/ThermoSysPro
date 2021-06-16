within ThermoSysPro.FlueGases.Machines;
model StaticFan "Static fan"
  parameter ThermoSysPro.Units.AngularVelocity_rpm VRot=1400 "Rotational speed";
  parameter ThermoSysPro.Units.AngularVelocity_rpm VRotn=1400
    "Nominal rotational speed";
  parameter Real rm=0.85
    "Product of the pump mechanical and electrical efficiencies";
  parameter Boolean adiabatic_compression=false
    "true: adiabatic compression - false: non adiabatic compression";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";

  parameter Real a1=-52.04
    "x^2 coef. of the pump characteristics hn = f(vol_flow) (s2/m5)";
  parameter Real a2=-71.735
    "x coef. of the pump characteristics hn = f(vol_flow) (s/m2)";
  parameter Real a3=45.59
    "Constant coef. of the pump characteristics hn = f(vol_flow) (m)";

  parameter Real b1=-8.4818
    "x^2 coef. of the pump efficiency characteristics rh = f(vol_flow) (s2/m6)";
  parameter Real b2=4.6593
    "x coef. of the pump efficiency characteristics rh = f(vol_flow) (s/m3)";
  parameter Real b3=-0.1533
    "Constant coef. of the pump efficiency characteristics rh = f(vol_flow) (s.u.)";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  parameter Real eps=1.e-6 "Small number";
  parameter Real rhmin=0.20 "Minimum efficiency to avoid zero crossings";

public
  Real rh( start=0.5) "Hydraulic efficiency";
  Modelica.SIunits.Length hn(start=10) "Pump head";
  Real R "Ratio VRot/VRotn (s.u.)";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow";
  Modelica.SIunits.VolumeFlowRate Qv(start=0.5) "Volumetric flow";
  Modelica.SIunits.Power Wh "Hydraulic power";
  Modelica.SIunits.Power Wm "Motor power";
   Modelica.SIunits.Density rho(start=998) "Fluid density";
  ThermoSysPro.Units.DifferentialPressure deltaP
    "Pressure variation between the outlet and the inlet";
  Modelica.SIunits.SpecificEnthalpy deltaH
    "Specific enthalpy variation between the outlet and the inlet";
  Modelica.SIunits.AbsolutePressure P(start=1.e5) "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000)
    "Fluid average specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy h1(start=100000)
    "Fluid specific enthalpy in";
  Modelica.SIunits.SpecificEnthalpy h2(start=100000)
    "Fluid specific enthalpy out";
  Modelica.SIunits.Temperature T( start=500) "Fluid temperature";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical commandeFan
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Connectors.FlueGasesInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  Connectors.FlueGasesOutlet C2
                          annotation (Placement(transformation(extent={{90,-10},
            {110,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal VRotation
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  if (cardinality(commandeFan) == 0) then
    commandeFan.signal = true;
  end if;

  if (cardinality(VRotation) == 0) then
    VRotation.signal = VRot;
  end if;

  /* Flue gas composition */
  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  deltaP = C2.P - C1.P;
  deltaH = h2 - h1;

  deltaP = rho*g*hn;

  if adiabatic_compression then
    deltaH = 0;
  else
    deltaH = g*hn/rh;
  end if;

  C1.Q = C2.Q;
  Q = C1.Q;
  Q = Qv*rho;

  /* Pump position (started or stopped) */
  R = if commandeFan.signal then VRotation.signal/VRotn else 0;

  /* Pump characteristics */
  hn = noEvent(a1*Qv*abs(Qv) + a2*Qv*R + a3*R^2);
  rh = noEvent(max(if (abs(R) > eps) then b1*Qv^2/R^2 + b2*Qv/R + b3 else b3, rhmin));

  /* Mechanical power */
  Wm = Q*deltaH/rm;

  /* Hydraulic power */
  Wh = Qv*deltaP/rh;

  /* Fluid thermodynamic properties */
  P = (C1.P + C2.P)/2;
  h = (h1 + h2)/2;

  // Temperature
  h =  ThermoSysPro.Properties.FlueGases.FlueGases_h(P, T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);
  h2 =  ThermoSysPro.Properties.FlueGases.FlueGases_h(P, C2.T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);

  // Enthalpy
  h1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, C1.T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);

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
        Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Polygon(
          points={{-40,92},{40,92},{-40,-92},{40,-92},{-40,92}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-92,40},{-92,-40},{92,40},{92,-40},{-92,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Window(
      x=0.03,
      y=0.02,
      width=0.95,
      height=0.95),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Polygon(
          points={{-40,92},{40,92},{-40,-92},{40,-92},{-40,92}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-92,40},{-92,-40},{92,40},{92,-40},{-92,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Backward)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u> </p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end StaticFan;
