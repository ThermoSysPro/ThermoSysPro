within ThermoSysPro.Fluid.Junctions;
model MassFlowMultiplier "Mass flow multipliier"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real alpha=2 "Flow multiplier";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Boolean flue_gases=(ftype == FluidType.FlueGases) "Flue gases";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.AbsolutePressure P(start=10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.Density rho(start=998) "Fluid density";
  FluidType fluids[3] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je "Thermal power diffusion from inlet e";
  Units.SI.Power Js "Thermal power diffusion from outlet s";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e "Diffusion conductance for inlet e";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet s";
  Real re "Value of r(Q/gamma) for inlet e";
  Real rs "Value of r(Q/gamma) for outlet s";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce.ftype;
  fluids[3] = Cs.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "MassFlowMultiplier: fluids mixing in volume are not compatible with each other");

  /* Mass balance equation */
  0 = alpha*Ce.Q - Cs.Q;

  P = Ce.P;
  P = Cs.P;

  /* Energy balance equation */
  0 = alpha*Ce.Q*Ce.h - Cs.Q*Cs.h + J;

  Ce.h_vol_2 = h;
  Cs.h_vol_1 = h;

  /* Fluid composition */
  0 = Ce.Xco2*alpha*Ce.Q - Cs.Xco2*Cs.Q;
  0 = Ce.Xh2o*alpha*Ce.Q - Cs.Xh2o*Cs.Q;
  0 = Ce.Xo2*alpha*Ce.Q - Cs.Xo2*Cs.Q;
  0 = Ce.Xso2*alpha*Ce.Q - Cs.Xso2*Cs.Q;

  Cs.ftype = ftype;

  Cs.Xco2 = Xco2;
  Cs.Xh2o = Xh2o;
  Cs.Xo2  = Xo2;
  Cs.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs.h = ThermoSysPro.Functions.SmoothCond(Cs.Q/gamma_s, Cs.h_vol_1, Cs.h_vol_2, 1);
  else
    Cs.h = if (Cs.Q > 0) then Cs.h_vol_1 else Cs.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re = if Ce.diff_on_1 then exp(-0.033*(Ce.Q*Ce.diff_res_1)^2) else 0;
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;

    gamma_e = if Ce.diff_on_1 then 1/Ce.diff_res_1 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;

    Je = if Ce.diff_on_1 then re*gamma_e*(Ce.h_vol_1 - Ce.h_vol_2) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
  else
    re = 0;
    rs = 0;

    gamma_e = gamma0;
    gamma_s = gamma0;

    Je = 0;
    Js = 0;
  end if;

  J = Je + Js;

  Ce.diff_res_2 = 0;
  Cs.diff_res_1 = 0;

  Ce.diff_on_2 = diffusion;
  Cs.diff_on_1 = diffusion;

 /* Fluid thermodynamic properties */
  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(P,h,fluid,mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,60},{-100,-60},{90,0},{-100,60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,0}), Text(
          extent={{-60,24},{-20,-16}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%alpha")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,60},{-100,-60},{90,0},{-100,60}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid), Text(
          extent={{-60,24},{-20,-16}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%alpha")}),
    Window(
      x=0.33,
      y=0.09,
      width=0.71,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end MassFlowMultiplier;
