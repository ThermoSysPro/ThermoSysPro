within ThermoSysPro.Fluid.PressureLosses;
model LumpedStraightPipe "Lumped straight pipe (circular duct)"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Length L=10. "Pipe length";
  parameter Units.SI.Diameter D=0.2 "Pipe internal hydraulic diameter";
  parameter Integer ntubes=1 "Number of pipes in parallel";
  parameter Real lambda=0.03
    "Friction pressure loss coefficient (active if lambda_fixed=true)";
  parameter Real rugosrel=0.0001
    "Pipe roughness (active if lambda_fixed=false)";
  parameter Units.SI.Position z1=0 "Inlet altitude";
  parameter Units.SI.Position z2=0 "Outlet altitude";
  parameter Boolean lambda_fixed=true
    "true: lambda given by parameter - false: lambde computed using Idel'Cik correlation";
  parameter Boolean inertia=false
    "true: momentum balance equation with inertia - false: without inertia";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.Area A=ntubes*pi*D^2/4
    "Pipe cross-sectional area (circular duct is assumed)";
  parameter Units.SI.Area Pw=pi*D*ntubes
    "Pipe wetted perimeter (circular duct is assumed)";

public
  Real khi "Hydraulic pressure loss coefficient";
  ThermoSysPro.Units.SI.PressureDifference deltaPf "Friction pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Total pressure loss";
  Units.SI.MassFlowRate Q(start=100) "Mass flow rate";
  Units.SI.ReynoldsNumber Re "Reynolds number";
  Units.SI.ReynoldsNumber Relim "Limit Reynolds number";
  Real lam "Friction pressure loss coefficient";
  Units.SI.Density rho "Fluid density";
  Units.SI.DynamicViscosity mu "Fluid dynamic viscosity";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure Pm "Fluid average pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  Units.SI.SpecificHeatCapacity cp(start=4200) "Fluid specific heat capacity";
  Units.SI.ThermalConductivity k(start=0.05) "Fluid thermal conductivity";
  Units.SI.MassFlowRate gamma_diff(start=1.e-4) "Diffusion conductance";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
initial equation
  if inertia then
    der(Q) = 0;
  end if;

equation

  C1.Q = C2.Q;
  C1.h = C2.h;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = C1.diff_on_1;
  C1.diff_on_2 = C2.diff_on_2;

  C2.diff_res_1 = C1.diff_res_1 + 1/gamma_diff;
  C1.diff_res_2 = C2.diff_res_2 + 1/gamma_diff;

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  Q = C1.Q;
  h = C1.h;
  deltaP = C1.P - C2.P;

  ftype = C1.ftype;

  /* Diffusion resistance */
  gamma_diff = A*k/cp/L;

  /* Pressure loss */
  if inertia then
    deltaP = deltaPf + rho*g*(z2 - z1) + L/A*der(Q);
  else
    deltaP = deltaPf + rho*g*(z2 - z1);
  end if;

  deltaPf = khi*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(2*A^2*rho);

  /* Darcy-Weisbach formula (Idel'cik p. 55). Quadratic flow regime is assumed and Re > 4000 (Re > Relim). */
  khi = lam*L/D;

  if lambda_fixed then
    lam = lambda;
  else
    if (rugosrel > 0.00005) then
      lam = 1/(2*Modelica.Math.log10(3.7/rugosrel))^2;
    else
      lam = if noEvent(Re > 0) then 1/(1.8*Modelica.Math.log10(Re) - 1.64)^2 else 0;
    end if;
  end if;

  Relim = if (rugosrel > 0.00005) then max(560/rugosrel, 2.e5) else 4000;
  Re = 4*abs(Q)/(Pw*mu);

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  end if;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  mu = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  k =  ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o,C1.Xo2, C1.Xso2);
  cp = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({127,255,0},
          if inertia then fill_color_dynamic
          else fill_color_singular))}),
    Window(
      x=0.06,
      y=0.08,
      width=0.82,
      height=0.65),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end LumpedStraightPipe;
