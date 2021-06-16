within ThermoSysPro.WaterSteam.Machines;
model SteamEngine "Steam engine"
  parameter Real caract[:, 2]=[0, 0; 15e5, 20.0]
    "Engine charateristics Q=f(deltaP)";
  parameter Real eta_is=0.85 "Isentropic efficiency";
  parameter Real W_frot=0.0
    "Power losses due to hydrodynamic friction (percent)";
  parameter Real eta_stato=1.0
    "Efficiency to account for cinetic losses (<= 1) (s.u.)";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";
  parameter Integer mode_e=0
    "Inlet IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_s=0
    "Outlet IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.Power W "Power produced by the engine";
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  Modelica.SIunits.SpecificEnthalpy His
    "Fluid specific enthalpy after isentropic expansion";
  ThermoSysPro.Units.DifferentialPressure deltaP "Pressure loss";
  Modelica.SIunits.AbsolutePressure Pe(start=10e5) "Pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Ps(start=10e5) "Pressure at the outlet";
  Modelica.SIunits.Temperature Te "Temperature at the inlet";
  Modelica.SIunits.Temperature Ts "Temperature at the outlet";
  Real xm(start=1.0,min=0) "Average vapor mass fraction (n.u.)";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-80,80},{-60,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
            0)));
  Connectors.FluidOutlet C2      annotation (Placement(transformation(extent={{
            60,-10},{80,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
equation

  Pe = C1.P;
  Ps = C2.P;
  deltaP = Pe - Ps;

  C1.Q = C2.Q;
  Q = C1.Q;

  /* No flow reversal */
  0 = C1.h - C1.h_vol;

  /* Average vapor mass fraction during the expansion */
  xm = (proe.x + pros.x)/2.0;

  /* Mass flow */
  if (option_interpolation == 1) then
    Q = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], deltaP);
  elseif (option_interpolation == 2) then
    Q = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], deltaP);
  else
    assert(false, "SteamEngine: incorrect interpolation option");
  end if;

  /* Fluid specific enthalpy at the outlet */
  C2.h - C1.h = xm*eta_is*(His - C1.h);

  /* Mechanical power produced by the engine */
  W = Q*eta_stato*(C1.h - C2.h)*(1 - W_frot/100);

  /* Fluid thermodynamic properties before the expansion */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pe, C1.h, mode_e);
  Te = proe.T;

  /* Fluid thermodynamic properties after the expansion */
  pros = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ps, C2.h, mode_s);
  Ts = pros.T;

  /* Fluid thermodynamic properties after the isentropic expansion */
  props = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ps(Ps, proe.s, mode_s);
  His = props.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-60,-100},{60,-100},{60,100},{-60,100}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,100},{20,12}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-16},{30,-66}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,60},{24,-42}}, color={0,0,255}),
        Rectangle(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-60,-100},{60,-100},{60,100},{-60,100}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,100},{20,20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-16},{30,-66}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,60},{24,-42}}, color={0,0,255}),
        Rectangle(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Beno&icirc;t Bride</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SteamEngine;
