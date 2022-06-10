within ThermoSysPro.Fluid.HeatExchangers;
model DynamicMultiFluidHeatExchanger "Dynamic one-phase heat exchanger"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Length L=1 "Exchanger length";
  parameter Units.SI.Position z1=0 "Exchanger inlet altitude";
  parameter Units.SI.Position z2=0 "Exchanger outlet altitude";
  parameter Real rugosrel_int=0.0007 "Internal relative roughness";
  parameter Real rugosrel_ext=0.0007 "External relative roughness";
  parameter Units.SI.Diameter Dint=0.1 "Internal diameter";
  parameter Units.SI.Diameter Dext=0.11 "External diameter";
  parameter Integer Ntubes=1 "Number of pipes in parallel";
  parameter Units.SI.Thickness e=2.e-3 "Wall thickness";
  parameter Units.SI.ThermalConductivity lambda=26 "Wall thermal conductivity";
  parameter Units.SI.SpecificHeatCapacity cpw=1000
    "Wall specific heat capacity (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.Density rhow=7800
    "Wall density (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Integer Ns=1 "Number of segments";
  parameter Units.SI.AbsolutePressure P0=1.e5
    "Fluid initial pressure (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.Temperature T0[Ns]=fill(290, Ns)
    "Initial fluid temperature (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.SpecificEnthalpy h0[Ns]=fill(1e5, Ns)
    "Initial fluid specific enthalpy (active if steady_state = false and option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and not
          option_temperature));
  parameter Boolean inertia=true
    "true: momentum balance equation with inertia - false: without inertia";
  parameter Boolean advection=false
    "true: momentum balance equation with advection terme - false: without advection terme";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean dynamic_mass_balance=true
    "true: dynamic mass balance equation - false: static mass balance equation (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean simplified_dynamic_energy_balance=true
    "true: simplified dynamic energy balance equation - false: full dynamic energy balance equation (active if dynamic_energy_balance=true and dynamic_mass_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and dynamic_mass_balance));
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0 (if option_temperature = true) or h0 (if option_temperature=false)(active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean option_temperature=true
    "true: initial temperature is fixed - false: initial specific enthalpy is fixed (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=not steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

  DynamicOnePhaseFlowPipe DynamicOnePhaseFlowPipe_2(
    Ns=Ns,
    L=L,
    ntubes=Ntubes,
    D=Dext,
    continuous_flow_reversal=continuous_flow_reversal,
    T0=T0,
    h0=h0,
    advection=advection,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    steady_state=steady_state,
    option_temperature=option_temperature,
    diffusion=diffusion,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    region=region,
    P0=P0,
    z1=z1,
    z2=z2,
    rugosrel=rugosrel_ext,
    inertia=inertia)
                  annotation (Placement(transformation(extent={{-10,30},{10,10}},
          rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall ExchangerWall(
    L=L,
    D=Dint,
    Ns=Ns,
    ntubes=Ntubes,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    T0=T0[1],
    cpw=cpw,
    rhow=rhow,
    e=e,
    lambda=lambda)                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
  Fluid.HeatExchangers.DynamicOnePhaseFlowPipe DynamicOnePhaseFlowPipe_1(
    ntubes=Ntubes,
    Ns=Ns,
    T0=T0,
    h0=h0,
    inertia=inertia,
    advection=advection,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    steady_state=steady_state,
    option_temperature=option_temperature,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    region=region,
    P0=P0,
    L=L,
    D=Dint,
    rugosrel=rugosrel_int,
    z1=z1,
    z2=z2) annotation (Placement(transformation(extent={{-10,-30},{10,-10}},
          rotation=0)));
  Interfaces.Connectors.FluidInlet  Cfg1 annotation (Placement(transformation(
          extent={{-10,40},{10,60}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet  Cfg2 annotation (Placement(transformation(
          extent={{-10,-60},{10,-40}}, rotation=0)));
  Interfaces.Connectors.FluidInlet                     Cws1 annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet                     Cws2 annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  connect(Cws2, DynamicOnePhaseFlowPipe_1.C2) annotation (Line(
      points={{100,0},{40,0},{40,-20},{10,-20}},
      color={255,0,0},
      thickness=0.5));
  connect(Cws1, DynamicOnePhaseFlowPipe_1.C1) annotation (Line(points={{-100,0},
          {-20,0},{-20,-20},{-10,-20}}, thickness=0.5));
  connect(ExchangerWall.WT1, DynamicOnePhaseFlowPipe_1.CTh)
    annotation (Line(points={{0,-2},{0,-17}}, color={191,95,0}));
  connect(DynamicOnePhaseFlowPipe_2.CTh, ExchangerWall.WT2)
    annotation (Line(points={{0,17},{0,2}}, color={191,95,0}));
  connect(DynamicOnePhaseFlowPipe_2.C2, Cfg2) annotation (Line(
      points={{10,20},{32,20},{32,-50},{0,-50}},
      color={0,0,0},
      thickness=1));
  connect(DynamicOnePhaseFlowPipe_2.C1, Cfg1) annotation (Line(
      points={{-10,20},{-26,20},{-26,50},{0,50}},
      color={0,0,0},
      thickness=1));
  annotation (         Icon(graphics={
        Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.HorizontalCylinder
          else FillPattern.Solid),
          fillColor={255,127,0}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.HorizontalCylinder
          else FillPattern.Solid),
         fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Line(points={{-60,50},{-60,-50}}),
        Line(points={{-20,50},{-20,-50}}),
        Line(points={{20,50},{20,-50}}),
        Line(points={{60,50},{60,-50}}),
        Text(
          extent={{-48,68},{-20,52}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Fluid2 inlet"),
        Text(
          extent={{-134,22},{-108,10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Fluid1 inlet"),
        Text(
          extent={{104,24},{132,12}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Fluid1 outlet"),
        Text(
          extent={{-46,-56},{-14,-68}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Fluid2 outlet")}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end DynamicMultiFluidHeatExchanger;
