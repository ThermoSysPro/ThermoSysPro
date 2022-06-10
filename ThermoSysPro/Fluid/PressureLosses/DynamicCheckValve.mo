within ThermoSysPro.Fluid.PressureLosses;
model DynamicCheckValve "Dynamic check valve"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter ThermoSysPro.Units.xSI.Cv Cvmax=8005.42 "Maximum CV";
  parameter Real caract[:, 2]=[0, 0; 1, Cvmax]
    "Position vs. Cv characteristics (active if mode_caract=1)";
  parameter Units.SI.MomentOfInertia J=1 "Flap moment of inertia";
  parameter Real Kf1=0 "Flap friction law coefficient #1";
  parameter Real Kf2=100 "Flap friction law coefficient #2";
  parameter Real n=5 "Flap friction law exponent";
  parameter Units.SI.Mass m=1 "Flap mass";
  parameter Units.SI.Area A=1 "Flap hydraulic area";
  parameter Integer mode_caract=0 "0:linear characteristics - 1:characteristics is given by caract[]" annotation(Evaluate=true);
  parameter Integer option_interpolation=1 "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)" annotation(Evaluate=true, Dialog(enable=(mode_caract == 1)));
  parameter Boolean mech_steady_state=true "true: start from mechanical steady state - false: start from 0";
  parameter Real Ouv0=0 "Initial valve position, between 0 and 1. 0:valve closed - 1: valve open (active if mech_steady_state=false)" annotation(Evaluate=true, Dialog(enable=not mech_steady_state));
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.Radius r=sqrt(A/pi) "Flap radius";
  parameter Units.SI.Angle theta_min=0 "Minimum flap aperture angle";
  parameter Units.SI.Angle theta_max=pi/2 "Maximum flap aperture angle";
  parameter Units.SI.Angle theta_m=(theta_min + theta_max)/2;
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  Boolean libre(start=true)
    "Indicator whether the flap is free to move in both directions";
  Units.SI.Torque Cp "Gravity torque";
  Units.SI.Torque Cf "Friction torque";
  Units.SI.Torque Ch "Hydraulic torque";
  Units.SI.Torque Ct "Total torque";
  Units.SI.Angle theta(start=theta_m) "Flap aperture angle";
  Units.SI.AngularVelocity omega "Flap angular speed";
  Units.SI.AngularAcceleration a "Flap angular acceleration";
  Real Ouv "Valve position";
  ThermoSysPro.Units.xSI.Cv Cv(start=Cvmax) "Cv";
  Units.SI.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.Temperature T(start=290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start=1.e5) "Fluid average pressrue";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
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

  Q = C1.Q;
  h = C1.h;
  deltaP = C1.P - C2.P;

  ftype = C1.ftype;

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

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.12 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end DynamicCheckValve;
