within ThermoSysPro.WaterSteam.Volumes;
model TwoPhaseCavityOnePipe "TwoPhaseCavity for one shell pass "

  parameter Boolean Vertical=true
    "true: vertical cylinder - false: horizontal cylinder";
  parameter Modelica.SIunits.Radius R=1.05
    "Radius of the Cavity cross-sectional area";
  parameter Modelica.SIunits.Length L=16.27 "Cavity length";
  parameter Modelica.SIunits.Length Lc=2.5
    "support plate spacing in cooling zone(Chicanes)";
  parameter Modelica.SIunits.Volume V=pi*R^2*L "Cavity volume";
  parameter Modelica.SIunits.Volume Vmin=1.e-6;
  parameter Real Vf0=0.5
    "Fraction of initial water volume in the Cavity (active if steady_state=false)";
  parameter Integer Ns=10 "Number of segments";
  parameter Integer NbTubT=10000 "Number of total pipes in Cavity";
  parameter Integer NbTubV=150 "Numbers of pipes in a vertical plan in Cavity";
  parameter Modelica.SIunits.Length L2=25 "tubes length";
  parameter Modelica.SIunits.Diameter Dext=0.020 "External pipe diameter";
  parameter Modelica.SIunits.Pressure P0=1e5
    "Fluid initial pressure (active if steady_state=false)";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, Vl0)";
  parameter Real COP = 1
    "Corrective terme for heat exchange coefficient or Fouling coefficient";
  parameter Real Kcorr = 1
    "Corrective terme for heat exchange coefficient between the vapor and the liquid Kvl (with a stagnation point Kcorr = 0.5)";
  parameter Boolean Cal_hcond=false
    "false : Condensation heat transfer coefficient = hcond (parameter) - true: calculate by Nusselt corelation";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hcond=8e3
    "Heat transfer coefficient between the vapor and the cooling pipes ";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kpa=0.02
    "Heat exchange coefficient between the wall and the outside ambiant";
  parameter Modelica.SIunits.Temperature Ta = 300 "External temperature";
  parameter Modelica.SIunits.Mass Mp=50e3 "Wall mass";
  parameter Modelica.SIunits.SpecificHeatCapacity cpp=600 "Wall specific heat";
  parameter Boolean step_square=true
    "true: Step square  - false: Step triangular";
  parameter Modelica.SIunits.PathLength Ls=L2/Ns "Section length for pipe";
  parameter Modelica.SIunits.Area Surf_exe=pi*Dext*Ls*NbTubT
    "Section heat exchange surface";
  parameter Modelica.SIunits.Area Surf_tot=Surf_exe*Ns
    "Total heat exchange surface";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi;

public
  Modelica.SIunits.Pressure P(start=10000) "Fluid average pressure";
  Modelica.SIunits.Pressure Pfond( start=11000)
    "Fluid pressure at the bottom of the cavity";
  Modelica.SIunits.SpecificEnthalpy hl(start=200e3)
    "Liquid phase spepcific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv(start=250e3)
    "Gas phase spepcific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hvIn(start=2400000)
    "Steam average spepcific enthalpy input cavity";
  Modelica.SIunits.Temperature Tl(start=310) "Liquid phase temperature";
  Modelica.SIunits.Temperature Tv(start=320) "Gas phase temperature";
  Modelica.SIunits.Volume Vl(start=100) "Liquid phase volume";
  Modelica.SIunits.Volume Vv(start=2000) "Gas phase volume";
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
  Modelica.SIunits.MassFlowRate Qcond(start=1000)
    "Condensation mass flow rate from the vapor phase";
  Modelica.SIunits.MassFlowRate QcondS(start=100)
    " Splitter mass flow rate of the liquid phase from the input two phases";
  Modelica.SIunits.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase";
  Modelica.SIunits.Power Wlp
    "Thermal power exchanged from the liquid phase to the wall";
  Modelica.SIunits.Power Wvp
    "Thermal power exchanged from the gas phase to the wall";
  Modelica.SIunits.Power Wpa "Thermal power losses to ambiant";
  Modelica.SIunits.Power dW[Ns](start=fill(10e5, Ns))
    "Power exchange between the wall and the fluid in each section side 3";
  Modelica.SIunits.Power Wt "Total power exchanged on the water side 3";
  Modelica.SIunits.Power Wt2( start= 0) "Total power exchanged Deheating zone";
  Modelica.SIunits.Temperature Tp1[Ns](start=fill(320, Ns))
    "Wall temperature in section i of side 1";
  Modelica.SIunits.Temperature Tp(start= 320) "Wall temperature of cavity";
  Modelica.SIunits.Position zl(start=1.05) "Liquid level in Cavity";
  Modelica.SIunits.Area Al "Cross sectional area of the liquid phase";
  Modelica.SIunits.Angle theta "Angle";
  Modelica.SIunits.Area Avl(start=1.0)
    "Heat exchange surface between the liquid and gas phases";
  Modelica.SIunits.Area Alp "Liquid phase surface on contact with the wall";
  Modelica.SIunits.Area Avp "Gas phase surface on contact with the wall";
  Modelica.SIunits.Area Ape "Wall surface on contact with the outside";
  Modelica.SIunits.ReynoldsNumber Rel(start= 6.e4) "liquid Reynolds number";
  Modelica.SIunits.ReynoldsNumber Rev(start= 6.e3) "Steam Reynolds number";
  Modelica.SIunits.ReynoldsNumber Revl(start= 6.e3)
    "Steam liquid Reynolds number";
  Modelica.SIunits.ThermalConductivity kl(start=1)
    "liquid thermal conductivity";
  Modelica.SIunits.ThermalConductivity kv(start=1) "steam thermal conductivity";
  Modelica.SIunits.DynamicViscosity mul(start=2.e-4)
    "liquid dynamic viscosity ";
  Modelica.SIunits.DynamicViscosity muv(start=2.e-5) "steam dynamic viscosity ";
  Modelica.SIunits.CoefficientOfHeatTransfer hcond3[Ns](start=fill(1e4, Ns))
    "Heat transfer coefficient between the vapor and the cooling pipes 2";
  Modelica.SIunits.CoefficientOfHeatTransfer Kvl(start=10)
    "Heat exchange coefficient between the liquid and gas phases";
  Modelica.SIunits.CoefficientOfHeatTransfer Klp(start=10)
    "Heat exchange coefficient between the liquid phase and the wall";
  Modelica.SIunits.CoefficientOfHeatTransfer Kvp(start=10)
    "Heat exchange coefficient between the gas phase and the wall";

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
  Connectors.FluidInlet CvBP "Steam input"
                                    annotation (Placement(transformation(extent=
           {{-86,50},{-66,70}}, rotation=0)));
  Connectors.FluidOutlet Cl "Water output"
                                     annotation (Placement(transformation(
          extent={{-85,-170},{-65,-150}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort Cth3[Ns]
                                     annotation (Placement(transformation(
          extent={{-82,0},{-70,12}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    "Water level"                        annotation (Placement(transformation(
          extent={{88,-107},{108,-87}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-250,-16},{-210,24}},
          rotation=0)));
  Connectors.FluidInlet Ce "Water input"
                                    annotation (Placement(transformation(extent=
           {{-219,19},{-199,39}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    "Propriétés de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-250,-106},{-210,-66}}, rotation=0)));
  Properties.WaterSteam.Common.ThermoProperties_ph provIn
    "Propriétés de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{0,70},{40,110}}, rotation=0)));
  Connectors.FluidInlet CvGCT "Steam input"
                                    annotation (Placement(transformation(extent=
           {{-160,50},{-140,70}}, rotation=0)));
initial equation
  if steady_state then
    der(hl) = 0;
    der(hv) = 0;
    Vl = Vf0*V;    // Without liquid level control
    //der(Vl) = 0; // With liquid level control
    der(P) = 0;
    der(Tp) = 0;
  else
    hl = lsat.h;
    hv = vsat.h;
    Vl = Vf0*V;
    P = P0;
    Tp = 320;
  end if;

equation
  /* Unconnected connectors */
  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h = 1.e5;
    Cl.a = true;
  end if;

  if (cardinality(CvBP) == 0) then
    CvBP.Q = 0;
    CvBP.h = 1.e5;
    CvBP.b = true;
  end if;

  if (cardinality(CvGCT) == 0) then
    CvGCT.Q = 0;
    CvGCT.h = 1.e5;
    CvGCT.b = true;
  end if;

  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.h = 1.e5;
    Ce.b = true;
  end if;

  /* Wall temperature and HeatFlowRate*/
  Cth3.T = Tp1;
  Cth3.W = dW;

  /* Model boundaries */
  Cl.P = Pfond;
  CvBP.P = P;
  CvGCT.P = P;
  Ce.P = P;

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

  /* Cavity volume */
  V = Vl + Vv;

  /* Water leval */
  yLevel.signal = zl;

  /* Liquid surface and vapor surface on contact with wall */
  Alp = if Vertical then 2*pi*R*zl + Al else (pi - 2*theta)*R*L + 2*Al;
  Avp = if Vertical then 2*pi*R*(L-zl) + Al else (pi + 2*theta)*R*L + 2*(pi*R^2 - Al);

  /* Wall surface on contact with the outside */
  Ape = Alp + Avp;

  /* Pressure at the bottom of the cavity */
  Pfond = P + prod.d*g*zl;

  /* Liquid phase mass balance equation */
  BQl = -Cl.Q + Qcond + QcondS + (1 - proe.x)*Ce.Q;
  rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;

  /* Vapor phase mass balance equation */
  BQv = CvBP.Q + CvGCT.Q - Qcond - QcondS + proe.x*Ce.Q;

  rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;

  /* Liquid phase energy balance equation */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + (Qcond+QcondS)*(lsat.h - (hl - P/rhol)) + (1 - proe.x)*Ce.Q*((if (proe.x > 0) then lsat.h else Ce.h) - (hl - P/rhol)) - Wlp + Wvl;

  Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;

  Cl.h_vol = hl;
  Ce.h_vol = hl;

  /* Gas phase energy balance equation */
  BHv = CvBP.Q*(CvBP.h - (hv - P/rhov)) + CvGCT.Q*(CvGCT.h - (hv - P/rhov)) - (Qcond+QcondS)*(lsat.h - (hv - P/rhov)) + proe.x*Ce.Q*((if (proe.x < 1) then vsat.h else Ce.h) - (hv - P/rhov)) - Wvl - Wvp + Wt;

  Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;

  CvBP.h_vol  = hv;
  CvGCT.h_vol = hv;

  /* Condensation mass flow rates */
  /* Only the power used for steam condensation is considered */
  Qcond = (-Wt + Wt2 + noEvent(max(Wvl,0)) + Wvp)/(vsat.h - lsat.h);

  QcondS = (1-provIn.x)*(CvBP.Q + CvGCT.Q);

  /* Steam average spepcific enthalpy input cavity */
  0 = noEvent( hvIn*(max(CvBP.Q, 1e-10) + max(CvGCT.Q,1e-10)) - max(CvBP.Q,1e-10)*CvBP.h - max(CvGCT.Q,1e-10)*CvGCT.h);

  /* Fluid thermodynamic properties*/
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Ce.h, 0);
  prol = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((P + Pfond)/2, hl, 0);
  provIn = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hvIn, 0);
  prov = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, hv, 0);
  prod = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pfond, Cl.h, 0);
  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;

  rhov = prov.d;
  xv = prov.x;

  muv = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(provIn.d, provIn.T);
  mul = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rhol, Tl);
  kl = noEvent(ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rhol, Tl, P, 0));
  kv = noEvent(ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(provIn.d, provIn.T, P, 0));

  /* Heat transfer coefficient between liquid and wall*/
  /* SACADURA, Von Karman equation*/
  Rel = noEvent( abs(Cl.Q*zl/(pi*R^2*mul)));
  Klp = 0.037*kl*Rel^0.8*(mul*prol.cp/kl)^0.3333/zl;

  /* Heat transfer coefficient between steam and wall*/
  Rev = noEvent( abs((CvBP.Q + CvGCT.Q + proe.x*Ce.Q)*(L-zl)/(pi*R^2*muv)));

  Revl = noEvent( abs((CvBP.Q + CvGCT.Q + proe.x*Ce.Q)*(2*R)/(pi*R^2*muv)));

  Kvp = 0.037*kv*Rev^0.8*(muv*prov.cp/kv)^0.3333/(L-zl);

  /* Heat transfer coefficient between steam and liquid */
  Kvl = 0.105*kv*Revl^0.68*(muv*prov.cp/kv)^0.33333 *(L/2/R)^(-0.103)/(2*R);

  /* Thermal power losses*/
  /* Energy balance equation at the wall */
  Mp*cpp*der(Tp) = Wlp + Wvp - Wpa;

  /* Heat exchange between liquid and gas phases */
  Wvl = Kcorr*Kvl*Avl*(Tv - Tl);

  /* Heat exchange between the liquid phase and the wall */
  Wlp = Klp*Alp*(Tl - Tp);

  /* Heat exchange between the gas phase and the wall */
  Wvp = Kvp*Avp*(Tv - Tp);

  /* Thermal power losses to ambiant, for simplifid we use the wall surface on contact with the fluid (Ape)*/
  Wpa = Kpa*Ape*(Tp - Ta);

  for i in 1:Ns loop
    /* Heat transfer coefficient of liquid*/
    if Cal_hcond then
       // Nusselt corelation
       hcond3[i] = ThermoSysPro.Functions.SmoothCond((Tv-Tp1[i]), COP*0.728*((g*rhol*(rhol - rhov)*kl^3*(vsat.h -lsat.h))/(NbTubV*mul*Dext*ThermoSysPro.Functions.SmoothMax((Tv-Tp1[i]),0.1)))^0.25,
                                                    COP*0.728*((g*rhol*(rhol - rhov)*kl^3*(vsat.h -lsat.h))/(NbTubV*mul*Dext*0.1))^0.25);
    else
       hcond3[i] = hcond;
    end if;

    /* Power exchanged for each section */
    dW[i] = - hcond3[i]*(Tv - Tp1[i])*Surf_exe + Wt2/Ns;

  end for;

  Wt = sum(dW);

  /* Total power exchanged for Deheating*/
  /* This equation is not valid for mass flow rate in the pipes = 0*/
  Wt2 = noEvent( if ( hvIn > vsat.h) then - (CvBP.Q + CvGCT.Q)*(hvIn - vsat.h) else 0);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-250,-200},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Text(
          extent={{-96,-68},{-78,-76}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Pipe 3"),
        Text(
          extent={{-118,-15},{-42,-51}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "Horizontal_1pipe"),
        Rectangle(
          extent={{-112,-76},{-56,-80}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-138,-54},{-120,-54}},
          color={0,0,255},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-152,-76},{-114,-94}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString=
               "in"),
        Line(
          points={{-134,-78},{-116,-78}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-56,-78},{-50,-78},{-50,-54},{-114,-54},{-124,-54}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{-116,-42},{-44,-114}},
          lineColor={0,0,255},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-114,-52},{-96,-56}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-126,42},{-32,12}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Condensation pipes"),
        Text(
          extent={{-114,30},{-48,6}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               " +  Deheating pipes")}),
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
        Line(
          points={{-238,-98},{88,-98}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-228,-112},{78,-112}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-214,-126},{66,-126}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-196,-138},{48,-138}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-232,-106},{82,-106}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-222,-118},{72,-118}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-206,-132},{56,-132}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-182,-144},{32,-144}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{-160,-150},{8,-150}},
          color={0,0,255},
          thickness=0.5),
        Line(points={{-160,50},{10,50}}, color={0,0,255}),
        Text(
          extent={{-90,84},{-58,70}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Steam BP"),
        Text(
          extent={{-164,84},{-132,70}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Steam HP"),
        Text(
          extent={{-248,52},{-206,40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "WaterSteam")}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end TwoPhaseCavityOnePipe;
