within ThermoSysPro.WaterSteam.Volumes;
model TwoPhaseCavity "TwoPhaseCavity for one shell pass "
  parameter Boolean Vertical=true
    "true: vertical cylinder - false: horizontal cylinder";
  parameter Modelica.SIunits.Radius R=1.05
    "Radius of the Cavity cross-sectional area";
  parameter Modelica.SIunits.Length Lc=2.5
    "support plate spacing in cooling zone(Chicanes)";
  parameter Modelica.SIunits.Volume V=50
    "Cavity volume ( total volume + bleedings volume - pipes volume) ";
  parameter Modelica.SIunits.Volume Vmin=1.e-6;
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the Cavity (active if steady_state=false)";
  parameter Integer Ns=10 "Number of segments for one tube pass";
  parameter Integer NbTub1=500
    "Numbers of drowned pipes in liquid; Pipe 1 (Hoizontal, Vertical Separate)";
  parameter Integer NbTub2=500 "Number of total pipes immersed in steam = NbTub2; Pipe 2";
  parameter Integer NbTub3=2000 "Number of total pipes immersed in steam ; Pipe 3";
  parameter Integer NbTubV=15 "Numbers of pipes in a vertical row (tube bank)";
  parameter Modelica.SIunits.Length L1=10
    " Length of drowned pipes in liquid (pipes 1)";
  parameter Modelica.SIunits.Length L2=10 " Length of Pipe 2 (in steam)";
  parameter Modelica.SIunits.Length L3=20 " Length of Pipe 3 (in steam)";
  parameter Modelica.SIunits.Diameter Dext=0.02 "External pipe diameter";
  parameter Modelica.SIunits.Diameter DIc=1.40 "Internal calendre diameter";
  parameter Modelica.SIunits.Length PasL = 0.025
    "Longitudianl step or Length bottom pipes triangular step";
  parameter Modelica.SIunits.Length PasT = 0.023
    " Transverse step or pipes step";
  //parameter Modelica.SIunits.Angle Angle = 60 "Average bend angle (deg)";
  parameter ThermoSysPro.Units.Angle_deg Angle = 60 "Average bend angle (deg)";
  parameter Modelica.SIunits.Pressure P0=1e5
    "Fluid initial pressure (active if steady_state=false)";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025
    "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975
    "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  //parameter Real Kvl=1000
  // "Heat exchange coefficient between the liquid and gas phases";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Vl0)";
  parameter Real COPv( start=1)= 1
    "Corrective terme for Heat exchange coefficient or Fouling coefficient steam side";
  parameter Real COPl(start=1) = 1
    "Corrective terme for Heat exchange coefficient or Fouling coefficient liquid side";
  parameter Boolean Cal_hconv=true
    "false : heat transfer coefficient liquid and steam = parameter  - true: calculate by Nusselt corelation";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hliq=1.5e3
    "Heat transfer coefficient between the liquid and the cooling pipes ";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hcond=8e3
    "Heat transfer coefficient between the vapor and the cooling pipes ";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kvl=1000
    "Heat exchange coefficient between the liquid and gas phases";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Klp=850
    "Heat exchange coefficient between the liquid phase and the wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kvp=450
    "Heat exchange coefficient between the gas phase and the wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kpa=0.5
    "Heat exchange coefficient between the wall and the outside ambiant";
  parameter Modelica.SIunits.Temperature Ta = 310 "External temperature";
  parameter Modelica.SIunits.Mass Mp=100e3 "Wall mass";
  parameter Modelica.SIunits.SpecificHeatCapacity cpp=600 "Wall specific heat";

//***********************************
  parameter Boolean step_square=true
    "true: Aligned pipes   - false: staggered pipes (Step triangular)";

//protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi;
  parameter Integer Ns3=2*Ns "Number of segments for half pipes";
  //parameter Modelica.SIunits.PathLength Ls1=L1/Ns "Section length for one pass pipe";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h4 = 1
    "h4 = 1, Heat exchange coefficient";
  parameter Modelica.SIunits.Area S4 = 1 " S4 = 1, Heat exchange surface  ";

public
  Modelica.SIunits.Length L(start=15) "Cavity length";
  Integer NbTubT "Number of total pipes in Cavity";
  Modelica.SIunits.Pressure P "Fluid average pressure";
  Modelica.SIunits.Pressure Pfond "Fluid pressure at the bottom of the cavity";
  Modelica.SIunits.SpecificEnthalpy hl "Liquid phase spepcific enthalpy";
  //Modelica.SIunits.SpecificEnthalpy hl0 "Liquid phase spepcific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv "Gas phase spepcific enthalpy";
  Modelica.SIunits.Temperature Tl "Liquid phase temperature";
  Modelica.SIunits.Temperature Tv "Gas phase temperature";
  Modelica.SIunits.Volume Vl "Liquid phase volume";
  Modelica.SIunits.Volume Vv "Gas phase volume";

  Real xl(start=0.5) "Mass vapor fraction in the liquid phase";
  Real xv(start=0) "Mass vapor fraction in the gas phase";
  Modelica.SIunits.Density rhol(start=996) "Liquid phase density";
  Modelica.SIunits.Density rhov(start=1.5) "Gas phase density";
  Modelica.SIunits.MassFlowRate BQl
    "Right hand side of the mass balance equation of the liquid phase";
  Modelica.SIunits.MassFlowRate BQv
    "Right hand side of the mass balance equation of the gas phaser";
  Modelica.SIunits.Power BHl
    "Right hand side of the energy balance equation of the liquid phase";
  Modelica.SIunits.Power BHv
    "Right hand side of the energy balance equation of the gas phase";
  Modelica.SIunits.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase";
  Modelica.SIunits.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase";
  Real QS "Surface mass flow rate of Water (kg/m2s)";
  //Real QSm "Surface mass flow rate maximal of Water (kg/m2s)";

  Modelica.SIunits.Power dW1[Ns](start=fill(10e5, Ns))
    "Power exchange between the wall and the fluid in each section side 1";
  Modelica.SIunits.Power dW2[Ns](start=fill(10e5, Ns))
    "Power exchange between the wall and the fluid in each section side 2";
  Modelica.SIunits.Power dW3[Ns3](start=fill(10e5, Ns3))
    "Power exchange between the wall and the fluid in each section side 3";

  Modelica.SIunits.Power W1t "Total power exchanged on the steam side 1";
  Modelica.SIunits.Power W2t "Total power exchanged on the water side 2";
  Modelica.SIunits.Power W3t "Total power exchanged on the water side 3";
  Modelica.SIunits.Power W4t "Total power exchanged on the steam side 4";
  Modelica.SIunits.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase";
  Modelica.SIunits.Power Wpl
    "Thermal power exchanged from the liquid phase to the wall";
  Modelica.SIunits.Power Wpv
    "Thermal power exchanged from the gas phase to the wall";
  Modelica.SIunits.Power Wpa "Thermal power losses to ambiant";
  Modelica.SIunits.Temperature Tp1[Ns](start=fill(400, Ns))
    "Wall temperature in section i of side 1";
  Modelica.SIunits.Temperature Tp2[Ns](start=fill(400, Ns))
    "Wall temperature in section i of side 2";
  Modelica.SIunits.Temperature Tp3[Ns3](start=fill(400, Ns3))
    "Wall temperature in section i of side 3";
  Modelica.SIunits.Temperature Tp( start= 400) "Wall temperature of cavity";
  Modelica.SIunits.Position zl(start=1.05) "Liquid level in Cavity";
  Modelica.SIunits.Area Al(start=5) "Cross sectional area of the liquid phase";
  Modelica.SIunits.Angle theta "Angle";
  Modelica.SIunits.Area Avl(start=5)
    "Heat exchange surface between the liquid and gas phases";
  Modelica.SIunits.Area Alp "Liquid phase surface on contact with the wall";
  Modelica.SIunits.Area Avp "Gas phase surface on contact with the wall";
  Modelica.SIunits.Area Ape "Wall surface on contact with the fluid";
  Modelica.SIunits.Area Surf_tot( start= 1.e4) "Total heat exchange surface";
  Modelica.SIunits.Area Surf_ext1( start= 1.e2)
    "Heat exchange surface for drowned section ; pipe 1";
  Modelica.SIunits.Area Surf_ext2( start= 1.e2)
    "Heat exchange surface for section 2 ; pipe 2 ";
  Modelica.SIunits.Area Surf_ext3( start= 1.e2)
    "Heat exchange surface for section 3 ; pipe 3";
  //Modelica.SIunits.ReynoldsNumber Rel (start= 6.e4)  "liquid Reynolds number";
  Modelica.SIunits.ReynoldsNumber Rel( start= 6.e4) "liquid Reynolds number";
  // Modelica.SIunits.ReynoldsNumber Rev( start= 6.e3) "Steam Reynolds number";
  Real Prl(start=1) "liquid Prandtl number in node i";
  Modelica.SIunits.ThermalConductivity kl(start=1)
    "liquid thermal conductivity";
  Modelica.SIunits.DynamicViscosity mul(start=2.e-4)
    "liquid dynamic viscosity ";
  Modelica.SIunits.DynamicViscosity mult[Ns](start=fill(2.e-4, Ns))
    "liquid dynamic viscosity at wall temperature";
  Modelica.SIunits.CoefficientOfHeatTransfer hcond2[Ns](start=fill(1e4, Ns))
    "Heat transfer coefficient between the vapor and the cooling pipes zone 2";
  Modelica.SIunits.CoefficientOfHeatTransfer hcond3[Ns3](start=fill(1e4, Ns3))
    "Heat transfer coefficient between the vapor and the cooling pipes zone 3";
  Modelica.SIunits.CoefficientOfHeatTransfer hliqu[Ns](start=fill(1000, Ns))
    "Heat transfer coefficient between the liquid and the cooling pipes zone 1";
  Modelica.SIunits.Diameter DH(start=0.02) "hydraulic diameter";
  Real EE[Ns](start=fill(1, Ns));

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol
    "Propriétés de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-250,70},{-210,110}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propriétés de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{60,70},{100,110}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-250,-200},{-210,-160}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{58,-200},{98,-160}}, rotation=0)));
  Connectors.FluidInlet Cv "Steam input"
                                    annotation (Placement(transformation(extent=
           {{-86,50},{-66,70}}, rotation=0)));
  Connectors.FluidOutlet Cl "Water output"
                                     annotation (Placement(transformation(
          extent={{-86,-170},{-66,-150}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth3[Ns3]
                                     annotation (Placement(transformation(
          extent={{-59,-37},{-47,-25}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{90,-105},{110,-85}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-250,-20},{-210,20}},
          rotation=0)));
  Connectors.FluidInlet Ce "Water input"
                                    annotation (Placement(transformation(extent=
           {{-160,50},{-140,70}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth1[Ns]
                                     annotation (Placement(transformation(
          extent={{-59,-103},{-47,-90}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth2[Ns]
                                     annotation (Placement(transformation(
          extent={{-59,35},{-47,48}}, rotation=0)));

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-250,-110},{-210,-70}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph provIn
    "Propriétés de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{12,70},{52,110}}, rotation=0)));
initial equation
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

equation
  /* Unconnected connectors */
  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h = 1.e5;
    Cl.a = true;
  end if;

  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.b = true;
  end if;

  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.h = 1.e5;
    Ce.b = true;
  end if;

  /* Wall temperature and HeatFlowRate*/
  Cth1.T = Tp1;
  Cth1.W = dW1;
  Cth2.T = Tp2;
  Cth2.W = dW2;
  Cth3.T = Tp3;
  Cth3.W = dW3;

  /* Model boundaries */
  Cl.P = Pfond;
  Cv.P = P;
  Ce.P = P;

  /* Cavity length */
  V=pi*R*R*L;

  /* Liquid volume */
  if Vertical then
     theta = 1;
     Al = pi*R^2;
     Vl = Al*zl;
     Avl = Al;
     NbTubT = NbTub1;
  else
     theta = Modelica.Math.asin(max(-0.9999,min(0.9999,(R - zl)/R)));
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
  rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;

  /* Vapor phase mass balance equation */
  BQv = Cv.Q + Qevap - Qcond + proe.x*Ce.Q;
  rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;

  /* Liquid phase energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + (1 - proe.x)*Ce.Q*((if (proe.x > 0) then lsat.h else Ce.h) - (hl - P/rhol)) - Wpl + Wvl + W1t;
  Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;

  /* Gas phase energy balance equation */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) + proe.x*Ce.Q*((if (proe.x < 1) then vsat.h else Ce.h) - (hv - P/rhov)) - Wvl - Wpv + W2t + W3t;
  Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;

  Cl.h_vol = hl;
  Ce.h_vol = hl;
  Cv.h_vol = hv;

  /* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wpl + Wpv - Wpa;

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

  /* Fluid thermodynamic properties */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Ce.h, 0);
  //prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hl, 0);
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((P+Pfond)/2, hl, 0);
  provIn = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Cv.h, 0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv, 0);
  prod = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pfond, Cl.h, 0);
  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  mul = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhol, Tl);
  kl = noEvent(ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhol, Tl,P, 0));

  /* Heat transfer coefficient of fluid
                   And
     Power exchanged for each section
    ----------------------------------*/
  /* Heat transfer coefficient of liquid*/
  //SACADOURA
  DH= if step_square then 4*PasL^2/(pi*Dext) - Dext else ( (2*PasL*PasT) - (pi*Dext^2*(Angle/120)))/(pi*Dext*(Angle/120));

  QS = Cl.Q /(DIc*Lc*(PasL - Dext)/PasL);

  Rel = noEvent( abs(QS*DH/mul));
  Prl = mul*prol.cp/kl;

  assert( (PasL - Dext) > 0,  "Error Data for TwoPhaseCavity model (PasL - Dext)<=0 ");

  for i in 1:Ns loop

    mult[i] = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhol, Tp1[i]);

    EE[i]= max( (PasT/Dext-1/2/((((PasL/Dext)^2 + (PasT/Dext/2)^2)^0.5/Dext)-1)),1);

    /* Heat transfer coefficient of liquid*/
    if Cal_hconv then
       // Kern corelation (SACADOURA)
       hliqu[i] = noEvent(if ((Rel > 1.e-6) and (Prl > 1.e-6)) then (COPl * 0.36*kl/Dext *Rel^0.55 *Prl^0.3333 *(mul/mult[i])^0.14) else  10);
    else
       hliqu[i] = COPl * hliq;
    end if;

    if Cal_hconv then
       /* Heat transfer coefficient of vapeur*/
       if Vertical then
         // Frank P. & David P. Fundamentals of Heat Transfer  For (PasL/Dext)= 1.4
         hcond2[i]  = COPv * noEvent( min( 1.13*( max( (g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h -lsat.h))/(max(L2,1)*mul*abs(lsat.T-Tp2[i]+1e-6)),2.225e15))^0.25, 20000));
       else
         // Nusselt corelation
         //******************
         hcond2[i]  =  COPv * noEvent( min( 0.728*( max( (g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h -lsat.h))/(NbTubV*mul*Dext*abs(lsat.T-Tp2[i]+1e-6)),2.225e15))^0.25, 20000));
       end if;
    else
       hcond2[i] = COPv * hcond;
    end if;

    /* Power exchanged for each section zone 1*/
    if (noEvent( abs(dW1[i]) < 0.1)) then
       dW1[i] = - h4*S4*(Tv - Tp1[i]);
    else
       dW1[i] = - hliqu[i]*Surf_ext1 *((Tv+Tl)/2 - (Tp1[1]+Tp1[Ns])/2);
    end if;

    /* Power exchanged for each section zone 2*/
    if (noEvent( abs(dW2[i]) < 0.1)) then
       dW2[i] = - h4*S4*(Tv - Tp2[i]);
    else
       dW2[i] = - hcond2[i]*Surf_ext2*(Tv - Tp2[i]);
    end if;

  end for;

  for i in 1:Ns3 loop
    if Cal_hconv then
       /* Heat transfer coefficient of vapeur*/
       if Vertical then
          // Frank P. & David P. Fundamentals of Heat Transfer  For vertical plate
          hcond3[i]  = COPv * noEvent( min( 1.13*( max( (g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h -lsat.h))/(max(L3,1)*mul*abs(lsat.T-Tp3[i]+1e-6)), 2.225e15))^0.25, 20000));
       else
          // Nusselt corelation
          //******************
          hcond3[i]  =  COPv * noEvent( min( 0.728*( max( (g*lsat.rho*(lsat.rho - vsat.rho)*kl^3*(vsat.h -lsat.h))/(NbTubV*mul*Dext*abs(lsat.T-Tp3[i]+1e-6)), 2.225e15))^0.25, 20000));
       end if;
    else
       hcond3[i] = COPv * hcond;
    end if;

    /* Power exchanged for each section  zone 3 + power exchanged for Deheating*/
    if (noEvent( abs(dW3[i]) < 0.1)) then
       dW3[i] = - h4*S4*(Tv - Tp3[i]);
    else
       dW3[i] = - hcond3[i]*Surf_ext3*(Tv - Tp3[i]) + W4t/Ns3;
    end if;

  end for;

  W1t = sum(dW1);
  W2t = sum(dW2);
  W3t = sum(dW3);

  /* Total power exchanged for Deheating*/
  W4t = noEvent( if ( Cv.h > vsat.h) then - Cv.Q*(Cv.h - vsat.h) else -0.0001);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-250,-200},{100,100}},
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
               "Pipe 4"),
        Text(
          extent={{-132,-36},{38,-50}},
          lineColor={0,0,255},
          textString=
               "Connected here for one pipe only")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-250,-200},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Ellipse(
          extent={{-100,50},{100,-150}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-250,50},{-50,-150}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-160,50},{8,-150}},
          lineColor={255,255,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-250,-48},{-160,-48}}, color={255,255,0}),
        Line(
          points={{-160,-48},{100,-48}},
          color={255,255,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,50},{-160,-150}},
          color={255,255,0},
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
          points={{-160,-118},{72,-118}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-132},{56,-132}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-150},{8,-150}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-136,-12},{34,-26}},
          lineColor={0,0,255},
          textString=
               "Connected here for one pipe only")}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 14.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end TwoPhaseCavity;
