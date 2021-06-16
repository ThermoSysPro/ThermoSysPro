within ThermoSysPro.WaterSteam.HeatExchangers;
model StaticCondenserHEI "HEI Static condenser"

  parameter Real Kf=0 "Friction pressure loss coefficient for the cold side";
  parameter Modelica.SIunits.Position z1c=0 "Hot inlet altitude";
  parameter Modelica.SIunits.Position z2c=0 "Hot outlet altitude";
  parameter Modelica.SIunits.Position z1f=0 "Cold inlet altitude";
  parameter Modelica.SIunits.Position z2f=0 "Cold outlet altitude";
  parameter Real Ucorr=1.00
    "Corrective term for the heat transfert coefficient (U) for calibration";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Modelica.SIunits.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot side";
  parameter Modelica.SIunits.Density p_rhof=0
    "If > 0, fixed fluid density for the cold side";
  parameter Integer modec=0
    "IF97 region of the water for the hot side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modecs=0
    "IF97 region of the water at the outlet of the hot side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modef=0
    "IF97 region of the water for the cold side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer Tube_Material1=1 "Material of the tubes type 1. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Integer Tube_Material2=1 "Material of the tubes type 2. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Integer Tube_Material3=1 "Material of the tubes type 3. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Integer Tube_Material4=1 "Material of the tubes type 4. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Integer Tube_Material5=1 "Material of the tubes type 5. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Integer Tube_Material6=1 "Material of the tubes type 6. 1:Cu Fe 194 - 2:Arsenical Cu - 3:Admiralty - 4:Al Brass - 5:Al Bronze - 6:Carbon Steel 
    - 7:Cu Ni 90-10 - 8:Cu Ni 70-30 - 9:SS (UNS S43035) - 10:Titanium Grades 1 & 2 - 11:SS (UNS S44660) 
    - 12:SS (UNS S44735) - 13:SS TP 304 - 14:SS TP 316/317 - 15:SS (UNS N08367)";
  parameter Real nb_pass=2 "number of water passes";
  parameter Real nb_tube1=12000
    "Number of tubes type 1. For exemple tubes of the condensing zone";
  parameter Real nb_tube2=900
    "Number of tubes type 2. For exemple gaz removal tubes";
  parameter Real nb_tube3=700
    "Number of tubes type 3. For exemple impingement tubes";
  parameter Real nb_tube4=200 "Number of tubes type 4";
  parameter Real nb_tube5=200 "Number of tubes type 5";
  parameter Real nb_tube6=200 "Number of tubes type 6";
  parameter Modelica.SIunits.Thickness e_tube1=0.7e-3 "Tubes thickness type 1";
  parameter Modelica.SIunits.Thickness e_tube2=0.7e-3 "Tubes thickness type 2";
  parameter Modelica.SIunits.Thickness e_tube3=1e-3 "Tubes thickness type 3";
  parameter Modelica.SIunits.Thickness e_tube4=1e-3 "Tubes thickness type 4";
  parameter Modelica.SIunits.Thickness e_tube5=1e-3 "Tubes thickness type 5";
  parameter Modelica.SIunits.Thickness e_tube6=1e-3 "Tubes thickness type 6";
  parameter Modelica.SIunits.Diameter D_tube1=25.4e-3
    "External diameter of tubes type 1";
  parameter Modelica.SIunits.Diameter D_tube2=25.4e-3
    "External diameter of tubes type 2";
  parameter Modelica.SIunits.Diameter D_tube3=25.4e-3
    "External diameter of tubes type 3";
  parameter Modelica.SIunits.Diameter D_tube4=25.4e-3
    "External diameter of tubes type 4";
  parameter Modelica.SIunits.Diameter D_tube5=25.4e-3
    "External diameter of tubes type 5";
  parameter Modelica.SIunits.Diameter D_tube6=25.4e-3
    "External diameter of tubes type 6";
  parameter Modelica.SIunits.Length L_tube1=10 "Tubes length type 1";
  parameter Modelica.SIunits.Length L_tube2=10 "Tubes length type 2";
  parameter Modelica.SIunits.Length L_tube3=10 "Tubes length type 3";
  parameter Modelica.SIunits.Length L_tube4=10 "Tubes length type 4";
  parameter Modelica.SIunits.Length L_tube5=10 "Tubes length type 5";
  parameter Modelica.SIunits.Length L_tube6=10 "Tubes length type 6";
  parameter Real FC=0.95 "Correction factor for cleanless";

  parameter Modelica.SIunits.Pressure Poffset=0
    "Offset applied on the pressure provided by HEI";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";
  Modelica.SIunits.Diameter D_tubes "Weight average diameter of tubes";
  Modelica.SIunits.Thickness e_tubes "Weight average thickness of tubes";
  Modelica.SIunits.Area S_pass(start=3) "Passage section of cold water";
  Modelica.SIunits.Area S_ech1(start=10000)
    "Heat exchange surface tubes type 1";
  Modelica.SIunits.Area S_ech2(start=10000)
    "Heat exchange surface tubes type 2";
  Modelica.SIunits.Area S_ech3(start=10000)
    "Heat exchange surface tubes type 3";
  Modelica.SIunits.Area S_ech4(start=10000)
    "Heat exchange surface tubes type 4";
  Modelica.SIunits.Area S_ech5(start=10000)
    "Heat exchange surface tubes type 5";
  Modelica.SIunits.Area S_ech6(start=10000)
    "Heat exchange surface tubes type 6";
  Real FM1 "Correction factor for material and gauge tubes type 1";
  Real FM2 "Correction factor for material and gauge tubes type 2";
  Real FM3 "Correction factor for material and gauge tubes type 3";
  Real FM4 "Correction factor for material and gauge tubes type 4";
  Real FM5 "Correction factor for material and gauge tubes type 5";
  Real FM6 "Correction factor for material and gauge tubes type 6";

public
  Modelica.SIunits.Power W(start=1e6)
    "Power exchanged from the hot side to the cold side";
  Modelica.SIunits.Temperature Tec(start=500)
    "Fluid temperature at the inlet of the hot side";
  Modelica.SIunits.Temperature Tsc(start=400)
    "Fluid temperature at the outlet of the hot side";
  Modelica.SIunits.Temperature Tef(start=350)
    "Fluid temperature at the inlet of the cold side";
  Modelica.SIunits.Temperature Tsf(start=350)
    "Fluid temperature at the outlet of the cold side";
  Modelica.SIunits.Pressure DPgc(start=1e2)
    "Gravity pressure loss in the hot side";
  Modelica.SIunits.Pressure DPff(start=1e3)
    "Friction pressure loss in the cold side";
  Modelica.SIunits.Pressure DPgf(start=1e2)
    "Gravity pressure loss in the cold side";
  Modelica.SIunits.Pressure DPf(start=1e3)
    "Total pressure loss in the cold side";
  Modelica.SIunits.Density rhof(start=998)
    "Density of the fluid in the cold side";
  Modelica.SIunits.Density rho_ex(start=950)
    "Water density at the extraction point";

  Modelica.SIunits.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Modelica.SIunits.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";
  Modelica.SIunits.Area S_ech(start=10000) "Heat exchange surface";
  Modelica.SIunits.Velocity Vf "Velocity of cold water";
  Real Fw "Correction factor for water";
  Modelica.SIunits.CoefficientOfHeatTransfer U1
    "Uncorrected heat transfert coefficient";
  Real FM "Overall correction factor for material and gauge";
  Modelica.SIunits.CoefficientOfHeatTransfer U "Heat transfert coefficient";
  Modelica.SIunits.Temperature Tcut_off
    "Saturation temperature at pressure cut off";
  Modelica.SIunits.Pressure Psat_att( start= 6000)
                                                  "Expected saturation pressure HEI";
  Modelica.SIunits.Pressure Pcut_off "Pressure cut off";
  Modelica.SIunits.Pressure Pzero_load "Pressure zero load";
  Modelica.SIunits.Pressure Pcond( start= 6000)
    "Expected corrected saturation pressure HEI";
  Modelica.SIunits.Temperature Tsat(start= 310)
    "Expected corrected saturation temperature HEI";
  Modelica.SIunits.Power Wcut_off(start=5e5)
    "Power exchanged from the hot side to the cold side at Pcut_off";
  Modelica.SIunits.Temperature TTD "Terminal Temperature Difference";
  Integer HEI "Applicabiltity of the standards HEI. 0:NO - 1:OK";
  Modelica.SIunits.Temperature Tsat_att(start= 310) "Expected saturation temperature HEI";
  Modelica.SIunits.SpecificHeatCapacity Cpmf(start= 950)
    "Average of specific heat capacity of cold water";
  Modelica.SIunits.SpecificEnthalpy Hmv(start=2500000)
    "Fluid input average specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hml(start=100000)
    "Extraction water average specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hex(start=100000)
    "Drain specific enthalpy at the outlet";

public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cee "Cooling water inlet"
    annotation (Placement(transformation(extent={{-112,-72},{-88,-50}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cse "Cooling water outlet"
    annotation (Placement(transformation(extent={{90,-72},{114,-50}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cex "Extraction water"
    annotation (Placement(transformation(extent={{-12,-114},{14,-90}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cvt "Turbine outlet"
    annotation (Placement(transformation(extent={{-13,88},{13,114}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    "Proprietes eau"
    annotation (Placement(transformation(extent={{50,80},{70,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    "Proprietes eau"
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    "Proprietes eau"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cep "Drain inlet"
    annotation (Placement(transformation(extent={{-112,8},{-88,30}}, rotation=0)));
public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cev "Vapor inlet"
    annotation (Placement(transformation(extent={{-112,50},{-88,72}}, rotation=
            0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    "Proprietes eau"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promf
    "Proprietes eau"
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation
  // Water/steam cavity
  //-------------------

  /* Unconnected connectors */
  if (cardinality(Cev) == 0) then
    Cev.Q = 0;
    Cev.h = 1.e5;
    Cev.b = true;
  end if;

  if (cardinality(Cep) == 0) then
    Cep.Q = 0;
    Cep.h = 1.e5;
    Cep.b = true;
  end if;

  /* Fluid pressure */
  Pcond = Cep.P;
  Pcond = Cev.P;
  Pcond = Cvt.P;

  /* Extraction water pressure */
  Cex.P = Pcond + rho_ex*g*(z2c-z1c);

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Hmv = Cvt.h_vol;
  Hmv = Cep.h_vol;
  Hmv = Cev.h_vol;
  Hex = Cex.h_vol;

  /* Flows in both sides */
  Qc = Cex.Q;
  Cee.Q = Cse.Q;
  Qf = Cee.Q;

  /* Flow reversal in the cold side */
  if continuous_flow_reversal then
    0 = noEvent(if (Qf > Qeps) then Cee.h - Cee.h_vol else if (Qf < -Qeps) then
        Cse.h - Cse.h_vol else Cee.h - 0.5*((Cee.h_vol - Cse.h_vol)*Modelica.Math.sin(pi
        *Qf/2/Qeps) + Cee.h_vol + Cse.h_vol));
  else
    0 = if (Qf > 0) then Cee.h - Cee.h_vol else Cse.h - Cse.h_vol;
  end if;

  /* Mixer: mass balance equation */
  Qc = Cvt.Q + Cep.Q + Cev.Q;

  /* Fluid input average specific enthalpy */
  Hmv = (Cvt.Q*Cvt.h  + Cep.Q*Cep.h + Cev.Q*Cev.h)/Qc;

  /* Extraction water average specific enthalpy */
  Hml = (lsat.h + Hex)/2;

  /* Extraction water specific enthalpy */
  Hex = noEvent(if (rho_ex > 0) then lsat.h + ((Cex.P - Pcond)/rho_ex) else lsat.h);

  /* Input power */
  W = Cvt.Q*(Cvt.h - lsat.h) + Cep.Q*(Cep.h - lsat.h) + Cev.Q*(Cev.h - lsat.h);

  /* Power exchanged between the two sides */
  W = Qf*(Cse.h - Cee.h);

  /* Gravity pressure losses in the hot side */
  DPgc = rho_ex*g*(z2c - z1c);

  /* Pressure losses in the cold side */
  Cee.P - Cse.P = DPf;

  DPff = Kf*ThermoSysPro.Functions.ThermoSquare(Qf, eps)/rhof;
  DPgf = rhof*g*(z2f - z1f);
  DPf  = DPff + DPgf;

  /* Fluid thermodynamic properties in the hot side */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cvt.P, Hmv, modec);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cex.P, Cex.h, modecs);
  //procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pcond + Cex.P)/2, (lsat.h + Cex.h)/2, modecs);

  Tec = proce.T;
  Tsc = procs.T;

  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Pcond);

  if (p_rhoc > 0) then
    rho_ex = p_rhoc;
  else
    rho_ex = procs.d;
  end if;

  /* Fluid thermodynamic properties in the cold side */
  profe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cee.P, Cee.h, modef);
  profs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cse.P, Cse.h, modef);
  promf = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Cee.P + Cse.P)/2, (Cee.h + Cse.h)/2, modef);

  Tef = profe.T;
  Tsf = profs.T;

  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = promf.d;
  end if;

  /* Calculation of the heat exchange surface */
  S_ech1 = pi*D_tube1*L_tube1*nb_tube1;
  S_ech2 = pi*D_tube2*L_tube2*nb_tube2;
  S_ech3 = pi*D_tube3*L_tube3*nb_tube3;
  S_ech4 = pi*D_tube4*L_tube4*nb_tube4;
  S_ech5 = pi*D_tube5*L_tube5*nb_tube5;
  S_ech6 = pi*D_tube6*L_tube6*nb_tube6;
  S_ech = S_ech1 + S_ech2 + S_ech3 + S_ech4 + S_ech5 + S_ech6;

 /* Calculation of the passage section of cold water */
  S_pass = (D_tube1/2-e_tube1)^2*pi*nb_tube1/nb_pass + (D_tube2/2-e_tube2)^2*pi*nb_tube2/nb_pass + (D_tube3/2-e_tube3)^2*pi*nb_tube3/nb_pass + (D_tube4/2-e_tube4)^2*pi*nb_tube4/nb_pass + (D_tube5/2-e_tube5)^2*pi*nb_tube5/nb_pass +(D_tube6/2-e_tube6)^2*pi*nb_tube6/nb_pass;

  /* Calculation of the velocity of cold water */
  Vf = Qf/rhof/S_pass;

  /* Calculation of the correction factor for water from the HEI standard 10th édition */
  Fw = -2.104072e-04*(Tef-273.15)^2 + 1.974994e-02*(Tef-273.15) + 6.639699e-01;

  /* Calculation of weight average diameter of tubes */
  D_tubes = (D_tube1*nb_tube1 + D_tube2*nb_tube2 + D_tube3*nb_tube3 + D_tube4*nb_tube4 + D_tube5*nb_tube5 + D_tube6*nb_tube6)/(nb_tube1 + nb_tube2 + nb_tube3 + nb_tube4 + nb_tube5 + nb_tube6);

  /* Calculation of the uncorrected heat transfert coefficient from the HEI standard 10th édition */
  U1 = ThermoSysPro.Correlations.Thermal.Function_U1(D_tubes,Vf);

  /* Calculation of the Weight average thickness of tubes */
  e_tubes = (e_tube1*nb_tube1+e_tube2*nb_tube2+e_tube3*nb_tube3+e_tube4*nb_tube4+e_tube5*nb_tube5+e_tube6*nb_tube6)/(nb_tube1+nb_tube2+nb_tube3+nb_tube4+nb_tube5+nb_tube6);

  /* Calculation of the Correction factor for material and gauge from the HEI standard 10th édition */
  FM1 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube1,Tube_Material1);
  FM2 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube2,Tube_Material2);
  FM3 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube3,Tube_Material3);
  FM4 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube4,Tube_Material4);
  FM5 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube5,Tube_Material5);
  FM6 = ThermoSysPro.Correlations.Misc.Function_FM(e_tube6,Tube_Material6);
  FM = (FM1*S_ech1 + FM2*S_ech2 + FM3*S_ech3 + FM4*S_ech4 + FM5*S_ech5 + FM6*S_ech6)/S_ech;

  /* Calculation of the heat transfert coefficient from the HEI standard 10th édition */
  U = Ucorr*U1*FM*FC*Fw;
  //U = U1*FM*FC*Fw + Ucorr;

  /* Calculation of Average of specific heat capacity of cold water */
  Cpmf = promf.cp;

  /* Calculation of Expected saturation temperature HEI */
  Tsat_att = Tef + (W/(Qf*Cpmf))*(1/(1-Modelica.Math.exp(-(U*S_ech)/(Qf*Cpmf))));

  /* Calculation of Expected saturation pressure HEI */
  Psat_att = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.psat(Tsat_att);

  /* Calculation of Pressure cut off HEI */
  Pcut_off = (5.752433E-04*(Tef-273.15)^3 + 1.735162E-02*(Tef-273.15)^2 + 8.052739E-02*(Tef-273.15) + 2.109159E+01)*100;

  /*Calculation of the saturation Temperature at Pressure cut off HEI */
  Tcut_off = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(Pcut_off);

  /* Calculation of Pressure zero load HEI */
  Pzero_load = (5.008000E-04*(Tef-273.15)^3 + 2.039549E-02*(Tef-273.15)^2 + 2.277566E-01*(Tef-273.15) + 1.027824E+01)*100;

  /* Calculation of power exchanged from the hot side to the cold side at Pcut_off */
  Tcut_off = Tef + (Wcut_off/(Qf*Cpmf))*(1/(1-Modelica.Math.exp(-(U*S_ech)/(Qf*Cpmf))));

  /* Calculation of Expected corrected saturation pressure HEI */
  if (Psat_att < Pcut_off) then
    Pcond = (Pcut_off-Pzero_load)/Wcut_off*W+Pzero_load+Poffset;
  else
    Pcond = Psat_att + Poffset;
  end if;

  /* Calculation of Expected corrected saturation pressure HEI */
    Tsat = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(Pcond);

  /* Calculation of the Terminal Temperature Difference */
  TTD = Tsat - Tsf;

  /* The standards HEI aren't applicable if the terminal temperature difference is less than 2,78 K */
  if (TTD > 2.78) then
    HEI = 1;
  else
    HEI = 0;
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-82},{100,80},{-100,80},{-100,-82},{100,-82}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,88},{20,70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Turbine outlet"),
        Text(
          extent={{-82,24},{-52,16}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Drain inlet"),
        Text(
          extent={{-24,-52},{26,-72}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Extraction water"),
        Text(
          extent={{38,-58},{86,-66}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water outlet"),
        Text(
          extent={{-86,-52},{-32,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water inlet"),
        Text(
          extent={{-86,66},{-50,54}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Vapor inlet"),
        Line(
          points={{0,8},{0,-70}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{0,-90},{-11,-70},{11,-70},{0,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-80,60},{72,12}},
          lineColor={28,108,200},
          textString="HEI")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-86},{100,100},{-100,100},{-100,-86},{100,-86}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{0,-90},{-11,-70},{11,-70},{0,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{0,8},{0,-70}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-80,84},{72,36}},
          lineColor={28,108,200},
          textString="HEI")}),
    Window(
      x=0.09,
      y=0.08,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StaticCondenserHEI;
