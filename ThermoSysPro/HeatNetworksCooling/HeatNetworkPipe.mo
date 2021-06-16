within ThermoSysPro.HeatNetworksCooling;
model HeatNetworkPipe
  "Static pipe with thermal losses and singular pressure losses"
  parameter Modelica.SIunits.Length L=10 "Pipe length";
  parameter Modelica.SIunits.Diameter D=0.2 "Pipe internal diameter";
  parameter Modelica.SIunits.Length e=0.05 "Wall thickness";
  parameter Real rugosrel=0 "Pipe roughness";
  parameter Modelica.SIunits.Length z1=0 "Pipe altitude at the inlet";
  parameter Modelica.SIunits.Length z2=0 "Pipe altitude at the outlet";
  parameter Modelica.SIunits.Temperature Tamb=293 "Ambient temperature";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer K=0.1
    "Heat exchange coefficient with ambient";
  parameter ThermoSysPro.Units.PressureLossCoefficient Ks=
                                                         1000
    "Singular pressure losses coefficient";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Modelica.SIunits.Power Wloss "Thermal losses at ambient conditions";
  Real khi "Hydraulic pressure loss coefficient";
  ThermoSysPro.Units.DifferentialPressure deltaPr "Regular pressure losses";
  ThermoSysPro.Units.DifferentialPressure deltaP "Total pressure losses";
  ThermoSysPro.Units.DifferentialPressure deltaPs "Singular pressure losses";
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  Modelica.SIunits.ReynoldsNumber Re "Reynolds number";
  Modelica.SIunits.ReynoldsNumber Relim "Limit Reynolds number";
  Real lambda "Friction pressure loss coefficient";
  Modelica.SIunits.Density rho "Fluid density";
  Modelica.SIunits.DynamicViscosity mu "Fluid dynamic viscosity";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Modelica.SIunits.AbsolutePressure Pm "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy hm "Fluid average specific enthalpy";
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-90,80},
            {-70,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{70,80},
            {90,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    annotation (Placement(transformation(extent={{-10,60},{10,80}}, rotation=0)));
equation

  C1.h = C2.h + Wloss/Q;
  C1.Q = C2.Q;
  C1.P - C2.P = deltaP;
  Q = C1.Q;

  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (Q > Qeps) then C1.h - C1.h_vol else if (Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;

  /* Thermal losses */
  Wloss = pi*(D + 2*e)*L*K*(T - Tamb);

  /* Pressure losses */
  deltaP = deltaPr + deltaPs + rho*g*(z2 - z1);
  deltaPs = 8*Ks * ThermoSysPro.Functions.ThermoSquare(
                                                      Q, eps)/(pi^2*D^4*rho^2);
  deltaPr = 8*khi*ThermoSysPro.Functions.ThermoSquare(
                                                     Q, eps)/(pi^2*D^4*rho);

  /* Darcy-Weisbach formula (Idel'cik p. 55). Quadratic flow regime is assumed and Re > 4000 (Re > Relim). */
  khi = lambda*L/D;

  if (rugosrel > 0.00005) then
    lambda = 1/(2*Modelica.Math.log10(3.7/rugosrel))^2;
  else
    lambda = if noEvent(Re > 0) then 1/(1.8*Modelica.Math.log10(Re) - 1.64)^2 else 0;
  end if;

  Relim = if (rugosrel > 0.00005) then max(560/rugosrel, 2.e5) else 4000;

  Re = 4*abs(Q)/(pi*D*mu);

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;
  hm = (C1.h + C2.h)/2;

  pro = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pm, hm, mode);

  T = pro.T;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = pro.d;
  end if;

  mu = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho, T);
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{60,80},{100,80},{100,-100},{-100,-100},{-100,80},{-60,80},{
              -60,-60},{60,-60},{60,80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{60,80},{100,80},{100,-100},{-100,-100},{-100,80},{-60,80},{
              -60,-60},{60,-60},{60,80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.06,
      y=0.08,
      width=0.82,
      height=0.65),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>"));
end HeatNetworkPipe;
