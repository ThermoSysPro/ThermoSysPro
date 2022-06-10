within ThermoSysPro.Fluid.Machines;
model StaticFan "Static fan"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter ThermoSysPro.Units.nonSI.AngularVelocity_rpm VRot=1400
    "Rotational speed";
  parameter ThermoSysPro.Units.nonSI.AngularVelocity_rpm VRotn=1400
    "Nominal rotational speed";
  parameter Real rm=0.85 "Product of the pump mechanical and electrical efficiencies";
  parameter Boolean adiabatic_compression=false "true: adiabatic compression - false: non adiabatic compression";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

  parameter Real a1=-52.04 "x^2 coef. of the pump characteristics hn = f(vol_flow) (s2/m5)";
  parameter Real a2=-71.735 "x coef. of the pump characteristics hn = f(vol_flow) (s/m2)";
  parameter Real a3=45.59  "Constant coef. of the pump characteristics hn = f(vol_flow) (m)";

  parameter Real b1=-8.4818 "x^2 coef. of the pump efficiency characteristics rh = f(vol_flow) (s2/m6)";
  parameter Real b2=4.6593 "x coef. of the pump efficiency characteristics rh = f(vol_flow) (s/m3)";
  parameter Real b3=-0.1533 "Constant coef. of the pump efficiency characteristics rh = f(vol_flow) (s.u.)";

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Real eps=1.e-6 "Small number";
  parameter Real rhmin=0.20 "Minimum efficiency to avoid zero crossings";

public
  Real rh( start=0.5) "Hydraulic efficiency";
  Units.SI.Length hn(start=10) "Pump head";
  Real R "Ratio VRot/VRotn (s.u.)";
  Units.SI.MassFlowRate Q(start=500) "Mass flow";
  Units.SI.VolumeFlowRate Qv(start=0.5) "Volumetric flow";
  Units.SI.Power Wh "Hydraulic power";
  Units.SI.Power Wm "Motor power";
  Units.SI.Density rho(start=998) "Fluid density";
  ThermoSysPro.Units.SI.PressureDifference deltaP
    "Pressure variation between the outlet and the inlet";
  Units.SI.SpecificEnthalpy deltaH
    "Specific enthalpy variation between the outlet and the inlet";
  Units.SI.AbsolutePressure P(start=1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid average specific enthalpy";
  Units.SI.Temperature T(start=500) "Fluid temperature";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical commandeFan
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Interfaces.Connectors.FluidInlet C1 annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet C2 annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal VRotation
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  /* Check that the fluid type is flue gases */
  assert(ftype == FluidType.FlueGases, "StaticFan: the fluid type must be flue gases");

  if (cardinality(commandeFan) == 0) then
    commandeFan.signal = true;
  end if;

  if (cardinality(VRotation) == 0) then
    VRotation.signal = VRot;
  end if;

  C1.Q = C2.Q;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = if (gamma_diff > 0) then C1.diff_on_1 else false;
  C1.diff_on_2 = if (gamma_diff > 0) then C2.diff_on_2 else false;

  C2.diff_res_1 = C1.diff_res_1 + (if (gamma_diff > 0) then 1/gamma_diff else 0);
  C1.diff_res_2 = C2.diff_res_2 + (if (gamma_diff > 0) then 1/gamma_diff else 0);

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  ftype = C1.ftype;

  Q = C1.Q;
  Q = Qv*rho;

  deltaP = C2.P - C1.P;
  deltaH = C2.h - C1.h;

  deltaP = rho*g*hn;

  if adiabatic_compression then
    deltaH = 0;
  else
    deltaH = g*hn/rh;
  end if;

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
  h = (C2.h + C1.h)/2;

  // Temperature
  h =  ThermoSysPro.Properties.FlueGases.FlueGases_h(P, T, C2.Xco2, C2.Xh2o, C2.Xo2, C2.Xso2);

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
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-92,40},{-92,-40},{92,40},{92,-40},{-92,40}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Backward)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end StaticFan;
