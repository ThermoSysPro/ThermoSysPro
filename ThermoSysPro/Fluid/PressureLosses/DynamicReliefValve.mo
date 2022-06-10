within ThermoSysPro.Fluid.PressureLosses;
model DynamicReliefValve "Dynamic relief valve"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.AbsolutePressure Popen=3e5 "Pressure that opens the valve";
  parameter Units.SI.AbsolutePressure Pout=1e5
    "Pressure at the valve outlet (for sizing)";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax=8005.42 "Maximum Cv";
  parameter Real caract[:, 2]=[0, 0; 1, Cvmax] "Position vs. Cv characteristics (active if mode_caract=1)";
  parameter Units.SI.Area A1=0.1 "Hydraulic area upstream the clapper";
  parameter Units.SI.Area A2=0.125 "Hydraulic area downstream the clapper";
  parameter Units.SI.Area clapper_area[:,2]=[0,A1; 0.01,A2; 1,A2]
    "Clapper area as a function of the clapper elevation";
  parameter Real D=1 "Damping";
  parameter Units.SI.Mass m=1 "Valve mass";
  parameter Units.SI.Length z_max=0.1 "Maximum clapper elevation";
  parameter Real Ke=62500 "Valve spring stiffness";
  parameter Real Cd=0 "Drag coefficient of the clapper";
  parameter Integer mode_caract=0
    "0:linear characteristics - 1:characteristics is given by caract[] - 2:characteristics for conic clapper" annotation(Evaluate=true);
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)" annotation(Evaluate=true, Dialog(enable=(mode_caract == 1)));
  parameter Boolean mech_steady_state=true "true: start from mechanical steady state - false: start from 0" annotation(Evaluate=true);
  parameter Units.SI.Length z0=0
    "Initial clapper elevation, between 0 and z_max. 0:valve closed - z_max: valve fully open (active if mech_steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=not mech_steady_state));
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  constant Units.SI.Density rho60F=998.98 "Water density at 60°F";
  constant Real K=1.733e12 "Valve constant";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Units.SI.Length z_min=0 "Minimum clapper elevation";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  Boolean clapper_is_free(start=true) "true if clapper is free to move in both directions, false otherwise";
  Units.SI.Force Fp "Gravity force";
  Units.SI.Force Fr "Spring force";
  Units.SI.Force Fd "Damping force";
  Units.SI.Force Fh "Hydraulic force";
  Units.SI.Force Fdyn "Dynamic pressure force";
  Units.SI.Force Ft "Total force";
  Units.SI.Length z(start=z_min) "Clapper elevation";
  Units.SI.Velocity v=der(z) "Clapper velocity";
  Units.SI.Acceleration a=der(v) "Clapper acceleration";
  Real Ouv "Valve position";
  Units.SI.Area A "Hydraulic area upstream the clapper";
  Units.SI.Force Fr_min "Spring force when valve is closed";
  ThermoSysPro.Units.xSI.Cv Cv "Cv";
  Units.SI.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.Temperature T(start=290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start=1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Units.SI.AbsolutePressure Pdyn "Dynamic pressure on the clapper";
  Units.SI.Velocity vh "Fluid velocity through the valve";
  Units.SI.Energy Wdyn "Dissipated fluid kinetic energy";
  Real Re=rho*(vh - v)*sqrt(4*A/pi)/ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho, T) "Clapper Reynolds";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-10,-108},{10,-88}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
initial equation
  if mech_steady_state then
    der(z) = 0;
    der(v) = 0;
  else
    z = z0;
    der(z) = 0;
  end if;

  Wdyn = 0;

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

  /* Hydraulic area upstream the clapper. It varies as a function of the valve elevation
  between A1 (valve closed) and A2 (valve open) with a hysteresis */
  A = ThermoSysPro.Functions.SplineInterpolation(clapper_area[:, 1], clapper_area[:, 2], z - z_min);

  /* Dynamic pressure on the valve */
  Pdyn = Cd*rho/2*(vh - v)^2;

  /* Dissipated kinetic energy */
  der(Wdyn) = Fdyn*v;

  /* Fluid velocity through the valve */
  rho*vh*A = Q;

  /* Force balance */
  Fp = -m*g;
  Fr = -Ke*(z - z_min) + Fr_min;
  Fd = -D*v;
  Fh = C1.P*A - C2.P*A2;
  Fdyn = sign(vh - v)*Pdyn*A;
  Ft = Fp + Fr + Fd + Fh + Fdyn;

  /* Newton's law */
  clapper_is_free = ((z > z_min) and (z < z_max)) or ((z <= z_min) and (Ft > 0)) or ((z >= z_max) and (Ft < 0));

  if clapper_is_free then
    m*a = Ft;
  else
    a = 0;
  end if;

  when {z <= z_min,z >= z_max} then
    reinit(v, 0);
  end when;

  /* Pressure that opens the valve */
  m*g - Fr_min = Popen*A1 - Pout*A2;

  /* Valve position */
  Ouv = (z - z_min)/(z_max - z_min);

  /* Pressure loss */
  deltaP*Cv*abs(Cv) = K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(rho*rho60F);

  /* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv);
    else
      assert(false, "DynamicReliefValve: incorrect interpolation option");
    end if;
  elseif (mode_caract == 2) then
    Cv = sqrt(pi*A1*K/(0.3*rho60F))*(z - z_min)/sqrt(1 + pi/A1*(z - z_min)^2);
  else
    assert(false, "DynamicReliefValve : incorrect Cv computation mode");
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
        Polygon(
          points={{0,0},{-30,-60},{30,-60},{0,0}},
          lineColor={28,108,200},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,0},{60,-30},{60,30},{0,0}},
          lineColor={28,108,200},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-60},{0,-98}}),
        Line(points={{60,0},{90,0}}),
        Line(points={{0,0},{10,10},{-10,20},{10,28},{-10,40},{10,50},{-10,60},{
              10,70}}, color={170,85,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,0},{-30,-60},{30,-60},{0,0}},
          lineColor={28,108,200},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,0},{60,-30},{60,30},{0,0}},
          lineColor={28,108,200},
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-60},{0,-98}}),
        Line(points={{60,0},{90,0}}),
        Line(points={{0,0},{10,10},{-10,20},{10,28},{-10,40},{10,50},{-10,60},{
              10,70}})}),
    Window(
      x=0.12,
      y=0.05,
      width=0.8,
      height=0.77),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.13 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end DynamicReliefValve;
