within ThermoSysPro.WaterSteam.HeatExchangers;
model CoolingTower "Cooling tower"

  parameter Integer fluid=1
    "<html>Fluid number: <br>1 - Water/Steam <br>7 - WaterSteamSimple </html>";
  parameter Modelica.SIunits.AbsolutePressure Patm=101325
    "Pressure above the fluid level";
  parameter Modelica.SIunits.MassFlowRate Qesp=0.001;

  // ---------------------   Geometrical parameters ------------------------------------------
  parameter Modelica.SIunits.Area A=13114 "Tower cross-sectional aera";
  parameter Real a1=1/z1 "Water/air interfacial area for the packing (m2/m3)";
  parameter Modelica.SIunits.Height z1 = 1.6
    "Height of the packing heat exchange zone";

  // ----------------------  Mixing law parameters -------------------------------------------
  parameter Real lambda=1.227 "Beta packing exchange parameter";
  parameter Real Y=0.51 "Beta packing exchange parameter";
  parameter Real p_Beta1=0
    "If > 0, fixed transfert coefficient for the evporating mass (otherwise, this coef. is computed)";
  Real Beta1
    "Coefficient de tranfert de masse d'évaporation calculé avec nn et lambda (packing)";

  // ---------------------- Air parameter at the inlet of the tower --------------------------
  parameter Real Xo2as(start=0.234) "O2 mass fraction in dry air";

  parameter Boolean steady_state=true "true: start from steady state";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real g=9.81 "Gravity constant";

  // ----------------------  Zone 1 : packing   --------------------------
public
  parameter Boolean packing_zone_activated=true
    "true: activation of the packing zone";

  Modelica.SIunits.Volume dV "Volume of the packing exchange zone";
  Real xeH2o "Air humidity at the inlet (kg/kg)";
  Modelica.SIunits.MassFlowRate QsAir2
    "Ambiant air mass flow at the inlet of the packing zone";
  Modelica.SIunits.SpecificEnthalpy HmAir2(start=100000)
    "Ambiant air specific enthalpy at the inlet of the packing zone";
  Modelica.SIunits.AbsolutePressure PeAir2
    "Ambiant air pressure at the inlet of the packing zone";
  Modelica.SIunits.Temperature Teair1(start=284.16)
    "Ambiant air temperature at the inlet of the packing zone";
  Real xeH2o1 "Ambiant air humidity at the inlet of the packing zone (kg/kg)";
  Modelica.SIunits.MassFlowRate QsAir1
    "Hot air mass flow at the outlet of the packing zone";
  Modelica.SIunits.SpecificEnthalpy HmAir1( start=100000)
    "Hot air specific enthalpy at the outlet of the packing zone";
  Modelica.SIunits.Temperature Tsair1(start=300)
    "Hot air temperature at the outlet of the packing zone";
  Real xsH2o1 "Hot air humidity at the outlet of the packing zone (kg/kg)";
  Real xsO2 "Hot air O2 mass fraction at the outlet of the packing zone";
  Modelica.SIunits.AbsolutePressure PeEau1
    "Hot water pressure at the inlet of the packing zone";
  Modelica.SIunits.MassFlowRate QeEau1
    "Hot water mass flow rate at the inlet of the packing zone";
  Modelica.SIunits.SpecificEnthalpy HeEau1
    "Hot water specific enthalpy at the inlet of the packing zone";
  Modelica.SIunits.Temperature Teeau1
    "Hot water temperature at the inlet of the packing zone";
  Modelica.SIunits.MassFlowRate QsEau1
    "Cold water pressure at the outlet of the packing zone";
  Modelica.SIunits.Temperature Tseau1( start = 300)
    "Cold water tempretaure at the outlet of the packing zone";
  Modelica.SIunits.SpecificEnthalpy HmEau1(start=200000)
    "Cold water specific enthalpy at the outlet of the packing zone";
  Modelica.SIunits.Power dw1
    "Cooling power given by water convection and evaporation in the packing zone";
  Modelica.SIunits.SpecificEnthalpy Hs1
    "Air specific enthalpy in the packing zone";
  Modelica.SIunits.SpecificEnthalpy Hse1
    "Air specific enthalpy saturated at Teau in the packing zone";
  Modelica.SIunits.MassFlowRate Qevap1
    "Evaporation mass flow in the packing zone";
  Modelica.SIunits.Volume Vair1(start=20000) "Air volume in the packing zone";
  Modelica.SIunits.Volume Veau1(start=2000) "Water volume in the packing zone";
  Modelica.SIunits.Density rhoEair1 "Air density at the inlet";
  Modelica.SIunits.DynamicViscosity muEair1 "Air viscosity at the inlet";
  Modelica.SIunits.SpecificHeatCapacity CpEair1
    "Air specific heat capacity at the inlet";
  Modelica.SIunits.ThermalConductivity lambdaEair1
    "Air thermal conductivity at the inlet";
  Modelica.SIunits.Density rhoSair1 "Air density at the outlet";
  Modelica.SIunits.DynamicViscosity muSair1 "Air viscosity at the outlet";
  Modelica.SIunits.SpecificHeatCapacity CpSair1
    "Air specific heat capacity at the outlet";
  Modelica.SIunits.ThermalConductivity lambdaSair1
    "Air thermal conductivity at the outlet";
  Modelica.SIunits.Density rho1 "Water density";

  // ----------------------  Zone 2 : rain   --------------------------
  parameter Boolean rain_zone_activated=true "Activation of the rain zone";
  parameter Modelica.SIunits.Area A2=A "Flow cross-sectional area in the tower";
  parameter Modelica.SIunits.Height z2=z1
    "Height of the exchange zone in the rain zone";
  parameter Modelica.SIunits.Diameter Dg=0.005 "Droplets diameter";
  parameter Real p_Beta2=0
    "If > 0, the mass transfer coef. is fixed, otherwise it is computed";

  Real Beta2 "Transfer coefficient for the rain";
  Modelica.SIunits.Velocity Ug(start=1) "Droplets velocity";
  Modelica.SIunits.Velocity Ua "Air velocity";
  Real a2 "Interfacial area water/air (m2/m3) (rain zone)";
  Modelica.SIunits.PrandtlNumber Pr "Droplets Prandtl number";
  Modelica.SIunits.NusseltNumber Nu "Droplets Nusselt number";
  Modelica.SIunits.ReynoldsNumber Re "Droplets Reynols number";
  Modelica.SIunits.Volume dV2 "Volume of the rain exchange zone";
  Modelica.SIunits.MassFlowRate QeAir2
    "Air mass flow rate at the inlet of the rain zone";
  Modelica.SIunits.SpecificEnthalpy HeAir2
    "Air specific enthalpy at the inlet of the rain zone";
  Modelica.SIunits.Temperature Teair2
    "Air temperature at the inlet of the rain zone";
  Modelica.SIunits.Temperature Tsair2
    "Air temperature at the outlet of the rain zone";
  Modelica.SIunits.Temperature Teeau2
    "Hot water temperature at the inlet of the rain zone";
  Modelica.SIunits.Temperature Tseau2
    "Cold water temperature at the outlet of the rain zone";
  Modelica.SIunits.MassFlowRate QsEau2
    "Cold water mass flow rate at the outlet of the rain zone";
  Modelica.SIunits.MassFlowRate Qevap2
    "Evaporation mass flow rate in the rain zone";
  Real xsH2o2 "Air humidity at the outlet of the rain zone (kg/kg)";
  Modelica.SIunits.Power dw2
    "Thermal power exchanged between the air and the droplets by convection and evaporation in the rain zone";
  Modelica.SIunits.SpecificEnthalpy Hs2
    "Air specific enthalpy at temprature Tair in the rain zone";
  Modelica.SIunits.SpecificEnthalpy Hse2
    "Air specific enthalpy saturated at temperature Teau in the rain zone";
  Real ng "Number of droplets";
  Modelica.SIunits.Volume Vair2(start=20000)
    "Air volume in the rain exchange zone";
  Modelica.SIunits.Volume Veau2(start=2000)
    "Water volume in the rain exchange zone";
  Modelica.SIunits.SpecificEnthalpy HmEau2(start=200000)
    "Average specific enthalpy in the rain zone";
  Modelica.SIunits.Area SEAU "Contact area air/water";
  Modelica.SIunits.Density rhoEair2(start=1) "Air density at the inlet";
  Modelica.SIunits.DynamicViscosity muEair2(start=1e-6)
    "Air viscosity at the inlet";
  Modelica.SIunits.SpecificHeatCapacity CpEair2(start=1000)
    "Air specific heat capacity at the inlet";
  Modelica.SIunits.ThermalConductivity lambdaEair2(start=0.05)
    "Air thermal conductivity at the inlet";
  Modelica.SIunits.Density rhoSair2 "Air density at the outlet";
  Modelica.SIunits.DynamicViscosity muSair2(start=1e-6)
    "Air viscosity at the outlet";
  Modelica.SIunits.SpecificHeatCapacity CpSair2(start=1000)
    "Air specific heat capacity at the outlet";
  Modelica.SIunits.ThermalConductivity lambdaSair2(start=0.05)
    "Air thermal conductivity at the outlet";
  Modelica.SIunits.Density rho2(start=995) "Water density";
  Real ddairhp1 "dérivé de la masse volumique de l'air par rapport à H paching";
  Real ddairhp2 "dérivé de la masse volumique de l'air par rapport à H pluie";
  Real Xh2oTeau1 "Fraction massique en H2o de l'air a Teeau zone 1";
  Real Xh2oTeau2 "Fraction massique en H2o de l'air a Teeau zone 1";

public
  Connectors.FluidInlet Cws1 "Cooling water inlet"
                                    annotation (Placement(transformation(extent=
           {{-90,-50},{-70,-30}}, rotation=0)));
  Connectors.FluidOutlet Cws2 "Cooling water outlet"
                                    annotation (Placement(transformation(extent=
           {{-110,-100},{-90,-80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_input1
    "Packing zone water/steam properties"
    annotation (Placement(transformation(extent={{-100,60},{-80,86}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_output1
    "Packing zone water/steam properties"
    annotation (Placement(transformation(extent={{-100,20},{-80,46}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_input2
    "Rain zone water/steam properties"
    annotation (Placement(transformation(extent={{80,60},{100,86}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro_output2
    "Rain zone water/steam properties"
    annotation (Placement(transformation(extent={{80,20},{100,46}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cair1 "Air inlet"
                              annotation (Placement(transformation(extent={{-10,
            -111},{10,-91}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cair2 "Air outlet"
                              annotation (Placement(transformation(extent={{-10,
            90},{10,110}}, rotation=0)));

initial equation

  if steady_state then
    if (rain_zone_activated == true) and (packing_zone_activated == true) then
      der(HmAir1) = 0;
      der(HmEau1) = 0;
      //////////der(HmAir2) = 0;
      der(HmEau2) = 0;
    elseif (packing_zone_activated == true) then
      der(HmAir1) = 0;
      der(HmEau1) = 0;
    elseif (rain_zone_activated == true) then
      der(HmAir2) = 0;
      der(HmEau2) = 0;
    end if;
  else
    if (rain_zone_activated == true) and (packing_zone_activated == true) then
      HmAir1 =  HeAir2;
      HmEau1 =  HeEau1;
      HmAir2 =  HeAir2;
      HmEau2 =  HeEau1;
    elseif (packing_zone_activated == true) then
      HmAir1 =  HeAir2;
      HmEau1 =  HeEau1;
    elseif (rain_zone_activated == true) then
      HmAir2 =  HeAir2;
      HmEau2 =  HeEau1;
    end if;
  end if;

equation

  /* Unconnected connectors */
  if (cardinality(Cws1) == 0) then
    Cws1.Q = 0;
    Cws1.h = 1.e5;
    Cws1.b = true;
  end if;

  if (cardinality(Cws2) == 0) then
    Cws2.Q = 0;
    Cws2.h = 1.e5;
    Cws2.a = true;
  end if;

  /* Air inlet */
  PeAir2 = Cair1.P;
  Teair2 = Cair1.T;
  QeAir2 = Cair1.Q;
  xeH2o  = Cair1.Xh2o;

  /* Water inlet */
  QeEau1 = Cws1.Q;
  HeEau1 = Cws1.h;
  PeEau1 = Cws1.P;

  /* Air outlet */
  Cair2.P = Cair1.P;
  Cair2.T = Tsair1;
  Cair2.Q = QsAir1;

  xsO2   = Xo2as*(1-xsH2o1);

  Cair2.Xco2 = 0;
  Cair2.Xh2o = xsH2o1;
  Cair2.Xo2  = xsO2;
  Cair2.Xso2 = 0;

  /* Water outlet */
  Cws2.Q = QsEau2;
  Cws2.P = PeEau1;

  //--------------------------------------------------------------------
  // Zone 1 : packing
  //--------------------------------------------------------------------

  /* Volume of the packing exchange zone */
  dV = A*z1;
  dV = Vair1 + Veau1;

  /* Mass balance equation for the air */
  der(Vair1)*rhoSair1 + Vair1*ddairhp1*der(HmAir1) = QsAir2 - QsAir1 + Qevap1;

  /* Energy balance equation for the air */
  Vair1*(PeAir2/rhoSair1*ddairhp1 + rhoSair1)*der(HmAir1) = QsAir2*HmAir2 - QsAir1*HmAir1 + dw1;

  /* Energy balance equation for the water */
  Veau1*(PeAir2/pro_output1.d*pro_output1.ddph + pro_output1.d) * der(HmEau1) = QeEau1*HeEau1 - QsEau1*HmEau1 - dw1;

  /* Beta computed or fixed for the packing zone */
  if (p_Beta1 > 0) then
     Beta1 = p_Beta1;
  else
    Beta1 = QeEau1/(a1*dV)*lambda*(QsAir2/QeEau1)^Y;
  end if;

  /* Air humidity at the outlet of the zone */
  xsH2o1 = xeH2o1 + Qevap1/QsAir2;

  //--------------------------------------------------------------------
  // Zone 2 : rain
  //--------------------------------------------------------------------

  /* Volume of the rain exchange zone */
  dV2 = A2*z2;
  dV2 = Vair2 + Veau2;

  /* Mass balance equation for the air */
  der(Vair2)*rhoSair2 + Vair2*ddairhp2*der(HmAir2) = QeAir2 - QsAir2 + Qevap2;

  /* Energy balance equation for the air */
  Vair2*(PeAir2/rhoSair2*ddairhp2 + rhoSair2)*der(HmAir2) = QeAir2*HeAir2 - QsAir2*HmAir2 + dw2;

  /* Energy balance equation for the water */
  Veau2*(PeAir2/pro_output2.d*pro_output2.ddph + pro_output2.d) * der(HmEau2) = QsEau1* HmEau1   - QsEau2* HmEau2   - dw2;

  /* Beta computed or fixed for the rain zone */
  if (p_Beta2 > 0) then
     Beta2 = p_Beta2;
  else
     Beta2 = lambdaEair2*Nu/(0.92*CpEair2*Dg);
  end if;

  /* Air humidity at the outlet of the zone */
  xsH2o2 = xeH2o + Qevap2/QeAir2;
  xeH2o1 = xsH2o2;

  if (rain_zone_activated == true) and (packing_zone_activated == true) then

    /* Mass balance equation for the water in zone 1 */
    der(Veau1)*pro_output1.d + Veau1*pro_output1.ddhp*der(HmEau1) = QeEau1 - QsEau1 - Qevap1;

    /* Power exchanged between water and air in zone 1 */
    dw1 = Beta1 *(Hse1 - Hs1)*a1*dV;

    /* Evaporation mass flow rate in zone 1 */
    Qevap1 = Beta1*(ThermoSysPro.Properties.FlueGases.XSat(Teeau1, PeAir2) - xeH2o1)*Vair1/z1;

    /* Mass balance equation for the water in zone 2 */
    der(Veau2)*pro_output2.d + Veau2*pro_output2.ddhp*der(HmEau2) = QsEau1 - QsEau2 - Qevap2;

    /* Power exchanged between the droplets and the air in zone 2 */
    dw2 = Beta2 *(Hse2 - Hs2)*a2*dV2;

    /* Evaporation mass flow rate in zone 2 */
    Qevap2 = Beta2*(ThermoSysPro.Properties.FlueGases.XSat(Teeau2, PeAir2) - xeH2o)*Vair2/z2;

    // convergence si permanent false
    //????????? correcte ????????????
    QsEau1 - QsEau2 = Qevap2;

    Cws1.h_vol = HmEau1;
    Cws2.h_vol = HmEau2;

  elseif (packing_zone_activated == true) then   // Packing zone

    /* Mass balance equation for the water in zone 1 */
    der(Veau1)*pro_output1.d + Veau1*pro_output1.ddhp*der(HmEau1) = QeEau1 - QsEau1 - Qevap1;

    /* Power exchanged between water and air in zone 1 */
    dw1 = Beta1 *(Hse1 - Hs1)*a1*dV;

    /* Evaporation mass flow rate in zone 1 */
    Qevap1 = Beta1*(ThermoSysPro.Properties.FlueGases.XSat(Teeau1, PeAir2) - xeH2o1)*Vair1/z1;

    Veau2 = 0;

    /* Power exchanged between the droplets and the air in zone 2 */
    dw2 = 0;

    /* Evaporation mass flow rate in zone 2 */
    Qevap2 =  0;

    HmEau2 = HmEau1;

    Cws1.h_vol = HmEau1;
    Cws2.h_vol = HmEau1;

  elseif (rain_zone_activated == true) then  // Rain zone

    Veau1 = 0;

    /* Power exchanged between water and air in zone 1 */
    dw1 = 0;

    /* Evaporation mass flow rate in zone 1 */
    Qevap1  =  0;

    /* Mass balance equation in zone 2 */
    der(Veau2)*pro_output2.d + Veau2*pro_output2.ddhp*der(HmEau2) = QsEau1 - QsEau2 - Qevap2;

    /* Power exchanged between the droplets and the air in zone 2 */
    dw2 = Beta2 *(Hse2-Hs2)*a2*dV2;

    /* Evaporation mass flow rate in zone 2 */
    Qevap2 = Beta2*(ThermoSysPro.Properties.FlueGases.XSat(Teeau2, PeAir2) - xeH2o)*Vair2/z2;

    HmEau1 = HeEau1;

    Cws1.h_vol = HmEau2;
    Cws2.h_vol = HmEau2;

  end if;

  /* Reynols number for the droplets */
  Re = rhoEair2*abs(Ug + Ua)*Dg/muEair2;

  /* Prandtl number */
  Pr = muEair2*CpEair2/lambdaEair2;

  /* Nusselt number */
  Nu = 2 + 0.6*Re^0.5*Pr^(1/3);

  /* Air/water interfacial area for the rain zone */
  a2 = SEAU/dV2;

  /* Number of droplets */
  ng = QsEau1/(4/3*pi*(Dg/2)^3*rho2);

  /* Air/water contact area */
  SEAU = ng * 4 * pi * (Dg/2)^2;

  /* Air velocity */
  Ua= Cair1.Q/(rhoEair2*A2);

  /* Droplets velocity */
  der(Ug) = -18*muEair2*(1 + 0.15*Re^0.687)/(rho2*Dg^2)*(Ug + Ua)^2 + g;

  //--------------------------------------------------------------------
  // Fluid thermodynamic properties in the packing zone
  //--------------------------------------------------------------------

  /* Air properties as a function of temperature and humidity */

  // Air inlet
  rhoEair1 = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  CpEair1  = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  muEair1  = ThermoSysPro.Properties.FlueGases.FlueGases_mu(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  lambdaEair1 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);

  // Air outlet
  rhoSair1 = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Cair1.P, Tsair1, Cair2.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair2.Xso2);
  CpSair1  = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Cair1.P, Tsair1, Cair2.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair2.Xso2);
  muSair1  = ThermoSysPro.Properties.FlueGases.FlueGases_mu(Cair1.P, Tsair1, Cair2.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair2.Xso2);
  lambdaSair1 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Cair1.P, Tsair1, Cair2.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair2.Xso2);

  // Air temperature at the inlet of zone 1
  // changed from Fluegases_T to FlueGases_h to provide a differentiable function
  HmAir2 = ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1-xsH2o2), Cair1.Xso2);


  // Air temperature at the outlet of zone 1
  // changed from Fluegases_T to FlueGases_h to provide a differentiable function
  HmAir1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Tsair1, Cair1.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair1.Xso2);

  //
  Xh2oTeau1 = ThermoSysPro.Properties.FlueGases.XSat(Teeau1, PeAir2);

  // Specific enthalpy of the air saturated with water
  Hs1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teair1, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  Hse1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teeau1, Cair1.Xco2, Xh2oTeau1,  Xo2as*(1 - Xh2oTeau1), Cair1.Xso2);

  // Partial derivatives of the air density
  ddairhp1 = ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(Cair1.P, Tsair1, Cair2.Xco2, xsH2o1, Xo2as*(1 - xsH2o1), Cair2.Xso2);
  ddairhp2 = ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(Cair1.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);

  /* Water properties as a function of pressure and specific enthalpy */

  // Water inlet
  pro_input1 = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(PeEau1, HeEau1, mode);
  Teeau1 = pro_input1.T;
  rho1 = pro_input1.d;

  // Water outlet
  pro_output1 = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(PeEau1, HmEau1, mode);
  Tseau1 = pro_output1.T;

  //--------------------------------------------------------------------
  // Fluid thermodynamic properties in the rain zone
  //--------------------------------------------------------------------

  /* Air properties as a function of temperature and humidity */

  // Air inlet
  rhoEair2 = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  CpEair2  = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  muEair2  = ThermoSysPro.Properties.FlueGases.FlueGases_mu(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  lambdaEair2 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);

  // Air outlet
  rhoSair2 = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Cair2.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  CpSair2 = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Cair2.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  muSair2 = ThermoSysPro.Properties.FlueGases.FlueGases_mu(Cair2.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);
  lambdaSair2 = ThermoSysPro.Properties.FlueGases.FlueGases_k(Cair2.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);

  // Air specific enthalpy at the inlet
  HeAir2  =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);

  // Air temperature at the outlet
  // changed from Fluegases_T to FlueGases_h to provide a differentiable function
  HmAir2  = ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair2.P, Tsair2, Cair1.Xco2, xsH2o2, Xo2as*(1 - xsH2o2), Cair1.Xso2);

  //
  Xh2oTeau2 = ThermoSysPro.Properties.FlueGases.XSat(Teeau2, PeAir2);

  // Specific enthalpy of the air saturated with water
  Hs2  =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teair2, Cair1.Xco2, Cair1.Xh2o, Cair1.Xo2, Cair1.Xso2);
  Hse2 =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Cair1.P, Teeau2, Cair1.Xco2, Xh2oTeau2, Xo2as*(1 - Xh2oTeau2), Cair1.Xso2);

  // Water inlet
  pro_input2 = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(PeEau1, HmEau1, mode);
  Teeau2 = pro_input2.T;
  rho2 = pro_input2.d;

  // Water outlet
  pro_output2 = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(PeEau1, HmEau2, mode);
  Tseau2 = pro_output2.T;

annotation (Icon(graphics={
        Rectangle(
          extent={{-90,-80},{90,-100}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,-42},{76,-48}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{76,-48},{62,-100},{40,-48},{20,-100},{2,-48},{-20,-100},{-40,
              -48},{-60,-100},{-74,-48}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{90,-82},{90,-100},{100,-100},{90,-82}},
          lineColor={85,170,255},
          lineThickness=1,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-100},{-70,-40},{-58,0},{-56,20},{-60,60},{-68,100},{70,
              100},{60,60},{56,20},{58,0},{74,-42},{100,-100},{-100,-100}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{0,0},{0,40}},
          color={255,0,0},
          thickness=1),
        Polygon(
          points={{0,60},{-10,40},{10,40},{0,60}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
                            Diagram(graphics={
        Rectangle(
          extent={{-90,-80},{90,-100}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,-42},{76,-48}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{76,-48},{62,-100},{40,-48},{20,-100},{2,-48},{-20,-100},{-40,
              -48},{-60,-100},{-74,-48}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{90,-80},{90,-100},{100,-100},{90,-80}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-100},{-70,-40},{-58,0},{-56,20},{-60,60},{-68,100},{70,
              100},{60,60},{56,20},{58,0},{74,-42},{100,-100},{-100,-100}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{0,0},{0,40}},
          color={255,0,0},
          thickness=1),
        Polygon(
          points={{0,60},{-10,40},{10,40},{0,60}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end CoolingTower;
