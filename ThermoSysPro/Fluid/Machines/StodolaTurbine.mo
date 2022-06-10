within ThermoSysPro.Fluid.Machines;
model StodolaTurbine "Multistage turbine group using Stodola's ellipse"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real Cst=1.e7 "Stodola's ellipse coefficient";
  parameter Real W_fric=0.0
    "Power losses due to hydrodynamic friction (percent)";
  parameter Real eta_stato=1.0
    "Efficiency to account for cinetic losses (<= 1) (s.u.)";
  parameter Units.SI.Area area_nz=1 "Nozzle area";
  parameter Real eta_nz=1.0
    "Nozzle efficency (eta_nz < 1 - turbine with nozzle - eta_nz = 1 - turbine without nozzle)";
  parameter Units.SI.MassFlowRate Qmax=1
    "Maximum mass flow through the turbine";
  parameter Real eta_is_nom=0.8 "Nominal isentropic efficiency";
  parameter Real eta_is_min=0.35 "Minimum isentropic efficiency";
  parameter Real a=-1.3889
    "x^2 coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Real b=2.6944
    "x coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Real c=-0.5056
    "Constant coefficient of the isentropic efficiency characteristics eta_is=f(Q/Qmax)";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter IF97Region region_e=IF97Region.All_regions "IF97 region before expansion (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_s=IF97Region.All_regions "IF97 region after expansion (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_ps=IF97Region.All_regions "IF97 region after isentropic expansion (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode_e=Integer(region_e) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_s=Integer(region_s) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_ps=Integer(region_ps) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.AbsolutePressure pcrit=ThermoSysPro.Properties.WaterSteam.BaseIF97.data.PCRIT
    "Critical pressure";
  parameter Units.SI.Temperature Tcrit=ThermoSysPro.Properties.WaterSteam.BaseIF97.data.TCRIT
    "Critical temperature";

public
  Real eta_is(start=0.85) "Isentropic efficiency";
  Real eta_is_wet(start=0.83) "Isentropic efficiency for wet steam";
  Units.SI.Power W "Mechanical power produced by the turbine";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy His
    "Fluid specific enthalpy after isentropic expansion";
  Units.SI.SpecificEnthalpy Hrs
    "Fluid specific enthalpy after the real expansion";
  Units.SI.AbsolutePressure Pe(start=10e5, min=0) "Pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start=10e5, min=0) "Pressure at the outlet";
  Units.SI.Temperature Te(min=0) "Temperature at the inlet";
  Units.SI.Temperature Ts(min=0) "Temperature at the outlet";
  Units.SI.Velocity Vs "Fluid velocity at the outlet";
  Units.SI.Density rhos(start=200) "Fluid density at the outlet";
  Real xm(start=1.0,min=0) "Average vapor mass fraction";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  Interfaces.Connectors.FluidInlet Ce annotation (Placement(transformation(
          extent={{-111,-10},{-91,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cs annotation (Placement(transformation(
          extent={{91,-10},{111,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.ElectroMechanics.Connectors.MechanichalTorque M
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal MechPower
                              annotation (Placement(transformation(
        origin={110,-90},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros1
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
equation
  /* Check that the fluid type is water/steam */
  assert((ftype == FluidType.WaterSteam) or (ftype == FluidType.WaterSteamSimple), "StodolaTurbine: the fluid type must be water/steam");

  if (cardinality(M) == 0) then
    M.Ctr = 0;
    M.w = 0;
  else
    M.Ctr*M.w = W;
  end if;

  Ce.Q = Cs.Q;

  Ce.h_vol_1 = Cs.h_vol_1;
  Ce.h_vol_2 = Cs.h_vol_2;

  Cs.diff_on_1 = if (gamma_diff > 0) then Ce.diff_on_1 else false;
  Ce.diff_on_2 = if (gamma_diff > 0) then Cs.diff_on_2 else false;

  Cs.diff_res_1 = Ce.diff_res_1 + (if (gamma_diff > 0) then 1/gamma_diff else 0);
  Ce.diff_res_2 = Cs.diff_res_2 + (if (gamma_diff > 0) then 1/gamma_diff else 0);

  Ce.ftype = Cs.ftype;

  Ce.Xco2 = Cs.Xco2;
  Ce.Xh2o = Cs.Xh2o;
  Ce.Xo2  = Cs.Xo2;
  Ce.Xso2 = Cs.Xso2;

  Q = Ce.Q;
  Pe = Ce.P;
  Ps = Cs.P;

  ftype = Ce.ftype;

  /* Isentropic efficiency */
  eta_is = if (Q < Qmax) then (max(eta_is_min,(a*(Q/Qmax)^2 + b*(Q/Qmax) + c))) else eta_is_nom;
  eta_is_wet = xm*eta_is;

  /* Average vapor mass fraction during the expansion */
  if noEvent((Pe > pcrit) or (Te > Tcrit)) then
    xm = 1;
  else
    xm = (proe.x + pros1.x)/2.0;
  end if;

  /* Stodola's ellipse law */
  if noEvent((Pe > pcrit) or (Te > Tcrit)) then
    Q = sqrt((Pe^2 - Ps^2)/(Cst*Te));
  else
    Q = sqrt((Pe^2 - Ps^2)/(Cst*Te*proe.x));
  end if;

  /* Fluid specific enthalpy after the expansion */
  Hrs - Ce.h = xm*eta_is*(His - Ce.h);

  /* Fluid specific enthalpy at the outlet of the nozzle */
  Vs = Q/rhos/area_nz;
  Cs.h - Hrs = (1 - eta_nz)*Vs^2/2;

  /* Mechanical power produced by the turbine */
  W = Q*eta_stato*(Ce.h - Cs.h)*(1 - W_fric/100);
  MechPower.signal = W;

  /* Fluid thermodynamic properties before the expansion */
  proe = ThermoSysPro.Properties.Fluid.Ph(Pe, Ce.h, mode_e, fluid);

  Te = proe.T;

  /* Fluid thermodynamic properties after the expansion */
  pros1 = ThermoSysPro.Properties.Fluid.Ph(Ps, Hrs, mode_s, fluid);

  /* Fluid thermodynamic properties at the outlet of the nozzle */
  pros = ThermoSysPro.Properties.Fluid.Ph(Ps, Cs.h, mode_s, fluid);

  Ts = pros.T;
  rhos = pros.d;

  /* Fluid thermodynamic properties after the isentropic expansion */
  props = ThermoSysPro.Properties.Fluid.Ps(Ps, proe.s, mode_ps, fluid);
  His = props.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,40},{-100,-40},{100,-100},{100,100},{-100,40}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid), Line(
          points={{0,-70},{0,-90}},
          color={0,0,0},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,40},{-100,-40},{100,-100},{100,100},{-100,40}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid), Line(
          points={{0,-70},{0,-90}},
          color={0,0,0},
          thickness=0.5)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 10.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StodolaTurbine;
