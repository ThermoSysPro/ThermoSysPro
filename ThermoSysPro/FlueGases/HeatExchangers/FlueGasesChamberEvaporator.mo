within ThermoSysPro.FlueGases.HeatExchangers;
model FlueGasesChamberEvaporator "Flue gases chamber  for water evaporation"
  parameter Modelica.SIunits.Area Se=400
    "Heat exchange surface on the flue gases side";
  parameter Modelica.SIunits.Length rugosi=1e-5 "Pipe roughness";
  parameter Real rencrf=0.1
    "Fouling resistance on the flue gases side (m².K/m)";
  parameter Real rencrc=0.1 "Fouling resistance on the coolant side (m².K/m)";
  parameter Real FVN=0 "Ashes volume fraction";
  parameter Modelica.SIunits.Height haut=15 "Flux wall height";
  parameter Real alpha=1 "Chamber width/depth ratio";
  parameter Modelica.SIunits.Diameter dtex=0.06 "Pipe external diameter";
  parameter Modelica.SIunits.Diameter dtin=0.05 "Pipe internal diameter";
  parameter Modelica.SIunits.Length lailet=0.05 "Membrane length";
  parameter Modelica.SIunits.Length eailet=0.001 "Membrane thickness";
  parameter Modelica.SIunits.Length ebeton=0.01 "Concrete thickness";
  parameter Modelica.SIunits.ThermalConductivity condt=10
    "Pipes thermal conductivity";
  parameter Modelica.SIunits.ThermalConductivity condm=10
    "Membrane thermal conductivity";
  parameter Modelica.SIunits.ThermalConductivity condb=10
    "Concret thermal conductivity";
  parameter Real emimur=0.1 "Walls emissitivity";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hi=10000
    "Coolant heat exchange coefficient";

protected
  Modelica.SIunits.ThermalConductivity c1(start=0.1)
    "Variable for the computation of the flue gases thermal conductivity";
  Modelica.SIunits.ThermalConductivity c2(start=0.1)
    "Variable for the computation of the flue gases thermal conductivity";
  Real bb(start=0.1e-5)
    "Variable for the computation of the friction coefficient";

public
  Modelica.SIunits.Temperature Tef(start=800)
    "Flue gases temperature at the inlet";
  Modelica.SIunits.Temperature Tsf(start=800)
    "Flue gases temperature at the outlet";
  Modelica.SIunits.AbsolutePressure Pef(start=1e5)
    "Flue gases pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Psf(start=1e5)
    "Flue gases pressure at the outlet";
  Modelica.SIunits.MassFlowRate Qf(start=10) "Flue gases mass flow rate";
  Real XfCO2(start=0.1) "CO2 mass fraction";
  Real XfH2O(start=0.1) "H2O mass fraction";
  Real XfO2(start=0.1) "O2 mass fraction";
  Real XfN2(start=0.1) "N2 mass fraction";
  Real XfSO2(start=0.6) "SO2 mass fraction";
  Modelica.SIunits.Power Wer(start=10e5) "Radiation power received";
  Modelica.SIunits.Power Wech(start=1e6) "Power exchanged";
  Modelica.SIunits.Temperature Ts(start=600)
    "Average surface temperature on the flue gases side";
  Modelica.SIunits.Temperature Tpet(start=600)
    "Average external fin wall temperature";
  Modelica.SIunits.AbsolutePressure Pec0(start=1e5) "Coolant pressure";
  Modelica.SIunits.AbsolutePressure Pec(start=1e5) "Coolant pressure";
  Modelica.SIunits.Angle anglb(start=1.5)
    "Angle of the junction between the pipe and the membrane";
  Modelica.SIunits.Angle angla(start=1.5)
    "Angle of the pipe exposed to the flue gases";
  Real rtube(start=100) "Number of coressponding pipes";
  Modelica.SIunits.Length long(start=100) "Chamber length";
  Modelica.SIunits.Length prof(start=10) "Chamber depth";
  Modelica.SIunits.Temperature Tc(start=800) "Coolant saturation temperature";
  Modelica.SIunits.AbsolutePressure Pmf(start=1e5)
    "Flue gases average pressure";
  Modelica.SIunits.Temperature Tmf(start=800) "Flue gases average temperature";
  Real Xcor(start=0.1)
    "Corrective coefficient for the flue gases mass fractions";
  Real XfH2O0(start=0.1) "H2O corrected mass fraction";
  Real XfCO20(start=0.1) "CO2 corrected mass fraction";
  Real XfO20(start=0.1) "O2 corrected mass fraction";
  Real XfSO20(start=0.1) "SO2 corrected mass fraction";
  Real XfN20(start=0.1) "N2 corrected mass fraction";
  constant Modelica.SIunits.AbsolutePressure Pnorm=1.01325e5 "Normal pressure";
  constant Modelica.SIunits.Temperature Tnorm=273.15 "Normal temperature";
  Modelica.SIunits.Density rhonorm(start=100)
    "Flue gases density at (Pnorm,Tnorm)";
  Modelica.SIunits.ThermalConductivity condf(start=100)
    "Flue gases thermal conductivity";
  Modelica.SIunits.SpecificHeatCapacity cpf(start=1000)
    "Flue gases specific heat capacity";
  Modelica.SIunits.DynamicViscosity muf(start=1e-5)
    "Flue gases dynamic viscosity";
  Modelica.SIunits.Density rhof(start=100) "Flue gases density";
  Real fvd(start=0.5) "Ashes volume fraction";
  Modelica.SIunits.Area Surf(start=50) "Flue gases cross-sectional area";
  Modelica.SIunits.Length Perim(start=50) "Chamber perimeter";
  Modelica.SIunits.Diameter Dh(start=50) "Chamber hydraulic diameter";
  Real Ref(start=10000) "Reynolds number";
  Real Prf(start=1) "Prandtl number";
  Modelica.SIunits.CoefficientOfHeatTransfer hc(start=1)
    "Convection heat exchange coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer hr(start=50)
    "Radiation heat exchange coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer hf(start=50)
    "Global heat exchange coefficient";
  Modelica.SIunits.Volume volumg(start=500) "Gas volume";
  Modelica.SIunits.Area senveng(start=500) "Gas envelope surface";
  Modelica.SIunits.Length rop(start=5)
    "Average optical radius between the pipes";
  Real Masmol(start=0.1) "Mixture molar mass";
  Modelica.SIunits.AbsolutePressure PCO2R(start=0.5e5) "CO2 partial pressure";
  Modelica.SIunits.AbsolutePressure PH2OR(start=0.5e5) "H2O partial pressure";
  Real EG(start=0.5);
  Real ES(start=0.5);
  Real emigaz(start=0.5) "Gases emissivity";
  Real emigaz0(start=0.5) "Gases emissivity";
  Real rugos(start=0.1e-5) "Pipe roughness on the flue gases side";
  Real kfrot(start=0.05) "Pressure losses friction coefficient";
  ThermoSysPro.Units.DifferentialPressure dpd(start=1000)
    "Dynamical pressure losses";
  ThermoSysPro.Units.DifferentialPressure dps(start=1000)
    "Static pressure losses";
  ThermoSysPro.Units.DifferentialPressure Pdf(start=1000)
    "Total pressure losses";
  Real R1(start=0.1) "Thermal resistance";
  Real R2(start=0.1) "Thermal resistance";
  Real R3(start=0.1) "Thermal resistance";
  Real R4(start=0.1) "Thermal resistance";
  Real R5(start=0.1) "Thermal resistance";
  Real R6(start=0.1) "Thermal resistance";
  Real R7(start=0.1) "Thermal resistance";
  Real R8(start=0.1) "Thermal resistance";
  Real R9(start=0.1) "Thermal resistance";
  Real R10(start=0.1) "Thermal resistance";
  Real R789(start=0.1) "Thermal resistance";
  Real R01(start=0.1) "Fouling resistance";
  Real R02(start=0.1) "Fouling resistance";
  Real R03(start=0.1) "Fouling resistance";
  Real R04(start=0.1) "Fouling resistance";
  Real R05(start=0.1) "Fouling resistancet";
  Real Rb1(start=0.1) "Concrete surface thermal resistance";
  Real Rb2(start=0.1) "Concrete surface thermal resistance";
  Real Rt(start=0.1) "Total surface thermal resistance (K/W)";
  Real U(start=50)
    "Global heat exchange coefficient per external surface unit (W/m²/K)";
  Modelica.SIunits.Area Set(start=500) "Total external surface";
  Modelica.SIunits.Velocity vit(start=1) "Gases veolicity";

  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet C1
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet C2
    annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPressure
    "Water/steam pressure"
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Thermal.Connectors.ThermalPort CTh
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
equation
  /* Flue gases inlet */
  Qf = C1.Q;
  Pef = C1.P;
  Tef = C1.T;

  XfCO2 = C1.Xco2;
  XfH2O = C1.Xh2o;
  XfO2 = C1.Xo2;
  XfN2 = 1 - XfCO2 - XfH2O - XfO2 - XfSO2;
  XfSO2 = C1.Xso2;

  /* Flue gases outlet */
  Qf = C2.Q;
  Psf = C2.P;
  Tsf = C2.T;

  XfCO2 = C2.Xco2;
  XfH2O = C2.Xh2o;
  XfO2 = C2.Xo2;
  XfSO2 = C2.Xso2;

  /* Power input */
  Wer = CTh.W;
  CTh.T = Tsf;

  /* Input coolant pressure */
  Pec0 = IPressure.signal;

  0 = if (Pec0 >= 0) then (Pec - Pec0) else (Pec - 10e5);

  /* Angle at the junction pipe/membrane */
  anglb = 2*Modelica.Math.asin(eailet/dtex);

  /* Angle of the pipe exposed to the flue gases*/
  angla = (Modelica.Constants.pi - anglb)/2;

  /* Number of corresponding pipes */
  rtube = Se/haut/(angla*dtex + lailet);

  /* Chamber length*/
  long = alpha/(1 + alpha)*rtube*(dtex + lailet)/2;

  /* Chamber depth */
  prof = 1/(1 + alpha)*rtube*(dtex + lailet)/2;

  /* Coolant saturation temperature */
  Tc = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(Pec);

  /* Average flue gases pressure an temperature */
  Pmf = 0.5*(Pef + Psf);
  Tmf = 0.5*(Tef + Tsf);

  /* Flue gases density at 273.15K and 1 atm */
  Xcor = 1/(1 - XfH2O);
  XfH2O0 = 0;
  XfCO20 = XfCO2*Xcor;
  XfO20 = XfO2*Xcor;
  XfSO20 = XfSO2*Xcor;
  XfN20 = 1 - (XfCO20 + XfO20 + XfSO20);

  rhonorm = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pnorm, Tnorm, XfCO20, XfH2O0, XfO20, XfSO20);

  /* Flue gases thermodynamic properties at Tmf and Pmf */
  if (Tmf > 973.15) then
    c1 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Pmf, 923.15, XfCO2, XfH2O, XfO2, XfSO2);
    c2 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Pmf, 973.15, XfCO2, XfH2O, XfO2, XfSO2);
    condf = (Tmf - 973.15)*(c2 - c1)/50 + c2;
  else
    c1 = 0;
    c2 = 0;
    condf = ThermoSysPro.Properties.FlueGases.FlueGases_k(Pmf, Tmf, XfCO2, XfH2O, XfO2, XfSO2);
  end if;

  cpf = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pmf, Tmf, XfCO2, XfH2O, XfO2, XfSO2);
  muf = ThermoSysPro.Properties.FlueGases.FlueGases_mu(Pmf, Tmf, XfCO2, XfH2O, XfO2, XfSO2);
  rhof = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pmf, Tmf, XfCO2, XfH2O, XfO2, XfSO2);

  /* Ashes volume fraction */
  fvd = FVN*rhof/rhonorm;

  // Flue gases heat exchange coefficient
  // ------------------------------------

  // Convection

  /* Geometry */
  Surf = prof*long;
  Perim = 2*(long + prof);
  Dh = 4*Surf/Perim;

  /* Reynolds number */
  Ref = (Qf/Surf)*Dh/muf;

  /* Prandtl number */
  Prf = muf*cpf/condf;

  /* Heat exchange coefficient (turbulent regime, Mac Adams correlation, pipe flow, hydraulic diameter analogy)*/
  hc = 0.023*(Ref^0.8)*(Prf^0.4)*condf/Dh;

  // Radiation

  /* Gas volume */
  volumg = Dh*long*prof;

  /* Total surface of the gase envelope */
  senveng = 2*Dh*long + 2*Dh*prof + 2*long*prof;

  /* Average optical raius between the pipes */
  rop = 3.6*volumg/senveng;

  /* Mixture molar mass */
  Masmol = XfCO2/44 + XfO2/32 + XfSO2/64 + XfH2O/18 + XfN2/28;

  /* CO2 partial pressure*/
  PCO2R = XfCO2/44/Masmol*Pef;

  /* H2O partial pressure */
  PH2OR = XfH2O/18/Masmol*Pef;

  /* Gas emissivity */
  (EG,ES,emigaz0) = ThermoSysPro.Properties.FlueGases.FlueGases_Absorb(PCO2R, PH2OR, fvd, rop, Tmf);

  if (emigaz0 < 0.0001) then
    emigaz = 0.0001;
  elseif (emigaz0 > 1) then
    emigaz = 0.99;
  else
    emigaz = emigaz0;
  end if;

  /* Heat exchange coefficient (take into account the CO2 and H2O radiation) */
  hr = 5.68e-8/(1/emigaz + (1 - emimur)/emimur)*(Tmf^2 + Ts^2)*(Tmf + Ts);

  /* Global heat exchange coefficient */
  hf = hc + hr;

  // Pressure losses
  //----------------

  rugos = 0.15e-3;

  /* Dynamic pressure losses */

  /* Friction pressure losses coefficient */
  if (Ref < 2000) then
    /* Laminar regime */
    bb = 0;
    kfrot = 64/Ref;
  else
    /* Turburlent regime */
    bb = (13/Ref + rugos/3.7/Dh);
    kfrot = 0.25*Modelica.Math.log10(bb)^(-2);
  end if;

  /* Friction pressure losses */
  dpd = kfrot*haut*(Qf^2)/(2*(Surf^2)*Dh*rhof);

  /* Static pressure losses */
  dps = rhof*Modelica.Constants.g_n*haut;

  /* Total pressure losses */
  Pdf = dpd + dps;

  // Global heat exchange coefficient between the flue gaases and the coolant
  //-------------------------------------------------------------------------

  /* Thermal resistance for a half (pipe + membrane) */
  if (hf <= 0) then
    R1 = 0;
    R4 = 0;
    Rb1 = 0;
  else
    R1 = 1/(hf*angla*dtex/2*haut);
    R4 = 1/(hf*lailet/2*haut);
    Rb1 = 1/(hf*(lailet + dtex)/2*haut);
  end if;

  R3 = 1/(hi*angla*dtin/2*haut);
  R8 = 1/(hi*anglb*dtin/2*haut);
  R9 = R3;
  R2= Modelica.Math.log(dtex/dtin)/(condt*angla*haut);
  R5 = lailet/4/(eailet*condm*haut);
  R6 = Modelica.Math.log(dtex/(dtin + (dtex - dtin)/2))/(condt*anglb*haut);
  R7 = Modelica.Math.log((dtin + (dtex - dtin)/2)/dtin)/(condt*anglb*haut);
  R10 = angla/4*(dtin + dtex)/(dtex - dtin)/(condt*haut);
  Rb2 = ebeton/(condb*(lailet + dtex)/2*haut);

  R01 = rencrc/(angla*dtin/2*haut);
  R02 = rencrc/(anglb*dtin/2*haut);
  R03 = rencrf/(angla*dtex/2*haut);
  R04 = rencrf/(lailet/2*haut);
  R05 = rencrf/((angla*dtex/2 + lailet/2)*haut);

  R789=1/(1/(R7+R8+R02)+1/(R9+R10+R01));

  /* Equivalent thermal resistance and global heat exchange coefficient per external surface unit */
  if (ebeton <= 0) then
    /* No concrete surface */
    Rt = 1/(1/(R1 + R03 + R2 + R3 + R01) + 1/(R4 + R04 + R5 + R6 + R789));
    U = 1/((angla*dtex/2 + lailet/2)*haut*Rt);
    Se = rtube*(angla*dtex + lailet)*haut;
  else
    /* Existence of a concrete surface */
    Rt = (1/(1/(R3 + R2 + R01) + 1/(R5 + R6 + R789))) + Rb1 + Rb2 + R05;
    U = 1/((lailet + dtex)/2*haut*Rt);
    Set = rtube*(dtex + lailet)*haut;
  end if;

  /* Gas velocity */
  vit = Qf/(long*prof*rhof);

  /* Tempretaure at the outlet */
  Tsf = Tef - (Wech - Wer)/(Qf*cpf);

  /* Power exchanged */
  U*Set*(Tsf - Tef)/Modelica.Math.log((Tsf - Tc)/(Tef - Tc)) = Wech - Wer;

  /* External surface temperature on the flue gases side*/
  Ts = Tmf - ((Wech - Wer)/hf/Set);

  /* Fin temperature */
  Tpet = Ts - ((Wech - Wer)*rencrf/Set);

  /* Pressure */
  Psf + Pdf = Pef;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-80,100},{-74,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,100},{-36,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,100},{44,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,100},{4,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{74,100},{80,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}),
                                       Icon(graphics={
        Rectangle(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-80,100},{-74,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,100},{-36,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,100},{44,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,100},{4,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{74,100},{80,-100}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-2,118},{34,94}},
          lineColor={0,0,255},
          textString=
               "P")}),
    Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Beno&icirc;t Bride </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end FlueGasesChamberEvaporator;
