within ThermoSysPro.WaterSteam.PressureLosses;
model ControlValve "Control valve"
  parameter ThermoSysPro.Units.Cv Cvmax=8005.42
    "Maximum CV (active if mode_caract=0)";
  parameter Real caract[:, 2]=[0, 0; 1, Cvmax]
    "Position vs. Cv characteristics (active if mode_caract=1)";
  parameter Integer mode_caract=0
    "0:linear characteristics - 1:characteristics is given by caract[]";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer fluid=1 "1: water/steam - 2: C3H3F5";
  parameter Integer option_rho_water=1
    "1: using (deltaP*Cv^2=A.Q^2/rho^2) - 2: using (deltaP*Cv^2=A.Q^2/(rho*rho_15)); with rho_15 is the density of the water at 15.5556 °C)";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.Density rho_15= 999 "density of the water at 15.5556 °C";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  ThermoSysPro.Units.Cv Cv(start=100) "Cv";
  Modelica.SIunits.MassFlowRate Q(start=500) "Mass flow rate";
  ThermoSysPro.Units.DifferentialPressure deltaP "Singular pressure loss";
  Modelica.SIunits.Density rho(start=998) "Fluid density";
  Modelica.SIunits.Temperature T(start=290) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure Pm(start=1.e5) "Fluid average pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Ouv
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Connectors.FluidInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -70},{-90,-50}}, rotation=0)));
  Connectors.FluidOutlet C2
                          annotation (Placement(transformation(extent={{90,-70},
            {110,-50}}, rotation=0)));
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

  /* Pressure loss */
  if (option_rho_water == 1) then
    deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho^2;
  elseif (option_rho_water == 2) then
    deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(rho*rho_15);
  else
    assert(false, "ControlValve - option_rho_water: invalid option");
  end if;

  /* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv.signal*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv.signal);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv.signal);
    else
      assert(false, "ControlValve: incorrect interpolation option");
    end if;
  else
    assert(false, "ControlValve: invalid option");
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
        Polygon(
          points={{40,40},{-40,40},{-40,56},{-38,74},{-32,84},{-20,94},{0,100},
              {20,94},{32,84},{38,72},{40,54},{40,40}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{40,40},{-40,40},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-102},{-100,-100}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-102},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-102},{-100,-100}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-102},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{40,40},{-40,40},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,40},{-40,40},{-40,56},{-38,74},{-32,84},{-20,94},{0,100},
              {20,94},{32,84},{38,72},{40,54},{40,40}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.07,
      y=0.13,
      width=0.8,
      height=0.77),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</h4></p>
<p><b>ThermoSysPro Version 3.1</h4>
<p>This component model is documented in Sect. 13.8 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end ControlValve;
