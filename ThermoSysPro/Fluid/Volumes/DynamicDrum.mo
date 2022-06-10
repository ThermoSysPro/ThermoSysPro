within ThermoSysPro.Fluid.Volumes;
model DynamicDrum "Dynamic drum"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Boolean Vertical=true
    "true: vertical cylinder - false: horizontal cylinder";
  parameter Units.SI.Radius R=1.05 "Radius of the drum cross-sectional area";
  parameter Units.SI.Length L=16.27 "Drum length";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025
    "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975
    "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Real Kvl=1000
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.CoefficientOfHeatTransfer Klp=400
    "Heat exchange coefficient between the liquid phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kvp=100
    "Heat exchange coefficient between the gas phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kpa=25
    "Heat exchange coefficient between the wall and the outside";
  parameter Units.SI.Mass Mp=117e3 "Wall mass";
  parameter Units.SI.SpecificHeatCapacity cpp=600 "Wall specific heat";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Vf0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the drum (active if dynamic_energy_balance=true and steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0=50.e5
    "Fluid initial pressure (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer fluid=Integer(ftype) "Fluid number";
  parameter Units.SI.Volume V=pi*R^2*L "Drum volume";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Units.SI.Volume Vmin=1.e-6;

public
  Units.SI.AbsolutePressure P "Fluid average pressure";
  Units.SI.AbsolutePressure Pfond "Fluid pressure at the bottom of the drum";
  Units.SI.SpecificEnthalpy hl "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase specific enthalpy";
  Units.SI.Temperature Tl "Liquid phase temperature";
  Units.SI.Temperature Tv "Gas phase temperature";
  Units.SI.Temperature Tp(start=550) "Wall temperature";
  Units.SI.Temperature Ta "External temperature";
  Units.SI.Volume Vl "Liquid phase volume";
  Units.SI.Volume Vv "Gas phase volume";
  Units.SI.Area Alp "Liquid phase surface on contact with the wall";
  Units.SI.Area Avp "Gas phase surface on contact with the wall";
  Units.SI.Area Ape "Wall surface on contact with the outside";
  Real xl(start=0.5) "Mass vapor fraction in the liquid phase";
  Real xv(start=0) "Mass vapor fraction in the vapor phase";
  Real xmv(start=0.5) "Mass vapor fraction in the ascending tube";
  Units.SI.Density rhol(start=996) "Liquid phase density";
  Units.SI.Density rhov(start=1.5) "Gas phase density";
  Units.SI.MassFlowRate BQl
    "Right hand side of the mass balance equation of the liquid phase";
  Units.SI.MassFlowRate BQv
    "Right hand side of the mass balance equation of the gas phase";
  Units.SI.Power BHl
    "Right hand side of the energy balance equation of the liquid phase";
  Units.SI.Power BHv
    "Right hand side of the energy balance equation of the gas phase";
  Units.SI.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase";
  Units.SI.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase";
  Units.SI.Power Wlv
    "Thermal power exchanged from the gas phase to the liquid phase";
  Units.SI.Power Wpl
    "Thermal power exchanged from the liquid phase to the wall";
  Units.SI.Power Wpv "Thermal power exchanged from the gas phase to the wall";
  Units.SI.Power Wpa "Thermal power exchanged from the outside to the wall";
  Units.SI.Position zl(start=1.05) "Liquid level in drum";
  Units.SI.Area Al "Cross sectional area of the liquid phase";
  Units.SI.Angle theta "Angle";
  Units.SI.Area Avl(start=1.0)
    "Heat exchange surface between the liquid and gas phases";
  FluidType fluids[8] "Fluids mixing in volume";
  Units.SI.Power Je1 "Thermal power diffusion from inlet Ce1";
  Units.SI.Power Je2 "Thermal power diffusion from inlet Ce2";
  Units.SI.Power Je3 "Thermal power diffusion from inlet Ce3";
  Units.SI.Power Jm "Thermal power diffusion from inlet Cm";
  Units.SI.Power Jd "Thermal power diffusion from outlet Cd";
  Units.SI.Power Js "Thermal power diffusion from outlet Cs";
  Units.SI.Power Jv "Thermal power diffusion from outlet Cv";
  Units.SI.Power Jt_l "Total thermal power diffusion for the liquid";
  Units.SI.Power Jt_v "Total thermal power diffusion for the vapor";
  Units.SI.MassFlowRate gamma_e1 "Diffusion conductance for inlet Ce1";
  Units.SI.MassFlowRate gamma_e2 "Diffusion conductance for inlet Ce2";
  Units.SI.MassFlowRate gamma_e3 "Diffusion conductance for inlet Ce3";
  Units.SI.MassFlowRate gamma_m "Diffusion conductance for inlet Cm";
  Units.SI.MassFlowRate gamma_d "Diffusion conductance for outlet Cd";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet Cs";
  Units.SI.MassFlowRate gamma_v "Diffusion conductance for outlet Cv";
  Real re1 "Value of r(Q/gamma) for inlet Ce1";
  Real re2 "Value of r(Q/gamma) for inlet Ce2";
  Real re3 "Value of r(Q/gamma) for inlet Ce3";
  Real rm "Value of r(Q/gamma) for inlet Cm";
  Real rd "Value of r(Q/gamma) for outlet Cd";
  Real rs "Value of r(Q/gamma) for outlet Cs";
  Real rv "Value of r(Q/gamma) for outlet Cv";

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol
    "Propri鴩s de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-60,40},{-20,80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propri鴩s de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{0,40},{40,80}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prom
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{0,-80},{40,-40}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ce1 "Feedwater input 1" annotation (
      Placement(transformation(extent={{-110,90},{-90,110}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Cm "Evaporation loop outlet" annotation (
      Placement(transformation(extent={{90,-110},{110,-90}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cd "Evaporation loop inlet" annotation (
      Placement(transformation(extent={{-110,-110},{-90,-90}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cv "Steam outlet" annotation (Placement(
        transformation(extent={{90,90},{110,110}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level "
    annotation (                            layer="icon", Placement(
        transformation(extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth "Thermal input to the liquid"
                                     annotation (Placement(transformation(
          extent={{-10,-60},{10,-40}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cex "Thermal input to the wall"
                           annotation (Placement(transformation(extent={{-10,90},
            {10,110}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{0,-20},{40,20}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ce2 "Feedwater input 2" annotation (
      Placement(transformation(extent={{-110,30},{-90,50}}, rotation=0),
        iconTransformation(extent={{-110,30},{-90,50}})));
  Interfaces.Connectors.FluidInlet Ce3 "Feedwater input 3" annotation (
      Placement(transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cs "Water outlet" annotation (Placement(
        transformation(extent={{90,-50},{110,-30}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      der(P) = 0;
      der(hl) = 0;
      der(hv) = 0;
      der(Vl) = 0;
      der(Tp) = 0;
    else
      P = P0;
      hl = lsat.h;
      hv = vsat.h;
      Vl = Vf0*V;
      der(Tp) = 0;
    end if;
  end if;

equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce1.ftype;
  fluids[3] = Ce2.ftype;
  fluids[4] = Ce3.ftype;
  fluids[5] = Cm.ftype;
  fluids[6] = Cd.ftype;
  fluids[7] = Cs.ftype;
  fluids[8] = Cv.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "DynamicDrum: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.h_vol_1 = 1.e5;
    Ce1.diff_res_1 = 0;
    Ce1.diff_on_1 = false;
    Ce1.ftype = ftype;
    Ce1.Xco2 = 0;
    Ce1.Xh2o = 1;
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
    Ce2.Xh2o = 1;
    Ce2.Xo2 = 0;
    Ce2.Xso2 = 0;
  end if;

  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.h = 1.e5;
    Ce3.h_vol_1 = 1.e5;
    Ce3.diff_res_1 = 0;
    Ce3.diff_on_1 = false;
    Ce3.ftype = ftype;
    Ce3.Xco2 = 0;
    Ce3.Xh2o = 1;
    Ce3.Xo2 = 0;
    Ce3.Xso2 = 0;
  end if;

  if (cardinality(Cm) == 0) then
    Cm.Q = 0;
    Cm.h = 1.e5;
    Cm.h_vol_1 = 1.e5;
    Cm.diff_res_1 = 0;
    Cm.diff_on_1 = false;
    Cm.ftype = ftype;
    Cm.Xco2 = 0;
    Cm.Xh2o = 1;
    Cm.Xo2 = 0;
    Cm.Xso2 = 0;
  end if;

  if (cardinality(Cd) == 0) then
    Cd.Q = 0;
    Cd.h_vol_2 = 1.e5;
    Cd.diff_res_2 = 0;
    Cd.diff_on_2 = false;
  end if;

  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h_vol_2 = 1.e5;
    Cs.diff_res_2 = 0;
    Cs.diff_on_2 = false;
  end if;

  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h_vol_2 = 1.e5;
    Cv.diff_res_2 = 0;
    Cv.diff_on_2 = false;
  end if;

  /* Liquid volume */
  if Vertical then
     theta = 1;
     Al = pi*R^2;
     Vl = Al*zl;
     Avl = Al;
  else
     theta = Modelica.Math.asin(max(-0.9999,min(0.9999,(R - zl)/R)));
     Al = (pi/2 - theta)*R^2 - R*(R - zl)*Modelica.Math.cos(theta);
     Vl = Al*L;
     Avl = 2*R*Modelica.Math.cos(theta)*L;
  end if;

  /* Drum volume */
  Vl + Vv = V;

  /* Liquid level */
  yLevel.signal = zl;

  /* Liquid surface and vapor surface on contact with wall */
  Alp = if Vertical then 2*pi*R*zl + Al else (pi - 2*theta)*R*L + 2*Al;
  Avp = if Vertical then 2*pi*R*(L - zl) + Al else (pi + 2*theta)*R*L + 2*Al;

  /* Wall surface on contact with the outside */
  Ape = Alp + Avp;

  /* Pressure at the bottom of the drum */
  Pfond = P + prod.d*g*zl;

  /* Liquid phase mass balance equation */
  BQl = Ce1.Q + Ce2.Q + Ce3.Q - Cd.Q - Cs.Q + (1 - xmv)*Cm.Q + Qcond - Qevap;

  if dynamic_energy_balance then
    rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
  else
    0 = BQl;
  end if;

  /* Gas phase mass balance equation */
  BQv = xmv*Cm.Q - Cv.Q + Qevap - Qcond;

  if dynamic_energy_balance then
    rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
  else
    0 = BQv;
  end if;

  /* Condensation and evaporation mass flow rates */
  Qcond = if noEvent(xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if noEvent(xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;

  Ce1.P = P;
  Ce2.P = P;
  Ce3.P = P;
  Cm.P = P;
  Cd.P = Pfond;
  Cs.P = P;
  Cv.P = P;

  /* Liquid phase energy balance equation */
  BHl = Ce1.Q*(Ce1.h - (hl - P/rhol)) + Ce2.Q*(Ce2.h - (hl - P/rhol)) + Ce3.Q*(Ce3.h - (hl - P/rhol))
    - Cd.Q*(Cd.h - (hl - P/rhol)) - Cs.Q*(Cs.h - (hl - P/rhol))
    + (1 - xmv)*Cm.Q*((if (xmv > 0) then lsat.h else Cm.h) - (hl - P/rhol))
    + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + Wlv - Wpl + Cth.W + Jt_l;

  if dynamic_energy_balance then
    Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
  else
    0 = BHl;
  end if;

  /* Gas phase energy balance equation */
  BHv = xmv*Cm.Q*((if (xmv < 1) then vsat.h else Cm.h) - (hv - P/rhov))
     - Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov))
     - Wlv - Wpv + Jt_v;

  if dynamic_energy_balance then
    Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  else
    0 = BHv;
  end if;

  Ce1.h_vol_2 = hl;
  Ce2.h_vol_2 = hl;
  Ce3.h_vol_2 = hl;
  Cm.h_vol_2 = hl;
  Cd.h_vol_1 = noEvent(min(lsat.h, hl));
  Cs.h_vol_1 = hl;
  Cv.h_vol_1 = hv;

  /* Energy balance equation at the wall */
  if dynamic_energy_balance then
    Mp*cpp*der(Tp) = Wpl + Wpv + Wpa;
  else
    0 = Wpl + Wpv + Wpa;
  end if;

  /* Heat exchange between liquid and gas phases */
  Wlv = Kvl*Avl*(Tv - Tl);

  /* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Alp*(Tl - Tp);

  /* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Avp*(Tv - Tp);

  /* Heat exchange between the wall and the outside */
  Wpa = Kpa*Ape*(Ta - Tp);

  /* Fluid composition (no balance equations) */
  Cd.ftype = ftype;
  Cs.ftype = ftype;
  Cv.ftype = ftype;

  Cd.Xco2 = 0;
  Cd.Xh2o = 1;
  Cd.Xo2  = 0;
  Cd.Xso2 = 0;
  Cs.Xco2 = 0;
  Cs.Xh2o = 1;
  Cs.Xo2  = 0;
  Cs.Xso2 = 0;
  Cv.Xco2 = 0;
  Cv.Xh2o = 1;
  Cv.Xo2  = 0;
  Cv.Xso2 = 0;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cd.h = ThermoSysPro.Functions.SmoothCond(Cd.Q/gamma_d, Cd.h_vol_1, Cd.h_vol_2, 1);
    Cs.h = ThermoSysPro.Functions.SmoothCond(Cs.Q/gamma_s, Cs.h_vol_1, Cs.h_vol_2, 1);
    Cv.h = ThermoSysPro.Functions.SmoothCond(Cv.Q/gamma_v, Cv.h_vol_1, Cv.h_vol_2, 1);
  else
    Cd.h = if (Cd.Q > 0) then Cd.h_vol_1 else Cd.h_vol_2;
    Cs.h = if (Cs.Q > 0) then Cs.h_vol_1 else Cs.h_vol_2;
    Cv.h = if (Cv.Q > 0) then Cv.h_vol_1 else Cv.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re1 = if Ce1.diff_on_1 then exp(-0.033*(Ce1.Q*Ce1.diff_res_1)^2) else 0;
    re2 = if Ce2.diff_on_1 then exp(-0.033*(Ce2.Q*Ce2.diff_res_1)^2) else 0;
    re3 = if Ce3.diff_on_1 then exp(-0.033*(Ce3.Q*Ce3.diff_res_1)^2) else 0;
    rm = if Cm.diff_on_1 then exp(-0.033*(Cm.Q*Cm.diff_res_1)^2) else 0;
    rd = if Cd.diff_on_2 then exp(-0.033*(Cd.Q*Cd.diff_res_2)^2) else 0;
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;
    rv = if Cv.diff_on_2 then exp(-0.033*(Cv.Q*Cv.diff_res_2)^2) else 0;

    gamma_e1 = if Ce1.diff_on_1 then 1/Ce1.diff_res_1 else gamma0;
    gamma_e2 = if Ce2.diff_on_1 then 1/Ce2.diff_res_1 else gamma0;
    gamma_e3 = if Ce3.diff_on_1 then 1/Ce3.diff_res_1 else gamma0;
    gamma_m = if Cm.diff_on_1 then 1/Cm.diff_res_1 else gamma0;
    gamma_d = if Cd.diff_on_2 then 1/Cd.diff_res_2 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;
    gamma_v = if Cv.diff_on_2 then 1/Cv.diff_res_2 else gamma0;

    Je1 = if Ce1.diff_on_1 then re1*gamma_e1*(Ce1.h_vol_1 - Ce1.h_vol_2) else 0;
    Je2 = if Ce2.diff_on_1 then re2*gamma_e2*(Ce2.h_vol_1 - Ce2.h_vol_2) else 0;
    Je3 = if Ce3.diff_on_1 then re3*gamma_e3*(Ce3.h_vol_1 - Ce3.h_vol_2) else 0;
    Jm = if Cm.diff_on_1 then rm*gamma_m*(Cm.h_vol_1 - Cm.h_vol_2) else 0;
    Jd = if Cd.diff_on_2 then rd*gamma_d*(Cd.h_vol_2 - Cd.h_vol_1) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
    Jv = if Cv.diff_on_2 then rv*gamma_v*(Cv.h_vol_2 - Cv.h_vol_1) else 0;
  else
    re1 = 0;
    re2 = 0;
    re3 = 0;
    rm = 0;
    rd = 0;
    rs = 0;
    rv = 0;

    gamma_e1 = gamma0;
    gamma_e2 = gamma0;
    gamma_e3 = gamma0;
    gamma_m = gamma0;
    gamma_d = gamma0;
    gamma_s = gamma0;
    gamma_v = gamma0;

    Je1 = 0;
    Je2 = 0;
    Je3 = 0;
    Jm = 0;
    Jd = 0;
    Js = 0;
    Jv = 0;
  end if;

  Jt_l = Je1 + Je2 + Je3 + Jm + Jd + Js;
  Jt_v = Jv;

  Ce1.diff_res_2 = 0;
  Ce2.diff_res_2 = 0;
  Ce3.diff_res_2 = 0;
  Cm.diff_res_2 = 0;
  Cd.diff_res_1 = 0;
  Cs.diff_res_1 = 0;
  Cv.diff_res_1 = 0;

  Ce1.diff_on_2 = diffusion;
  Ce2.diff_on_2 = diffusion;
  Ce3.diff_on_2 = diffusion;
  Cm.diff_on_2 = diffusion;
  Cd.diff_on_1 = diffusion;
  Cs.diff_on_1 = diffusion;
  Cv.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  prol = ThermoSysPro.Properties.Fluid.Ph(P, hl, 0, fluid);
  prov = ThermoSysPro.Properties.Fluid.Ph(P, hv, 0, fluid);
  prod = ThermoSysPro.Properties.Fluid.Ph(Pfond, Cd.h, 0, fluid);
  prom = ThermoSysPro.Properties.Fluid.Ph(P, Cm.h, 0, fluid);
  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P, fluid);

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  xmv = if noEvent(Cm.Q > 0) then prom.x else 0;

  Cth.T = Tl;
  Cex.T = Ta;
  Cex.W = Wpa;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,100},{-68,100},{-60,80}}),
        Line(points={{-90,-100},{-68,-100},{-60,-80}}),
        Line(points={{62,80},{70,100},{90,100}}),
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
        Line(points={{60,-80},{72,-100},{90,-100}}),
        Polygon(
          points={{0,100},{-20,98},{-40,92},{-60,80},{-80,60},{-92,40},{-98,20},
              {-100,0},{-98,-20},{98,-20},{100,0},{98,20},{92,40},{80,60},{60,
              80},{40,92},{20,98},{0,100}},
          lineColor={28,108,200},
          fillColor=DynamicSelect({170,213,255},
          if dynamic_energy_balance then {170,213,255}
          else if diffusion then {213,255,170}
          else {255,255,170}),
          fillPattern=DynamicSelect(FillPattern.Sphere,
          if dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid))}),
    Window(
      x=0.16,
      y=0.04,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end DynamicDrum;
