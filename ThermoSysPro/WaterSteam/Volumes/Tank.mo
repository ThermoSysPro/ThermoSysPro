within ThermoSysPro.WaterSteam.Volumes;
model Tank "Open tank"
  parameter Modelica.SIunits.AbsolutePressure Patm=1.013e5
    "Pressure above the fluid level";
  parameter Modelica.SIunits.Area A=1 "Tank cross sectional area";
  parameter Modelica.SIunits.Position ze1=40 "Altitude of inlet 1";
  parameter Modelica.SIunits.Position ze2=de2/2 "Altitude of inlet 2";
  parameter Modelica.SIunits.Position zs1=40 "Altitude of outlet 1";
  parameter Modelica.SIunits.Position zs2=ds2/2 "Altitude of outlet 2";
  parameter Modelica.SIunits.Diameter de1=0.20 "Diameter of inlet 1";
  parameter Modelica.SIunits.Diameter de2=0.20 "Diameter of inlet 2";
  parameter Modelica.SIunits.Diameter ds1=0.20 "Diameter of outlet 1";
  parameter Modelica.SIunits.Diameter ds2=0.20 "Diameter of outlet 2";
  parameter Modelica.SIunits.Position z0=30
    "Initial fluid level (active if steady_state=false)";
  parameter Modelica.SIunits.SpecificEnthalpy h0=1.e5
    "Initial fluid specific enthalpy (active if steady_state=false)";
  parameter Real ke1=1
    "Pressure loss coefficient for inlet e1";
  parameter Real ke2=1
    "Pressure loss coefficient for inlet e2";
  parameter Real ks1=1
    "Pressure loss coefficient for outlet s1";
  parameter Real ks2=1
    "Pressure loss coefficient for outlet s2";
  parameter Boolean dynamic_mass_balance=false
    "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean steady_state=false
    "true: start from steady state - false: start from h0";
  parameter Boolean steady_state_mech=false
    "true: start from steady state - false: start from z0";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  parameter Real eps=1.e-0 "Small number for ths square function";
  parameter Modelica.SIunits.Position zmin=1.e-6 "Minimum fluid level";
  parameter Real pi=Modelica.Constants.pi;

public
  Modelica.SIunits.Position z "Fluid level";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Modelica.SIunits.AbsolutePressure P(start=1.e5) "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000)
    "Fluid average specific enthalpy";
  Modelica.SIunits.Density rho(start=998) "Fluid density";
  Modelica.SIunits.MassFlowRate BQ
    "Right hand side of the mass balance equation";
  Modelica.SIunits.Power BH "Right hand side of the energy balance equation";
  ThermoSysPro.Units.DifferentialPressure deltaP_e1 "Presure loss for e1";
  ThermoSysPro.Units.DifferentialPressure deltaP_e2 "Presure loss for e2";
  ThermoSysPro.Units.DifferentialPressure deltaP_s1 "Presure loss for s1";
  ThermoSysPro.Units.DifferentialPressure deltaP_s2 "Presure loss for s2";
  Real omega_e1;
  Real omega_e2;
  Real omega_s1;
  Real omega_s2;
  Modelica.SIunits.Angle theta_e1;
  Modelica.SIunits.Angle theta_e2;
  Modelica.SIunits.Angle theta_s1;
  Modelica.SIunits.Angle theta_s2;
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Water properties"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{100,10},{120,30}}, rotation=0)));
  Connectors.FluidInlet Ce1          annotation (Placement(transformation(
          extent={{-110,50},{-90,70}}, rotation=0)));
  Connectors.FluidOutlet Cs2         annotation (Placement(transformation(
          extent={{90,-70},{110,-50}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth
                                     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
  Connectors.FluidInlet Ce2          annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}, rotation=0)));
  Connectors.FluidOutlet Cs1         annotation (Placement(transformation(
          extent={{92,50},{112,70}}, rotation=0)));
initial equation
  if steady_state then
    der(h) = 0;
  else
    h = h0;
  end if;

  if steady_state_mech then
    der(z) = 0;
  else
    z = z0;
  end if;

equation
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.b = true;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.b = true;
  end if;

  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.h = 1.e5;
    Cs1.a = true;
  end if;

  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.h = 1.e5;
    Cs2.a = true;
  end if;

  /* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q - Cs1.Q - Cs2.Q;
  if dynamic_mass_balance then
    A*(pro.ddph*der(P) + pro.ddhp*der(h))*z + A*rho*der(z) = BQ;
  else
    A*rho*der(z) = BQ;
  end if;

  /* Momentum balance equations */
  theta_e1 = if (z > ze1 + de1/2) then pi/2
             else if (z < ze1 - de1/2) then -pi/2
             else asin((z - ze1)/de1/2);

  theta_e2 = if (z > ze2 + de2/2) then pi/2
             else if (z < ze2 - de2/2) then -pi/2
             else asin((z - ze2)/de2/2);

  theta_s1 = if (z > zs1 + ds1/2) then pi/2
             else if (z < zs1 - ds1/2) then -pi/2
             else asin((z - zs1)/ds1/2);

  theta_s2 = if (z > zs2 + ds2/2) then pi/2
             else if (z < zs2 - ds2/2) then -pi/2
             else asin((z - zs2)/ds2/2);

  omega_e1 = if (Ce1.Q >= 0) then 1 else (pi + 2*theta_e1 + sin(2*theta_e1))/2/pi;
  omega_e2 = if (Ce2.Q >= 0) then 1 else (pi + 2*theta_e2 + sin(2*theta_e2))/2/pi;
  omega_s1 = if (Cs1.Q <= 0) then 1 else (pi + 2*theta_s1 + sin(2*theta_s1))/2/pi;
  omega_s2 = if (Cs2.Q <= 0) then 1 else (pi + 2*theta_s2 + sin(2*theta_s2))/2/pi;

  deltaP_e1 = Ce1.P - (Patm + rho*g*max(z - ze1, 0));
  deltaP_e2 = Ce2.P - (Patm + rho*g*max(z - ze2, 0));
  deltaP_s1 = Patm + rho*g*max(z - zs1, 0) - Cs1.P;
  deltaP_s2 = Patm + rho*g*max(z - zs2, 0) - Cs2.P;

  deltaP_e1*omega_e1^2 = ke1*ThermoSysPro.Functions.ThermoSquare(Ce1.Q, eps)/2/rho;
  deltaP_e2*omega_e2^2 = ke2*ThermoSysPro.Functions.ThermoSquare(Ce2.Q, eps)/2/rho;
  deltaP_s1*omega_s1^2 = ks1*ThermoSysPro.Functions.ThermoSquare(Cs1.Q, eps)/2/rho;
  deltaP_s2*omega_s2^2 = ks2*ThermoSysPro.Functions.ThermoSquare(Cs2.Q, eps)/2/rho;

  /* Energy balance equation */
  BH = Ce1.Q*(Ce1.h - h) + Ce2.Q*(Ce2.h - h) - Cs1.Q*(Cs1.h - h) - Cs2.Q*(Cs2.h - h) + Cth.W;
  if (z > zmin) then
    A*rho*z*der(h) = BH;
  else
    der(h) = 0;
  end if;

  Ce1.h_vol = h;
  Ce2.h_vol = h;
  Cs1.h_vol = h;
  Cs2.h_vol = h;

  Cth.T = T;

  /* Fluid level sensor */
  yLevel.signal = z;

  /* Fluid thermodynamic properties */
  P = Patm + rho*g*z/2;

  pro = ThermoSysPro.Properties.Fluid.Ph(P, h, mode, fluid);

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
        grid={2,2}), graphics={Rectangle(
          extent={{-100,20},{100,-100}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Rectangle(extent={{-100,100},{100,20}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,20},{100,-100}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Rectangle(extent={{-100,100},{100,20}},
            lineColor={28,108,200})}),
    Window(
      x=0.16,
      y=0.03,
      width=0.81,
      height=0.9),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</h4>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 14.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Tank;
