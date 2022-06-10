within ThermoSysPro.Fluid.Junctions;
model SteamExtractionSplitter "Splitter for steam extraction"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real alpha = 1
    "Vapor mass fraction at the extraction/Vapor mass fraction at the inlet (0 <= alpha <= 1)";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region_e=IF97Region.All_regions "IF97 region at the inlet (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode_e=Integer(region_e) - 1 "IF97 region at the inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer fluid=Integer(ftype) "Fluid number";

public
  Real x_ex(start=0.99) "Vapor mass fraction at the extraction outlet";
  Units.SI.AbsolutePressure P(start=10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  FluidType fluids[4] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je "Thermal power diffusion from inlet e";
  Units.SI.Power Js "Thermal power diffusion from outlet s";
  Units.SI.Power Jex "Thermal power diffusion from outlet ex";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e "Diffusion conductance for inlet e";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet s";
  Units.SI.MassFlowRate gamma_ex "Diffusion conductance for outlet ex";
  Real re "Value of r(Q/gamma) for inlet e";
  Real rs "Value of r(Q/gamma) for outlet s";
  Real rex "Value of r(Q/gamma) for outlet ex";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce annotation (Placement(
        transformation(extent={{-113,-10},{-93,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs annotation (Placement(
        transformation(extent={{93,-10},{113,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cex "Extraction outlet"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}, rotation=
            0)));
equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce.ftype;
  fluids[3] = Cs.ftype;
  fluids[4] = Cex.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "SteamExtractionSplitter: fluids mixing in volume are not compatible with each other");

  /* Mass balance equation */
  0 = Ce.Q - Cs.Q - Cex.Q;

  P = Ce.P;
  P = Cs.P;
  P = Cex.P;

  /* Energy balance equation */
  0 = Ce.Q*Ce.h - Cs.Q*Cs.h - Cex.Q*Cex.h + J;

  Ce.h_vol_2 = h;
  Cs.h_vol_1 = h;
  Cex.h_vol_1 = if noEvent(x_ex < 1) then (1 - x_ex)*lsat.h + x_ex*vsat.h else h;

  /* Fluid composition */
  0 = Ce.Xco2*Ce.Q - Cs.Xco2*Cs.Q - Cex.Xco2*Cex.Q;
  0 = Ce.Xh2o*Ce.Q - Cs.Xh2o*Cs.Q - Cex.Xh2o*Cex.Q;
  0 = Ce.Xo2*Ce.Q - Cs.Xo2*Cs.Q - Cex.Xo2*Cex.Q;
  0 = Ce.Xso2*Ce.Q - Cs.Xso2*Cs.Q - Cex.Xso2*Cex.Q;

  Cs.ftype = ftype;
  Cex.ftype = ftype;

  Cs.Xco2 = Xco2;
  Cs.Xh2o = Xh2o;
  Cs.Xo2  = Xo2;
  Cs.Xso2 = Xso2;

  Cex.Xco2 = Xco2;
  Cex.Xh2o = Xh2o;
  Cex.Xo2  = Xo2;
  Cex.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs.h = ThermoSysPro.Functions.SmoothCond(Cs.Q/gamma_s, Cs.h_vol_1, Cs.h_vol_2, 1);
    Cex.h = ThermoSysPro.Functions.SmoothCond(Cex.Q/gamma_ex, Cex.h_vol_1, Cex.h_vol_2, 1);
  else
    Cs.h = if (Cs.Q > 0) then Cs.h_vol_1 else Cs.h_vol_2;
    Cex.h = if (Cex.Q > 0) then Cex.h_vol_1 else Cex.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re = if Ce.diff_on_1 then exp(-0.033*(Ce.Q*Ce.diff_res_1)^2) else 0;
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;
    rex = if Cex.diff_on_2 then exp(-0.033*(Cex.Q*Cex.diff_res_2)^2) else 0;

    gamma_e = if Ce.diff_on_1 then 1/Ce.diff_res_1 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;
    gamma_ex = if Cex.diff_on_2 then 1/Cex.diff_res_2 else gamma0;

    Je = if Ce.diff_on_1 then re*gamma_e*(Ce.h_vol_1 - Ce.h_vol_2) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
    Jex = if Cex.diff_on_2 then rex*gamma_ex*(Cex.h_vol_2 - Cex.h_vol_1) else 0;
  else
    re = 0;
    rs = 0;
    rex = 0;

    gamma_e = gamma0;
    gamma_s = gamma0;
    gamma_ex = gamma0;

    Je = 0;
    Js = 0;
    Jex = 0;
  end if;

  J = Je + Js + Jex;

  Ce.diff_res_2 = 0;
  Cs.diff_res_1 = 0;
  Cex.diff_res_1 = 0;

  Ce.diff_on_2 = diffusion;
  Cs.diff_on_1 = diffusion;
  Cex.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties at the inlet */
  proe = ThermoSysPro.Properties.Fluid.Ph(P, Ce.h, mode_e,fluid);

  /* Fluid thermodynamic properties at the saturation point */
  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P,fluid);

  /* Vapor mass fraction at the extraction outlet */
  x_ex = alpha*proe.x;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,30},{-100,-30},{-40,-30},{20,-100},{20,-100},{60,-100},
              {70,-100},{0,-30},{100,-30},{100,30},{-100,30}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,28},{-100,-32},{-40,-32},{20,-102},{20,-102},{60,-102},
              {70,-102},{0,-32},{100,-32},{100,28},{-100,28}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
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
end SteamExtractionSplitter;
