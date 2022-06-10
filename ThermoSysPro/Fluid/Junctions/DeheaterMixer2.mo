within ThermoSysPro.Fluid.Junctions;
model DeheaterMixer2
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Temperature Tmax=700 "Maximum fluid temperature";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.AbsolutePressure P(start=50e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T(start=700) "Fluid temperature";
  Units.SI.SpecificEnthalpy hmax(start=10e5) "Maximum fluid specific enthalpy";
  FluidType fluids[4] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je "Thermal power diffusion from inlet e";
  Units.SI.Power Je_mix "Thermal power diffusion from inlet e_mix";
  Units.SI.Power Js "Thermal power diffusion from outlet s";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e "Diffusion conductance for inlet e";
  Units.SI.MassFlowRate gamma_e_mix "Diffusion conductance for inlet e_mix";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet s";
  Real re "Value of r(Q/gamma) for inlet e";
  Real re_mix "Value of r(Q/gamma) for inlet e_mix";
  Real rs "Value of r(Q/gamma) for outlet s";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce_mix annotation (
      Placement(transformation(extent={{-9,-110},{11,-90}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs annotation (Placement(
        transformation(extent={{90,50},{110,70}}, rotation=0)));
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce.ftype;
  fluids[3] = Ce_mix.ftype;
  fluids[4] = Cs.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "DeheaterMixer2: fluids mixing in volume are not compatible with each other");

  /* Mass balance equation */
  0 = Ce.Q + Ce_mix.Q - Cs.Q;

  P = Ce.P;
  P = Ce_mix.P;
  P = Cs.P;

  /* Energy balance equation */
  0 = Ce.Q*Ce.h + Ce_mix.Q*Ce_mix.h - Cs.Q*Cs.h + J;

  Ce.h_vol_2 = h;
  Ce_mix.h_vol_2 = h;
  Cs.h_vol_1 = h;

  /* The flow at the mixing inlet is such as to ensure T <= Tmax */
  if T <= Tmax then
    Ce_mix.Q = 0;
  else
    h = hmax;
  end if;

  /* Fluid composition balance equations */
  0 = Ce.Xco2*Ce.Q + Ce_mix.Xco2*Ce_mix.Q - Cs.Xco2*Cs.Q;
  0 = Ce.Xh2o*Ce.Q + Ce_mix.Xh2o*Ce_mix.Q - Cs.Xh2o*Cs.Q;
  0 = Ce.Xo2*Ce.Q + Ce_mix.Xo2*Ce_mix.Q - Cs.Xo2*Cs.Q;
  0 = Ce.Xso2*Ce.Q + Ce_mix.Xso2*Ce_mix.Q - Cs.Xso2*Cs.Q;

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
    re_mix = if Ce_mix.diff_on_1 then exp(-0.033*(Ce_mix.Q*Ce_mix.diff_res_1)^2) else 0;
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;

    gamma_e = if Ce.diff_on_1 then 1/Ce.diff_res_1 else gamma0;
    gamma_e_mix = if Ce_mix.diff_on_1 then 1/Ce_mix.diff_res_1 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;

    Je = if Ce.diff_on_1 then re*gamma_e*(Ce.h_vol_1 - Ce.h_vol_2) else 0;
    Je_mix = if Ce_mix.diff_on_1 then re_mix*gamma_e_mix*(Ce_mix.h_vol_1 - Ce_mix.h_vol_2) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
  else
    re = 0;
    re_mix = 0;
    rs = 0;

    gamma_e = gamma0;
    gamma_e_mix = gamma0;
    gamma_s = gamma0;

    Je = 0;
    Je_mix = 0;
    Js = 0;
  end if;

  J = Je + Je_mix + Js;

  Ce.diff_res_2 = 0;
  Ce_mix.diff_res_2 = 0;
  Cs.diff_res_1 = 0;

  Ce.diff_on_2 = diffusion;
  Ce_mix.diff_on_2 = diffusion;
  Cs.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  hmax = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(P, Tmax, fluid, mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,80},{-100,40},{-20,40},{-20,-100},{20,-100},{20,40},{
              100,40},{100,80},{-100,80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-16,72},{16,46}},
          lineColor={0,0,255},
          textString=
               "D")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,80},{-100,40},{-20,40},{-20,-100},{20,-100},{20,40},{
              100,40},{100,80},{-100,80}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid), Text(
          extent={{-18,78},{22,38}},
          lineColor={0,0,255},
          textString=
               "D")}),
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
end DeheaterMixer2;
