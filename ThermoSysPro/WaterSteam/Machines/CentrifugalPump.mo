within ThermoSysPro.WaterSteam.Machines;
model CentrifugalPump "Centrifugal pump"
  parameter ThermoSysPro.Units.AngularVelocity_rpm N=1400
    "Pump angular velocity in rpm (active if input M is not connected)";
  parameter ThermoSysPro.Units.AngularVelocity_rpm N_nom=1400
    "Nominal angular velocity in rpm";
  parameter Modelica.SIunits.MomentOfInertia J=10
    "Rotating masses moment of inertia (active if dynamic_mech_equation=true)";
  parameter Modelica.SIunits.Volume V=1
    "Pump volume (active if dynamic_energy_balance=true)";
  parameter Boolean dynamic_mech_equation=false
    "true: dynamic mechanical equation - false: static mechanical equation (active if input M is connected)";
  parameter Boolean dynamic_energy_balance=false
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=1
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

  parameter Integer mode_car=2
    "1:nominal values and coef. c given by parameters - 2:nominal values and coef. c computed from semi-parabolic characteristics";
  parameter Integer mode_car_hn=2
    "1:complete pump head characteristics - 2:semi-parabolic pump head characteristics";
  parameter Integer mode_car_Cr=2
    "1:complete torque characteristics - 2:analytic formula";

  parameter Modelica.SIunits.VolumeFlowRate Qv_nom_p=0.4781
    "Nominal volumetric flow (active if mode_car=1)";
  parameter Modelica.SIunits.Height hn_nom_p=22.879
    "Nominal pump head (active if mode_car=1)";
  parameter Modelica.SIunits.Height rh_nom_p=0.863
    "Nominal pump efficiency (active if mode_car=1)";

  parameter Real F_t[:]={ 0.634, 0.643, 0.646, 0.640, 0.629, 0.613, 0.595, 0.575, 0.552, 0.533, 0.516, 0.505,
                          0.504, 0.510, 0.512, 0.522, 0.539, 0.559, 0.580, 0.601, 0.630, 0.662, 0.692, 0.722,
                          0.753, 0.782, 0.808, 0.832, 0.857, 0.879, 0.904, 0.930, 0.959, 0.996, 1.027, 1.060,
                          1.090, 1.124, 1.165, 1.204, 1.238, 1.258, 1.271, 1.282, 1.288, 1.281, 1.260, 1.225,
                          1.172, 1.107, 1.031, 0.942, 0.842, 0.733, 0.617, 0.500, 0.368, 0.240, 0.125, 0.011,
                         -0.102,-0.168,-0.255,-0.342,-0.423,-0.494,-0.556,-0.620,-0.655,-0.670,-0.670,-0.660,
                         -0.655,-0.640,-0.600,-0.570,-0.520,-0.470,-0.430,-0.360,-0.275,-0.160,-0.040, 0.130,
                          0.295, 0.430, 0.550, 0.620, 0.634}
    "Head characteristics (active if mode_car_hn=1)";

  parameter Real G_t[:]={-0.684,-0.547,-0.414,-0.292,-0.187,-0.105,-0.053,-0.012, 0.042, 0.097, 0.156, 0.227,
                          0.300, 0.371, 0.444, 0.522, 0.596, 0.672, 0.738, 0.763, 0.797, 0.837, 0.865, 0.883,
                          0.886, 0.877, 0.859, 0.838, 0.804, 0.758, 0.703, 0.645, 0.583, 0.520, 0.454, 0.408,
                          0.370, 0.343, 0.331, 0.329, 0.338, 0.354, 0.372, 0.405, 0.450, 0.486, 0.520, 0.552,
                          0.579, 0.603, 0.616, 0.617, 0.606, 0.582, 0.546, 0.500, 0.432, 0.360, 0.288, 0.214,
                          0.123, 0.037,-0.053,-0.161,-0.248,-0.314,-0.372,-0.580,-0.740,-0.880,-1.000,-1.120,
                         -1.250,-1.370,-1.490,-1.590,-1.660,-1.690,-1.770,-1.650,-1.590,-1.520,-1.420,-1.320,
                         -1.230,-1.100,-0.980,-0.820, -0.684}
    "Torque characteristics (active if mode_car_Cr=1)";

  parameter Real c_p=1.288
    "Dimensionless coef. of the semi-parabolic pump head characteristics (active if mode_car=1 and mode_car_hn=2)";
  constant Real b=2
    "Dimensionless coef. of the parabolic pump efficiency characteristics";

  parameter Real hn_coef[2]={-88.67, 43.15}
    "Coef. of the semi-parabolic pump head characteristics (active if mode_car=2)";
  parameter Real rh_coef[2]={-3.7751, 3.61}
    "Coef. of the parabolic pump efficiency characteristics (active if mode_car=2)";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.AngularVelocity w_a_min=1.e-4
    "Small angular velocity";
  parameter Modelica.SIunits.VolumeFlowRate Qv_a_min=1.e-4
    "Small volume flow rate";
  parameter Real rh_min=0.05 "Minimum efficiency";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";
//  parameter Boolean dyn_mech_equation=((cardinality(M) <> 0) and dynamic_mech_equation);
  parameter Boolean dyn_mech_equation=dynamic_mech_equation;

public
  Real w_a "Dimensionless angular velocity";
  Real Qv_a(start=1) "Dimensionless volumetric flow";
  Real hn_a(start=1) "Dimensionless head";
  Real Cr_a(start=1) "Dimensionless resistive torque";
  Real rh_a(start=1) "Dimensionless pump efficiency";
  Modelica.SIunits.AngularVelocity w_nom "Nominal angular velocity";
  Modelica.SIunits.VolumeFlowRate Qv_nom "Nominal volumetric flow";
  Modelica.SIunits.Height hn_nom "Nominal pump head";
  Modelica.SIunits.Torque Cr_nom "Nominal resistive hydraulic torque";
  Real rh_nom "Nominal pump efficiency";
  Modelica.SIunits.Angle theta "Angle arctan(Qv_a/w_a) (rad)";
  ThermoSysPro.Units.Angle_deg theta_deg "Angle arctan(Qv_a/w_a) (deg)";
  Modelica.SIunits.AngularVelocity w "Angular velocity in rad";
  ThermoSysPro.Units.AngularVelocity_rpm w_rpm "Angular velocity in rpm";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  Modelica.SIunits.VolumeFlowRate Qv(start=0.5) "Volumetric flow rate";
  Modelica.SIunits.Pressure deltaP
    "Pressure variation between the outlet and the inlet";
  Modelica.SIunits.Height hn(start=10) "Pump head";
  Modelica.SIunits.Torque Cm "Motor torque";
  Modelica.SIunits.Torque Cr "Resistive hydraulic torque";
  Real rh "Pump efficiency";
  Modelica.SIunits.Power Wr "Resistive power";
  Modelica.SIunits.Power Wm "Motor power";
  Modelica.SIunits.Energy Ec "Kinetic energy of the rotating masses";
  Modelica.SIunits.Density rho(start=998) "Fluid density";
  Modelica.SIunits.SpecificEnthalpy deltaH
    "Specific enthalpy variation between the outlet and the inlet";
  Modelica.SIunits.Pressure Pm(start=1.e5) "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000)
    "Fluid average specific enthalpy";
  Real c "Dimensionless coef. of the semi-parabolic pump head characteristics";
  Real F "Function F";
  Real G "Function G";
  Real Z "Function Z";
  Real i_h "Index in head characteristics table";
  Real i_t "Index in torque characteristics table";
  Real alpha=hn_coef[1] "Coef. alpha of the characteristics for hn";
  Real beta=hn_coef[2] "Coef. beta of the characteristics for hn";
  Real gamma=rh_coef[1] "Coef. gamma of the characteristics for rh";
  Real delta=rh_coef[2] "Coef. delta of the characteristics for rh";

  Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{90,-10},
            {110,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ElectroMechanics.Connectors.MechanichalTorque M
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
initial equation
  if dyn_mech_equation then
    der(w) = 0;
  end if;

  if dynamic_energy_balance then
    der(h) = 0;
  end if;

equation

  if (cardinality(M) == 0) then
    M.w = pi/30*N;
  end if;

  deltaP = C2.P - C1.P;
  deltaH = C2.h - C1.h;

  deltaP = rho*g*hn;

  C1.Q = C2.Q;
  Q = C1.Q;
  Q = Qv*rho;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  /* Energy balance equation */
  if dynamic_energy_balance then
    V*rho*der(h) = -Q*deltaH + Wr;
  else
    deltaH = ThermoSysPro.Functions.SmoothCond(Q, g*hn/ThermoSysPro.Functions.SmoothMax(rh, rh_min),
                                                  g*hn/ThermoSysPro.Functions.SmoothMin(rh, -rh_min));
  end if;

  /* Nominal quantities */
  w_nom = pi/30*N_nom;

  if (mode_car == 1) then
    Qv_nom = Qv_nom_p;
    hn_nom = hn_nom_p;
    rh_nom = rh_nom_p;
  elseif (mode_car == 2) then
    Qv_nom = -delta/2/gamma;
    hn_nom = beta + alpha*delta^2/4/gamma^2;
    rh_nom = -delta^2/4/gamma;
  else
    assert(false, "CentrifugalPump: invalid option");
  end if;

  Cr_nom = rho*g*Qv_nom*hn_nom/rh_nom/w_nom;

  /* Dimensionless quantities */
  w_a = w/w_nom;
  Qv_a = Qv/Qv_nom;
  hn_a = hn/hn_nom;
  rh_a = rh/rh_nom;
  Cr_a = Cr/Cr_nom;

  /* Dimensionless coef. c */
  if (mode_car == 1) then
    c = c_p;
  elseif (mode_car == 2) then
    c = 1/(1 + alpha*delta^2/4/beta/gamma^2);
  else
    assert(false, "CentrifugalPump: invalid option");
  end if;

  /* Angle theta */
  theta = noEvent(if (abs(w_a) > w_a_min) then atan(Qv_a/w_a) else
                        if (abs(Qv_a) < Qv_a_min) then (if (w_a > 0) then 0 else -pi) else
                        if (Qv_a > 0) then pi/2 else
                        - pi/2);
  theta_deg = 180/pi*theta;

  i_h = (theta + pi)/(2*pi)*(size(F_t, 1) - 1) + 1;
  i_t = (theta + pi)/(2*pi)*(size(G_t, 1) - 1) + 1;

  /* Pump head */
  if (mode_car_hn == 1) then
    F = ThermoSysPro.Functions.SplineInterpolation(1:size(F_t, 1), F_t[:], i_h);
    hn_a = (w_a^2 + Qv_a^2)*F;
  elseif (mode_car_hn == 2) then
    F = ((1 - c)*ThermoSysPro.Functions.SmoothSign(w_a)*tan(theta)*ThermoSysPro.Functions.SmoothAbs(tan(theta)) + c)/(1 + tan(theta)^2);
    hn_a = (1 - c)*Qv_a*abs(Qv_a) + c*w_a^2;
  else
    assert(false, "CentrifugalPump: invalid option");
  end if;

  /* Pump resistive torque */
  if (mode_car_Cr == 1) then
    G = ThermoSysPro.Functions.SplineInterpolation(1:size(G_t, 1), G_t[:], i_t);
    Z = 0;
    Cr_a = (w_a^2 + Qv_a^2)*G;
  elseif (mode_car_Cr == 2) then
    G = 0;
    Z = (1 + tan(theta)^2)/(b - (b - 1)*tan(theta))*F;
    Cr_a = if noEvent(abs(w_a) > w_a_min) then w_a^2*Z else w_a^2/b*F;
  else
    assert(false, "CentrifugalPump: invalid option");
  end if;

  /* Pump efficiency */
  rh_a = if noEvent(abs(w_a) > w_a_min) then
              -(b - 1)*(Qv_a/w_a)^2 + b*Qv_a/w_a else
              -(b - 1)*(Qv_a/w_a_min)^2 + b*Qv_a/w_a_min;

  /* Motor power */
  Wm = Cm*w;

  /* Resistive hydraulic power */
  Wr = Cr*w;

  /* Kinetic energy of the rotating masses */
  Ec = 1/2*J*w^2;

  /* Rotating mass equation */
  if dyn_mech_equation then
    J*der(w) = Cm - Cr;
  else
    0 = Cm - Cr;
  end if;

  w_rpm = 30/pi*w;

  w = M.w;
  Cm = M.Ctr;

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  h = (C1.h + C2.h)/2;

  pro = ThermoSysPro.Properties.Fluid.Ph(Pm, h, mode, fluid);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-30,40},{60,0},{-30,-40},{-30,40}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.03,
      y=0.02,
      width=0.95,
      height=0.95),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-30,40},{60,0},{-30,-40},{-30,40}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 20129</h4>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 12.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"),
    DymolaStoredErrors);
end CentrifugalPump;
