within ThermoSysPro.Fluid.HeatExchangers;
model DynamicCondenser "Dynamic condenser"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Units.SI.Radius Rv=1.0 "Radius of the Cavity cross-sectional area";
  parameter Units.SI.Length Lv=15 "Cavity length";
  parameter Units.SI.Length L2=14 "Pipes length";
  parameter Units.SI.Length Lc=2.5
    "Support plate spacing in cooling zone(chicanes)";
  parameter Units.SI.Diameter Dc=0.016 "Internal diameter of the cooling pipes";
  parameter Units.SI.Thickness ec=2.e-3 "Thickness of the cooling pipes";
  parameter Integer Ns=10 "Number of segments for pipes";
  parameter Integer ntubest=10000 "Number of total pipes in Cavity ";
  parameter Integer ntubesV=200 "Numbers of pipes in a vertical plan in Cavity";
  parameter Units.SI.SpecificHeatCapacity cp=460
    "Specific heat capacity of the metal of the cooling pipes";
  parameter Units.SI.Density rho=7900
    "Density of the metal of the cooling pipes";
  parameter Units.SI.ThermalConductivity lambda=26
    "Wall thermal conductivity of the cooling pipes";
  parameter Units.SI.Temperature T0[Ns]=fill(290, Ns)
    "Initial fluid temperature (active if steady_state = false and option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and
          option_temperature));
  parameter Units.SI.SpecificEnthalpy h0[Ns]=fill(1e5, Ns)
    "Initial fluid specific enthalpy (active if steady_state = false and option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not steady_state and not
          option_temperature));
  parameter Boolean inertia=true "true: momentum balance equation with inertia - false: without inertia";
  parameter Boolean advection=false "true: momentum balance equation with advection terme - false: without advection terme";
  parameter Boolean dynamic_energy_balance=true "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean dynamic_mass_balance=true "true: dynamic mass balance equation - false: static mass balance equation (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean simplified_dynamic_energy_balance=true "true: simplified dynamic energy balance equation - false: full dynamic energy balance equation (active if dynamic_energy_balance=true and dynamic_mass_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and dynamic_mass_balance));
  parameter Boolean steady_state=true "true: start from steady state - false: start from (P0c, Vf0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Real Vf0=0.066 "Fraction of initial liquid volume in the drum (active if dynamic_energy_balance=true and steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0c=1e4
    "Fluid initial pressure (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean option_temperature=true "true: initial temperature is fixed - false: initial specific enthalpy is fixed (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=not steady_state));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

  Volumes.TwoPhaseCavityOnePipe DynamicCondenser(
    Vf0=Vf0,
    P0=P0c,
    Ns=Ns,
    L2=L2,
    NbTubT=ntubest,
    Lc=Lc,
    NbTubV=ntubesV,
    Dext=Dc + 2*ec,
    R=Rv,
    L=Lv,
    Vertical=true,
    wsftype=wsftype,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion)
    annotation (                        Placement(transformation(extent={{-100,-100},
            {100,100}},       rotation=0)));
  DynamicOnePhaseFlowPipe pipe_3(
    D=Dc,
    L=L2,
    ntubes=ntubest,
    Ns=Ns,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    steady_state=steady_state,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    advection=advection,
    option_temperature=option_temperature,
    inertia=inertia,
    T0=T0,
    h0=h0)
    annotation (Placement(transformation(extent={{-58,-20},{54,18}}, rotation=0)));
  Interfaces.Connectors.FluidInlet  C1vap "Vapor inlet" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet  C2ex "Condensed water extraction outlet"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  Interfaces.Connectors.FluidInlet  Ce1 "Cooling water inlet" annotation (
      Placement(transformation(extent={{-110,-11},{-90,9}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet  Ce2 "Cooling water outlet" annotation (
      Placement(transformation(extent={{89,-11},{109,9}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal sortieReelle
    annotation (Placement(transformation(extent={{98,-62},{118,-42}}, rotation=
            0)));

  Interfaces.Connectors.FluidInlet  C1 "Extra water inlet" annotation (
      Placement(transformation(extent={{-91,65},{-71,85}},  rotation=0),
        iconTransformation(extent={{-91,65},{-71,85}})));
  Thermal.HeatTransfer.HeatExchangerWall Wall_3(
    D=Dc,
    e=ec,
    lambda=lambda,
    cpw=cp,
    rhow=rho,
    L=L2,
    Ns=Ns,
    ntubes=ntubest,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state)
    annotation (Placement(transformation(extent={{-58,-4},{54,40}}, rotation=0)));
  Interfaces.Connectors.FluidInlet  C2vap "Vapor inlet" annotation (Placement(
        transformation(extent={{-49,82},{-29,102}}, rotation=0),
        iconTransformation(extent={{-49,82},{-29,102}})));
equation

  if (cardinality(C1) == 1) then
    C1.Q = 0;
    C1.h = 1.e5;
    C1.h_vol_1 = 1.e5;
    C1.diff_res_1 = 0;
    C1.diff_on_1 = false;
    C1.ftype = ftype;
    C1.Xco2 = 0;
    C1.Xh2o = 1;
    C1.Xo2 = 0;
    C1.Xso2 = 0;
  end if;

  if (cardinality(C2vap) == 1) then
    C2vap.Q = 0;
    C2vap.h = 1.e5;
    C2vap.h_vol_1 = 1.e5;
    C2vap.diff_res_1 = 0;
    C2vap.diff_on_1 = false;
    C2vap.ftype = ftype;
    C2vap.Xco2 = 0;
    C2vap.Xh2o = 1;
    C2vap.Xo2 = 0;
    C2vap.Xso2 = 0;
  end if;

  connect(DynamicCondenser.Cl, C2ex)
                               annotation (Line(points={{7.10543e-015,-73.3333},
          {7.10543e-015,-98},{0,-98},{0,-100}}, color={0,0,255}));
  connect(DynamicCondenser.yLevel, sortieReelle)
    annotation (Line(points={{98.8571,-31.3333},{94,-31.3333},{94,-52},{108,-52}}));
  connect(DynamicCondenser.Cth3, Wall_3.WT2)
                                      annotation (Line(points={{-0.571429,
          37.3333},{-2,32},{-2,22.4}}, color={191,95,0}));
  connect(Wall_3.WT1, pipe_3.CTh) annotation (Line(points={{-2,13.6},{-2,4.7}},
        color={191,95,0}));
  connect(DynamicCondenser.CvBP, C1vap)
    annotation (Line(points={{-0.571429,73.3333},{-0.571429,92},{0,92},{0,100}}));
  connect(C2vap, DynamicCondenser.CvGCT)
    annotation (Line(points={{-39,92},{-42.8571,92},{-42.8571,73.3333}}));
  connect(pipe_3.C2, Ce2) annotation (Line(
      points={{54,-1},{99,-1}},
      color={0,0,255},
      thickness=0.5));
  connect(pipe_3.C1, Ce1)
    annotation (Line(points={{-58,-1},{-100,-1}}, thickness=0.5));
  connect(C1, DynamicCondenser.Ce) annotation (Line(points={{-81,75},{-76.5714,
          75},{-76.5714,52.6667}},
                               color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={Text(
          extent={{6,114},{32,98}},
          lineColor={0,0,255},
          textString="LP")}),
                       Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{100,58},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,58},{-80,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,24},{-80,18}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-20},{-80,-26}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-42},{-80,-48}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,24},{20,18}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-42},{20,-48}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-20},{20,-26}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-20},{-30,-26}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-42},{-30,-48}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,24},{-30,18}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,100},{-20,98},{-40,94},{-60,88},{-80,78},{-92,66},{-96,62},
              {-96,62},{-100,58},{100,58},{96,62},{92,66},{86,72},{80,78},{60,
              88},{40,94},{20,98},{0,100}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-100},{-20,-98},{-40,-96},{-60,-90},{-80,-80},{-92,-68},{
              -96,-64},{-100,-60},{-100,-60},{98,-60},{100,-60},{96,-64},{92,
              -68},{80,-80},{60,-90},{40,-96},{20,-98},{0,-100}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({53,117,255}, if fluid==1 then {53,117,255} else if fluid==2 then {0,255,255} else if fluid==3 then {175,175,175} else if fluid==4 then {255,170,213} else if fluid==5 then {0,127,0} else if fluid==6 then {170,215,215} else {213,255,170}),
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{100,-60},{80,-80},{80,-60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-60},{-80,-60},{-80,-80},{-100,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,58},{-80,58},{-80,78},{-100,58}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,58},{80,58},{80,78},{100,58}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-64},{-80,-70}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-64},{20,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-64},{-30,-70}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,2},{-80,-4}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,2},{20,-4}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,2},{-30,-4}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,46},{-80,40}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,46},{20,40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,46},{-30,40}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{90,8},{80,20}}, color={255,0,0}),
        Line(points={{90,-10},{80,-22}}, color={255,0,0}),
        Line(points={{90,-1},{78,-1}}, color={255,0,0}),
        Line(points={{-90,9},{-80,20}}, color={0,0,255}),
        Line(points={{-90,-10},{-80,-24}}, color={0,0,255}),
        Line(points={{-90,-1},{-76,-1}}, color={0,0,255})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.5.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>"));
end DynamicCondenser;
