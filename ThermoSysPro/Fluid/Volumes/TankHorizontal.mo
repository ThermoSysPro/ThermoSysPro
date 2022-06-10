within ThermoSysPro.Fluid.Volumes;
model TankHorizontal "Open horizontal tank"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.AbsolutePressure Patm=1.013e5
    "Pressure above the fluid level";
  parameter Units.SI.Radius R=1 "Radius of the tank cross-sectional area";
  parameter Units.SI.Length L=10 "Tank equivalentlength";
  parameter Units.SI.Position ze1=2*R "Altitude of inlet 1";
  parameter Units.SI.Position ze2=0 "Altitude of inlet 2";
  parameter Units.SI.Position zs1=2*R "Altitude of outlet 1";
  parameter Units.SI.Position zs2=0 "Altitude of outlet 2";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient ke1=1
    "Pressure loss coefficient for inlet e1";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient ke2=1
    "Pressure loss coefficient for inlet e2";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient ks1=1
    "Pressure loss coefficient for outlet s1";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient ks2=1
    "Pressure loss coefficient for outlet s2";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean dynamic_mass_balance=false
    "true: dynamic mass balance equation - false: static mass balance equation (active if the fluid is compressible and if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=isCompressible and dynamic_energy_balance));
  parameter Boolean steady_state=false
    "true: start from steady state - false: start from (P0, h0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.SpecificEnthalpy h0=1.e5
    "Initial fluid specific enthalpy (active if steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean steady_state_mech=false
    "true: start from steady state - false: start from z0";
  parameter Units.SI.Position z0=2*R
    "Initial fluid level (active if steady_state_mech=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state_mech));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter Boolean dynamic_composition_balance=false
    "<html>true: dynamic fluid composition balance equation <br>false: static fluid composition balance equation (active for flue gases)</html>" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.FlueGases), tab="Fluid", group="Fluid properties"));

  parameter ThermoSysPro.Units.SI.MassFraction Xco20=0.0
    "Initial CO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xh2o0=0.05
    "Initial H20 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xo20=0.23
    "Initial O2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xso20=0
    "Initial SO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));

protected
  constant Units.SI.SpecificEnthalpy hr=2501569
    "Water/steam reference specific enthalpy at 0.01°C";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Units.SI.Thickness e=0.25 "Inlet/outlet thickness";
  parameter Real eps=1.e-0 "Small number for ths square function";
  parameter Units.SI.Position zmin=1.e-6 "Minimum fluid level";
  parameter Boolean flue_gases=(ftype == FluidType.FlueGases) "Flue gases";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Position z "Fluid level";
  Units.SI.Area A "Surface of the liquid in the tank";
  Units.SI.Angle theta "Angle";
  Units.SI.Area Aw "Wall area = Wall surface on contact with the outside";
  Units.SI.Area Al "Cross section area of the liquid in the tank";
  Units.SI.Area Alw "Liquid surface on contact with the wall";
  Units.SI.Volume Vl(start=1) "Fluid volume";
  Units.SI.Volume V(start=1) "Tank volume";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start=1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid average specific enthalpy";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.MassFlowRate BQ "Right hand side of the mass balance equation";
  Units.SI.Power BH "Right hand side of the energy balance equation";
  Real Oe1;
  Real Oe2;
  Real Os1;
  Real Os2;
  Units.SI.DerDensityByPressure ddph "density derivative by pressure";
  Units.SI.DerDensityByEnthalpy ddhp "density derivative by enthalpy";
  FluidType fluids[5] "Fluids mixing in volume";
  Units.SI.MassFlowRate BXco2 "Right hand side of the CO2 balance equation";
  Units.SI.MassFlowRate BXh2o "Right hand side of the H2O balance equation";
  Units.SI.MassFlowRate BXo2 "Right hand side of the O2 balance equation";
  Units.SI.MassFlowRate BXso2 "Right hand side of the SO2 balance equation";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je1 "Thermal power diffusion from inlet e1";
  Units.SI.Power Je2 "Thermal power diffusion from inlet e2";
  Units.SI.Power Js1 "Thermal power diffusion from outlet s1";
  Units.SI.Power Js2 "Thermal power diffusion from outlet s2";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e1 "Diffusion conductance for inlet e1";
  Units.SI.MassFlowRate gamma_e2 "Diffusion conductance for inlet e2";
  Units.SI.MassFlowRate gamma_s1 "Diffusion conductance for outlet s1";
  Units.SI.MassFlowRate gamma_s2 "Diffusion conductance for outlet s2";
  Real re1 "Value of r(Q/gamma) for inlet e1";
  Real re2 "Value of r(Q/gamma) for inlet e2";
  Real rs1 "Value of r(Q/gamma) for outlet s1";
  Real rs2 "Value of r(Q/gamma) for outlet s2";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{102,-9},{122,11}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce1 annotation (Placement(
        transformation(extent={{-110,40},{-90,60}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs2 annotation (
      Placement(transformation(extent={{90,-60},{110,-40}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth
                                     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce2 annotation (Placement(
        transformation(extent={{-110,-60},{-90,-40}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs1 annotation (
      Placement(transformation(extent={{92,39},{112,59}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      der(h) = 0;
    else
      h = h0;
    end if;
  end if;

  if steady_state_mech then
    der(z) = 0;
  else
    z = z0;
  end if;

  if flue_gases then
    if dynamic_composition_balance then
      if steady_state then
        der(Xco2) = 0;
        der(Xh2o) = 0;
        der(Xo2) = 0;
        der(Xso2) = 0;
      else
        Xco2 = Xco20;
        Xh2o = Xh2o0;
        Xo2 = Xo20;
        Xso2 = Xso20;
      end if;
    end if;
  end if;

equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce1.ftype;
  fluids[3] = Ce2.ftype;
  fluids[4] = Cs1.ftype;
  fluids[5] = Cs2.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "TankHorizontal: fluids mixing in volume are not compatible with each other");

  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.h_vol_1 = 1.e5;
    Ce1.diff_res_1 = 0;
    Ce1.diff_on_1 = false;
    Ce1.ftype = ftype;
    Ce1.Xco2 = 0;
    Ce1.Xh2o = 0;
    Ce1.Xo2 = 0;
    Ce1.Xso2 = 0;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.h_vol_1 = 1.e5;
    Ce2.diff_res_1 = 0;
    Ce2.diff_on_1 = false;
    Ce2.ftype = ftype;
    Ce2.Xco2 = 0;
    Ce2.Xh2o = 0;
    Ce2.Xo2 = 0;
    Ce2.Xso2 = 0;
  end if;

  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.h_vol_2 = 1.e5;
    Cs1.diff_res_2 = 0;
    Cs1.diff_on_2 = false;
  end if;

  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.h_vol_2 = 1.e5;
    Cs2.diff_res_2 = 0;
    Cs2.diff_on_2 = false;
  end if;

  /* Geometry: horizontal cylinder */
  Aw = 2*pi*R*L + 2*pi*R^2;
  theta = Modelica.Math.asin(max(-0.9999,min(0.9999,(R - z)/R)));
  Al = (pi/2 - theta)*R^2 - R*(R - z)*Modelica.Math.cos(theta);
  A = 2*R*Modelica.Math.cos(theta)*L;
  Alw = (pi - 2*theta)*R*L + 2*Al;

  /* Fluid and tank volume */
  Vl = Al*L;
  V = pi*R^2*L;

  /* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q - Cs1.Q - Cs2.Q;

  if isCompressible and dynamic_energy_balance and dynamic_mass_balance then
    A*(ddph*der(P) + ddhp*der(h - Xh2o*hr))*z + A*rho*der(z) = BQ;
  else
    A*rho*der(z) = BQ;
  end if;

  /* Fluid pressure at the inlets and outlets */
  if (cardinality(Ce1) == 0) then
    Ce1.P = Patm + rho*g*max(z - ze1, 0);
    Oe1 = 0;
  else
    (Ce1.P - (Patm + rho*g*max(z - ze1, 0)))*Oe1 = ke1*ThermoSysPro.Functions.ThermoSquare(Ce1.Q, eps)/2/rho;
    Oe1 = if ((Ce1.Q >= 0) or (z > ze1 + e)) then 1 else if (z < ze1) then 0 else (z - ze1)/e;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.P = Patm + rho*g*max(z - ze2, 0);
    Oe2 = 0;
  else
    (Ce2.P - (Patm + rho*g*max(z - ze2, 0)))*Oe2 = ke2*ThermoSysPro.Functions.ThermoSquare(Ce2.Q, eps)/2/rho;
    Oe2 = if ((Ce2.Q >= 0) or (z > ze2 + e)) then 1 else if (z < ze2) then 0 else (z - ze2)/e;
  end if;

  if (cardinality(Cs1) == 0) then
    Cs1.P = Patm + rho*g*max(z - zs1, 0);
    Os1 = 0;
  else
    (Patm + rho*g*max(z - zs1, 0) - Cs1.P)*Os1 = ks1*ThermoSysPro.Functions.ThermoSquare(Cs1.Q, eps)/2/rho;
    Os1 = if ((Cs1.Q <= 0) or (z > zs1 + e)) then 1 else if (z < zs1) then 0 else (z - zs1)/e;
  end if;

  if (cardinality(Cs2) == 0) then
    Cs2.P = Patm + rho*g*max(z - zs2, 0);
    Os2 = 0;
  else
    (Patm + rho*g*max(z - zs2, 0) - Cs2.P)*Os2 = ks2*ThermoSysPro.Functions.ThermoSquare(Cs2.Q, eps)/2/rho;
    Os2 = if ((Cs2.Q <= 0) or (z > zs2 + e)) then 1 else if (z < zs2) then 0 else (z - zs2)/e;
  end if;

  /* Energy balance equation */
  BH = Ce1.Q*((Ce1.h - Ce1.Xh2o*hr) - (h - Xh2o*hr)) + Ce2.Q*((Ce2.h - Ce2.Xh2o*hr) - (h - Xh2o*hr)) - Cs1.Q*((Cs1.h - Cs1.Xh2o*hr) - (h - Xh2o*hr)) - Cs2.Q*((Cs2.h - Cs2.Xh2o*hr) - (h - Xh2o*hr)) + Cth.W + J;

  if dynamic_energy_balance then
    if z > zmin then
      if dynamic_mass_balance then
        A*z*((P/rho*ddph - 1)*der(P) + (P/rho*ddhp + rho)*der(h - Xh2o*hr)) = BH;
      else
        A*z*rho*der(h - Xh2o*hr) = BH;
      end if;
    else
      der(h - Xh2o*hr) = 0;
    end if;
  else
    BH = 0;
  end if;

  Ce1.h_vol_2 = h;
  Ce2.h_vol_2 = h;
  Cs1.h_vol_1 = h;
  Cs2.h_vol_1 = h;

  Cth.T = T;

  /* Fluid level sensor */
  yLevel.signal = z;

  /* Fluid composition balance equations */
  BXco2 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q - Cs1.Xco2*Cs1.Q - Cs2.Xco2*Cs2.Q;
  BXh2o = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q - Cs1.Xh2o*Cs1.Q - Cs2.Xh2o*Cs2.Q;
  BXo2 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q - Cs1.Xo2*Cs1.Q - Cs2.Xo2*Cs2.Q;
  BXso2 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q - Cs1.Xso2*Cs1.Q - Cs2.Xso2*Cs2.Q;

  if flue_gases then
    if dynamic_composition_balance then
      A*z*rho*der(Xco2) + Xco2*BQ = BXco2;
      A*z*rho*der(Xh2o) + Xh2o*BQ = BXh2o;
      A*z*rho*der(Xo2)  + Xo2*BQ  = BXo2;
      A*z*rho*der(Xso2) + Xso2*BQ = BXso2;
    else
      Xco2*BQ = BXco2;
      Xh2o*BQ = BXh2o;
      Xo2*BQ  = BXo2;
      Xso2*BQ = BXso2;
    end if;
  else
    Xco2 = 0;
    Xh2o = 0;
    Xo2 = 0;
    Xso2 = 0;
  end if;

  Cs1.ftype = ftype;
  Cs2.ftype = ftype;

  Cs1.Xco2 = Xco2;
  Cs1.Xh2o = Xh2o;
  Cs1.Xo2  = Xo2;
  Cs1.Xso2 = Xso2;

  Cs2.Xco2 = Xco2;
  Cs2.Xh2o = Xh2o;
  Cs2.Xo2  = Xo2;
  Cs2.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs1.h = ThermoSysPro.Functions.SmoothCond(Cs1.Q/gamma_s1, Cs1.h_vol_1, Cs1.h_vol_2, 1);
    Cs2.h = ThermoSysPro.Functions.SmoothCond(Cs2.Q/gamma_s2, Cs2.h_vol_1, Cs2.h_vol_2, 1);
  else
    Cs1.h = if (Cs1.Q > 0) then Cs1.h_vol_1 else Cs1.h_vol_2;
    Cs2.h = if (Cs2.Q > 0) then Cs2.h_vol_1 else Cs2.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re1 = if Ce1.diff_on_1 then exp(-0.033*(Ce1.Q*Ce1.diff_res_1)^2) else 0;
    re2 = if Ce2.diff_on_1 then exp(-0.033*(Ce2.Q*Ce2.diff_res_1)^2) else 0;
    rs1 = if Cs1.diff_on_2 then exp(-0.033*(Cs1.Q*Cs1.diff_res_2)^2) else 0;
    rs2 = if Cs2.diff_on_2 then exp(-0.033*(Cs2.Q*Cs2.diff_res_2)^2) else 0;

    gamma_e1 = if Ce1.diff_on_1 then 1/Ce1.diff_res_1 else gamma0;
    gamma_e2 = if Ce2.diff_on_1 then 1/Ce2.diff_res_1 else gamma0;
    gamma_s1 = if Cs1.diff_on_2 then 1/Cs1.diff_res_2 else gamma0;
    gamma_s2 = if Cs2.diff_on_2 then 1/Cs2.diff_res_2 else gamma0;

    Je1 = if Ce1.diff_on_1 then re1*gamma_e1*(Ce1.h_vol_1 - Ce1.h_vol_2) else 0;
    Je2 = if Ce2.diff_on_1 then re2*gamma_e2*(Ce2.h_vol_1 - Ce2.h_vol_2) else 0;
    Js1 =  if Cs1.diff_on_2 then rs1*gamma_s1*(Cs1.h_vol_2 - Cs1.h_vol_1) else 0;
    Js2 = if Cs2.diff_on_2 then rs2*gamma_s2*(Cs2.h_vol_2 - Cs2.h_vol_1) else 0;
  else
    re1 = 0;
    re2 = 0;
    rs1 = 0;
    rs2 = 0;

    gamma_e1 = gamma0;
    gamma_e2 = gamma0;
    gamma_s1 = gamma0;
    gamma_s2 = gamma0;

    Je1 = 0;
    Je2 = 0;
    Js1 = 0;
    Js2 = 0;
  end if;

  J = Je1 + Je2 + Js1 + Js2;

  Ce1.diff_res_2 = 0;
  Ce2.diff_res_2 = 0;
  Cs1.diff_res_1 = 0;
  Cs2.diff_res_1 = 0;

  Ce1.diff_on_2 = diffusion;
  Ce2.diff_on_2 = diffusion;
  Cs1.diff_on_1 = diffusion;
  Cs2.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  P = Patm + rho*g*z/2;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P,h,fluid,mode,Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(P,h,fluid,mode,Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);
  end if;

  if dynamic_mass_balance then
    ddph = ThermoSysPro.Properties.Fluid.Density_derp_Ph(P, h, fluid,mode, Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);
    ddhp = ThermoSysPro.Properties.Fluid.Density_derh_Ph(P, h, fluid,mode, Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);
  else
    ddph = 0;
    ddhp = 0;
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-100,40},{-52,-40}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid),
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Ellipse(
          extent={{58,40},{100,-40}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid),
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Rectangle(
          extent={{-78,40},{79,-40}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.HorizontalCylinder
          else FillPattern.Solid),
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Line(
          points={{-100,-18},{102,-18}},
          color={255,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(
          points={{-91,-32},{91,-32}},
          color={255,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(points={{-90,50},{-60,50},{-20,40}}),
        Line(points={{92,50},{60,50},{20,40}}),
        Line(points={{-90,-50},{-60,-50},{-20,-40}}),
        Line(points={{92,-50},{60,-50},{20,-40}}),
        Line(
          points={{-101,-1},{101,-1}},
          color={255,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-100,40},{-46,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Ellipse(
          extent={{50,40},{104,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Rectangle(
          extent={{-76,40},{81,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Line(
          points={{-98,12},{102,12}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-98,3},{104,3}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-98,-6},{104,-6}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-97,-15},{101,-15}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-94,-24},{98,-24}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-89,-32},{93,-32}},
          color={255,255,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(points={{-90,50},{-60,50},{-20,40}}),
        Line(points={{92,50},{60,50},{20,40}}),
        Line(points={{-90,-50},{-60,-50},{-20,-40}}),
        Line(points={{92,-50},{60,-50},{20,-40}})}),
    Window(
      x=0.16,
      y=0.03,
      width=0.81,
      height=0.9),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end TankHorizontal;
