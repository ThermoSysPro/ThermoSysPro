within ThermoSysPro.Fluid.PressureLosses;
model ThreeWayValve "Three way valve"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter ThermoSysPro.Units.xSI.Cv Cvmax1=8005.42 "Valve 1 max CV";
  parameter ThermoSysPro.Units.xSI.Cv Cvmax2=8005.42 "Valve 2 max CV";
  parameter Real caract1[:, 2]=[0, 0; 1, Cvmax1]
    "Valve 1 - Position vs. Cv characteristics (active if mode_caract1=true)";
  parameter Real caract2[:, 2]=[0, 0; 1, Cvmax2]
    "Valve 2 - Position vs. Cv characteristics (active if mode_caract2=true)";
  parameter Integer mode_caract1=0
    "Valve 1 - 0:linear characteristics - 1:characteristics is given by caract1[]";
  parameter Integer mode_caract2=0
    "Valve 2 - 0:linear characteristics - 1:characteristics is given by caract2[]";
  parameter Units.SI.Volume V=1
    "Three way valve volume (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Boolean dynamic_energy_balance=false
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=true
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

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Ouv
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Interfaces.Connectors.FluidInlet C1 annotation (layer="icon", Placement(
        transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet C2 annotation (layer="icon", Placement(
        transformation(extent={{90,-50},{110,-30}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Valve1(
    Cvmax=Cvmax1,
    caract=caract1,
    mode_caract=mode_caract1,
    p_rho=p_rho,
    region=region,
    gamma_diff=gamma_diff)
               annotation (Placement(transformation(
        origin={-6,-50},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Interfaces.Connectors.FluidOutlet C3 annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve Valve2(
    Cvmax=Cvmax2,
    caract=caract2,
    mode_caract=mode_caract2,
    p_rho=p_rho,
    region=region,
    gamma_diff=gamma_diff)
               annotation (Placement(transformation(extent={{40,-4},{60,16}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1
                                         annotation (Placement(transformation(
          extent={{-80,60},{-60,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add Add1(k2=-1) annotation (Placement(transformation(
          extent={{-40,40},{-20,60}}, rotation=0)));
  Volumes.VolumeA VolumeA1(
    V=V,
    p_rho=p_rho,
    dynamic_energy_balance=dynamic_energy_balance,
    diffusion=diffusion,
    continuous_flow_reversal=continuous_flow_reversal,
    ftype=ftype,
    region=region,
    dynamic_composition_balance=dynamic_composition_balance,
    Xco20=Xco20,
    Xh2o0=Xh2o0,
    Xo20=Xo20,
    Xso20=Xso20)            annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.PipePressureLoss PerteDP1(K=0, region=region, gamma_diff=gamma_diff)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
equation
  connect(Ouv, Valve2.Ouv)
    annotation (Line(points={{0,110},{0,60},{50,60},{50,17}}));
  connect(Constante1.y, Add1.u1)
    annotation (Line(points={{-59,70},{-50,70},{-50,56},{-41,56}}, color={0,0,
          255}));
  connect(Ouv, Add1.u2)
    annotation (Line(points={{0,110},{0,90},{-90,90},{-90,44},{-41,44}}));
  connect(Add1.y, Valve1.Ouv)
    annotation (Line(points={{-19,50},{-10,50},{-10,26},{-28,26},{-28,-50},{-17,
          -50}},                                                  color={0,0,
          255}));
  connect(VolumeA1.Cs1, Valve2.C1)
    annotation (Line(points={{10,0},{40,0}}, color={0,0,255}));
  connect(VolumeA1.Cs2, Valve1.C1)
    annotation (Line(points={{0,-10},{0,-40},{8.88178e-016,-40}}, color={0,0,
          255}));
  connect(Valve1.C2, C3)
    annotation (Line(points={{-8.88178e-016,-60},{-8.88178e-016,-78},{0,-78},{0,
          -100}}, color={0,0,255}));
  connect(PerteDP1.C2, VolumeA1.Ce1)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
  connect(Valve2.C2, C2)
    annotation (Line(points={{60,0},{80,0},{80,-40},{100,-40}}, color={0,0,255}));
  connect(PerteDP1.C1, C1)
    annotation (Line(points={{-60,0},{-80,0},{-80,-40},{-100,-40}}, color={0,0,
          255}));
  annotation(structurallyIncomplete, Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.9 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}),
            graphics={Text(extent={{12,-40},{46,-62}},   textString=
                                                   "Valve 1"), Text(extent={{36,
              -6},{70,-28}}, textString =       "Valve 2")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}),
         graphics={
        Polygon(
          points={{-100,0},{-100,-80},{100,0},{100,-80},{-100,0}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-100},{0,-40},{20,-100},{-20,-100}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,40},{-40,40},{-40,56},{-38,74},{-32,84},{-20,94},{0,100},
              {20,94},{32,84},{38,72},{40,54},{40,40}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-40},{40,40},{-40,40},{0,-40}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.09,
      y=0.11,
      width=0.7,
      height=0.66),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2003</b></p>
</HTML>
<html>
<p><b>Version 1.4</b></p>
</HTML>
"), Diagram(Text(extent=[34, -4; 68, -26], string="Valve 2")));
end ThreeWayValve;
