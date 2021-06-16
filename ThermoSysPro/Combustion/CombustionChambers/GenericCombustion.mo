within ThermoSysPro.Combustion.CombustionChambers;
model GenericCombustion "Generic combustion chamber"
  parameter ThermoSysPro.Units.PressureLossCoefficient kcham=1
    "Pressure loss coefficient in the combustion chamber";
  parameter Modelica.SIunits.Area Acham=1
    "Average corss-sectional area of the combusiton chamber";
  parameter Real Xpth=0.01
    "Thermal loss fraction in the body of the combustion chamber (0-1 over Q.HHV)";
  parameter Real ImbCV=0 "Unburnt particles ratio in the volatile ashes (0-1)";
  parameter Real ImbBF=0
    "Unburnt particle ratio in the low furnace ashes (0-1)";
  parameter Modelica.SIunits.SpecificHeatCapacity Cpcd=500
    "Ashes specific heat capacity";
  parameter Modelica.SIunits.Temperature Tbf=500
    "Ashes temperature at the outlet of the low furnace";
  parameter Real Xbf=0.1 "Ashes ration in the low furnace (0-1)";

protected
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Modelica.SIunits.SpecificEnergy HHVcarbone=32.8e6
    "Unburnt carbon higher heating value";
  Real amCO2 "CO2 molecular mass";
  Real amH2O "H2O molecular mass";
  Real amSO2 "SO2 molecular mass";

public
  Modelica.SIunits.MassFlowRate Qea(start=400) "Air mass flow rate";
  Modelica.SIunits.AbsolutePressure Pea(start=1e5) "Air pressure at the inlet";
  Modelica.SIunits.Temperature Tea(start=600) "Air temperature at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hea(start=50e3)
    "Air specific enthalpy at the inlet";
  Real XeaCO2(start=0) "CO2 mass fraction at the air inlet";
  Real XeaH2O(start=0.1) "H2O mass fraction at the air inlet";
  Real XeaO2(start=0.2) "O2 mass fraction at the air inlet";
  Real XeaSO2(start=0) "SO2 mass fraction at the air inlet";
  Modelica.SIunits.MassFlowRate Qfuel(start=5) "Fuel mass flow rate";
  Modelica.SIunits.Temperature Tfuel(start=300) "Fuel temperature";
  Modelica.SIunits.SpecificEnthalpy Hfuel(start=10e3) "Fuel specific enthalpy";
  Real XCfuel(start=0.8) "C mass fraction in the fuel";
  Real XHfuel(start=0.2) "H mass fraction in the fuel";
  Real XOfuel(start=0) "O mass fraction in the fuel";
  Real XSfuel(start=0) "S mass fraction in the fuel";
  Real Xwfuel(start=0) "H2O mass fraction in the fuel";
  Real XCDfuel(start=0) "Ashes mass fraction in the fuel";
  Modelica.SIunits.SpecificEnergy LHVfuel(start=5e7) "Fuel lower heating value";
  Modelica.SIunits.SpecificHeatCapacity Cpfuel(start=1000)
    "Fuel specific heat capacity";
  Modelica.SIunits.SpecificEnergy HHVfuel "Fuel higher heating value";
  Modelica.SIunits.MassFlowRate Qews(start=1) "Water/steam mass flow rate";
  Modelica.SIunits.SpecificEnthalpy Hews(start=10e3)
    "Water/steam specific enthalpy at the inlet";
  Modelica.SIunits.MassFlowRate Qsf(start=400) "Flue gases mass flow rate";
  Modelica.SIunits.AbsolutePressure Psf(start=12e5)
    "Flue gases pressure at the outlet";
  Modelica.SIunits.Temperature Tsf(start=1500)
    "Flue gases temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=50e4)
    "Flue gases specific enthalpy at the outlet";
  Real XsfCO2(start=0.5) "CO2 mass fraction in the flue gases";
  Real XsfH2O(start=0.1) "H2O mass fraction in the flue gases";
  Real XsfO2(start=0) "O2 mass fraction in the flue gases";
  Real XsfSO2(start=0) "SO2 mass fraction in the flue gases";
  Modelica.SIunits.Power Wfuel(start=5e8) "LHV power available in the fuel";
  Modelica.SIunits.Power Wpth(start=1e6) "Thermal losses power";
  Real exc(start=1) "Combustion air ratio";
  Modelica.SIunits.MassFlowRate Qcv(start=1) "Volatile ashes mass flow rate";
  Modelica.SIunits.MassFlowRate Qbf(start=1) "Low furnace ashes mass flow rate";
  Modelica.SIunits.SpecificEnthalpy Hcv(start=10e3)
    "Volatile ashes specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hbf(start=10e3)
    "Low furnace ashes specific enthalpy at the outlet";
  ThermoSysPro.Units.DifferentialPressure deltaPccb(start=1e3)
    "Pressure loss in the combustion chamber";
  Modelica.SIunits.SpecificEnthalpy Hrair(start=10e3)
    "Air reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrws(start=10e4)
    "Water/steam reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrfuel(start=10e3)
    "Fuel reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrcd(start=10e3)
    "Ashes reference specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy Hrfg(start=10e3)
    "Flue gases reference specific enthalpy";
  Real Vea(start=0.001) "Air volume mass (m3/kg)";
  Real Vsf(start=0.001) "Flue gases volume mass (m3/kg)";
  Modelica.SIunits.Density rhoea(start=0.001) "Air density at the inlet";
  Modelica.SIunits.Density rhosf(start=0.001)
    "Flue gases density at the outlet";
  Modelica.SIunits.MassFlowRate Qm(start=400)
    "Average mlass flow rate in the combusiton chamber";
  Real Vccbm(start=0.001) "Average volume mass in the combustion chamber";
  Modelica.SIunits.Velocity v(start=100)
    "Flue gases reference velocity in the combusiton chamber";
public
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel "Fuel inlet"
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}, rotation=
            0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ca "Air inlet"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
          rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg "Flue gases outlet"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws "Water/steam inlet"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}}, rotation=0)));
equation
  /* Air inlet */
  Qea = Ca.Q;
  Pea = Ca.P;
  Tea = Ca.T;
  XeaCO2 = Ca.Xco2;
  XeaH2O = Ca.Xh2o;
  XeaO2 = Ca.Xo2;
  XeaSO2 = Ca.Xso2;

  /* Fuel inlet */
  Qfuel = Cfuel.Q;
  Tfuel = Cfuel.T;
  XCfuel = Cfuel.Xc;
  XHfuel = Cfuel.Xh;
  XOfuel = Cfuel.Xo;
  XSfuel = Cfuel.Xs;
  Xwfuel = Cfuel.hum;
  XCDfuel = Cfuel.Xashes;
  LHVfuel = Cfuel.LHV;
  Cpfuel = Cfuel.cp;

  /* Water inlet */
  Qews = Cws.Q;
  Hews = Cws.h;
  Cws.h = Cws.h_vol;

  /* Flue gases outlet */
  Qsf = Cfg.Q;
  Psf = Cfg.P;
  Tsf = Cfg.T;
  XsfCO2 = Cfg.Xco2;
  XsfH2O = Cfg.Xh2o;
  XsfO2 = Cfg.Xo2;
  XsfSO2 = Cfg.Xso2;

  /* Air specific enthalpy at the inlet */
  Hea = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);

  /* Flue gases specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);

  /* Air density at the inlet */
  rhoea = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pea, Tea, XeaCO2, XeaH2O, XeaO2, XeaSO2);
  Vea = if (rhoea > 0.001) then 1/rhoea else 1/1.1;

  /* Flue gases density at the outlet */
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  Vsf = if (rhosf > 0.001) then 1/rhosf else 1/0.1;

  amCO2 = amC + 2*amO;
  amH2O = 2*amH + amO;
  amSO2 = amS + 2*amO;

  /* Mass balance equation */
  Qsf = Qea + Qews + Qfuel*(1 - XCDfuel) - Qcv*ImbCV - Qbf*ImbBF;
  Qcv = Qfuel*XCDfuel*(1 - Xbf)/(1 - ImbCV);
  Qbf = Qfuel*XCDfuel*Xbf/(1 - ImbBF);

  /* CO2 flue gases mass fraction */
  XsfCO2*Qsf = (Qea*XeaCO2) + ((Qfuel*XCfuel - Qcv*ImbCV - Qbf*ImbBF)*amCO2/amC);

  /* H2O flue gases mass fraction */
  XsfH2O*Qsf = Qews + (Qea*XeaH2O+Qfuel*XHfuel*amH2O/2 /amH);

  /* O2 flue gases mass fraction */
  XsfO2*Qsf = (Qea*XeaO2) - (Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS)) + (Qfuel*XOfuel);

  /* SO2 flue gases mass fraction */
  XsfSO2*Qsf = (Qea*XeaSO2) + (Qfuel*XSfuel*amSO2/amS);

  /* Fuel thermal power */
  HHVfuel = LHVfuel + 224.3e5*XHfuel + 25.1e5*Xwfuel;
  Wfuel = Qfuel*HHVfuel;
  Wpth = Qfuel*LHVfuel*Xpth;

  /* Combusiton air ratio */
  exc = Qea*(1 - XeaH2O)/
        ((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO) -
         Qfuel*amO*2*(Qcv*ImbCV + Qbf*ImbBF)/amC)/(XeaO2/(1 - XeaH2O)));

  /* Pressure losses */
  Pea - Psf = deltaPccb;
  Qm = Qea + (Qfuel + Qews)/2;
  Vccbm = (Vea + Vsf)/2;
  v = Qm*Vccbm/Acham;
  deltaPccb = (kcham*(v^2))/(2*Vccbm);

  /* Energy balance equation */
  ((Qea + Qews + Qfuel*(1 - XCDfuel))*(Hsf - Hrfg) + Wpth + Qcv*(Hcv - Hrcd)+ Qbf*(Hbf - Hrcd)+(Qcv*ImbCV+Qbf*ImbBF)*HHVcarbone)
    - (Qfuel*(Hfuel - Hrfuel + LHVfuel) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws)) = 0;

  Hfuel = Cpfuel*(Tfuel - 273.16);
  Hcv = Cpcd*(Tsf - 273.16);
  Hbf = Cpcd*(Tbf - 273.16);

 /* Reference specific enthalpies */
  Hrair = 2501.569e3*XeaH2O;
  Hrfuel = 0;
  Hrws = 2501.569e3;
  Hrfg = 2501.569e3*XsfH2O;
  Hrcd = 0;

    annotation (Diagram(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-36},{-44,30},{-34,-2},{-10,66},{10,-4},{44,54},{66,-44},
              {38,-80},{-34,-80},{-50,-36}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-36},{-18,-44},{-26,-16},{-16,6},{4,-44},{8,-28},{36,-72},
              {16,-80},{-16,-80},{-32,-36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
                             Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-36},{-44,30},{-34,-2},{-10,66},{10,-4},{44,54},{66,-44},
              {38,-80},{-34,-80},{-50,-36}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-36},{-18,-44},{-26,-16},{-16,6},{4,-44},{8,-28},{36,-72},
              {16,-80},{-16,-80},{-32,-36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Beno&icirc;t Bride</li>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>"));
end GenericCombustion;
