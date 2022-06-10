within ThermoSysPro.Fluid.Volumes;
model TwoPhaseVolume "TwoPhaseVolume"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Units.SI.Volume V=1 "Cavity volume";
  parameter Units.SI.Area A=1 "Cavity cross-sectional area";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025
    "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975
    "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Units.SI.Area Avl=A
    "Heat exchange surface between the liquid and gas phases";
  parameter Real Kvl=1000
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (Vf0, P0)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the drum (active if steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0=0.1e5
    "Fluid initial pressure (active if steady_state=false)" annotation (
      Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer fluid=Integer(ftype) "Fluid number";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";

public
  Units.SI.AbsolutePressure P "Fluid average pressure";
  Units.SI.AbsolutePressure Pfond "Fluid pressure at the bottom of the cavity";
  Units.SI.SpecificEnthalpy hl "Liquid phase spepcific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase spepcific enthalpy";
  Units.SI.Temperature Tl "Liquid phase temperature";
  Units.SI.Temperature Tv "Gas phase temperature";
  Units.SI.Volume Vl "Liquid phase volume";
  Units.SI.Volume Vv "Gas phase volume";
  Real xl(start=0.5) "Mass vapor fraction in the liquid phase";
  Real xv(start=0) "Mass vapor fraction in the gas phase";
  Units.SI.Density rhol(start=996) "Liquid phase density";
  Units.SI.Density rhov(start=1.5) "Gas phase density";
  Units.SI.MassFlowRate BQl
    "Right hand side of the mass balance equation of the liquid phase";
  Units.SI.MassFlowRate BQv
    "Right hand side of the mass balance equation of the gas phaser";
  Units.SI.Power BHl
    "Right hand side of the energy balance equation of the liquid phase";
  Units.SI.Power BHv
    "Right hand side of the energy balance equation of the gas phase";
  Units.SI.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase";
  Units.SI.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase";
  Units.SI.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase";
  FluidType fluids[4] "Fluids mixing in volume";
  Units.SI.Power Je "Thermal power diffusion from inlet Ce";
  Units.SI.Power Jv "Thermal power diffusion from inlet Cv";
  Units.SI.Power Jl "Thermal power diffusion from outlet Cl";
  Units.SI.Power Jt_l "Total thermal power diffusion for the liquid";
  Units.SI.Power Jt_v "Total thermal power diffusion for the vapor";
  Units.SI.MassFlowRate gamma_e "Diffusion conductance for inlet Ce";
  Units.SI.MassFlowRate gamma_v "Diffusion conductance for inlet Cv";
  Units.SI.MassFlowRate gamma_l "Diffusion conductance for outlet Cl";
  Real re "Value of r(Q/gamma) for inlet Ce";
  Real rv "Value of r(Q/gamma) for inlet Cv";
  Real rl "Value of r(Q/gamma) for outlet Cl";

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol
    "Propri鴩s de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-60,40},{-20,80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propri鴩s de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{0,40},{40,80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{0,-80},{40,-40}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Cv "Steam input" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cl "Water output" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth
                                     annotation (Placement(transformation(
          extent={{-10,10},{10,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}}, rotation=
            0)));
  Interfaces.Connectors.FluidInlet Ce "Water input" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      der(P) = 0;
      der(hl) = 0;
      der(hv) = 0;
      der(Vl) = 0;
    else
      P = P0;
      hl = lsat.h;
      hv = vsat.h;
      Vl = Vf0*V;
    end if;
  end if;

equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce.ftype;
  fluids[3] = Cv.ftype;
  fluids[4] = Cl.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "TwoPhaseVolume: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.h = 1.e5;
    Ce.h_vol_1 = 1.e5;
    Ce.diff_res_1 = 0;
    Ce.diff_on_1 = false;
    Ce.ftype = ftype;
    Ce.Xco2 = 0;
    Ce.Xh2o = 1;
    Ce.Xo2 = 0;
    Ce.Xso2 = 0;
  end if;

  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.h_vol_1 = 1.e5;
    Cv.diff_res_1 = 0;
    Cv.diff_on_1 = false;
    Cv.ftype = ftype;
    Cv.Xco2 = 0;
    Cv.Xh2o = 1;
    Cv.Xo2 = 0;
    Cv.Xso2 = 0;
  end if;

  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h_vol_2 = 1.e5;
    Cl.diff_res_2 = 0;
    Cl.diff_on_2 = false;
  end if;


  /* Volume of the cavity */
  V = Vl + Vv;

  /* Pressure at the bottom of the cavity */
  Pfond = P + prod.d*g*Vl/A;

  /* Liquid phase mass balance equation */
  BQl = -Cl.Q + Qcond - Qevap + Ce.Q;

  if dynamic_energy_balance then
    rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
  else
    0 = BQl;
  end if;

  /* Vapor phase mass balance equation */
  BQv = Cv.Q + Qevap - Qcond;

  if dynamic_energy_balance then
    rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
  else
    0 = BQv;
  end if;

  /* Condensation and evaporation mass flow rates */
  Qcond = if (xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if (xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;

  Ce.P = P;
  Cv.P = P;
  Cl.P = Pfond;

  /* Liquid phase energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + Ce.Q*(Ce.h - (hl - P/rhol)) + Wvl + Jt_l;

  if dynamic_energy_balance then
    Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
  else
    0 = BHl;
  end if;

  /* Gas phase energy balance equation */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) - Wvl + Cth.W + Jt_v;

  if dynamic_energy_balance then
    Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  else
    0 = BHv;
  end if;

  Ce.h_vol_2 = hl;
  Cv.h_vol_2 = hv;
  Cl.h_vol_1 = hl;

  /* Heat exchange between liquid and gas phases */
  Wvl = Kvl*Avl*(Tv - Tl);

  /* Water leval */
  yLevel.signal = Vl/A;

  /* Fluid composition (no balance equations) */
  Cl.ftype = ftype;

  Cl.Xco2 = 0;
  Cl.Xh2o = 1;
  Cl.Xo2  = 0;
  Cl.Xso2 = 0;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cl.h = ThermoSysPro.Functions.SmoothCond(Cl.Q/gamma_l, Cl.h_vol_1, Cl.h_vol_2, 1);
  else
    Cl.h = if (Cl.Q > 0) then Cl.h_vol_1 else Cl.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re = if Ce.diff_on_1 then exp(-0.033*(Ce.Q*Ce.diff_res_1)^2) else 0;
    rv = if Cv.diff_on_1 then exp(-0.033*(Cv.Q*Cv.diff_res_1)^2) else 0;
    rl = if Cl.diff_on_2 then exp(-0.033*(Cl.Q*Cl.diff_res_2)^2) else 0;

    gamma_e = if Ce.diff_on_1 then 1/Ce.diff_res_1 else gamma0;
    gamma_v = if Cv.diff_on_1 then 1/Cv.diff_res_1 else gamma0;
    gamma_l = if Cl.diff_on_2 then 1/Cl.diff_res_2 else gamma0;

    Je = if Ce.diff_on_1 then re*gamma_e*(Ce.h_vol_1 - Ce.h_vol_2) else 0;
    Jv = if Cv.diff_on_1 then rv*gamma_v*(Cv.h_vol_1 - Cv.h_vol_2) else 0;
    Jl = if Cl.diff_on_2 then rl*gamma_l*(Cl.h_vol_2 - Cl.h_vol_1) else 0;
  else
    re = 0;
    rv = 0;
    rl = 0;

    gamma_e = gamma0;
    gamma_v = gamma0;
    gamma_l = gamma0;

    Je = 0;
    Jv = 0;
    Jl = 0;
  end if;

  Jt_l = Je + Jl;
  Jt_v = Jv;

  Ce.diff_res_2 = 0;
  Cv.diff_res_2 = 0;
  Cl.diff_res_1 = 0;

  Ce.diff_on_2 = diffusion;
  Cv.diff_on_2 = diffusion;
  Cl.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.Fluid.Ph((P + Pfond)/2, hl, 0,fluid);
  prov = ThermoSysPro.Properties.Fluid.Ph(P, hv, 0,fluid);
  prod = ThermoSysPro.Properties.Fluid.Ph(Pfond, Cl.h, 0,fluid);
  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P,fluid);

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  Cth.T = Tv;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{0,100},{-20,98},{-40,92},{-60,80},{-80,60},{-92,40},{-98,20},
              {-100,0},{-98,-20},{98,-20},{100,0},{98,20},{92,40},{80,60},{60,
              80},{40,92},{20,98},{0,100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=DynamicSelect(FillPattern.Sphere,
          if dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid)),
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=DynamicSelect(FillPattern.Sphere,
          if dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid)),
        Polygon(
          points={{0,100},{-20,98},{-40,92},{-60,80},{-80,60},{-92,40},{-98,20},
              {-100,0},{-98,-20},{98,-20},{100,0},{98,20},{92,40},{80,60},{60,
              80},{40,92},{20,98},{0,100}},
          lineColor={28,108,200},
          fillColor= DynamicSelect({170,213,255},
          if dynamic_energy_balance then {170,213,255}
          else if diffusion then {213,255,170}
          else {255,255,170}),
          fillPattern=DynamicSelect(FillPattern.Sphere,
          if dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid))}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end TwoPhaseVolume;
