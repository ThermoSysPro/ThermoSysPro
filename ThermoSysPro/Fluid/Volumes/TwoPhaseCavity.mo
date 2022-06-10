within ThermoSysPro.Fluid.Volumes;
model TwoPhaseCavity "TwoPhaseCavity for one shell pass "
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Boolean Vertical=true "true: vertical cylinder - false: horizontal cylinder";
  parameter Units.SI.Radius R=1.05 "Radius of the Cavity cross-sectional area";
  parameter Units.SI.Length Lc=2.5
    "Support plate spacing in cooling zone(chicanes)";
  parameter Units.SI.Volume V=50
    "Cavity volume (= total volume + bleeding volume - pipe volume) ";
  parameter Units.SI.Volume Vmin=1.e-6;
  parameter Integer Ns=10 "Number of segments for one tube pass";
  parameter Integer NbTub1=500 "Numbers of drowned pipes in liquid; Pipe 1 (Hoizontal, Vertical Separate)";
  parameter Integer NbTub2=500 "Number of total pipes immersed in steam = NbTub2; Pipe 2";
  parameter Integer NbTub3=2000 "Number of total pipes immersed in steam ; Pipe 3";
  parameter Integer NbTubV=15 "Numbers of pipes in a vertical row (tube bank)";
  parameter Units.SI.Length L1=10 "Length of drowned pipes in liquid (pipes 1)";
  parameter Units.SI.Length L2=10 "Length of Pipe 2 (in steam)";
  parameter Units.SI.Length L3=20 "Length of Pipe 3 (in steam)";
  parameter Units.SI.Diameter Dext=0.02 "External pipe diameter";
  parameter Units.SI.Diameter DIc=1.40 "Internal calendre diameter";
  parameter Units.SI.Length PasL=0.025
    "Longitudinal step or length bottom pipes triangular step";
  parameter Units.SI.Length PasT=0.023 "Transverse step or pipes step";
  parameter ThermoSysPro.Units.nonSI.Angle_deg Angle=60
    "Average bend angle (deg)";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025 "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975 "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Real COPl(start=1)=1 "Corrective terme for the heat exchange coefficient or the fouling coefficient of the liquid side";
  parameter Real COPv( start=1)=1 "Corrective terme for heat exchange coefficient or the fouling coefficient of the steam side";
  parameter Boolean Cal_hconv=true "false: heat transfer coefficient liquid and steam given by parameter COPl and COPv- true: calculated using the Nusselt correlation";
  parameter Units.SI.CoefficientOfHeatTransfer hliq=1.5e3
    "Heat transfer coefficient between the liquid and the cooling pipes ";
  parameter Units.SI.CoefficientOfHeatTransfer hcond=8e3
    "Heat transfer coefficient between the vapor and the cooling pipes ";
  parameter Units.SI.CoefficientOfHeatTransfer Kvl=1000
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.CoefficientOfHeatTransfer Klp=850
    "Heat exchange coefficient between the liquid phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kvp=450
    "Heat exchange coefficient between the gas phase and the wall";
  parameter Units.SI.CoefficientOfHeatTransfer Kpa=0.5
    "Heat exchange coefficient between the wall and the outside ambiant";
  parameter Units.SI.Temperature Ta=310 "External temperature";
  parameter Units.SI.Mass Mp=100e3 "Wall mass";
  parameter Units.SI.SpecificHeatCapacity cpp=600 "Wall specific heat";
  parameter Boolean step_square=true "true: aligned pipes - false: staggered pipes (triangular step)";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Vf0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the drum (active if dynamic_energy_balance=true and steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0=1.e5
    "Fluid initial pressure (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi;
  parameter Integer Ns3=2*Ns "Number of segments for half pipes";
  parameter Integer fluid=Integer(ftype) "Fluid number";
  parameter Units.SI.CoefficientOfHeatTransfer h4=1 "Heat exchange coefficient";
  parameter Units.SI.Area S4=1 "Heat exchange surface";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";

public
  Units.SI.Length L(start=15) "Cavity length";
  Integer NbTubT "Number of total pipes in Cavity";
  Units.SI.Pressure P "Fluid average pressure";
  Units.SI.Pressure Pfond "Fluid pressure at the bottom of the cavity";
  Units.SI.SpecificEnthalpy hl "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv "Gas phase specific enthalpy";
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
  Real QS "Surface mass flow rate of Water (kg/m2s)";
  Units.SI.Power dW1[Ns](start=fill(10e5, Ns))
    "Power exchange between the wall and the fluid in each section side 1";
  Units.SI.Power dW2[Ns](start=fill(10e5, Ns))
    "Power exchange between the wall and the fluid in each section side 2";
  Units.SI.Power dW3[Ns3](start=fill(10e5, Ns3))
    "Power exchange between the wall and the fluid in each section side 3";
  Units.SI.Power W1t "Total power exchanged on the steam side 1";
  Units.SI.Power W2t "Total power exchanged on the water side 2";
  Units.SI.Power W3t "Total power exchanged on the water side 3";
  Units.SI.Power W4t "Total power exchanged on the steam side 4";
  Units.SI.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase";
  Units.SI.Power Wpl
    "Thermal power exchanged from the liquid phase to the wall";
  Units.SI.Power Wpv "Thermal power exchanged from the gas phase to the wall";
  Units.SI.Power Wpa "Thermal power losses to ambiant";
  Units.SI.Temperature Tp1[Ns](start=fill(400, Ns))
    "Wall temperature in section i of side 1";
  Units.SI.Temperature Tp2[Ns](start=fill(400, Ns))
    "Wall temperature in section i of side 2";
  Units.SI.Temperature Tp3[Ns3](start=fill(400, Ns3))
    "Wall temperature in section i of side 3";
  Units.SI.Temperature Tp(start=400) "Wall temperature of cavity";
  Units.SI.Position zl(start=1.05) "Liquid level in Cavity";
  Units.SI.Area Al(start=5) "Cross sectional area of the liquid phase";
  Units.SI.Angle theta "Angle";
  Units.SI.Area Avl(start=5)
    "Heat exchange surface between the liquid and gas phases";
  Units.SI.Area Alp "Liquid phase surface on contact with the wall";
  Units.SI.Area Avp "Gas phase surface on contact with the wall";
  Units.SI.Area Ape "Wall surface on contact with the fluid";
  Units.SI.Area Surf_tot(start=1.e4) "Total heat exchange surface";
  Units.SI.Area Surf_ext1(start=1.e2)
    "Heat exchange surface for drowned section ; pipe 1";
  Units.SI.Area Surf_ext2(start=1.e2)
    "Heat exchange surface for section 2 ; pipe 2 ";
  Units.SI.Area Surf_ext3(start=1.e2)
    "Heat exchange surface for section 3 ; pipe 3";
  Units.SI.ReynoldsNumber Rel(start=6.e4) "liquid Reynolds number";
  Real Prl(start=1) "liquid Prandtl number in node i";
  Units.SI.ThermalConductivity kl(start=1) "liquid thermal conductivity";
  Units.SI.DynamicViscosity mul(start=2.e-4) "liquid dynamic viscosity ";
  Units.SI.DynamicViscosity mult[Ns](start=fill(2.e-4, Ns))
    "liquid dynamic viscosity at wall temperature";
  Units.SI.CoefficientOfHeatTransfer hcond2[Ns](start=fill(1e4, Ns))
    "Heat transfer coefficient between the vapor and the cooling pipes zone 2";
  Units.SI.CoefficientOfHeatTransfer hcond3[Ns3](start=fill(1e4, Ns3))
    "Heat transfer coefficient between the vapor and the cooling pipes zone 3";
  Units.SI.CoefficientOfHeatTransfer hliqu[Ns](start=fill(1000, Ns))
    "Heat transfer coefficient between the liquid and the cooling pipes zone 1";
  Units.SI.Diameter DH(start=0.02) "hydraulic diameter";
  Real EE[Ns](start=fill(1, Ns));
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
          extent={{-250,70},{-210,110}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propri鴩s de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{60,70},{100,110}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-250,-200},{-210,-160}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{58,-200},{98,-160}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Cv "Steam input" annotation (Placement(
        transformation(extent={{-88,50},{-68,70}}, rotation=0),
        iconTransformation(extent={{-88,50},{-68,70}})));
  Interfaces.Connectors.FluidOutlet Cl "Water output" annotation (Placement(
        transformation(extent={{-88,-170},{-68,-150}}, rotation=0),
        iconTransformation(extent={{-88,-170},{-68,-150}})));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth3[Ns3]
                                     annotation (Placement(transformation(
          extent={{-85,-53},{-73,-41}}, rotation=0), iconTransformation(extent=
            {{-85,-53},{-73,-41}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{88,-109},{108,-89}}, rotation=0), iconTransformation(extent={
            {88,-109},{108,-89}})));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-250,-20},{-210,20}},
          rotation=0)));
  Interfaces.Connectors.FluidInlet Ce "Water input" annotation (Placement(
        transformation(extent={{-160,50},{-140,70}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth1[Ns]
                                     annotation (Placement(transformation(
          extent={{-85,-133},{-73,-120}},rotation=0), iconTransformation(extent=
           {{-85,-133},{-73,-120}})));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth2[Ns]
                                     annotation (Placement(transformation(
          extent={{-85,19},{-73,32}}, rotation=0), iconTransformation(extent={{
            -85,19},{-73,32}})));

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-250,-110},{-210,-70}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph provIn
    "Propri鴩s de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{12,70},{52,110}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      der(hl) = 0;
      der(hv) = 0;
      der(Vl) = 0;
      der(P) = 0;
      der(Tp) = 0;
    else
      hl = lsat.h;
      hv = vsat.h;
      Vl = Vf0*V;
      P = P0;
      der(Tp) = 0;
    end if;
  end if;

equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce.ftype;
  fluids[3] = Cv.ftype;
  fluids[4] = Cl.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "TwoPhaseCavity: fluids mixing in volume are not compatible with each other");

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

  /* Wall temperature and heat flow rate*/
  Cth1.T = Tp1;
  Cth1.W = dW1;
  Cth2.T = Tp2;
  Cth2.W = dW2;
  Cth3.T = Tp3;
  Cth3.W = dW3;

  /* Cavity length */
  V = pi*R*R*L;

  /* Liquid volume */
  if Vertical then
     theta = 1;
     Al = pi*R^2;
     Vl = Al*zl;
     Avl = Al;
     NbTubT = NbTub1;
  else
     theta = Modelica.Math.asin(max(-0.9999, min(0.9999,(R - zl)/R)));
     Al = (pi/2 - theta)*R^2 - R*(R - zl)*Modelica.Math.cos(theta);
     Vl = Al*L;
     Avl = 2*R*Modelica.Math.cos(theta)*L;
     NbTubT = NbTub1 + NbTub3;
  end if;

  /* Heat exchange surface*/
  Surf_ext1 = pi*Dext*L1/Ns*NbTub1;
  Surf_ext2 = pi*Dext*L2/Ns*NbTub2;
  Surf_ext3 = pi*Dext*L3/Ns3*NbTub3;
  Surf_tot  = Ns*Surf_ext1 + Ns*Surf_ext2 + Ns3*Surf_ext3;

  /* Cavity volume */
  V = Vl + Vv;

  /* Water leval */
  yLevel.signal = zl;

  /* Liquid surface and vapor surface on contact with wall */
  Alp = if Vertical then 2*sqrt(pi/Al)*Vl + Al else (pi - 2*theta)*R*L + 2*Al;
  Avp = if Vertical then 2*sqrt(pi/Al)*Vv + Al else (pi + 2*theta)*R*L + 2*(pi*R^2 - Al);

  /* Wall surface on contact with the outside */
  Ape = Alp + Avp;

  /* Pressure at the bottom of the cavity */
  Pfond = P + prod.d*g*zl;

  /* Liquid phase mass balance equation */
  BQl = -Cl.Q + Qcond - Qevap + (1 - proe.x)*Ce.Q;

  if dynamic_energy_balance then
    rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
  else
    0 = BQl;
  end if;

  /* Vapor phase mass balance equation */
  BQv = Cv.Q + Qevap - Qcond + proe.x*Ce.Q;

  if dynamic_energy_balance then
    rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
  else
    0 = BQv;
  end if;

  Ce.P = P;
  Cv.P = P;
  Cl.P = Pfond;

  /* Liquid phase energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + (1 - proe.x)*Ce.Q*((if (proe.x > 0) then lsat.h else Ce.h) - (hl - P/rhol)) - Wpl + Wvl + W1t + Jt_l;

  if dynamic_energy_balance then
    Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
  else
    0 = BHl;
  end if;

  /* Gas phase energy balance equation */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) + proe.x*Ce.Q*((if (proe.x < 1) then vsat.h else Ce.h) - (hv - P/rhov)) - Wvl - Wpv + W2t + W3t + Jt_v;

  if dynamic_energy_balance then
    Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  else
    0 = BHv;
  end if;

  Ce.h_vol_2 = hl;
  Cv.h_vol_2 = hv;
  Cl.h_vol_1 = hl;

  /* Energy balance equation at the wall */
  if dynamic_energy_balance then
    Mp*cpp*der(Tp) = Wpl + Wpv - Wpa;
  else
    0 = Wpl + Wpv - Wpa;
  end if;

  /* Heat exchange between liquid and gas phases */
  Wvl = Kvl*Avl*(Tv - Tl);

  /* Heat exchange between the liquid phase and the wall */
  Wpl = Klp*Alp*(Tl - Tp);

  /* Heat exchange between the gas phase and the wall */
  Wpv = Kvp*Avp*(Tv - Tp);

  /* Thermal power losses to ambiant, for simplifid we use the wall surface on contact with the fluid (Ape)*/
  Wpa = Kpa*Ape*(Tp - Ta);

  /* Condensation and evaporation mass flow rates */
  Qcond = if (xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if (xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;

  /* Heat transfer coefficient of fluid 
                   and
     Power exchanged for each section 
    ----------------------------------*/
  /* Heat transfer coefficient of liquid*/
  // Sacadura
  DH = if step_square then 4*PasL^2/(pi*Dext) - Dext else ((2*PasL*PasT) - (pi*Dext^2*(Angle/120)))/(pi*Dext*(Angle/120));

  QS = Cl.Q /(DIc*Lc*(PasL - Dext)/PasL);

  Rel = noEvent( abs(QS*DH/mul));
  Prl = mul*prol.cp/kl;

  assert(PasL - Dext > 0, "Error Data for TwoPhaseCavity model (PasL - Dext)<= 0 ");

  for i in 1:Ns loop
    mult[i] = ThermoSysPro.Properties.Fluid.DynamicViscosity_rhoT(rhol, Tp1[i], fluid);

    EE[i]= max((PasT/Dext - 1/2/((((PasL/Dext)^2 + (PasT/Dext/2)^2)^0.5/Dext) - 1)), 1);

    /* Heat transfer coefficient of liquid*/
    if Cal_hconv then
       // Kern corelation (Sacadura)
       hliqu[i] = noEvent(if ((Rel > 1.e-6) and (Prl > 1.e-6)) then (COPl*0.36*kl/Dext*Rel^0.55*Prl^0.3333*(mul/mult[i])^0.14) else  10);
    else
       hliqu[i] = COPl*hliq;
    end if;

    if Cal_hconv then
       /* Heat transfer coefficient of vapeur*/
       if Vertical then
         // Frank P. & David P. Fundamentals of Heat Transfer  For (PasL/Dext)= 1.4
         hcond2[i] = COPv*noEvent(min(1.13*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(max(L2, 1)*mul*abs(lsat.T - Tp2[i] + 1e-6)), 2.225e15))^0.25, 20000));
       else
         // Nusselt corelation
         hcond2[i] = COPv*noEvent(min(0.728*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(NbTubV*mul*Dext*abs(lsat.T - Tp2[i] + 1e-6)), 2.225e15))^0.25, 20000));
       end if;
    else
       hcond2[i] = COPv*hcond;
    end if;

    /* Power exchanged for each section zone 1*/
    if (noEvent(abs(dW1[i]) < 0.1)) then
       dW1[i] = -h4*S4*(Tv - Tp1[i]);
    else
       dW1[i] = -hliqu[i]*Surf_ext1 *((Tv + Tl)/2 - (Tp1[1] + Tp1[Ns])/2);
    end if;

    /* Power exchanged for each section zone 2*/
    if (noEvent(abs(dW2[i]) < 0.1)) then
       dW2[i] = -h4*S4*(Tv - Tp2[i]);
    else
       dW2[i] = -hcond2[i]*Surf_ext2*(Tv - Tp2[i]);
    end if;
  end for;

  for i in 1:Ns3 loop
    if Cal_hconv then
       /* Heat transfer coefficient of vapeur*/
       if Vertical then
          // Frank P. & David P. Fundamentals of Heat Transfer  For vertical plate
          hcond3[i] = COPv*noEvent(min( 1.13*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(max(L3,1)*mul*abs(lsat.T - Tp3[i] + 1e-6)), 2.225e15))^0.25, 20000));
       else
          // Nusselt corelation
          hcond3[i] = COPv*noEvent(min(0.728*(max((g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h - lsat.h))/(NbTubV*mul*Dext*abs(lsat.T - Tp3[i] + 1e-6)), 2.225e15))^0.25, 20000));
       end if;
    else
       hcond3[i] = COPv*hcond;
    end if;

    /* Power exchanged for each section  zone 3 + power exchanged for Deheating*/
    if (noEvent(abs(dW3[i]) < 0.1)) then
       dW3[i] = -h4*S4*(Tv - Tp3[i]);
    else
       dW3[i] = -hcond3[i]*Surf_ext3*(Tv - Tp3[i]) + W4t/Ns3;
    end if;
  end for;

  W1t = sum(dW1);
  W2t = sum(dW2);
  W3t = sum(dW3);

  /* Total power exchanged for Deheating*/
  W4t = noEvent(if (Cv.h > vsat.h) then -Cv.Q*(Cv.h - vsat.h) else -0.0001);

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
  proe = ThermoSysPro.Properties.Fluid.Ph(P, Ce.h, 0, fluid);
  prol = ThermoSysPro.Properties.Fluid.Ph((P + Pfond)/2, hl, 0, fluid);
  provIn = ThermoSysPro.Properties.Fluid.Ph(P, Cv.h, 0, fluid);
  prov = ThermoSysPro.Properties.Fluid.Ph(P, hv, 0, fluid);
  prod = ThermoSysPro.Properties.Fluid.Ph(Pfond, Cl.h, 0, fluid);
  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P, fluid);

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  mul = ThermoSysPro.Properties.Fluid.DynamicViscosity_rhoT(rhol, Tl, fluid);
  kl = noEvent(ThermoSysPro.Properties.Fluid.ThermalConductivity_rhoT(rhol, Tl, P, 0, fluid));

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-260,-200},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Text(
          extent={{-142,2},{-124,-6}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 3"),
        Text(
          extent={{-164,55},{-88,19}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Horizontal_1pipe"),
        Rectangle(
          extent={{-158,-6},{-102,-10}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-184,16},{-166,16}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-198,-6},{-160,-24}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "in"),
        Line(
          points={{-180,-8},{-162,-8}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-102,-8},{-96,-8},{-96,16},{-160,16},{-170,16}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{-162,28},{-90,-44}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash),
        Text(
          extent={{-182,-56},{-86,-78}},
          lineColor={0,0,255},
          textString=
               "Vertical Separate"),
        Rectangle(
          extent={{-170,-100},{-166,-152}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-114,-76},{-114,-94}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{-116,-100},{-112,-152}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-168,-76},{-168,-94}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.None}),
        Rectangle(
          extent={{-166,-176},{-120,-180}},
          lineColor={0,0,255},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-190,-128},{-172,-136}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 2"),
        Text(
          extent={{-152,-180},{-134,-188}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 1"),
        Text(
          extent={{-111,-122},{-93,-130}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 3"),
        Text(
          extent={{-210,-164},{-172,-182}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "in"),
        Line(
          points={{-168,-150},{-168,-160},{-114,-160},{-114,-150}},
          color={0,0,255},
          pattern=LinePattern.Dash,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-183,-168},{-105,-168}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-182,-96},{-106,-192}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-114,-78},{-114,-72},{-92,-72},{-92,-178},{-120,-178}},
          color={0,0,255},
          pattern=LinePattern.Dash,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-188,-178},{-170,-178}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{12,-54},{54,-70}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Vertical"),
        Rectangle(
          extent={{4,-82},{8,-134}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{6,-58},{6,-76}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{58,-82},{62,-134}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,-60},{60,-78}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.None}),
        Rectangle(
          extent={{10,-142},{56,-146}},
          lineColor={0,0,255},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-16,-104},{2,-112}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 2"),
        Text(
          extent={{16,-162},{42,-154}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 1"),
        Text(
          extent={{65,-112},{83,-120}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 3"),
        Text(
          extent={{-20,-50},{18,-68}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "in"),
        Line(
          points={{6,-134},{6,-144},{60,-144},{60,-134}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-7,-138},{71,-138}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-8,-78},{70,-152}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{2,-20},{58,-24}},
          lineColor={0,0,255},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{32,34},{50,26}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 2"),
        Text(
          extent={{16,-26},{34,-34}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 1"),
        Text(
          extent={{18,10},{36,2}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 3"),
        Text(
          extent={{4,60},{56,34}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Horizontal"),
        Rectangle(
          extent={{2,2},{58,-2}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,26},{58,22}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-24,24},{-6,24}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-36,-22},{-4,-22}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-58,-10},{-20,-28}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "in"),
        Line(
          points={{60,-22},{72,-22},{72,24},{60,24},{58,24}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-20,0},{-2,0}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-20,-22},{-20,-3},{-20,-1}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{58,0},{64,0},{64,12},{-10,12},{-10,24}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{-2,36},{76,-38}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-2,-16},{76,-16}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-160,18},{-142,14}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,26},{20,22}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,-100},{-166,-116}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,-82},{62,-98}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-234,64},{-164,36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe4=deheating pipes"),
        Text(
          extent={{-158,26},{-140,18}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 4"),
        Text(
          extent={{0,34},{18,26}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 4"),
        Text(
          extent={{64,-86},{82,-94}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 4"),
        Text(
          extent={{-190,-104},{-172,-112}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 4")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-260,-200},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Ellipse(
          extent={{-100,50},{100,-150}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-260,50},{-60,-150}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-160,50},{0,-150}},
          lineColor={28,108,200},
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(points={{-260,-48},{-160,-48}}, color={0,0,0}),
        Line(
          points={{-160,-48},{100,-48}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,50},{-160,-150}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-160,-98},{88,-98}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-112},{78,-112}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-126},{66,-126}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-106},{82,-106}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-120},{72,-120}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-132},{56,-132}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-150},{0,-150}},
          color={0,0,255}),
        Line(
          points={{0,50},{0,-150}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-160,-140},{44,-140}},
          color={0,0,255},
          pattern=LinePattern.Dash)}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end TwoPhaseCavity;
