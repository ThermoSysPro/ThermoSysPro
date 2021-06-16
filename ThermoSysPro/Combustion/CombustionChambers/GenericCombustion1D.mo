within ThermoSysPro.Combustion.CombustionChambers;
model GenericCombustion1D "Generic combustion chamber 1D"

  parameter Integer NCEL = 7;

  parameter Modelica.SIunits.Area Acham=1
    "Average cross-sectional area of the combusition chamber";
  //parameter Modelica.SIunits.Area SM[NCEL] = {639.92,198.58,466.48,466.48,466.48,523.79,523.79}
  parameter Modelica.SIunits.Area SM[NCEL] = fill(100, NCEL)
    "Heat exchange area for the node i = projetee )";
  parameter Real RSURF[NCEL] = cat(1,{1.321},fill(1.409,NCEL - 1))
    "Reel surface/projetee surface ";
  parameter ThermoSysPro.Units.PressureLossCoefficient kcham=0.01
    "Pressure loss coefficient in the combustion chamber";
  parameter Real Xpth=0.00
    "Thermal loss fraction in the body of the combustion chamber (0-1 over Q.HHV)";
  parameter Real ImbCV=0 "Unburnt particles ratio in the volatile ashes (0-1)";
  parameter Real ImbBF=0
    "Unburnt particle ratio in the low furnace ashes (0-1)";
  parameter Modelica.SIunits.SpecificHeatCapacity Cpcd=500
    "Ashes specific heat capacity";
  parameter Modelica.SIunits.Temperature Tbf=500
    "Ashes temperature at the outlet of the low furnace";
  parameter Real Xbf=0.1 "Ashes ration in the low furnace (0-1)";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Kec= 50
    "Convection and conduction(fouling) heat exchange coefficient";
  parameter Real EPSPAR = 0.6 "Combustion chamber walls emissivity";
  //parameter Real hrCorr=1.00 "Corrective term for ratiation heat exchange";

protected
  constant Real SIGMA = 5.669e-8 "Boltzman constant W/m^2/K^4";
  constant Real amC=12.01115 "Carbon atomic mass";
  constant Real amH=1.00797 "Hydrogen atomic mass";
  constant Real amO=15.9994 "Oxygen atomic mass";
  constant Real amS=32.064 "Sulfur atomic mass";
  constant Modelica.SIunits.SpecificEnergy HHVcarbone=32.8e6
    "Unburnt carbon higher heating value, CO2 = 3.2791664E+07";
  constant Real RAD = 0.017453293 "pi/180";
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
  Real XCfuel(start=0.8) "C mass fraction in the fuel /pur";
  Real XHfuel(start=0.2) "H mass fraction in the fuel /pur";
  Real XOfuel(start=0) "O mass fraction in the fuel /pur";
  Real XSfuel(start=0) "S mass fraction in the fuel /pur";
  Real Xwfuel(start=0) "H2O mass fraction in the fuel";
  Real XCDfuel(start=0) "Ashes mass fraction in the fuel /Dryer";
  Modelica.SIunits.SpecificEnergy LHVfuel_D(start=5e7)
    "Fuel lower heating value /Dryer";
  Modelica.SIunits.SpecificEnergy LHVfuel(start=5e7)
    "Fuel lower heating value /Brut";
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
  //////////////////////Modelica.SIunits.Power Wfuel(start=5e8) "LHV power available in the fuel";
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
  Modelica.SIunits.Temperature Tpi[NCEL](start=fill(400, NCEL))
    "Wall temperature for node i";
  Modelica.SIunits.Power Ws[NCEL]( start=fill(10e6,NCEL))
    "Power delivered to each segment";
  Modelica.SIunits.Power Wst( start = 50.e6)
    "Total power exchanged on all segment";

public
  ThermoSysPro.Combustion.Connectors.FuelInlet Cfuel "Fuel inlet"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ca "Air inlet"
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg "Flue gases outlet"
    annotation (Placement(transformation(extent={{-10,80},{10,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws "Water/steam inlet"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}}, rotation=
            0)));
  Thermal.Connectors.ThermalPort Cth[NCEL] "Thermal W T"
    annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
equation

  /* Heat transfer */
  Cth.W = - Ws;
  Cth.T = Tpi;

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
  LHVfuel_D = Cfuel.LHV;
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
  Vea = if (rhoea >0.001) then
                              1/rhoea else 1/1.1;

  /* Flue gases density at the outlet */
  rhosf = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Psf, Tsf, XsfCO2, XsfH2O, XsfO2, XsfSO2);
  Vsf = if (rhosf >0.001) then
                              1/rhosf else 1/0.1;

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
  //XsfH2O*Qsf = Qews + (Qea*XeaH2O+Qfuel*XHfuel* amH2O/2 /amH);
  XsfH2O*Qsf = Qews + (Qea*XeaH2O+Qfuel*XHfuel* amH2O/2 /amH)+Xwfuel*Qfuel;

  /* O2 flue gases mass fraction */
  XsfO2*Qsf = (Qea*XeaO2) - (Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS)) + (Qfuel*XOfuel);

  /* SO2 flue gases mass fraction */
  XsfSO2*Qsf = (Qea*XeaSO2) + (Qfuel*XSfuel*amSO2/amS);

  /* LHV conversion from dryer to crude*/
  LHVfuel = -2510000.0*Xwfuel + LHVfuel_D*(1-Xwfuel);

  /* Fuel higher heating value */
  HHVfuel = LHVfuel_D + 224.3e5*XHfuel + 25.1e5*Xwfuel;

  /* Thermal losses power */
  Wpth = Qfuel*LHVfuel*Xpth;

  /* Combusiton air ratio */
  exc = Qea*(1 - XeaH2O)/
        ((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO) -
         Qfuel*amO*2*(Qcv*ImbCV + Qbf*ImbBF)/amC)/(XeaO2/(1 - XeaH2O)));
//  exc = Qea*(1 - XeaH2O)/((Qfuel*amO*(2*XCfuel/amC + 0.5*XHfuel/amH + 2*XSfuel/amS - XOfuel/amO))/(XeaO2c/(1 - XeaH2O)));

  /* Pressure losses */
  Pea - Psf = deltaPccb;
  Qm = (Qea + Qfuel + Qews)/2;
  Vccbm = (Vea + Vsf)/2;
  v = Qm*Vccbm/Acham;
  deltaPccb = (kcham*(v^2))/(2*Vccbm);

  /* Power delivered to each segment*/
  for i in 1:NCEL loop
    Ws[i] = SIGMA*EPSPAR*RSURF[i]*SM[i]*(Tsf^4 - Tpi[i]^4) +  Kec*RSURF[i]*SM[i]*(Tsf - Tpi[i]);
  end for;

  Wst = sum(Ws);

  /* Energy balance equation */
  ((Qea + Qews + Qfuel*(1 - XCDfuel))*(Hsf - Hrfg) + Wpth + Qcv*(Hcv - Hrcd)+ Qbf*(Hbf - Hrcd)+(Qcv*ImbCV+Qbf*ImbBF)*HHVcarbone)
   + Wst - (Qfuel*(Hfuel - Hrfuel + LHVfuel) + Qea*(Hea - Hrair) + Qews*(Hews - Hrws)) = 0;

  Hfuel = Cpfuel*(Tfuel-273.16);
  Hcv = Cpcd*(Tsf-273.16);
  Hbf = Cpcd*(Tbf-273.16);

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
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,45},{-54,53},{-50,57},{-44,59},{-36,61},{-26,61},{-16,59},
              {-8,55},{0,51},{2,48},{0,46},{-2,45},{-6,43},{-6,42},{-4,42},{4,
              44},{10,44},{16,43},{28,41},{44,37},{28,29},{16,25},{2,21},{-8,19},
              {-16,17},{-28,17},{-42,19},{-50,21},{-56,27},{-56,33},{-52,37},{
              -56,45}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,45},{-54,51},{-48,55},{-40,57},{-32,57},{-22,55},{-14,51},
              {-10,47},{-14,43},{-18,41},{-22,39},{-22,37},{-18,35},{-12,36},{
              -8,36},{-2,37},{2,37},{10,37},{22,35},{-4,25},{-18,21},{-26,19},{
              -36,19},{-42,21},{-50,23},{-54,27},{-56,33},{-54,39},{-56,45}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,213,170}),
        Polygon(
          points={{-51,39},{-53,45},{-49,49},{-45,51},{-41,51},{-36,47},{-33,43},
              {-33,39},{-34,35},{-37,31},{-39,29},{-43,27},{-47,27},{-51,29},{
              -53,31},{-53,33},{-51,39}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,170}),
        Polygon(
          points={{-56,-30},{-54,-22},{-50,-18},{-44,-16},{-36,-14},{-26,-14},{
              -16,-16},{-8,-20},{-2,-24},{0,-26},{0,-28},{0,-28},{-2,-30},{-6,
              -32},{-4,-32},{4,-30},{10,-30},{20,-32},{28,-34},{44,-38},{28,-46},
              {16,-50},{2,-54},{-8,-56},{-16,-58},{-28,-58},{-42,-56},{-50,-54},
              {-56,-48},{-56,-42},{-52,-38},{-56,-30}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,-30},{-54,-24},{-48,-20},{-40,-18},{-32,-18},{-22,-20},{
              -14,-24},{-10,-28},{-14,-32},{-18,-34},{-22,-36},{-22,-38},{-18,
              -40},{-12,-40},{-8,-40},{-2,-38},{2,-38},{10,-38},{22,-40},{-4,
              -50},{-18,-54},{-26,-56},{-36,-56},{-42,-54},{-50,-52},{-54,-48},
              {-56,-42},{-54,-36},{-56,-30}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,213,170}),
        Polygon(
          points={{-51,-36},{-53,-30},{-49,-26},{-45,-24},{-41,-24},{-36,-28},{
              -33,-32},{-33,-36},{-34,-40},{-37,-44},{-39,-46},{-43,-48},{-47,
              -48},{-51,-46},{-53,-44},{-53,-42},{-51,-36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,170})}),    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,45},{-52,53},{-48,57},{-42,59},{-34,61},{-24,61},{-14,59},
              {-6,55},{2,51},{4,48},{2,46},{0,45},{-4,43},{-4,42},{-2,42},{6,44},
              {12,44},{18,43},{30,41},{46,37},{30,29},{18,25},{4,21},{-6,19},{
              -14,17},{-26,17},{-40,19},{-48,21},{-54,27},{-54,33},{-50,37},{
              -54,45}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,45},{-52,51},{-46,55},{-38,57},{-30,57},{-20,55},{-12,51},
              {-8,47},{-12,43},{-16,41},{-20,39},{-20,37},{-16,35},{-10,36},{-6,
              36},{0,37},{4,37},{12,37},{24,35},{-2,25},{-16,21},{-24,19},{-34,
              19},{-40,21},{-48,23},{-52,27},{-54,33},{-52,39},{-54,45}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,213,170}),
        Polygon(
          points={{-49,39},{-51,45},{-47,49},{-43,51},{-39,51},{-34,47},{-31,43},
              {-31,39},{-32,35},{-35,31},{-37,29},{-41,27},{-45,27},{-49,29},{
              -51,31},{-51,33},{-49,39}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,170}),
        Polygon(
          points={{-54,-30},{-52,-22},{-48,-18},{-42,-16},{-34,-14},{-24,-14},{
              -14,-16},{-6,-20},{0,-24},{2,-26},{2,-28},{2,-28},{0,-30},{-4,-32},
              {-2,-32},{6,-30},{12,-30},{22,-32},{30,-34},{46,-38},{30,-46},{18,
              -50},{4,-54},{-6,-56},{-14,-58},{-26,-58},{-40,-56},{-48,-54},{
              -54,-48},{-54,-42},{-50,-38},{-54,-30}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,-30},{-52,-24},{-46,-20},{-38,-18},{-30,-18},{-20,-20},{
              -12,-24},{-8,-28},{-12,-32},{-16,-34},{-20,-36},{-20,-38},{-16,
              -40},{-10,-40},{-6,-40},{0,-38},{4,-38},{12,-38},{24,-40},{-2,-50},
              {-16,-54},{-24,-56},{-34,-56},{-40,-54},{-48,-52},{-52,-48},{-54,
              -42},{-52,-36},{-54,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,213,170}),
        Polygon(
          points={{-49,-36},{-51,-30},{-47,-26},{-43,-24},{-39,-24},{-34,-28},{
              -31,-32},{-31,-36},{-32,-40},{-35,-44},{-37,-46},{-41,-48},{-45,
              -48},{-49,-46},{-51,-44},{-51,-42},{-49,-36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,170})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 8.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>"));
end GenericCombustion1D;
