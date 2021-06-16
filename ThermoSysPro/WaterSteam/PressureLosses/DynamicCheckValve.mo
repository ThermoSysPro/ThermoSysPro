within ThermoSysPro.WaterSteam.PressureLosses;
model DynamicCheckValve "Dynamic check valve"
  parameter ThermoSysPro.Units.Cv Cvmax=8005.42 "Maximum CV";
  parameter Real caract[:, 2]=[0, 0; 1, Cvmax]
    "Position vs. Cv characteristics (active if mode_caract=1)";
  parameter Modelica.SIunits.MomentOfInertia J=1 "Flap moment of inertia";
  parameter Real Kf1=0 "Flap friction law coefficient #1";
  parameter Real Kf2=100 "Flap friction law coefficient #2";
  parameter Real n=5 "Flap friction law exponent";
  parameter Modelica.SIunits.Mass m=1 "Flap mass";
  parameter Modelica.SIunits.Area A=1 "Flap hydraulic area";
  parameter Real Ouv0=0 "Initial valve position, between 0 and 1. 0:valve closed - 1: valve open (active if permanent_meca = false)";
  parameter Integer mode_caract=0
    "0:linear characteristics - 1:characteristics is given by caract[]";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)";
  parameter Boolean mech_steady_state=true
    "true: start from mechanical steady state - false: start from 0";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";
  parameter Modelica.SIunits.Radius r=sqrt(A/pi) "Flap radius";
  parameter Modelica.SIunits.Angle theta_min=0 "Minimum flap aperture angle";
  parameter Modelica.SIunits.Angle theta_max=pi/2 "Maximum flap aperture angle";
  parameter Modelica.SIunits.Angle theta_m = (theta_min + theta_max)/2;
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Boolean libre(start=true)
    "Indicator whether the flap is free to move in both directions";
  Modelica.SIunits.Torque Cp "Gravity torque";
  Modelica.SIunits.Torque Cf "Friction torque";
  Modelica.SIunits.Torque Ch "Hydraulic torque";
  Modelica.SIunits.Torque Ct "Total torque";
  Modelica.SIunits.Angle theta(start=theta_m) "Flap aperture angle";
  Modelica.SIunits.AngularVelocity omega "Flap angular speed";
  Modelica.SIunits.AngularAcceleration a "Flap angular acceleration";
  Real Ouv "Valve position";
  ThermoSysPro.Units.Cv Cv(start=Cvmax) "Cv";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.DifferentialPressure deltaP "Singular pressure loss";
  Modelica.SIunits.Density rho(start=998) "Fluid density";
  Modelica.SIunits.Temperature T(start=290) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure Pm(start=1.e5) "Fluid average pressrue";
  Modelica.SIunits.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FluidOutlet C2                annotation (Placement(transformation(
          extent={{90,-10},{110,10}},rotation=0)));
initial equation
  if mech_steady_state then
    der(theta) = 0;
    der(omega) = 0;
  else
    assert((0 <= Ouv0) and (Ouv0 <= 1), "DynamickCheckValve: Ouv0 should be between 0 and 1");
    theta = acos(1 - Ouv0);
    omega = 0;
  end if;

equation

  C1.h = C2.h;
  C1.Q = C2.Q;

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

  /* Flap angle */
  Ouv = 1 - cos(theta);

  omega = der(theta);
  a = der(omega);

  Cp = -m*g*r*sin(theta);
  Cf = -sign(omega)*(Kf1 + Kf2*abs(omega)^n);
  Ch = deltaP*r*A*cos(theta);

  Ct = Cp + Cf + Ch;

  libre = ((theta > theta_min) and (theta < theta_max)) or ((theta <= theta_min)
     and (Ct > 0)) or ((theta >= theta_max) and (Ct < 0));

  if libre then
    J*a = Ct;
  else
    a = 0;
  end if;

  when {theta <= theta_min,theta >= theta_max} then
    reinit(omega, 0);
  end when;

  /* Pressure loss */
  deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/
    rho^2;

  /* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv);
    else
      assert(false, "DynamicCheckValve: incorrect interpolation option");
    end if;
  else
    assert(false, "ClapetDyn : mode de calcul du Cv incorrect");
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
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={170,85,255},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={170,85,255},
          thickness=0.5),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Text(extent={{-28,80},{32,20}}, textString=
                                            "D")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-70,70},{-50,50}},
          lineColor={170,85,255},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-60},{-60,60},{60,-60},{60,60}},
          color={170,85,255},
          thickness=0.5),
        Line(points={{-100,0},{-60,0}}),
        Line(points={{60,0},{100,0}}),
        Text(extent={{-28,80},{32,20}}, textString=
                                            "D")}),
    Window(
      x=0.08,
      y=0.01,
      width=0.81,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 13.12 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end DynamicCheckValve;
