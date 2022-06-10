within ThermoSysPro.Fluid.HeatExchangers;
model SteamGenerator_1SG "Single steam generator"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real H0_Mix_AlimDomeGV=1194812.89980521;
  parameter Boolean inertia=false
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
  parameter Real Vf0=0.1 "Fraction of initial water volume in the drum (active if dynamic_energy_balance=true and steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0=50.e5
    "Fluid initial pressure in the drum (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean option_temperature=false
    "true: initial temperature is fixed - false: initial specific enthalpy is fixed (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=not steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

public
  ThermoSysPro.Fluid.HeatExchangers.DynamicOnePhaseFlowPipe UtubeHotLeg(
    L=10.848,
    D=0.01687,
    z2=10.848,
    h(start={1483455.66417054,1452982.36179149,1407381.72335656,1372666.398393,
          1346263.00297153,1326153.46646787,1326153}),
    Ns=5,
    dpfCorr=0.17,
    hcCorr=5,
    ntubes=5340,
    advection=advection,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    steady_state=steady_state,
    inertia=inertia,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    option_temperature=option_temperature,
    P(start={15548026.576998,15539261.540558,15513354.885726,15479081.11289,15444819.569988,
          15410560.642776,15395560}),
    Tp(start={564,562,560,559,568}))
                 annotation (Placement(transformation(
        origin={-67,-41.5},
        extent={{30.5,-15},{-30.5,15}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicOnePhaseFlowPipe UtubeColdtLeg(
    L=10.848,
    D=0.01687,
    h(start={1326153.46646787,1310848.36111251,1299218.76228131,
          1290360.28876122,1283604.94388924,1280654.73156587,1280654.73156587}),
    Ns=5,
    dpfCorr=0.17,
    hcCorr=5,
    z1=10.848,
    ntubes=5340,
    inertia=inertia,
    advection=advection,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    steady_state=steady_state,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    option_temperature=option_temperature,
    P(start={15393431.104025,15393244.26355,15392971.944187,15392877.066005,15392915.646752,
          15393000.834432,15393020}),
    Tp(start={584,580,575,571,568}))
                 annotation (Placement(transformation(
        origin={67,-41.5},
        extent={{30.5,-14},{-30.5,14}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.DynamicDrum DomeGV(
    hl(start=1257382.15477056),
    hv(start=2771260.46625813),
    cpp=500,
    L=8.625,
    Cd(P(start=67.9e5)),
    zl(fixed=false, start=0.66),
    R=4.2818979,
    Mp=32000,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    Vf0=Vf0,
    P0=P0,
    wsftype=wsftype)
              annotation (Placement(transformation(extent={{-22,64},{22,107}},
          rotation=0)));
protected
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe DPSeparateurCyclone(
    L=1,
    D=0.95886,
    lambda=0.03,
    inertia=inertia)
                 annotation (Placement(transformation(
        origin={0,42},
        extent={{-5,-10},{5,10}},
        rotation=90)));
public
  ThermoSysPro.Fluid.Volumes.VolumeC MixAlimDomeGV(
    h0=H0_Mix_AlimDomeGV,
    h(start=1194851.37111438),
    V=0.01,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    dynamic_mass_balance=dynamic_mass_balance,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    ftype=ftype)                               " "
    annotation (Placement(transformation(
        origin={94,63},
        extent={{-8,-8},{8,8}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss DPnulle_AlimDwnc(
      K=1e-4)
    annotation (Placement(transformation(
        origin={94,88},
        extent={{-6,-7},{6,7}},
        rotation=270)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss DPnulle_DomeDwnc(
    p_rho=0,
    C2(P(start=6829391.22090726), Q(fixed=false, start=6643)),
    K=0.172144)                   annotation (Placement(transformation(extent={{53,53},
            {63,73}},          rotation=0)));

public
  ThermoSysPro.Fluid.Sensors.SensorP CapteurPAlim
    annotation (Placement(transformation(
        origin={99,26},
        extent={{-6,-6},{6,6}},
        rotation=270)));

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet fluidOutletI
    annotation (Placement(transformation(extent={{-10,139},{10,159}}, rotation=
            0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet fluidInlet annotation (
      Placement(transformation(extent={{42,102},{62,122}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet fluidInlet1 annotation (
      Placement(transformation(extent={{-56,-132},{-36,-112}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet fluidOutletI1
    annotation (Placement(transformation(extent={{36,-132},{56,-112}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal outputReal
    annotation (Placement(transformation(extent={{-42,86},{-62,106}}, rotation=
            0)));
public
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe DownComerGV(
    p_rho=0,
    h(start=1194851.3),
    z1=10.8,
    C1(
      h_vol_1(start=1.1733e6),
      h(start=1.1733e6),
      Q(start=7525.84),
      P(start=6829391.22090726)),
    L=10.8,
    D=0.216,
    C2(
      h_vol_1(start=1.1733e6),
      Q(start=7525.84),
      h(start=1.1733e6),
      P(fixed=false, start=68.4935e5)),
    lambda=0.08,
    ntubes=32,
    Q(start=7525.84/4),
    inertia=inertia)           "DownComerGV" annotation (Placement(transformation(
        origin={94.5,-41},
        extent={{-31,16.5},{31,-16.5}},
        rotation=270)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(
    L=10.848,
    D=0.01687,
    e=2.18e-3,
    lambda=23,
    cpw=503,
    rhow=8430,
    Ns=5,
    ntubes=5340,
    dynamic_energy_balance=dynamic_energy_balance,
    Tp(start={571,568,566,564,562}))
                  annotation (Placement(transformation(
        origin={-44,-41},
        extent={{-33,-16},{33,16}},
        rotation=270)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall1(
    L=10.848,
    D=0.01687,
    e=2.18e-3,
    lambda=23,
    cpw=503,
    rhow=8430,
    Ns=5,
    ntubes=5340,
    dynamic_energy_balance=dynamic_energy_balance,
    Tp(start={563,560,558,557,556}))
                  annotation (Placement(transformation(
        origin={44,-41},
        extent={{-33,16},{33,-16}},
        rotation=270)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicTwoPhaseFlowRiser RiserGV(
    Ns=5,
    h(start={1194851.37008144,1260885.3160958,1364323.64228458,1450411.24087846,
          1525552.01981793,1595519.78942018,1595519.78863864}),
    D=0.03689,
    L=10.848,
    z2=10.848,
    hcCorr=5,
    dpfCorr=1,
    ntubes=5340,
    Q(start={8600/4,8600/4,8600/4,8600/4,8600/4,8600/4}),
    inertia=inertia,
    advection=advection,
    dynamic_energy_balance=dynamic_energy_balance,
    dynamic_mass_balance=dynamic_mass_balance,
    simplified_dynamic_energy_balance=simplified_dynamic_energy_balance,
    steady_state=steady_state,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    option_temperature=option_temperature,
    P(start={6866734.6044951,6862203.9025063,6853535.2456408,6846247.0825137,6840314.8313501,
          6834912.1497303,6828884.4924605}),
    Tp1(start={563.83109489963,562.97171435789,562.21322867383,561.55248247184,560.97588254902}),
    Tp2(start={563.83109489963,562.97171435789,562.21322867383,561.55248247184,560.97588254902}))
                                                          annotation (Placement(
        transformation(
        origin={-2.5,-41},
        extent={{-32,31.5},{32,-31.5}},
        rotation=90)));

  ThermoSysPro.Fluid.Volumes.VolumeC volumeA(
    h0=1185.2e3,
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    dynamic_mass_balance=dynamic_mass_balance,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    ftype=ftype,
    P0=6849350)                annotation (Placement(transformation(
        origin={1,-90},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.Fluid.Volumes.VolumeC volumeA1(
    dynamic_energy_balance=dynamic_energy_balance,
    steady_state=steady_state,
    dynamic_mass_balance=dynamic_mass_balance,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    ftype=ftype)                                                                                                                   annotation (
      Placement(transformation(
        origin={0,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(UtubeHotLeg.C2, UtubeColdtLeg.C1) annotation (Line(
      points={{-67,-11},{-67,-2},{67,-2},{67,-11}},
      color={127,0,0},
      thickness=0.5));
  connect(MixAlimDomeGV.Ce1, DPnulle_AlimDwnc.C2)
    annotation (Line(points={{94,71},{94,82}}, thickness=0.5));
  connect(DPnulle_DomeDwnc.C2, MixAlimDomeGV.Ce3) annotation (Line(
      points={{63,63},{86,63}},
      color={0,0,255},
      thickness=0.5));
  connect(MixAlimDomeGV.Cs, CapteurPAlim.C1) annotation (Line(
      points={{94,55},{94.2,32}},
      color={0,0,255},
      thickness=0.5));
  connect(DPnulle_AlimDwnc.C1, fluidInlet)
    annotation (Line(points={{94,94},{94,100.5},{52,100.5},{52,112}}));
  connect(fluidInlet1, UtubeHotLeg.C1) annotation (Line(
      points={{-46,-122},{-66,-122},{-66,-72},{-67,-72}},
      color={127,0,0},
      thickness=0.5));
  connect(UtubeColdtLeg.C2, fluidOutletI1) annotation (Line(
      points={{67,-72},{68,-78},{68,-122},{46,-122}},
      color={127,0,0},
      thickness=0.5));
  connect(CapteurPAlim.C2, DownComerGV.C1)      annotation (Line(
      points={{94.2,19.88},{94.2,20},{94,20},{94,6},{94.5,6},{94.5,-10}},
      color={0,0,255},
      thickness=0.5));
  connect(UtubeHotLeg.CTh, heatExchangerWall.WT1) annotation (Line(
      points={{-62.5,-41.5},{-57.25,-41.5},{-57.25,-41},{-47.2,-41}},
      color={191,95,0},
      thickness=0.5));
  connect(heatExchangerWall1.WT1, UtubeColdtLeg.CTh) annotation (Line(
      points={{47.2,-41},{58,-41},{58,-41.5},{62.8,-41.5}},
      color={191,95,0},
      thickness=0.5));
  connect(DownComerGV.C2, volumeA.Ce1)      annotation (Line(points={{94.5,-72},
          {94.5,-108},{1,-108},{1,-100}}, color={0,0,255}));
  connect(volumeA.Cs, RiserGV.C1)
                                annotation (Line(points={{1,-80},{0.65,-80},{
          0.65,-73}}, color={0,0,255}));
  connect(RiserGV.C2, volumeA1.Ce1)
                                  annotation (Line(points={{0.65,-9},{
          -6.12303e-016,-9},{-6.12303e-016,8}}, color={0,0,255}));
  connect(volumeA1.Cs, DPSeparateurCyclone.C1) annotation (Line(points={{
          6.12303e-016,28},{-6.12303e-016,28},{-6.12303e-016,37}}, color={0,0,
          255}));
  connect(heatExchangerWall.WT2, RiserGV.CTh2)
                                             annotation (Line(points={{-40.8,
          -41},{-18.25,-41}}, color={191,95,0}));
  connect(RiserGV.CTh1, heatExchangerWall1.WT2)
                                              annotation (Line(points={{19.55,
          -41},{40.8,-41}}, color={191,95,0}));
  connect(DomeGV.Cv, fluidOutletI) annotation (Line(points={{22,107},{22,124},{
          0,124},{0,149}}, color={255,0,0}));
  connect(DPSeparateurCyclone.C2, DomeGV.Cm) annotation (Line(points={{
          6.12303e-016,47},{6.12303e-016,52},{22,52},{22,64}}, color={0,0,255}));
  connect(DomeGV.Cs, DPnulle_DomeDwnc.C1) annotation (Line(points={{22,76.9},{40,
          76.9},{40,63},{53,63}},    color={0,0,255}));
  connect(DomeGV.yLevel, outputReal) annotation (Line(points={{24.2,85.5},{32,85.5},
          {32,114},{-36,114},{-36,96},{-52,96}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-150,-150},{150,150}},
        initialScale=0.1), graphics={Text(
          extent={{55,81},{55,75}},
          lineColor={0,0,255},
          textString=
               "petit DP"), Text(
          extent={{-126,153},{-84,123}},
          lineColor={0,0,255},
          textString=
               "= 1GV")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-150,-150},{150,150}},
        initialScale=0.1), graphics={
        Ellipse(
          extent={{-42,150},{42,108}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={0,128,255}),
        Rectangle(
          extent={{-42,131},{42,80}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={0,128,255}),
        Ellipse(
          extent={{-36,-108},{36,-150}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={0,128,255}),
        Rectangle(
          extent={{-42,86},{42,56}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={170,213,255}),
        Rectangle(
          extent={{-36,42},{36,-128}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={170,213,255}),
        Polygon(
          points={{-42,56},{42,56},{36,42},{-36,42},{-42,56}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.VerticalCylinder,
          if dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor={170,213,255})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end SteamGenerator_1SG;
